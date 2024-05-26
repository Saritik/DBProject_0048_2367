CREATE TABLE Catering
(
  Catering_ID NUMERIC(5) NOT NULL,
  Name VARCHAR(15) NOT NULL,
  Cosher CHAR(1) NOT NULL CHECK(cosher='Y' or cosher='N'),
  PRIMARY KEY (Catering_ID)
);

CREATE TABLE Worker
(
  Worker_ID NUMERIC(5) NOT NULL,
  WorkHoures NUMERIC(2) NOT NULL,
  Name VARCHAR(15) NOT NULL,
  Salary NUMERIC(6) NOT NULL,
  PRIMARY KEY (Worker_ID)
);

CREATE TABLE Dishs
(
  Dishs_ID NUMERIC(5) NOT NULL,
  Price NUMERIC(4) NOT NULL,
  Name VARCHAR(15) NOT NULL,
  CosherType VARCHAR(7) NOT NULL CHECK(cosherType='Dairy' or cosherType='Meat' or cosherType='None'),
  Catering_ID NUMERIC(5) NOT NULL,
  PRIMARY KEY (Dishs_ID),
  FOREIGN KEY (Catering_ID) REFERENCES Catering(Catering_ID)

);

CREATE TABLE Material
(
  Material_ID NUMERIC(5) NOT NULL,
  Name VARCHAR(15) NOT NULL,
  Type VARCHAR(15) NOT NULL,
  ExpiryDate DATE NOT NULL,
  PRIMARY KEY (Material_ID)
);

CREATE TABLE Customer
(
  Customer_ID NUMERIC(5) NOT NULL,
  Name VARCHAR(15) NOT NULL,
  Email VARCHAR(20) NOT NULL,
  Address VARCHAR(20) NOT NULL,
  PhoneNumber VARCHAR(11) NOT NULL,
  PaymentDetails VARCHAR(10) NOT NULL,
  PRIMARY KEY (Customer_ID)
);

CREATE TABLE WorkingIn
(
  Worker_ID NUMERIC(5) NOT NULL,
  Catering_ID NUMERIC(5) NOT NULL,
  PRIMARY KEY (Worker_ID, Catering_ID),
  FOREIGN KEY (Worker_ID) REFERENCES Worker(Worker_ID),
  FOREIGN KEY (Catering_ID) REFERENCES Catering(Catering_ID)
);

CREATE TABLE Contain
(
  Quantity NUMERIC(6) NOT NULL,
  Dishs_ID NUMERIC(5) NOT NULL,
  Material_ID NUMERIC(5) NOT NULL,
  PRIMARY KEY (Dishs_ID, Material_ID),
  FOREIGN KEY (Dishs_ID) REFERENCES Dishs(Dishs_ID),
  FOREIGN KEY (Material_ID) REFERENCES Material(Material_ID)
);

CREATE TABLE The_Order
(
  Order_ID NUMERIC(5) NOT NULL,
  TotalPrice NUMERIC(7) NOT NULL,
  Order_Date DATE NOT NULL,
  Address VARCHAR(20) NOT NULL,
  PhoneNumber VARCHAR(11) NOT NULL,
  Customer_ID NUMERIC(5) NOT NULL,
  PRIMARY KEY (Order_ID),
  FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Belong
(
  Amount NUMERIC(6) NOT NULL,
  Dishs_ID NUMERIC(5) NOT NULL,
  Order_ID NUMERIC(5) NOT NULL,
  PRIMARY KEY (Dishs_ID, Order_ID),
  FOREIGN KEY (Dishs_ID) REFERENCES Dishs(Dishs_ID),
  FOREIGN KEY (Order_ID) REFERENCES The_Order(Order_ID)
);
