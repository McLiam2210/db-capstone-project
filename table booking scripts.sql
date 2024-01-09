-- CheckBooking stored proc
delimiter //
drop procedure if exists CheckBooking //
create procedure CheckBooking(IN date_ DATE, IN table_no INT)
begin
declare table_booked tinyint(1);
declare message varchar(255);

select exists( 
	select bookingid from bookings as b
	where b.date = date_ and b.tableno = table_no)
into table_booked;

if table_booked then
	set message = concat('Table ', table_no, ' is already booked');
else
	set message = concat('Table ', table_no, ' is not booked');
end if;

select message as 'Booking status';

end
//
delimiter ;

-- call CheckBooking('2022-10-10', 1);


-- AddValidBooking proc
delimiter //
drop procedure if exists AddValidBooking //
create procedure AddValidBooking(IN date_ DATE, IN table_no INT) 
begin 
declare table_booked tinyint(1);
declare message varchar(255);

start transaction;
select exists( 
	select bookingid from bookings as b
	where b.date = date_ and b.tableno = table_no)
into table_booked;

if table_booked = 0 then
	insert into bookings(date, TableNo) values (date_, table_no);
    select concat('Table ', table_no, ' has been booked') into message;
else
	select concat('Table ', table_no, ' is already booked - booking cancelled') into message;
end if;
commit;
select message as 'Booking status';

end //
delimiter ;

-- call AddValidBooking('2024-02-01', 3);	


-- AddBooking proc
delimiter //
drop procedure if exists AddBooking //
create procedure AddBooking(
IN bookingid_ INT, IN customerid_ INT, IN table_no INT, IN date_ DATE)

begin
insert into bookings (bookingid, customerid, tableno, date) values
(bookingid_, customerid_, table_no, date_);

select 'New booking added' as Confirmation;
end //
delimiter ;

-- call AddBooking(13, 3, 3, '2024-01-05');



-- UpdateBooking proc
delimiter //
drop procedure if exists UpdateBooking //
create procedure UpdateBooking(
IN bookingid_ INT, IN date_ DATE)

begin
update bookings
set bookings.date = date_
where bookingid = bookingid_;
end //
delimiter ;

-- call UpdateBooking(13, '2024-01-05');



-- DeleteBooking proc
delimiter //
drop procedure if exists DeleteBooking //
create procedure DeleteBooking(
IN bookingid_ INT)

begin
delete from bookings
where bookingid = bookingid_;
end //
delimiter ;

call DeleteBooking(13);