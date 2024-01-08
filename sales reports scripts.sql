-- TASK 1
drop view if exists OrdersView;
create view OrdersView as
SELECT orderid, Quantity, BillAmount
FROM LittleLemon.Orders
WHERE Quantity >= 2;

-- TASK 2
select distinct c.customerid, c.name, m.cuisine, o.billamount, mi.name
from customer as c
join orders as o
on c.customerID = o.customerID
join menus as m 
on o.menuid = m.menuid
join menuitems as mi
on m.itemid = mi.itemid
where o.billamount > 50;

-- TASK 3
select m.cuisine, m.itemid, mi.name
from menus as m
join 
	(select o.menuid, count(orderid) 
	from orders as o
	group by menuid
    having count(orderid) > 1) as x
on m.menuid = x.menuid
join menuitems as mi
on mi.itemid = m.itemid;

-- Stored proc
drop procedure if exists GetMaxQuantity;
create procedure GetMaxQuantity()
select max(quantity) as MaxQuantity from orders;
call GetMaxQuantity();

-- Prepared Statement
prepare GetOrderDetails 
from 'select orderid, billamount, quantity from orders where orderid = ?';
set @id = 1;
execute GetOrderDetails using @id;

-- stored proc 2
delimiter //
drop procedure if exists CancelOrder;
create procedure CancelOrder(IN order_id INT)
BEGIN
delete from orders
where orderid = order_id;
select concat('Order ', order_id, ' is cancelled') as Confirmation;
END //
delimiter ;

call CancelOrder(6);




