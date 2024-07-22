ALTER TABLE Customer ADD (
    customer_type VARCHAR2(20)
);


ALTER TABLE Kindergarten ADD (
    customer_id NUMBER UNIQUE
);

ALTER TABLE Kindergarten 
ADD CONSTRAINT fk_kindergarten_customer 
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id);

ALTER TABLE Kindergarten DROP COLUMN name;


CREATE TABLE Menu (
    menu_date DATE,
    kindergarten_id NUMBER,
    menu_type VARCHAR2(20),
    description VARCHAR2(500),
    PRIMARY KEY (menu_date, kindergarten_id),
    FOREIGN KEY (kindergarten_id) REFERENCES Kindergarten(kindergartenId)
);


CREATE TABLE DietaryRestrictions (
    restriction_id NUMBER PRIMARY KEY,
    restriction_type VARCHAR2(50),
    food_item VARCHAR2(100),
    severity VARCHAR2(20),
    notes VARCHAR2(500)
);


CREATE TABLE IsHaving (
    child_id NUMBER,
    restriction_id NUMBER,
    PRIMARY KEY (child_id, restriction_id),
    FOREIGN KEY (child_id) REFERENCES Child(childId),
    FOREIGN KEY (restriction_id) REFERENCES DietaryRestrictions(restriction_id)
);


CREATE TABLE Includes (
    menu_date DATE,
    kindergarten_id NUMBER,
    dishes_id NUMBER,
    PRIMARY KEY (menu_date, kindergarten_id, dishes_id),
    FOREIGN KEY (menu_date, kindergarten_id) REFERENCES Menu(menu_date, kindergartenId),
    FOREIGN KEY (dishes_id) REFERENCES Dishs(dishs_id)
);


CREATE TABLE Affects (
    restriction_id NUMBER,
    dishes_id NUMBER,
    PRIMARY KEY (restriction_id, dishes_id),
    FOREIGN KEY (restriction_id) REFERENCES DietaryRestrictions(restriction_id),
    FOREIGN KEY (dishes_id) REFERENCES Dishs(dishs_id)
);
