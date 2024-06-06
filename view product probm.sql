create table Products (
    ProductID int primary key,
    ProductName varchar(20), 
    Price int, 
    StockQuantity int
    );

-- Task 1: Create the view
create view ProductDetails as
select ProductID, ProductName, Price, StockQuantity from Products;

-- Task 2: Drop the view if it exists
begin
   execute immediate 'drop view ProductDetails';
exception
   when others then
      if sqlcode != -942 then -- ORA-00942: table or view does not exist
         raise;
      end if;
end;

-- Task 3: Verify if the view exists
select view_name from user_views where view_name = 'PRODUCTDETAILS';
