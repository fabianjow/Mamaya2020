--  Module: ECAD                                        
--  Database Script for setting up the MySQL database   
--  tables required for practical lessons.              
--  Creation Date: 25 Oct 2020.                         

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- Delete tables before creating     

DROP TABLE IF EXISTS OrderData;
DROP TABLE IF EXISTS ShopCartItem;
DROP TABLE IF EXISTS ShopCart;
DROP TABLE IF EXISTS CatProduct;
DROP TABLE IF EXISTS ProductSpec;
DROP TABLE IF EXISTS Specification;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Shopper;

-- Create the tables      

CREATE TABLE Shopper 
(
  ShopperID INT(4) NOT NULL AUTO_INCREMENT,
  Name VARCHAR(50) NOT NULL,
  Address VARCHAR(150) DEFAULT NULL,
  Country VARCHAR(50) DEFAULT NULL,
  Phone VARCHAR(20) DEFAULT NULL,
  Email VARCHAR(50) NOT NULL,
  Password VARCHAR(255) NOT NULL,
  DateEntered TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ShopperID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE Category 
(
  CategoryID INT(4) NOT NULL AUTO_INCREMENT,
  CatName VARCHAR(255) DEFAULT NULL,
  CatDesc LONGTEXT DEFAULT NULL,
  CatImage VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (CategoryID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE Product 
(
  ProductID INT(4) NOT NULL AUTO_INCREMENT,
  ProductTitle VARCHAR(255) DEFAULT NULL,
  ProductDesc LONGTEXT DEFAULT NULL,
  ProductImage VARCHAR(255) DEFAULT NULL,
  Price DOUBLE NOT NULL DEFAULT 0.0,
  Quantity INT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (ProductID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE Specification
(
  SpecID INT(4) NOT NULL AUTO_INCREMENT,
  SpecName VARCHAR(64) DEFAULT NULL,
  PRIMARY KEY (SpecID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE ProductSpec 
(
  ProductID INT(4) NOT NULL,
  SpecID INT(4) NOT NULL,
  SpecVal VARCHAR(255) DEFAULT NULL,
  Priority INT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (ProductID, SpecID),
  FOREIGN KEY fk_PS_Product(ProductID) REFERENCES Product(ProductID),
  FOREIGN KEY fk_PS_Specification(SpecID) REFERENCES Specification(SpecID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE CatProduct 
(
  CategoryID INT(4) NOT NULL,
  ProductID INT(4) NOT NULL,
  PRIMARY KEY (CategoryID, ProductID),
  FOREIGN KEY fk_CP_Category(CategoryID) REFERENCES Category(CategoryID),
  FOREIGN KEY fk_CP_Product(ProductID) REFERENCES Product(ProductID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE ShopCart
(
  ShopCartID INT(4) NOT NULL AUTO_INCREMENT,
  ShopperID INT(4) NOT NULL,
  OrderPlaced INT(4) NOT NULL DEFAULT 0,
  Quantity INT(4) DEFAULT NULL,  
  SubTotal DOUBLE DEFAULT NULL,
  Tax DOUBLE DEFAULT NULL,
  ShipCharge DOUBLE DEFAULT NULL,
  Total DOUBLE DEFAULT NULL,
  DateCreated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ShopCartID),
  FOREIGN KEY fk_SC_Shopper(ShopperID) REFERENCES Shopper(ShopperID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE ShopCartItem 
(
  ShopCartID INT(4) NOT NULL,
  ProductID INT(4) NOT NULL,
  Price DOUBLE NOT NULL,
  Name VARCHAR(255) NOT NULL,
  Quantity INT(4) NOT NULL,
  PRIMARY KEY (ShopCartID, ProductID),
  FOREIGN KEY fk_SCI_ShopCart(ShopCartID) REFERENCES ShopCart(ShopCartID),
  FOREIGN KEY fk_SCI_Product(ProductID) REFERENCES Product(ProductID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE OrderData
(
  OrderID INT(4) NOT NULL AUTO_INCREMENT,
  ShopCartID INT(4) NOT NULL,
  ShipName VARCHAR(50) NOT NULL,
  ShipAddress VARCHAR(150) NOT NULL,
  ShipCountry VARCHAR(50) NOT NULL,
  ShipPhone VARCHAR(20) DEFAULT NULL,
  ShipEmail VARCHAR(50) DEFAULT NULL,
  PaymentID VARCHAR(255) DEFAULT NULL,
  BillName VARCHAR(50) DEFAULT NULL,
  BillAddress VARCHAR(150) DEFAULT NULL,
  BillCountry VARCHAR(50) DEFAULT NULL,
  BillPhone VARCHAR(20) DEFAULT NULL,
  BillEmail VARCHAR(50) DEFAULT NULL,
  DateOrdered TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  
  PRIMARY KEY (OrderID),
  FOREIGN KEY fk_Order_ShopCart(ShopCartID) REFERENCES ShopCart(ShopCartID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Load the tables with sample data     

INSERT INTO Shopper (ShopperID, Name, Address, Country, Phone, EMail, Password, DateEntered) VALUES 
(1, 'Ecader', 'Ngee Ann Polytechnic', 'Singapore', '64600000', 'ecader@np.edu.sg', 'password', '2011-07-11 15:10:29');

INSERT INTO Category (CategoryID, CatName, CatDesc, CatImage) VALUES
(1, 'Computer', 'The most comprehensive collection of computer books', 'Laptop.jpg'),
(2, 'Outdoor & Nature', 'Everything you need to know about outdoor and nature', 'Eagle.jpg');

INSERT INTO Specification (SpecID, SpecName) VALUES
(1, 'Author'),
(2, 'Publisher');

INSERT INTO Product (ProductID, ProductTitle, ProductDesc, ProductImage, Price, Quantity) VALUES
(1, 'Java and XML', 'Two hot topics come together in this developer\'s guide from Brett McLaughlin, Java and XML. Both Java and XML are cross-platform technologies; by using Java for code and XML for transporting data, you can build truly portable applications. This title is aimed at intermediate to advanced programmers; while XML topics are explained more or less from scratch, readers will need prior knowledge of Java.', 'ComputerBk1.jpg', 50, 5),
(2, 'Javascript : The Definitive Guide', 'This book has been the bible for JavaScript programmers - a programmer\'s guide and comprehensive reference to the core language and to the client-side JavaScript APIs defined by web browsers. The 6th edition covers HTML5 and ECMAScript 5. Many chapters have been completely rewritten to bring them in line with today\'s best web development practices. New chapters in this edition document jQuery and server side JavaScript.', 'ComputerBk2.jpg', 55, 2),
(3, 'Designing Active Server Pages', 'Designing Active Server Pages provides an important tool for often-overworked ASP programmers: a set of techniques for making the wisest use of the technology in a production environment. Targeting an audience of readers who already are seasoned in ASP, author Scott Mitchell explores techniques for producing "reusable and robust ASP applications."', 'ComputerBk3.jpg', 29.95, 1),
(4, 'Focus Guide to the Birds of North America', 'World-renowned birder Kenn Kaufman addresses a long-running paradox of bird field guides with his Focus Guide. While beginning birdwatchers prefer photographic guides like those by Donald Stokes, the physical traits that make identification easier are more readily discerned in the idealized paintings of illustrative guides like those by Roger Tory Peterson and National Geographic. Kaufman''s groundbreaking work combines the best of both approaches by digitally enhancing photographic images to show the characteristics that are sometimes not apparent in photographs.', 'NatureBk1.jpg', 20, 3),
(5, '100 Years of Fishing', 'We\'ve reeled in the highest-caliber stories and artwork to celebrate the past 100 years of our fishing tradition. Stories and essays from such well-known authors as Zane Grey, Sigurd Olson, Ernest Hemingway, Robert Ruark, Patrick McManus, Norman Maclean, and Jimmy Carter combine with historical and current photos of most styles of fishing', 'NatureBk2.jpg', 39.95, 1);

INSERT INTO ProductSpec (ProductID, SpecID, SpecVal,Priority) VALUES
(1, 1, 'B. McLaughlin & M. Loukides', 1),
(1, 2, 'O\'Reilly & Associates', 2),
(2, 1, 'D. Flanagan', 1),
(2, 2, 'O\'Reilly & Associates', 2),
(3, 1, 'Scott Mitchell', 1),
(3, 2, 'O\'Reilly & Associates', 2),
(4, 1, 'K. Kaufman & K.Kaufmann', 1),
(4, 2, 'Houghton Mifflin Co', 2),
(5, 1, 'Michael Dregni', 1),
(5, 2, 'Voyageur Press', 2);

INSERT INTO CatProduct (CategoryID, ProductID) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5);

INSERT INTO ShopCart (ShopCartID, ShopperID, OrderPlaced, Quantity, SubTotal, Tax, ShipCharge, Total, DateCreated) VALUES
(1, 1, 1, 1, 20.00, 1.40, 2.00, 23.40, '2011-07-11 15:12:50');

INSERT INTO ShopCartItem (ShopCartId, ProductId, Name, Price, Quantity) VALUES
(1, 4, 'Focus Guide to the Birds of North America', 20.00, 1);

INSERT INTO OrderData (OrderID, ShopCartID, ShipName, ShipAddress, ShipCountry, ShipPhone, ShipEmail, BillName, BillAddress, BillCountry, BillPhone, BillEmail, DateOrdered) VALUES
(1, 1, 'Ecader', 'Ngee Ann Polytechnic', 'Singapore', '64600000', 'ecader@np.edu.sg', 'Ecader', 'Ngee Ann Polytechnic', 'Singapore', '64600000', 'ecader@np.edu.sg', '2011-07-11 15:13:31');

