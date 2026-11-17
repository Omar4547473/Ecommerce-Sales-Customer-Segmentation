select top(10) * from merged_dataset_retail_2009_2011

select COUNT(*) as total,
sum(case when Invoice like 'C%' THEN 1 ELSE 0 END) AS cancelled_invoices,
sum(case when Quantity <= 0 then 1 else 0 end)AS negative_or_zero_qty,
sum(case when Price  <= 0 then 1 else 0 end)AS zero_or_negative_price,
sum(case when Customer_ID is null then 1 else 0 end) as  missing_customers,
sum(case when Description is null then 1 else 0 end) as  missing_descriptions

from merged_dataset_retail_2009_2011

select Invoice,StockCode,Description,Quantity,Price,Customer_ID, Country,(Quantity * Price)AS Total_Revenue
into clean_retail_data
from merged_dataset_retail_2009_2011
where Invoice not like 'C%'
and Quantity >0 and Price>0 and Customer_ID is not null and  Description IS NOT NULL;

select top(5) * from clean_retail_data


select SUM(Total_Revenue) ,
COUNT(DISTINCT Invoice),
COUNT(DISTINCT Customer_ID),
COUNT(DISTINCT StockCode)
from clean_retail_data


select top(10)  
Description,
sum(Quantity)as tota_Quantity,
sum(Total_Revenue)as total
from clean_retail_data
group by Description
order by total desc

select top(10)
Country,
COUNT(DISTINCT Customer_ID)as tope_customer,
sum(Total_Revenue)as total_rv
from clean_retail_data
group by Country
order by total_rv desc

select top(10) 
Country,
Customer_ID,
COUNT(DISTINCT Invoice) as total_invoice,
SUM(Total_Revenue) as total_rev
from clean_retail_data
group by Country , Customer_ID 
order by total_rev desc 

