#*******************************************************#
# Insert query to populate "MenuItems" table:
#*******************************************************#

INSERT INTO MenuItems (ItemID, Name, Type, Price)
VALUES
(1, 'Olives','Starters',5),
(2, 'Flatbread','Starters', 5),
(3, 'Minestrone', 'Starters', 8),
(4, 'Tomato bread','Starters', 8),
(5, 'Falafel', 'Starters', 7),
(6, 'Hummus', 'Starters', 5),
(7, 'Greek salad', 'Main Courses', 15),
(8, 'Bean soup', 'Main Courses', 12),
(9, 'Pizza', 'Main Courses', 15),
(10, 'Greek yoghurt','Desserts', 7),
(11, 'Ice cream', 'Desserts', 6),
(12, 'Cheesecake', 'Desserts', 4),
(13, 'Athens White wine', 'Drinks', 25),
(14, 'Corfu Red Wine', 'Drinks', 30),
(15, 'Turkish Coffee', 'Drinks', 10),
(16, 'Turkish Coffee', 'Drinks', 10),
(17, 'Kabasa', 'Main Courses', 17);

#*******************************************************#
# Insert query to populate "Menu" table:
#*******************************************************#

INSERT INTO Menus (MenuID,ItemID,Cuisine)
VALUES
(1, 1, 'Greek'),
(1, 7, 'Greek'),
(1, 10, 'Greek'),
(1, 13, 'Greek'),
(2, 3, 'Italian'),
(2, 9, 'Italian'),
(2, 12, 'Italian'),
(2, 15, 'Italian'),
(3, 5, 'Turkish'),
(3, 17, 'Turkish'),
(3, 11, 'Turkish'),
(3, 16, 'Turkish');

#*******************************************************#
# Insert query to populate "customer" table:
#*******************************************************#

INSERT INTO customer (customerID,name,phone,email)
VALUES
(1, "John Smith", '0400000000', "dfg@gjedl.com"),
(2, "Anna Iversen", "0489284820", "dfjs@lfgj.com"),
(3, "John Smith", '0400000090', "dfg@gjedfdl.com"),
(4, "John dsg", '0400000010', "dfg@gjeddfl.com"),
(5, "John Sghfghdmith", '0400004000', "dfdssg@gjedl.com"),
(6, "John Smidfsdfth", '0400000600', "dfg@gjdfsedl.com"),
(7, "John Smisdfsdth", '0404000000', "dfg@gjessdl.com"),
(8, "John Smsdfsdith", '0406000000', "dfgggg@ggjedl.com");

#*******************************************************#
# Insert query to populate "Employees" table:
#*******************************************************#

INSERT INTO employees (EmployeeID, Name, Role, Address, Contact_Number, Email, Annual_Salary) VALUES
(01,'Mario Gollini','Manager','724, Parsley Lane, Old Town, Chicago, IL',351258074,'Mario.g@littlelemon.com','$70,000'),
(02,'Adrian Gollini','Assistant Manager','334, Dill Square, Lincoln Park, Chicago, IL',351474048,'Adrian.g@littlelemon.com','$65,000'),
(03,'Giorgos Dioudis','Head Chef','879 Sage Street, West Loop, Chicago, IL',351970582,'Giorgos.d@littlelemon.com','$50,000'),
(04,'Fatma Kaya','Assistant Chef','132  Bay Lane, Chicago, IL',351963569,'Fatma.k@littlelemon.com','$45,000'),
(05,'Elena Salvai','Head Waiter','989 Thyme Square, EdgeWater, Chicago, IL',351074198,'Elena.s@littlelemon.com','$40,000'),
(06,'John Millar','Receptionist','245 Dill Square, Lincoln Park, Chicago, IL',351584508,'John.m@littlelemon.com','$35,000');

#*******************************************************#
# Insert query to populate "Bookings" table:
#*******************************************************#

INSERT INTO Bookings (BookingID, TableNo, customerID, BookingSlot, EmployeeID)
VALUES
(1, 12, 1,'19:00:00',1),
(2, 12, 2, '19:00:00', 1),
(3, 19, 3, '15:00:00', 3),
(4, 15, 4, '17:30:00', 4),
(5, 5,  5, '18:30:00', 2),
(6, 8,  6, '20:00:00', 5);

#*******************************************************#
# Insert query to populate "Orders" table:
#*******************************************************#

INSERT INTO Orders (OrderID, TableNo, MenuID, BookingID, Quantity, BillAmount)
VALUES
(1, 12, 1, 1, 2, 86),
(2, 19, 2, 2, 1, 37),
(3, 15, 2, 3, 1, 37),
(4, 5, 3, 4, 1, 40),
(5, 8, 1, 5, 1, 43);
