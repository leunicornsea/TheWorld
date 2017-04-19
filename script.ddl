#@(#) script.ddl

DROP TABLE IF EXISTS Order_specification;
DROP TABLE IF EXISTS Album;
DROP TABLE IF EXISTS Employment_Contract;
DROP TABLE IF EXISTS Contract;
DROP TABLE IF EXISTS Emplyee;
DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Artist_or_Band;
DROP TABLE IF EXISTS Record_studio;
DROP TABLE IF EXISTS Genre;
DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Bill;
CREATE TABLE Bill
(
	Nr numeric (20),
	Date date,
	Sum double precision,
	PRIMARY KEY(Nr)
);

CREATE TABLE Client
(
	Person_Code numeric (20),
	Surname,
	Name,
	Last_Name,
	Adress,
	PRIMARY KEY(Person_Code)
);

CREATE TABLE Country
(
	Name,
	Code,
	id_Country integer,
	PRIMARY KEY(id_Country)
);

CREATE TABLE Genre
(
	Id varchar (255),
	Name,
	Emerged_date date,
	id_Genre integer,
	PRIMARY KEY(id_Genre)
);

CREATE TABLE Record_studio
(
	Name,
	Adress,
	Email,
	Created_date date,
	Fax,
	id_Record_studio integer,
	PRIMARY KEY(id_Record_studio)
);

CREATE TABLE Artist_or_Band
(
	Name,
	Created_date date,
	Members int,
	id_Artist_or_Band integer,
	fk_Genreid_Genre integer NOT NULL,
	PRIMARY KEY(id_Artist_or_Band),
	CONSTRAINT Has FOREIGN KEY(fk_Genreid_Genre) REFERENCES Genre (id_Genre)
);

CREATE TABLE City
(
	Name,
	Country,
	Dial_Code,
	id_City integer,
	fk_Countryid_Country integer NOT NULL,
	PRIMARY KEY(id_City),
	FOREIGN KEY(fk_Countryid_Country) REFERENCES Country (id_Country)
);

CREATE TABLE Payment
(
	Date date,
	Sum double precision,
	Type char (11),
	id_Payment integer,
	fk_ClientPerson_Code numeric (20) NOT NULL,
	fk_BillNr numeric (20) NOT NULL,
	CHECK(Type in ('Credit_Card', 'Cash', 'Transfer')),
	PRIMARY KEY(id_Payment),
	CONSTRAINT Pays FOREIGN KEY(fk_ClientPerson_Code) REFERENCES Client (Person_Code)
);

CREATE TABLE Store
(
	Name,
	Adress,
	Email,
	Phone_number,
	Website,
	id_Store integer,
	fk_Cityid_City integer NOT NULL,
	PRIMARY KEY(id_Store),
	CONSTRAINT Has FOREIGN KEY(fk_Cityid_City) REFERENCES City (id_City)
);

CREATE TABLE Emplyee
(
	ID numeric (20),
	Name,
	Surname,
	Email,
	Emplyment_date date,
	Personal_code date,
	Duty char (10),
	fk_Storeid_Store integer NOT NULL,
	PRIMARY KEY(ID),
	CHECK(Duty in ('Manager', 'Consultant', 'Cashier')),
	CONSTRAINT Works FOREIGN KEY(fk_Storeid_Store) REFERENCES Store (id_Store)
);

CREATE TABLE Contract
(
	Planuojamas_grazinimas,
	Galutine_bukle,
	Pradine_bukle,
	ID,
	Contract_date date,
	Sum double precision,
	Quantity int,
	State char (9),
	fk_EmplyeeID numeric (20) NOT NULL,
	PRIMARY KEY(ID),
	CHECK(State in ('Ordered', 'Canceled', 'Shipped', 'Delivered')),
	CONSTRAINT Confirms FOREIGN KEY(fk_EmplyeeID) REFERENCES Emplyee (ID)
);

CREATE TABLE Employment_Contract
(
	Id,
	Works_From date,
	Works_To date,
	Salary int,
	id_Employment_Contract integer,
	fk_EmplyeeID numeric (20) NOT NULL,
	PRIMARY KEY(id_Employment_Contract),
	UNIQUE(fk_EmplyeeID),
	CONSTRAINT Signs FOREIGN KEY(fk_EmplyeeID) REFERENCES Emplyee (ID)
);

CREATE TABLE Album
(
	Bar_code numeric (20),
	Name,
	Release_date,
	Cost int,
	Number_of_songs int,
	Format char (5),
	fk_Artist_or_Bandid_Artist_or_Band integer NOT NULL,
	fk_ContractID NOT NULL,
	fk_Record_studioid_Record_studio integer NOT NULL,
	PRIMARY KEY(Bar_code),
	CHECK(Format in ('CD', 'Vinyl')),
	CONSTRAINT Has FOREIGN KEY(fk_Artist_or_Bandid_Artist_or_Band) REFERENCES Artist_or_Band (id_Artist_or_Band),
	CONSTRAINT Orders FOREIGN KEY(fk_ContractID) REFERENCES Contract (ID),
	CONSTRAINT Releases FOREIGN KEY(fk_Record_studioid_Record_studio) REFERENCES Record_studio (id_Record_studio)
);

CREATE TABLE Order_specification
(
	Quantity int,
	id_Order_specification integer,
	fk_ClientPerson_Code numeric (20) NOT NULL,
	fk_AlbumBar_code numeric (20) NOT NULL,
	PRIMARY KEY(id_Order_specification),
	CONSTRAINT Specifies FOREIGN KEY(fk_ClientPerson_Code) REFERENCES Client (Person_Code),
	CONSTRAINT Contains FOREIGN KEY(fk_AlbumBar_code) REFERENCES Album (Bar_code)
);
