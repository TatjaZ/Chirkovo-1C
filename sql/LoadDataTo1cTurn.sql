drop procedure LoadDataTo1cTurn            
go
create procedure LoadDataTo1cTurn            
(@DateFrom datetime,      
  @DateTo datetime,      
  @WareHouseID T_ID,       
  @Result int out)          
--with recompile                   
as                  
begin            
/*           
 выгрузка в 1с для Чирково так как в Ясене       
*/                 
           
 declare @DivisionID T_ID,@RevaluationID T_ID, @InventoryID T_ID, @TurnOwnID T_ID                  
           
 select @DateTo=dateadd(dd,1,@DateTo)                  
 select @DivisionID=DivisionID from WareHouse where ID=@WareHouseID            
 select @RevaluationID=Revaluation from StandartAdj where ID=1              
 select @InventoryID=2 -- ИД документа инвентаризации           
 select @TurnOwnID=3  -- ИД документа на внутреннее перемещение           
        
/* тары сказали не будет!           
 select TMCID             
 into #Tara            
 from StandartAdj,WHNomenclature (index WH_NomenclGr_idx)            
 where StandartAdj.ID=1 and            
       WHNomenclature.WHNomenclatureGroupID=StandartAdj.ContainerID            
 group by TMCID            
*/        
       
           
/* Приходные документы*/           
       
set forceplan on       
           
 select convert(numeric(1),1) as TypeTurn,           
        WHDocument.ID WHDocumentID,           
        WHDocument.Kind,           
        WHDocument.Date,         
        WHDocument.Number  + (case when WHDocument.Series<>'' then '-' +  WHDocument.Series else '' end) as Number,     
        WHDocument.WareHouseID,     
        WHDocument.DivisionID,       
        W.Date as Date_Reestr,       
        DE.UNN,            
        WHCard.NomenclID,           
        W.CreditQuantity*WHCard.PriceF as SumPriceF,           
        Round(W.CreditQuantity*WHCard.PriceN,2) as SumPriceN,           
        Round(W.CreditQuantity*WHCard.PricePAll,2) as SumPricePALL,                 
        Round(W.CreditQuantity*WH.PricePAll,2) as SummOperWithDiscont, --Сумма товара со скидкой       
        W.CreditQuantity*(WHCard.PricePAll-WH.PricePAll)  as SummDiscont, --Сумма скидки      
        W.CreditQuantity*Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4) as SummTradeRaiseDiscont, -- Сумма скидки за счет ТН        
        W.CreditQuantity*Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4)*(WHCard.NDSPersent*0.01)as SummNDSDiscont,  -- Сумма скидки за счет НДС                                 
        W.CreditQuantity*((WHCard.PricePAll-WH.PricePAll) -Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4)-Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4)*(WHCard.NDSPersent*0.01)) as SummRoundDiscon, -- Сумма скидки за счет Округления      
        W.CreditQuantity*(case when WHCard.NDSPersent=0 then WHCard.PriceN else 0 end) as SumPriceN_0,                 
        W.CreditQuantity*(case when WHCard.NDSPersent=10 then WHCard.PriceN else 0 end) as SumPriceN_10,                 
        W.CreditQuantity*(case when WHCard.NDSPersent=20 then WHCard.PriceN else 0 end) as SumPriceN_18,            
        Round(W.CreditQuantity*(case when WHCard.NDSPersent=0 then WHCard.PricePAll else 0 end),2) as SumPricePALL_0,                 
        Round(W.CreditQuantity*(case when WHCard.NDSPersent=10 then WHCard.PricePAll else 0 end),2) as SumPricePALL_10,                 
        Round(W.CreditQuantity*(case when WHCard.NDSPersent=20 then WHCard.PricePAll else 0 end),2) as SumPricePALL_18,            
        --НДС Поставщика              
        Round(W.CreditQuantity * (WHCard.PriceN-WHDCExt.GlassPrice) *0.01*(case when WHDCExt.SenderTax=10 then WHDCExt.SenderTax else 0 end) ,2)  as NDSIn_10,        
        Round(W.CreditQuantity * (WHCard.PriceN-WHDCExt.GlassPrice) *0.01*(case when WHDCExt.SenderTax=20 then WHDCExt.SenderTax else 0 end) ,2)  as NDSIn_18,              
        W.CreditQuantity as QuantityFact,           
        convert(integer,0) as FixedPrice,        
        convert(integer,0) as IsTara,        
        Round(W.CreditQuantity*(WHCard.PriceN-WHDCExt.GlassPrice)*WHDCExt.SenderTax*0.01,2) NDSIn, --НДС в отпускной цене            
        --Возьмем НДС обратным счетом как в реестре 4!! знака после запятой!         
        -- W.CreditQuantity*Round((WHCard.PriceP-WHDCExt.GlassPrice)*WHCard.NDSPersent*0.01,2)  NDSOut, --НДС в розничной цене         
    
         -- round( W.CreditQuantity*((WHCard.PriceP-WHDCExt.GlassPrice)*WHCard.NDSPersent*0.01+WHDCExt.GlassPrice*WHDCExt.GlassNDS*0.01),2) NDSOut,   
        round(W.CreditQuantity*(WHCard.PricePAll/(1+WHCard.NDSPersent*0.01)*(WHCard.NDSPersent*0.01)),2)   NDSOut,   
        round(W.CreditQuantity*(case when WHCard.NDSPersent=10 then     
                              (WHCard.PricePAll/(1+WHCard.NDSPersent*0.01)*(WHCard.NDSPersent*0.01))                                     
                              else 0 end),2) NDSOut_10, --НДС 10% в розничной цене         
        round(W.CreditQuantity*(case when WHCard.NDSPersent=20 then     
                              (WHCard.PricePAll/(1+WHCard.NDSPersent*0.01)*(WHCard.NDSPersent*0.01))    
                              else 0 end),2) NDSOut_18,  --НДС 20% в розничной цене         

        --Торговую надбавку расчитаю тоже обратным счетом    
        --W.CreditQuantity*(WHCard.PricePAll-Round((WHCard.PriceP-WHDCExt.GlassPrice)*(1+WHCard.NDSPersent*0.01)*WHCard.SalesTax*0.01,2)-           
                          --Round((WHCard.PriceP-WHDCExt.GlassPrice)*WHCard.NDSPersent*0.01,2)-(WHCard.PriceN-WHDCExt.GlassPrice)) SumTradeRaise, -- Торговая надбавка           
        --W.CreditQuantity*(WHCard.PricePAll-WHCard.PriceN-round(WHCard.PricePAll/(1+WHCard.NDSPersent*0.01)*(WHCard.NDSPersent*0.01),4)) SumTradeRaise, -- Торговая надбавка           
        W.CreditQuantity*(WHCard.PricePAll-WHCard.PriceN-(WHCard.PricePAll/(1+WHCard.NDSPersent*0.01)*(WHCard.NDSPersent*0.01))) SumTradeRaise,  
    
        W.CreditQuantity*Round((WHCard.PriceP-WHDCExt.GlassPrice)*(1+WHCard.NDSPersent*0.01)*WHCard.SalesTax*0.01,2) SumSalesTax, -- Налог с продаж           
                     
        W.CreditQuantity*WHDCExt.GlassPrice GlassPrice, -- Цена посуды           
           
        W.CreditQuantity*WHDCExt.GlassPrice*WHDCExt.GlassNDS*0.01 GlassNDS, -- НДС посуды           
        --W.CreditQuantity*(WHCard.PricePAll-(WHCard.PriceP-WHDCExt.GlassPrice)*(1+WHCard.NDSPersent*0.01)*(1+WHCard.SalesTax*0.01)) SumRestOfRound -- Сумма округления           
        convert(money,0) SumRestOfRound -- Сумма округления           
 into #T1           
 from WHTurn W (index WHTurn3_idx),                             
      WHDocumentContent WH (index  PK_WHDOCUMENTCONTENT),                             
      WHDocument,                              
      WHCard (index PK_WHCARD),              
      WHDCExt, Division D,              
      DivisionExt DE           
 where W.Date>@DateFrom and W.Date<@DateTo and              
      (W.DivisionID=@DivisionID or @WareHouseID=0) and              
      D.ID=W.DivisionToID and              
      DE.ID=D.DivisionExtID and                             
      W.WHCardID>0 and                             
      W.CreditQuantity>0 and                             
      WH.ID=W.WHDocumentContentID and           
      WH.KindDocID!=@RevaluationID and -- не переоценка           
      WH.KindDocID!=@TurnOwnID and     -- не внутреннее перемещение           
      WH.KindDocID!=@InventoryID and   -- не инвентаризация    
      WH.KindDocID!=98 and   -- не возврат товара от покупателя                  
      WHDocument.ID=WH.WHDocumentID and                               
      WHCard.ID=W.WHCardID and                              
      WHDCExt.ID=WHCard.WHDCExtID           
 select @Result=@@error            
 if @Result!=0 return 1  
  
/*Возврат товара от покупателя*/  
insert into #T1  
  
 select convert(numeric(1),1) as TypeTurn,  
        WHDocument.ID WHDocumentID,                    
        WHDocument.Kind,           
        WHDocument.Date,         
        convert(varchar,BKCashDocument.SalePointID) as Number,     
        WHDocument.WareHouseID,     
        WHDocument.DivisionID,       
        W.Date as Date_Reestr,       
        DE.UNN,            
        WHCard.NomenclID,           
        W.CreditQuantity*WHCard.PriceF as SumPriceF,           
        W.CreditQuantity*WHCard.PriceN as SumPriceN,           
        W.CreditQuantity*WHCard.PricePAll as SumPricePALL,                 
        W.CreditQuantity*WH.PricePAll as SummOperWithDiscont, --Сумма товара со скидкой       
        W.CreditQuantity*(WHCard.PricePAll-WH.PricePAll)  as SummDiscont, --Сумма скидки      
        W.CreditQuantity*Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4) as SummTradeRaiseDiscont, -- Сумма скидки за счет ТН        
        W.CreditQuantity*Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4)*(WHCard.NDSPersent*0.01)as SummNDSDiscont,  -- Сумма скидки за счет НДС                                 
        W.CreditQuantity*((WHCard.PricePAll-WH.PricePAll) -Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4)-Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4)*(WHCard.NDSPersent*0.01)) as SummRoundDiscon, -- Сумма скидки за счет Округления      
        W.CreditQuantity*(case when WHCard.NDSPersent=0 then WHCard.PriceN else 0 end) as SumPriceN_0,                 
        W.CreditQuantity*(case when WHCard.NDSPersent=10 then WHCard.PriceN else 0 end) as SumPriceN_10,                 
        W.CreditQuantity*(case when WHCard.NDSPersent=20 then WHCard.PriceN else 0 end) as SumPriceN_18,            
        W.CreditQuantity*(case when WHCard.NDSPersent=0 then WHCard.PricePAll else 0 end) as SumPricePALL_0,                 
        W.CreditQuantity*(case when WHCard.NDSPersent=10 then WHCard.PricePAll else 0 end) as SumPricePALL_10,                 
        W.CreditQuantity*(case when WHCard.NDSPersent=20 then WHCard.PricePAll else 0 end) as SumPricePALL_18,            
        --НДС Поставщика              
        Round(W.CreditQuantity * (WHCard.PriceN-WHDCExt.GlassPrice) *0.01*(case when WHDCExt.SenderTax=10 then WHDCExt.SenderTax else 0 end) ,2)  as NDSIn_10,        
        Round(W.CreditQuantity * (WHCard.PriceN-WHDCExt.GlassPrice) *0.01*(case when WHDCExt.SenderTax=20 then WHDCExt.SenderTax else 0 end) ,2)  as NDSIn_18,              
        W.CreditQuantity as QuantityFact,           
        convert(integer,0) as FixedPrice,        
        convert(integer,0) as IsTara,        
        Round(W.CreditQuantity*(WHCard.PriceN-WHDCExt.GlassPrice)*WHDCExt.SenderTax*0.01,2) NDSIn, --НДС в отпускной цене            
        --Возьмем НДС обратным счетом как в реестре 4!! знака после запятой!         
        -- W.CreditQuantity*Round((WHCard.PriceP-WHDCExt.GlassPrice)*WHCard.NDSPersent*0.01,2)  NDSOut, --НДС в розничной цене         
    
         -- round( W.CreditQuantity*((WHCard.PriceP-WHDCExt.GlassPrice)*WHCard.NDSPersent*0.01+WHDCExt.GlassPrice*WHDCExt.GlassNDS*0.01),2) NDSOut,   
        round(W.CreditQuantity*(WHCard.PricePAll/(1+WHCard.NDSPersent*0.01)*(WHCard.NDSPersent*0.01)),4)   NDSOut,   
        W.CreditQuantity*(case when WHCard.NDSPersent=10 then     
                              round((WHCard.PricePAll/(1+WHCard.NDSPersent*0.01)*(WHCard.NDSPersent*0.01)),4)                                     
                              else 0 end) NDSOut_10, --НДС 10% в розничной цене         
        W.CreditQuantity*(case when WHCard.NDSPersent=20 then     
                              round((WHCard.PricePAll/(1+WHCard.NDSPersent*0.01)*(WHCard.NDSPersent*0.01)),4)    
                              else 0 end) NDSOut_18,  --НДС 20% в розничной цене         
        --Торговую надбавку расчитаю тоже обратным счетом    
        --W.CreditQuantity*(WHCard.PricePAll-Round((WHCard.PriceP-WHDCExt.GlassPrice)*(1+WHCard.NDSPersent*0.01)*WHCard.SalesTax*0.01,2)-           
                          --Round((WHCard.PriceP-WHDCExt.GlassPrice)*WHCard.NDSPersent*0.01,2)-(WHCard.PriceN-WHDCExt.GlassPrice)) SumTradeRaise, -- Торговая надбавка           
        --W.CreditQuantity*(WHCard.PricePAll-WHCard.PriceN-round(WHCard.PricePAll/(1+WHCard.NDSPersent*0.01)*(WHCard.NDSPersent*0.01),4)) SumTradeRaise, -- Торговая надбавка           
        W.CreditQuantity*(WHCard.PricePAll-WHCard.PriceN-(WHCard.PricePAll/(1+WHCard.NDSPersent*0.01)*(WHCard.NDSPersent*0.01))) SumTradeRaise,  
    
        W.CreditQuantity*Round((WHCard.PriceP-WHDCExt.GlassPrice)*(1+WHCard.NDSPersent*0.01)*WHCard.SalesTax*0.01,2) SumSalesTax, -- Налог с продаж           
                     
        W.CreditQuantity*WHDCExt.GlassPrice GlassPrice, -- Цена посуды           
           
        W.CreditQuantity*WHDCExt.GlassPrice*WHDCExt.GlassNDS*0.01 GlassNDS, -- НДС посуды           
        --W.CreditQuantity*(WHCard.PricePAll-(WHCard.PriceP-WHDCExt.GlassPrice)*(1+WHCard.NDSPersent*0.01)*(1+WHCard.SalesTax*0.01)) SumRestOfRound -- Сумма округления           
        convert(money,0) SumRestOfRound -- Сумма округления           
 from WHTurn W (index WHTurn3_idx),                             
      WHDocumentContent WH (index  PK_WHDOCUMENTCONTENT),                             
      WHDocument,  
      BKCashDocument,                              
      WHCard (index PK_WHCARD),              
      WHDCExt, Division D,              
      DivisionExt DE           
 where W.Date>@DateFrom and W.Date<@DateTo and              
      (W.DivisionID=@DivisionID or @WareHouseID=0) and              
      D.ID=W.DivisionToID and              
      DE.ID=D.DivisionExtID and                             
      W.WHCardID>0 and                             
      W.CreditQuantity>0 and                             
      WH.ID=W.WHDocumentContentID and           
      WH.KindDocID=98 and   --возврат товара от покупателя                  
      WHDocument.ID=WH.WHDocumentID and    
      BKCashDocument.ID=WH.BKCashDocumentID and                               
      WHCard.ID=W.WHCardID and                              
      WHDCExt.ID=WHCard.WHDCExtID           
 select @Result=@@error            
 if @Result!=0 return 1  
           
/* Расходные документы*/           
          
 insert into #T1                     
 select convert(numeric(1),2) as TypeTurn,           
        WHDocument.ID WHDocumentID,           
        WHDocument.Kind,           
        WHDocument.Date,           
        WHDocument.Number  + (case when WHDocument.Series<>'' then '-' +  WHDocument.Series else '' end) as Number,     
        WHDocument.WareHouseID,     
        WHDocument.DivisionID,       
        W.Date as Date_Reestr,       
        DE.UNN,            
        --(select isnull(max(WareHouse.ID),0) from WareHouse where DivisionID=W.DivisionToID) WareHouseFromID,           
        --(select isnull(max(WareHouse.ID),0) from WareHouse where DivisionID=W.DivisionID) WareHouseToID,              
        WHCard.NomenclID,           
        W.DebetQuantity*WHCard.PriceF,           
        W.DebetQuantity*WHCard.PriceN,           
        W.DebetQuantity*WHCard.PricePAll,                 
        W.DebetQuantity*WH.PricePAll as SummOperWithDiscont, --Сумма товара со скидкой       
        W.DebetQuantity*(WHCard.PricePAll-WH.PricePAll)  as SummDiscont, --Сумма скидки      
        W.DebetQuantity*Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4) as SummTradeRaiseDiscont, -- Сумма скидки за счет ТН        
        W.DebetQuantity*Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4)*(WHCard.NDSPersent*0.01)as SummNDSDiscont,  -- Сумма скидки за счет НДС                                 
        W.DebetQuantity*((WHCard.PricePAll-WH.PricePAll) -Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4)-Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4)*(WHCard.NDSPersent*0.01)) as SummRoundDiscon, -- Сумма скидки за счет Округления      
        W.CreditQuantity*(case when WHCard.NDSPersent=0 then WHCard.PriceN else 0 end) as SumPriceN_0,                 
        W.CreditQuantity*(case when WHCard.NDSPersent=10 then WHCard.PriceN else 0 end) as SumPriceN_10,                 
        W.CreditQuantity*(case when WHCard.NDSPersent=20 then WHCard.PriceN else 0 end) as SumPriceN_18,     
        W.DebetQuantity*(case when WHCard.NDSPersent=0 then WHCard.PricePAll else 0 end) as SumPricePALL_0,                 
        W.DebetQuantity*(case when WHCard.NDSPersent=10 then WHCard.PricePAll else 0 end) as SumPricePALL_10,                 
        W.DebetQuantity*(case when WHCard.NDSPersent=20 then WHCard.PricePAll else 0 end) as SumPricePALL_18,                     
        --выгружаю НДС поставщика         
        case when WHCard.NDSPersent=10 then Round(W.DebetQuantity*((WHCard.PriceN-WHDCExt.GlassPrice)*WHDCExt.SenderTax*0.01),2) else 0 end as NDSIn_10,                  
        case when WHCard.NDSPersent=20 then Round(W.DebetQuantity*((WHCard.PriceN-WHDCExt.GlassPrice)*WHDCExt.SenderTax*0.01),2) else 0 end as NDSIn_18,   
              
        W.DebetQuantity,           
        --case when WHCard.PriceF>WHCard.PriceN then 1 else 0 end as FixedPrice,           
        --case when exists(select 1 from #Tara where #Tara.TMCID=WHCard.NomenclID) then 1 else 0 end as IsTara,           
        convert(integer,0) as FixedPrice,        
        convert(integer,0) as IsTara,        
           
        Round(W.DebetQuantity*(WHCard.PriceN-WHDCExt.GlassPrice)*WHDCExt.SenderTax*0.01,2) NDSIn, --НДС в отпускной цене              
              
        W.DebetQuantity*Round((WHCard.PriceP-WHDCExt.GlassPrice)*WHCard.NDSPersent*0.01,2) NDSOut, --НДС в розничной цене              
                          
        W.DebetQuantity*(case when WHCard.NDSPersent=10 then Round((WHCard.PriceP-WHDCExt.GlassPrice)*0.1,2) else 0 end) NDSOut_10, --НДС в розничной цене         
         
        W.DebetQuantity*(case when WHCard.NDSPersent=20 then Round((WHCard.PriceP-WHDCExt.GlassPrice)*0.20,2) else 0 end) NDSOut_18,  --НДС в розничной цене         
         
        W.DebetQuantity*(WHCard.PricePAll-Round((WHCard.PriceP-WHDCExt.GlassPrice)*(1+WHCard.NDSPersent*0.01)*WHCard.SalesTax*0.01,2)-           
                          Round((WHCard.PriceP-WHDCExt.GlassPrice)*WHCard.NDSPersent*0.01,2)-(WHCard.PriceN-WHDCExt.GlassPrice)) SumTradeRaise,            
             
        W.DebetQuantity*Round((WHCard.PriceP-WHDCExt.GlassPrice)*(1+WHCard.NDSPersent*0.01)*WHCard.SalesTax*0.01,2) SumSalesTax,            
                     
        W.DebetQuantity*WHDCExt.GlassPrice GlassPrice,           
        W.DebetQuantity*WHDCExt.GlassPrice*WHDCExt.GlassNDS*0.01 GlassNDS,             
            
        --W.DebetQuantity*(WHCard.PricePAll-(WHCard.PriceP-WHDCExt.GlassPrice)*(1+WHCard.NDSPersent*0.01)*(1+WHCard.SalesTax*0.01)) SumRestOfRound           
        convert(money,0) SumRestOfRound           
 from WHTurn W (index WHTurn3_idx),                             
      WHDocumentContent WH (index  PK_WHDOCUMENTCONTENT),                             
      WHDocument,                              
      WHCard (index PK_WHCARD),              
      WHDCExt, Division D,              
      DivisionExt DE           
 where W.Date>@DateFrom and W.Date<@DateTo and              
       (W.DivisionID=@DivisionID or @WareHouseID=0) and              
       D.ID=W.DivisionToID and              
       DE.ID=D.DivisionExtID and                             
       W.WHCardID>0 and                             
       W.DebetQuantity>0 and                             
       WH.ID=W.WHDocumentContentID and               
       WH.KindDocID!=@RevaluationID and -- не переоценка           
       WH.KindDocID!=@TurnOwnID and     -- не внутреннее перемещение           
       WH.KindDocID!=@InventoryID and   -- не инвентаризация   
       WH.KindDocID!=5 and   -- не реализация  
       WHDocument.ID=WH.WHDocumentID and                               
       WHCard.ID=W.WHCardID and                              
       WHDCExt.ID=WHCard.WHDCExtID               
 select @Result=@@error            
 if @Result!=0            
 return 1    
          
/*Реализация через кассы*/           
 insert into #T1                     
 select convert(numeric(1),2) as TypeTurn,           
        WHDocument.ID WHDocumentID,           
        WHDocument.Kind,           
        WHDocument.Date,           
        convert(varchar,BKCashDocument.SalePointID) as Number,     
        WHDocument.WareHouseID,     
        WHDocument.DivisionID,       
        W.Date as Date_Reestr,       
        DE.UNN,            
        --(select isnull(max(WareHouse.ID),0) from WareHouse where DivisionID=W.DivisionToID) WareHouseFromID,           
        --(select isnull(max(WareHouse.ID),0) from WareHouse where DivisionID=W.DivisionID) WareHouseToID,              
        WHCard.NomenclID,           
        W.DebetQuantity*WHCard.PriceF,           
        W.DebetQuantity*WHCard.PriceN,           
        W.DebetQuantity*WHCard.PricePAll,                 
        W.DebetQuantity*WH.PricePAll as SummOperWithDiscont, --Сумма товара со скидкой       
        W.DebetQuantity*(WHCard.PricePAll-WH.PricePAll)  as SummDiscont, --Сумма скидки      
        W.DebetQuantity*Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4) as SummTradeRaiseDiscont, -- Сумма скидки за счет ТН        
        W.DebetQuantity*Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4)*(WHCard.NDSPersent*0.01)as SummNDSDiscont,  -- Сумма скидки за счет НДС                                 
        W.DebetQuantity*((WHCard.PricePAll-WH.PricePAll) -Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4)-Round((WHCard.PricePAll-WH.PricePAll)/(1+WHCard.NDSPersent*0.01),4)*(WHCard.NDSPersent*0.01)) as SummRoundDiscon, -- Сумма скидки за счет Округления      
        W.CreditQuantity*(case when WHCard.NDSPersent=0 then WHCard.PriceN else 0 end) as SumPriceN_0,                 
        W.CreditQuantity*(case when WHCard.NDSPersent=10 then WHCard.PriceN else 0 end) as SumPriceN_10,                 
        W.CreditQuantity*(case when WHCard.NDSPersent=20 then WHCard.PriceN else 0 end) as SumPriceN_18,     
        W.DebetQuantity*(case when WHCard.NDSPersent=0 then WHCard.PricePAll else 0 end) as SumPricePALL_0,                 
        W.DebetQuantity*(case when WHCard.NDSPersent=10 then WHCard.PricePAll else 0 end) as SumPricePALL_10,                 
        W.DebetQuantity*(case when WHCard.NDSPersent=20 then WHCard.PricePAll else 0 end) as SumPricePALL_18,                     
        --выгружаю НДС поставщика         
        case when WHCard.NDSPersent=10 then Round(W.DebetQuantity*((WHCard.PriceN-WHDCExt.GlassPrice)*WHDCExt.SenderTax*0.01),2) else 0 end as NDSIn_10,                  
        case when WHCard.NDSPersent=20 then Round(W.DebetQuantity*((WHCard.PriceN-WHDCExt.GlassPrice)*WHDCExt.SenderTax*0.01),2) else 0 end as NDSIn_18,   
              
        W.DebetQuantity,           
        --case when WHCard.PriceF>WHCard.PriceN then 1 else 0 end as FixedPrice,           
        --case when exists(select 1 from #Tara where #Tara.TMCID=WHCard.NomenclID) then 1 else 0 end as IsTara,           
        convert(integer,0) as FixedPrice,        
        convert(integer,0) as IsTara,        
           
        Round(W.DebetQuantity*(WHCard.PriceN-WHDCExt.GlassPrice)*WHDCExt.SenderTax*0.01,2) NDSIn, --НДС в отпускной цене              
              
        W.DebetQuantity*Round((WHCard.PriceP-WHDCExt.GlassPrice)*WHCard.NDSPersent*0.01,2) NDSOut, --НДС в розничной цене              
                          
        W.DebetQuantity*(case when WHCard.NDSPersent=10 then Round((WHCard.PriceP-WHDCExt.GlassPrice)*0.1,2) else 0 end) NDSOut_10, --НДС в розничной цене         
         
        W.DebetQuantity*(case when WHCard.NDSPersent=20 then Round((WHCard.PriceP-WHDCExt.GlassPrice)*0.20,2) else 0 end) NDSOut_18,  --НДС в розничной цене         
         
        W.DebetQuantity*(WHCard.PricePAll-Round((WHCard.PriceP-WHDCExt.GlassPrice)*(1+WHCard.NDSPersent*0.01)*WHCard.SalesTax*0.01,2)-           
                          Round((WHCard.PriceP-WHDCExt.GlassPrice)*WHCard.NDSPersent*0.01,2)-(WHCard.PriceN-WHDCExt.GlassPrice)) SumTradeRaise,            
             
  
        W.DebetQuantity*Round((WHCard.PriceP-WHDCExt.GlassPrice)*(1+WHCard.NDSPersent*0.01)*WHCard.SalesTax*0.01,2) SumSalesTax,            
                     
        W.DebetQuantity*WHDCExt.GlassPrice GlassPrice,           
        W.DebetQuantity*WHDCExt.GlassPrice*WHDCExt.GlassNDS*0.01 GlassNDS,             
            
        --W.DebetQuantity*(WHCard.PricePAll-(WHCard.PriceP-WHDCExt.GlassPrice)*(1+WHCard.NDSPersent*0.01)*(1+WHCard.SalesTax*0.01)) SumRestOfRound           
        convert(money,0) SumRestOfRound           
 from WHTurn W (index WHTurn3_idx),                             
      WHDocumentContent WH (index  PK_WHDOCUMENTCONTENT),                             
      WHDocument,  
      BKCashDocument,                                                          
      WHCard (index PK_WHCARD),              
      WHDCExt, Division D,              
      DivisionExt DE           
 where W.Date>@DateFrom and W.Date<@DateTo and              
       (W.DivisionID=@DivisionID or @WareHouseID=0) and              
       D.ID=W.DivisionToID and              
       DE.ID=D.DivisionExtID and                             
       W.WHCardID>0 and                             
       W.DebetQuantity>0 and                             
       WH.ID=W.WHDocumentContentID and               
       WH.KindDocID=5 and   -- Реализация через кассу   
       WHDocument.ID=WH.WHDocumentID and    
       BKCashDocument.ID=WH.BKCashDocumentID and                                                          
       WHCard.ID=W.WHCardID and                              
       WHDCExt.ID=WHCard.WHDCExtID               
 select @Result=@@error            
 if @Result!=0            
 return 1     
          
/*Переоценка*/          
 insert into #T1                     
 select convert(numeric(1),3) as TypeTurn,           
        WHD.ID WHDocumentID,           
        WHD.Kind,           
        WHD.Date,           
        WHD.Number  + (case when WHD.Series<>'' then '-' +  WHD.Series else '' end) as Number,      
        WHD.WareHouseID,     
        convert(numeric(1),0) as DivisionID,       
        W.Date as Date_Reestr,       
        DE.UNN,            
        WHDC.NomenclID,          
        W.QuantityFact*(W.PriceF-OLD.PriceF) as SumPriceF,           
        W.QuantityFact*(W.PriceN-OLD.PriceN) as SumPriceN,           
        W.QuantityFact*(W.PricePAll-OLD.PricePAll)as SumPricePALL,       
        convert(money,0) as SummOperWithDiscont,            
        convert(money,0) as SummDiscont,            
        convert(money,0) as SummTradeRaiseDiscont,            
        convert(money,0) as SummNDSDiscont,       
        convert(money,0) as SummRoundDiscon,    
        W.QuantityFact*(case when W.NDSPersent=0 and OLD.NDSPersent=0         
                               then W.PriceN-OLD.PriceN        
                               when W.NDSPersent=0 and (OLD.NDSPersent=20 or OLD.NDSPersent=10)        
                               then W.PriceN         
                               when (W.NDSPersent=10 or W.NDSPersent=20) and OLD.NDSPersent=0         
                               then -OLD.PriceN         
                               else 0 end) as SumPriceN_0,         
        W.QuantityFact*(case when W.NDSPersent=10 and OLD.NDSPersent=10         
                               then W.PriceN-OLD.PriceN        
                               when W.NDSPersent=10 and (OLD.NDSPersent=20 or OLD.NDSPersent=0)        
                               then W.PriceN         
                               when (W.NDSPersent=0 or W.NDSPersent=20) and OLD.NDSPersent=10         
                               then -OLD.PriceN         
                               else 0 end) as SumPriceN_10,         
        W.QuantityFact*(case when W.NDSPersent=20 and OLD.NDSPersent=20         
                               then W.PriceN-OLD.PriceN        
                               when W.NDSPersent=20 and (OLD.NDSPersent=10 or OLD.NDSPersent=0)        
                               then W.PriceN         
                               when (W.NDSPersent=10 or W.NDSPersent=0) and OLD.NDSPersent=20         
                               then -OLD.PriceN         
                               else 0 end) as SumPriceN_18,         
              
        W.QuantityFact*(case when W.NDSPersent=0 and OLD.NDSPersent=0         
                               then W.PricePAll-OLD.PricePAll        
                               when W.NDSPersent=0 and (OLD.NDSPersent=20 or OLD.NDSPersent=10)        
                               then W.PricePAll         
                               when (W.NDSPersent=10 or W.NDSPersent=20) and OLD.NDSPersent=0         
                               then -OLD.PricePAll         
                               else 0 end) as SumPricePALL_0,         
        W.QuantityFact*(case when W.NDSPersent=10 and OLD.NDSPersent=10         
                               then W.PricePAll-OLD.PricePAll        
                               when W.NDSPersent=10 and (OLD.NDSPersent=20 or OLD.NDSPersent=0)        
                               then W.PricePAll         
                               when (W.NDSPersent=0 or W.NDSPersent=20) and OLD.NDSPersent=10         
                               then -OLD.PricePAll         
                               else 0 end) as SumPricePALL_10,         
        W.QuantityFact*(case when W.NDSPersent=20 and OLD.NDSPersent=20         
                               then W.PricePAll-OLD.PricePAll        
                               when W.NDSPersent=20 and (OLD.NDSPersent=10 or OLD.NDSPersent=0)        
                               then W.PricePAll         
                               when (W.NDSPersent=10 or W.NDSPersent=0) and OLD.NDSPersent=20         
                               then -OLD.PricePAll         
                               else 0 end) as SumPricePALL_18,         
        --выгружаю НДС поставщика         
        convert(money,0) as NDSIn_10,                  
        convert(money,0) as NDSIn_18,            
        W.QuantityFact,                       
        convert(integer,0) as FixedPrice,        
        convert(integer,0) as IsTara,        
        Round(W.QuantityFact*((W.PriceN-WHDCExt.GlassPrice)*WHDCExt.SenderTax*0.01-(OLD.PriceN-OLDExt.GlassPrice)*OLDExt.SenderTax*0.01),2) NDSIn, --НДС в отпускной цене              
        --Возьмем обратным счетом    
        --W.QuantityFact*(Round((W.PriceP-WHDCExt.GlassPrice)*W.NDSPersent*0.01,2)-Round((OLD.PriceP-OLDExt.GlassPrice)*OLD.NDSPersent*0.01,2)) NDSOut, --НДС в розничной цене     
        W.QuantityFact*(round(W.PricePAll/(1+W.NDSPersent*0.01)*(W.NDSPersent*0.01),4)-round(OLD.PricePAll/(1+OLD.NDSPersent*0.01)*(OLD.NDSPersent*0.01),4)) NDSOut, --НДС в розничной цене              
        W.QuantityFact*(case when W.NDSPersent=10 and OLD.NDSPersent=10         
                               then round(W.PricePAll/(1+W.NDSPersent*0.01)*(W.NDSPersent*0.01),4)-round(OLD.PricePAll/(1+OLD.NDSPersent*0.01)*(OLD.NDSPersent*0.01),4)    
                               when W.NDSPersent=10 and (OLD.NDSPersent=20 or OLD.NDSPersent=0)         
                               then round(W.PricePAll/(1+W.NDSPersent*0.01)*(W.NDSPersent*0.01),4)    
                               when (W.NDSPersent=20 or W.NDSPersent=0) and OLD.NDSPersent=10         
                               then -round(OLD.PricePAll/(1+OLD.NDSPersent*0.01)*(OLD.NDSPersent*0.01),4)    
                               else 0 end) NDSOut_10, --НДС в розничной цене         
         
        W.QuantityFact*(case when W.NDSPersent=20 and OLD.NDSPersent=20         
                               then round(W.PricePAll/(1+W.NDSPersent*0.01)*(W.NDSPersent*0.01),4)-round(OLD.PricePAll/(1+OLD.NDSPersent*0.01)*(OLD.NDSPersent*0.01),4)    
                               when (W.NDSPersent=10 or W.NDSPersent=0) and OLD.NDSPersent=20         
                               then -round(OLD.PricePAll/(1+OLD.NDSPersent*0.01)*(OLD.NDSPersent*0.01),4)    
                               when W.NDSPersent=20 and (OLD.NDSPersent=10 or OLD.NDSPersent=0)         
                               then round(W.PricePAll/(1+W.NDSPersent*0.01)*(W.NDSPersent*0.01),4)    
                               else 0 end) NDSOut_18, --НДС в розничной цене         
         
        W.QuantityFact*((W.PricePAll-W.PriceN-round(W.PricePAll/(1+W.NDSPersent*0.01)*(W.NDSPersent*0.01),4))-          
                        (OLD.PricePAll-OLD.PriceN-round(OLD.PricePAll/(1+OLD.NDSPersent*0.01)*(OLD.NDSPersent*0.01),4))) SumTradeRaise,           
           
        W.QuantityFact*(Round((W.PriceP-WHDCExt.GlassPrice)*(1+W.NDSPersent*0.01)*W.SalesTax*0.01,2)-          
                        Round((OLD.PriceP-OLDExt.GlassPrice)*(1+OLD.NDSPersent*0.01)*OLD.SalesTax*0.01,2)) SumSalesTax,            
        W.QuantityFact*(WHDCExt.GlassPrice-OLDExt.GlassPrice) GlassPrice,           
        W.QuantityFact*(WHDCExt.GlassPrice*WHDCExt.GlassNDS*0.01-OLDExt.GlassPrice*OLDExt.GlassNDS*0.01) GlassNDS,             
            
        --W.DebetQuantity*(WHCard.PricePAll-(WHCard.PriceP-WHDCExt.GlassPrice)*(1+WHCard.NDSPersent*0.01)*(1+WHCard.SalesTax*0.01)) SumRestOfRound           
        convert(money,0) SumRestOfRound           
 from WHDocument WHD (index WH_Date_Kind_idx),          
      Division D, DivisionExt DE,          
      WHDocumentContent WHDC (index WHDocument_idx),          
      WHTurn (index WHTurn4_idx),            
      WHCard W (index PK_WHCARD),              
      WHDCExt,              
      WHCard OLD,               
      WHDCExt OLDExt          
 where WHD.Date>@DateFrom and           
       WHD.Date<@DateTo and          
       WHD.WareHouseID>0 and          
       WHD.Kind=@RevaluationID and -- переоценка          
       D.ID=WHD.DivisionID and          
       DE.ID=D.DivisionExtID and                             
       WHDC.WHDocumentID=WHD.ID and  
       --WHDC.WHDocumentID not in (33743,33744,33745,33746,33757) and                     
       WHTurn.WHDocumentContentID=WHDC.ID and  --новый вариант                                  
       WHTurn.CreditQuantity>0 and             --новый вариант берем приходную часть            
       W.ID=WHTurn.WHCardID and                --новый вариант       
       (WHTurn.DivisionID=@DivisionID or @WareHouseID=0) and                        
       WHDCExt.ID=W.WHDCExtID and                       
       OLD.ID=W.SourceWHCardID and                       
       OLDExt.ID=OLD.WHDCExtID          
 --group by WHD.ID, WHD.Kind, WHD.Date, WHD.Number, DE.UNN, WHDC.NomenclID          
          
        
        
 -- вывод данных          
 select WHDocumentID,TypeTurn,Kind,Date,Number,WareHouseID,DivisionID,     
        convert(varchar(10),Date_Reestr,104)as Date_Reestr,UNN,--FixedPrice,IsTara,  --WareHouseFromID,WareHouseToID,           
        convert(integer,0) as FixedPrice,        
        convert(integer,0) as IsTara,        
        sum(SumPriceF) sumPriceF,           
        sum(SumPriceN) sumPriceN,           
        sum(SumPricePAll) sumPricePALL,        
        sum (SummOperWithDiscont) SummOperWithDiscont, --Сумма скидки      
        sum (SummDiscont) SummDiscont,            
        sum (SummTradeRaiseDiscont) SummTradeRaiseDiscont,            
        sum (SummNDSDiscont) SummNDSDiscont,       
        sum (SummRoundDiscon) SummRoundDiscon,    
        isnull(sum(SumPriceN_0),0) sumPriceN_0,        
        isnull(sum(SumPriceN_10),0) sumPriceN_10,        
        isnull(sum(SumPriceN_18),0) sumPriceN_18,                   
        isnull(sum(SumPricePAll_0),0) sumPricePALL_0,        
        isnull(sum(SumPricePAll_10),0) sumPricePALL_10,        
        isnull(sum(SumPricePAll_18),0) sumPricePALL_18,        
        isnull(sum(NDSIn_10),0) NDSIn_10,         
        isnull(sum(NDSIn_18),0) NDSIn_18,         
        sum(QuantityFact) QuantityFact,           
        sum(NDSIn) NDSIn,           
        round(sum(NDSOut),2) NDSOut,              
        round(isnull(sum(NDSOut_10),0),2) NDSOut_10,              
        round(isnull(sum(NDSOut_18),0),2) NDSOut_18,              
        round(sum(SumTradeRaise),2) SumTradeRaise,           
        sum(SumSalesTax) SumSalesTax,              
        sum(SumRestOfRound) SumRestOfRound,            
        sum(GlassPrice) GlassPrice,            
        sum(GlassNDS) GlassNDS,        
        case   --Kind 5-реализация товара через кассы           
         when Kind in (5,98)        
          then (select sum(SumCash) from BKCashDocument B (index Date_idx)  
                where B.Date between convert(datetime, convert(varchar(10),#T1.Date,104)+' 00:00',104) and convert(datetime,convert(varchar(10),#T1.Date,104)+' 23:59',104) and        
                      B.Kind=#T1.TypeTurn and   
                      B.SalePointID=convert(numeric(10),#T1.Number) and       
                      B.Dissolving=0 and   
                      B.WHDocumentID=#T1.WHDocumentID)        
         else convert(money,0)        
        end as SumNal,        
        case            
         when Kind in (5,98)       
          then (select sum(SumCard) from BKCashDocument B (index Date_idx)     
                where B.Date between convert(datetime, convert(varchar(10),#T1.Date,104)+' 00:00',104) and convert(datetime,convert(varchar(10),#T1.Date,104)+' 23:59',104) and        
                      B.Kind=#T1.TypeTurn and    
                      B.SalePointID=convert(numeric(10),#T1.Number) and      
                      B.Dissolving=0 and   
                      B.WHDocumentID=#T1.WHDocumentID)        
         else convert(money,0)        
        end as SumBNal,   
              case            
         when Kind in (5,98)       
          then (select sum(SumNotCach) from BKCashDocument B (index Date_idx)  
                where B.Date between convert(datetime, convert(varchar(10),#T1.Date,104)+' 00:00',104) and convert(datetime,convert(varchar(10),#T1.Date,104)+' 23:59',104) and        
                      B.Kind=#T1.TypeTurn and   
                      B.SalePointID=convert(numeric(10),#T1.Number) and       
                      B.Dissolving=0 and   
                      B.WHDocumentID=#T1.WHDocumentID)        
         else convert(money,0)        
        end as SumNotCach        
         
 from #T1              
 group by WHDocumentID,TypeTurn,Kind,Date,Number,WareHouseID,DivisionID,convert(varchar(10),Date_Reestr,104),UNN        
          --FixedPrice,IsTara             
          --WareHouseFromID,WareHouseToID,           
 order by TypeTurn,Kind,Date,Number,UNN           
             
 select @Result=@@error                  
 return 1                  
end
go
Grant Execute on LoadDataTo1cTurn to AllUser 
go