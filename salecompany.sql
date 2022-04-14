/*DATABASE CREATION*/
/*drop database `saleCompany`;*/
CREATE DATABASE IF NOT EXISTS `saleCompany`;
USE `saleCompany`;
/*TABLE CREATION*/

CREATE TABLE IF NOT EXISTS customer
(
  `email` varchar(20) NOT NULL,
  `CID` char(8) NOT NULL,
  `name` varchar(10) NOT NULL,
  `surname` varchar(10) NOT NULL,
  `address` varchar(30) NOT NULL,
  `phoneNr` varchar(20) NOT NULL,
  PRIMARY KEY (`CID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS category
(
  `catID` char(1) NOT NULL,
  `name` varchar(20) NULL,
  PRIMARY KEY (`catID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS department
(
  `depName` enum('Sales','Management','Finances') NOT NULL,
  `depID` char(1) NOT NULL,
  PRIMARY KEY (`depID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS store
(
  `storeID` char(1) NOT NULL,
  `sLocation` varchar(40) NOT NULL,
  PRIMARY KEY (`storeID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS employee
(
  `EID` char(8) NOT NULL,
  `name` varchar(20) NOT NULL,
  `surname` varchar(10) NOT NULL,
  `address` varchar(20) NOT NULL,
  `phoneNr` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `salary` int NOT NULL,
  `position` enum('Simple','Manager','Director') NOT NULL,
  `depID` char(8) NOT NULL,
  `storeID` char(8) NOT NULL,
  PRIMARY KEY (`EID`),
  constraint `department` foreign key (`depID`) REFERENCES department(`depID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  constraint `store` FOREIGN KEY (`storeID`) REFERENCES store(`storeID`) ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS family
(
  `name` varchar(20) NOT NULL,
  `surname`  varchar(20) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `persID` varchar(12) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `relation` varchar(20) NOT NULL,
  `EID` char(8) NOT NULL,
  PRIMARY KEY (`persID`),
  constraint FOREIGN KEY (`EID`) REFERENCES employee(`EID`) on update cascade
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS invoice
(
  `IID` char(4) NOT NULL,
  `date` date NOT NULL,
  `value` int ,
  `EID` char(8) NOT NULL,
  `CID` char(8) NOT NULL,
  PRIMARY KEY (`IID`),
  constraint `employee` FOREIGN KEY (`EID`) REFERENCES employee(`EID`) on delete no action on update cascade,
  constraint `customer` foreign KEY (`CID`) REFERENCES customer(`CID`) on delete no action on update cascade
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS stockMarket
(
  `quantity` int NOT NULL,
  `price` int NOT NULL,
  `StID` char(3) NOT NULL,
  `EID` char(8) NOT NULL,
  PRIMARY KEY (`StID`),
  FOREIGN KEY (`EID`) REFERENCES employee(`EID`) on update cascade
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS product
(
  `PID` char(5) NOT NULL,
  `name` varchar(20) NOT NULL,
  `price` int NOT NULL,
  `dateManufactured` date NOT NULL,
  `description` varchar(50) NOT NULL,
  `catID` char(8) NOT NULL,
  PRIMARY KEY (`PID`),
  FOREIGN KEY (`catID`) REFERENCES category(`catID`) on update cascade
  
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS sold
(
  `SID` char(6) NOT NULL,
  `quantity` int NOT NULL,
  `IID` char(8) NOT NULL,
  `PID` char(8) NOT NULL,
  PRIMARY KEY (`SID`),
  constraint `invoice`  FOREIGN KEY (`IID`) REFERENCES invoice(`IID`) on delete no action on update cascade,
  constraint `product`  FOREIGN KEY (`PID`) REFERENCES product(`PID`) on delete no action on update cascade
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*DATA INSERTION*/

INSERT INTO customer(`email`,`CID`,`name`,`surname`,`address`,`phoneNr`) VALUES 
	('khasani@hotmail.com','13546980','Kadri','Hasani','Durres','0698855421'),
    ('allulla@gmail.com','17894561','Albi','Llulla','Tirane','0698445733'),
    ('lshabani@yahoo.com','19786542','Leonard','Shabani','Kavaje','0698142273'),
    ('azyla@hotmail.com','13321568','Arber','Zyla','Durres','0691175732'),
    ('kbalaj@yahoo.com','17896544','Kevin','Balaj','Tirane','0691125537'),
    ('aseferi@gmail.com','17895645','Ana','Seferi','Tirane','0682248733'),
    ('beniEcen@hotmail.com','16321321','Beni','Ecen','Durres','0689421433'),
    ('bdoda@gmail.com','12135467','Besmir','Doda','Diber','0698445733'),
    ('vpetani@yahoo.com','18799878','Vasil','Petani','Durres','0698445733'),
    ('aGorea@hotmail.com','19999975','Andi','Gorea','Durres','0689494666'),
    ('kBalla@hotmail.com','20789456','Klejdi','Balla','Berat','0677788512'),
    ('magneli@gmail.com','25464561','Massimo','Agneli','Milano','00655847'),
    ('landiL@yahoo.com','21231232','Landi','Lezha','Shkoder','0678111723'),
    ('yHasamoto@gmail.com','22131233','Yuki','Hasamoto','Tokyo','1112254879'),
	('jallaisufi@gmail.com','12354678','Juxhin','Allaisufi','Tokyo','1113331879'),
	('ebasha@hotmail.com','65489762','Egi','Basha','Berat','0698656900');
    
/*select * from customer where address='Durres';*/

INSERT INTO category(`catID`,`name`) VALUES

	('1','Hardware'),
    ('2','Software'),
    ('3','Accessory'),
    ('4','Services');

INSERT INTO department(`depID`,`depName`) VALUES

	('1','Sales'),
    ('2','Management'),
    ('3','Finances');

INSERT INTO store (`storeID`,`sLocation`) VALUES

	('1','Tirane'),
    ('2','Tirana'),
    ('3','Durres'),
    ('4','Berat'),
    ('5','Shkoder'),
    ('6','Milano'),
    ('7','Tokyo');

INSERT INTO employee( `EID`,`name`,`surname`,`address`,`phoneNr`,`email`,`gender`,`salary`,`position`,`depID`,`storeID`) VALUES

	('11177789','Deni','Hysaj','Durres','0699282666','dHysaj@gmail.com','M',2000,'Director','2','1'),
    ('11264578','Andi','Garuli','Durres','0698142273','andiHysen@yahoo.com','M',1500,'Director','3','1'),
    ('11335312','Krist','Likaj','Durres','0694577882','kLikaj@gmail.com','M',1500,'Director','1','1'),
    ('11444567','Ana','Sema','Tirane','0696677113','anasema@hotmail.com','F',600,'Simple','1','1'),
    ('12412345','Selim','Kushaj','Tirane','0690021478','selimK@gmail.com','M',650,'Simple','1','1'),
    ('11333123','Arban','Keçi','Tirane','0699987412','arbanKeçi@yahoo.com','M',600,'Simple','1','1'),
    ('12117896','Kleo','Koka','Tirane','0684452177','kkoka@hotmail.com','M',700,'Manager','2','2'),
    ('33324689','Luka','Malaj','Tirane','06934533114','lukamalaj@yahoo.com','M',500,'Simple','1','2'),
    ('66678954','Oerd','Bylykbashi','Tirane','0675578415','oBylykbashi@gmail.com','M',600,'Simple','3','2'),
    ('17117895','Enea','Lami','Durres','0679282866','eLami@hotmail.com','M',700,'Manager','2','3'),
    ('44412346','Esi','Bakaj','Durres','0689212466','bakajesi@yahoo.com','M',500,'Simple','1','3'),
    ('13111547','Nensi','Marga','Durres','0691577846','nmarga@gmail.com','F',600,'Simple','3','3'),
    ('14567789','Evelin','Uliu','Berat','0699772666','euliu@hotmail.com','F',700,'Manager','2','4'),
    ('10114215','Selena','Meta','Berat','0679286766','sMeta@yahoo.com','F',500,'Simple','1','4'),
    ('14576224','Jasmina','Rama','Berat','0691232666','jrama@gmail.com','F',500,'Simple','3','4'),
    ('12345001','Armela','Ligori','Shkoder','0699281622','aligori@gmail.com','F',700,'Manager','2','5'),
    ('44332645','Luljeta','Cenaj','Shkoder','0699211636','lcenaj@hotmail.com','F',500,'Simple','1','5'),
    ('10002341','Dearda','Minçe','Shkoder','0697782666','minçeDearda@yahoo.com','F',500,'Simple','3','5'),
    ('98831465','Jasmina','Gaxheri','Milano','355664718','jgaxheri@yahoo.com','F',700,'Manager','2','6'),
    ('69971541','Leo','Miraka','Milano','3556112344','lMiraka@gmail.com','M',500,'Simple','1','6'),
    ('71122134','Olti','Veshi','Milano','3556122447','oltiveshi@gmail.com','M',500,'Simple','3','6'),
    ('13311134','Denado','Rabeli','Tokyo','112244784','drabeli18@epoka.edu.al','M',1200,'Manager','2','7'),
    ('15789117','Ernesto','Hemingway','Tokyo','11223578','vladD@yahoo.com','M',500,'Simple','1','7'),
    ('11214718','Lili','Likaj','Tokyo','11332387','liliLikaj@hotmail.com','F',500,'Simple','3','7'),
    ('33668799','Indrit','Agolli','Tirane','0691722546','iagolli@gmail.com','M',600,'Simple','3','1'),
    ('45444580','Gesti','Kuçi','Tirane','06996874166','gestiK@yahoo.com','M',500,'Simple','2','1');

INSERT INTO family (`name`,`surname`,`gender`,`persID`,`phoneNumber`,`relation`,`EID`) VALUES

	('Arben','Meta','M','12455744','066321142','Husband','10114215'),
    ('Klejdi','Rabeli','M','13344899','0695656561','Brother','13311134'),
    ('Anisa','Agolli','F','1234557','0672533456','Wife','33668799'),
    ('Kristina','Gorana','F','123354744','069966142','Wife','66678954'),
    ('Arben','Sema','M','132248975','068745142','Husband','11444567'),
    ('Leona','Koka','F','178956423','069785142','Mother','12117896'),
    ('Harry','Marga','M','156789','069921141','Husband','13111547'),
    ('Leonard','Kuçi','M','12354687','067841142','Cousin','45444580'),
    ('Arian','Rama','M','123477896','066323482','Brother','14576224'),
    ('Ana','Bakaj','F','13489655','0693248751','Sister','44412346'),
    ('Ariana','Cela','F','1965437','0671445679','Wife','11177789');

INSERT INTO invoice(`IID`,`date`,`value`,`EID`,`CID`) VALUES

	('0000','2020-05-24',600,'33324689','17894561'),
    ('0001','2020-03-23',500,'12412345','17896544'),
    ('0002','2020-05-12',400,'11444567','17895645'),
    ('0003','2020-05-21',50,'44412346','18799878'),
    ('0004','2020-03-20',100,'44412346','19999975'),
    ('0005','2020-04-26',300,'10114215','65489762'),
    ('0006','2020-05-23',200,'10114215','20789456'),
    ('0007','2020-05-18',250,'44332645','12135467'),
    ('0008','2020-03-19',450,'44332645','21231232'),
    ('0009','2020-04-01',100,'69971541','25464561'),
    ('0010','2020-05-03',600,'15789117','22131233'),
    ('0011','2020-03-25',1500,'15789117','12354678'),
    ('0012','2020-04-19',150,'11444567','17896544'),
    ('0013','2020-05-20',100,'33324689','19786542'),
	('0014','2020-04-29',20,'10114215','20789456'),
	('0015','2020-05-09',120,'69971541','25464561');
    
INSERT INTO stockMarket(`quantity`,`price`,`StID`,`EID`)VALUES 

	(25,1200,'001','11264578'),
    (10,800,'002','13111547'),
    (15,1000,'003','14576224'),
    (10,600,'004','10002341'),
    (5,500,'005','71122134'),
    (9,1300,'006','11214718');

INSERT INTO product(`PID`,`name`,`price`,`dateManufactured`,`description`,`catID`) VALUES

	('00001','Headphones XR-31',50,'2020-03-25','A pair of bluetooth connectable headphones','3'),
    ('00002','SimXR234-Vers2',100,'2020-03-20','Graphic card','1'),
    ('00003','CPU DR4445LL',200,'2020-03-25','CPU','1'),
    ('00004','CPU GranZ8000',300,'2020-03-25','CPU','1'),
    ('00005','Transistor 2N6408',20,'2020-03-25','An electric component','1'),
    ('00006','GC 245HighVISION',150,'2020-03-25','Graphic card','1'),
    ('00007','GC 22247VISION',200,'2020-03-25','Graphic card','1'),
    ('00008','Memory Card 100TB',500,'2020-03-25','A memory card of a certain size','1'),
    ('00009','Adapter HP Universal',50,'2020-03-25','Accessor','3'),
    ('00010','Installations',300,'2019-03-01','Installations -Prices start from 300 but vary','4'),
    ('00011','Repairs',250,'2019-03-01','Repairs -Prices start from 250 but vary','4');

INSERT INTO sold(`SID`,`IID`,`PID`,`quantity`) VALUES 

    ('000000','0000','00008',1),
    ('000001','0000','00002',1),
    ('000002','0001','00004',1),
    ('000003','0001','00007',1),
	('000004','0002','00010',1),
    ('000005','0002','00002',1),
    ('000006','0003','00009',1),
    ('000007','0004','00005',5),
    ('000008','0005','00006',1),
    ('000009','0005','00006',1),
    ('000010','0006','00007',1),
    ('000011','0007','00011',1),
    ('000012','0008','00011',1),
    ('000013','0008','00003',1),
    ('000014','0009','00009',2),
    ('000015','0010','00008',1),
    ('000016','0010','00002',1),
    ('000017','0011','00010',1),
    ('000018','0011','00011',1),
    ('000019','0011','00006',1),
    ('000020','0011','00002',1),
    ('000021','0011','00003',1),
    ('000022','0011','00008',1),
    ('000023','0012','00006',1),
    ('000024','0013','00001',2),
    ('000025','0014','00005',1),
    ('000026','0015','00002',1),
    ('000027','0015','00005',1);

/*Querys */

/*Query 1 -> Name of all products sold by an employee whose name is Ernesto and date of invoice was 2020-05-03*/

select name from product where PID in 
(select PID from sold where IID = 
(select IID from invoice where EID in 
(select EID from employee where name ='Ernesto') and date ='2020-05-03'));

/*Query 2 -> Name and surname of costumer/s who bought products on the date 2020-05-18*/

select name,surname from customer where CID=
(select CID from invoice where date='2020-05-18' );

/*Query 3 -> Relationship between employee and it's family member for the employee who sold invoice nr 0003*/

select relation from family where EID=
(select EID from invoice where IID='0003');

/*Query 4 -> All family members who do not share the same surname with the employee they are connected to */

select E.name as A,E.surname as B ,F.name as C,F.surname as D,F.relation as Relation 
from employee as E ,family as F where E.EID=F.EID and E.surname != F.surname;

/*Query 5 -> How many products named Transistor 2N6408 were sold in invoice printed by employee Esi on date 2020-03-20. */

select quantity from sold where IID=
	(select IID from invoice where EID=(select EID from employee where name ='Esi') and date='2020-03-20')
	and PID=
	(select PID from product where name='Transistor 2N6408');

/*Query 6 -> All employees who work in the tokyo store and their position in this store */

select name,surname from employee where storeID=(select storeID from store where slocation='Tokyo');

/*Query 7 ->Count how many times product named 'Memory Card 100TB' have been part of an invoice*/

select count(SID) from sold where pid=(select pid from product where name='Memory Card 100TB');

/*Query 8 -> Find the director of the Finances department */

select name,surname from employee where position='Director' and depID=(select depID from department where depName='Finances');

/*Query 9 -> Who is the manager of the Tokyo store and what is his salary */

select * from employee where position='Manager' 
and depID=(select depID from department where depName='Management') 
and storeID=(select storeID from store where slocation='Tokyo');

/*Query 10-> Find the 3 most well payed managers */

SELECT name,surname,salary from employee where position='Manager' order by salary desc limit 3;

/*Query 11-> Find the least expensive product in invoice printed by Luljeta*/

select * from product where pid in 
(select pid from sold where iid in
(select iid from invoice where eid =
(select eid from employee where name='Luljeta')) ) order by price limit 1;

/*Query 12-> Names and price of products of the hardware category that cost more than 100 euros */

select name as NameOfProduct , price as Price from product 
where catId=(select catID from category where name='Hardware') and price>100;

/*Query 13-> Name of products that have never been sold in the Durres store*/

select product.name as Name_Of_Product from product where pid not in 
(select pid from sold where iid in
(select iid from invoice where eid in
(select eid from employee where storeID in (select storeID from store where slocation='Durres') and position='Simple')));

													/*Triggers*/

 /*Trigger to set minimal salary of employee as 600 euros .*/
 
DELIMITER //
CREATE TRIGGER salbelow BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
IF NEW.salary<600 THEN SET NEW.salary=600;
END IF;
END//
DELIMITER ;

/*Trigger to warn when deleting invoice data*/

DELIMITER //
CREATE TRIGGER warning BEFORE DELETE ON invoice
FOR EACH ROW
BEGIN
	IF old.iid like '%0' THEN 
		signal sqlstate '45000'
			set message_text='You cannot delete invoice information !!';
	END IF;
END//
DELIMITER ;

/*Trigger to check when entering data of stock market to check if the employee is from finance*/

DELIMITER //
CREATE TRIGGER stockEmployee BEFORE insert ON stockmarket
FOR EACH ROW
BEGIN
	IF new.EID not in (select eid from employee where depID='3') then 
		signal sqlstate '45000'
			set message_text='You cannot enter an employee that is not part of finance as a controller of stock market !!';
	END IF;
END//
DELIMITER ;

/*Trigger to check if person printing invoice is not from the sales department*/

DELIMITER //
CREATE TRIGGER allowPrinting BEFORE insert ON invoice
FOR EACH ROW
BEGIN
	IF new.EID not in (select eid from employee where depID='1' and position='Simple') then 
		signal sqlstate '45000'
			set message_text='This employee cannot print the invoice !!';
	END IF;
END//
DELIMITER ;

/*Trigger to check if position of employee from finances is that of manager */

DELIMITER //
CREATE TRIGGER financeManager BEFORE insert ON employee
FOR EACH ROW
BEGIN
	IF new.EID in (select eid from employee where depID='3' and position='Manager') then 
		signal sqlstate '45000'
			set message_text='You cannot enter a manager of finances';
	END IF;
END//
DELIMITER ;

/*Trigger that doesn't allow the entrance of new directors */

DELIMITER //
CREATE TRIGGER newDirector BEFORE insert ON employee
FOR EACH ROW
BEGIN
	IF new.EID in (select eid from employee where position='Director') then 
		signal sqlstate '45000'
			set message_text='You cannot enter a new director';
	END IF;
END//
DELIMITER ;

/*Trigger to not allow the deletion of director*/

DELIMITER //
CREATE TRIGGER delDirector BEFORE delete ON employee
FOR EACH ROW
BEGIN
	IF old.EID in (select eid from employee where position='Director') then 
		signal sqlstate '45000'
			set message_text='You cannot delete a director';
	END IF;
END//
DELIMITER ;


															/*Functions*/  
  
/*Function to determine if there are more male or female employees */

DELIMITER //
DROP function IF EXISTS gender_Equality//
CREATE function gender_Equality() returns varchar(50)
deterministic
begin
	declare outp varchar(50);
	declare totalMale int;
	declare totalFemale int;
	select count(EID) into totalMale from employee where gender='M';
	select count(EID) into totalFemale from employee where gender='F';
	if totalMale>totalFemale
	then set outp='There are more males ';
	elseif totalFemale>totalMale
	then set outp='There are more females ';
    else 
    set outp='Equal number of females and males';
	END IF;
	return(outp);
	END//
DELIMITER ;

select max(gender_Equality()) as Males_or_Females from employee;

/*Function to get the phone number of family member of employee given employee name */

DELIMITER //
DROP function IF EXISTS get_Phone//
create function get_Phone(n varchar(20)) returns varchar(20)
deterministic
begin
	declare outp varchar(20);
	if exists (select distinct EID from family where EID=(select EID from employee where name=n)) 
	then set outp=(select phoneNumber from family where family.EID=(select EID from employee where name=n));
	else 
	set outp='Such an employee either does not exist or has no family member';
	END IF;
	return(outp);
	END//
DELIMITER ;

select distinct get_Phone('Denado') from family;

/*Function to get nr of invoices printed by a certain employee*/

DELIMITER //
DROP function IF EXISTS invoices_By//
create function invoices_By(n varchar(20)) returns varchar(50)
deterministic
begin
	declare outp varchar(50);
	if exists (select distinct EID from invoice where EID in (select EID from employee where name=n)) 
    then set outp= (select count(IID) from invoice where EID in (select EID from employee where name=n));
    else 
	set outp='Such an employee either does not exist or has printed no invoices';
	END IF;
	return(outp);
	END//
DELIMITER ;

select distinct invoices_By('Ernesto') from family;
/*Query implementation of the same function*/
select count(IID) from invoice where eid in(select eid from employee where name='Ernesto');

/*Procedures*/

/*Procedure 1 -> To get the store location given employee name */

DELIMITER //
DROP PROCEDURE IF EXISTS GetOfficeByName//
CREATE PROCEDURE GetOfficeByName(IN EmpName VARCHAR(20))
BEGIN
SELECT slocation from store where storeID=(select storeID from employee where name=EmpName);
END //
DELIMITER ;

CALL GetOfficeByName('Deni');

/*Procedure 2 -> Return all data of the employees part of a department*/

DELIMITER //
DROP PROCEDURE IF EXISTS getEmployeeOfDepartment//
CREATE PROCEDURE getEmployeeOfDepartment(IN DepartmentName VARCHAR(20))
BEGIN
SELECT * from employee where depID=(select depID from department where depName=DepartmentName);
END //
DELIMITER ;

CALL getEmployeeOfDepartment('Finances');

/*Procedure 3-> Get all products and their quantity sold in a certain invoice*/

DELIMITER //
DROP PROCEDURE IF EXISTS getProducts//
CREATE PROCEDURE getProducts(IN invoiceIdNum VARCHAR(20))
BEGIN
SELECT product.name as PRODUCT_Name,sold.quantity as Quantity from product,sold where product.pid in (select pid from sold where iid=invoiceIdNum) and sold.SID in (select sid from sold where iid=invoiceIdNum) ;
END //
DELIMITER ;

CALL getProducts('0007');

/*Procedure 4-> Set discount for good customers .*/

DELIMITER //
DROP PROCEDURE IF EXISTS discounts//
CREATE PROCEDURE discounts(IN invoiceIdNum VARCHAR(20),out output varchar(30))
BEGIN
declare cnt int;
select count(CID) into cnt from invoice where CID=invoiceIdNum;
if cnt>4 
	then set output='You have earned a 10% discount';
elseif cnt>3 
	then set output='You have earned a 7% discount' ;
elseif cnt>2 
	then set output='You have earned a 5% discount' ;
elseif cnt>1
	then set output='You have earned a 3% discount' ;
else 
	set output='No discount !';
END IF;
END //
DELIMITER ;

CALL discounts('17896544',@out);
select @out as DiscountEarned;

/*Procedure 5-> To find the value of invoice based on products from sold*/

DELIMITER //
DROP PROCEDURE IF EXISTS priceOfInvoice//
CREATE PROCEDURE priceOfInvoice(IN invoiceIdNum VARCHAR(20),out output int)
BEGIN
select sum(quantity*(select price from product where PID=sold.pid)) into output from sold where IID=invoiceIdNum;
END //
DELIMITER ;

CALL priceOfInvoice('0015',@out);
select @out as priceOfInvoice;

/*User Creation*/

create user sales@localhost identified by 'sales';

create user finance@localhost identified by 'finance';

create user manager@localhost identified by 'manager';

create user director@localhost identified by 'director';

create user customer@localhost identified by 'customer';

create user administration@localhost identified by 'administration';

/*Access Granting*/

grant insert , update on salecompany.invoice to sales@localhost;

grant insert , update on salecompany.stockmarket to finance@localhost;
grant insert , update on salecompany.invoice to finance@localhost;
grant insert , update on salecompany.product to finance@localhost; 

grant select on salecompany.product to customer@localhost;

grant all privileges on salecompany.* to administration@localhost;

grant insert , update , select , delete on salecompany.* to manager@localhost;

grant insert,grant option,select,delete,update on salecompany.* to director@localhost;

/*Checking acces */

show grants for manager@localhost;
show grants for finance@localhost;
show grants for sales@localhost;
show grants for administration@localhost;
show grants for director@localhost;
show grants for customer@localhost;