prompt PL/SQL Developer import file
prompt Created on יום שני 22 יולי 2024 by משתמש
set feedback off
set define off
prompt Creating ACTIVITY...
create table ACTIVITY
(
  activityid      NUMBER(3) not null,
  act_description VARCHAR2(100) default 'No description provided',
  activity_name   VARCHAR2(100)
)
;
alter table ACTIVITY
  add primary key (ACTIVITYID);

prompt Creating K_TYPE...
create table K_TYPE
(
  k_type_id  NUMBER(3) not null,
  type_name  VARCHAR2(30),
  age_groupe VARCHAR2(5)
)
;
alter table K_TYPE
  add primary key (K_TYPE_ID);

prompt Creating BUILDINGS...
create table BUILDINGS
(
  b_num     NUMBER(3) not null,
  address   VARCHAR2(30),
  accesible VARCHAR2(3)
)
;
alter table BUILDINGS
  add primary key (B_NUM);

prompt Creating CUSTOMER...
create table CUSTOMER
(
  customer_id    NUMBER(5) not null,
  name           VARCHAR2(15) not null,
  email          VARCHAR2(20) not null,
  address        VARCHAR2(20) not null,
  phonenumber    VARCHAR2(11) not null,
  paymentdetails VARCHAR2(10) not null,
  customer_type  VARCHAR2(20)
)
;
alter table CUSTOMER
  add primary key (CUSTOMER_ID);

prompt Creating KINDERGARTEN...
create table KINDERGARTEN
(
  kindergartenid NUMBER(3) not null,
  capacity       INTEGER,
  k_language     VARCHAR2(20),
  b_num          NUMBER(3),
  k_type_id      NUMBER(3),
  customer_id    NUMBER
)
;
alter table KINDERGARTEN
  add primary key (KINDERGARTENID);
alter table KINDERGARTEN
  add unique (CUSTOMER_ID);
alter table KINDERGARTEN
  add constraint FK_KINDERGARTEN_CUSTOMER foreign key (CUSTOMER_ID)
  references CUSTOMER (CUSTOMER_ID);
alter table KINDERGARTEN
  add foreign key (B_NUM)
  references BUILDINGS (B_NUM);
alter table KINDERGARTEN
  add foreign key (K_TYPE_ID)
  references K_TYPE (K_TYPE_ID);

prompt Creating ACTIVITYSCHEDULE...
create table ACTIVITYSCHEDULE
(
  act_hour       VARCHAR2(5) not null,
  activity_date  DATE,
  activityid     NUMBER(3) not null,
  kindergartenid NUMBER(3) not null
)
;
alter table ACTIVITYSCHEDULE
  add primary key (ACTIVITYID, KINDERGARTENID);
alter table ACTIVITYSCHEDULE
  add foreign key (ACTIVITYID)
  references ACTIVITY (ACTIVITYID);
alter table ACTIVITYSCHEDULE
  add foreign key (KINDERGARTENID)
  references KINDERGARTEN (KINDERGARTENID);

prompt Creating DIETARYRESTRICTIONS...
create table DIETARYRESTRICTIONS
(
  restriction_id   NUMBER not null,
  restriction_type VARCHAR2(50),
  food_item        VARCHAR2(100),
  severity         VARCHAR2(20),
  notes            VARCHAR2(500)
)
;
alter table DIETARYRESTRICTIONS
  add primary key (RESTRICTION_ID);

prompt Creating CATERING...
create table CATERING
(
  catering_id NUMBER(5) not null,
  name        VARCHAR2(15) not null,
  cosher      CHAR(1) default 'N' not null
)
;
alter table CATERING
  add primary key (CATERING_ID);
alter table CATERING
  add check (cosher='Y' or cosher='N');

prompt Creating DISHS...
create table DISHS
(
  dishs_id    NUMBER(5) not null,
  price       NUMBER(4) not null,
  name        VARCHAR2(15) not null,
  coshertype  VARCHAR2(7) not null,
  catering_id NUMBER(5) not null,
  isspecial   NUMBER(1) default 0
)
;
alter table DISHS
  add primary key (DISHS_ID);
alter table DISHS
  add foreign key (CATERING_ID)
  references CATERING (CATERING_ID);
alter table DISHS
  add check (cosherType='Dairy' or cosherType='Meat' or cosherType='None');

prompt Creating AFFECTS...
create table AFFECTS
(
  restriction_id NUMBER not null,
  dishes_id      NUMBER not null
)
;
alter table AFFECTS
  add primary key (RESTRICTION_ID, DISHES_ID);
alter table AFFECTS
  add foreign key (RESTRICTION_ID)
  references DIETARYRESTRICTIONS (RESTRICTION_ID);
alter table AFFECTS
  add foreign key (DISHES_ID)
  references DISHS (DISHS_ID);

prompt Creating THE_ORDER...
create table THE_ORDER
(
  order_id    NUMBER(5) not null,
  totalprice  NUMBER(7) not null,
  order_date  DATE not null,
  address     VARCHAR2(20) not null,
  phonenumber VARCHAR2(11) not null,
  customer_id NUMBER(5) not null,
  status      VARCHAR2(20) default 'Pending'
)
;
alter table THE_ORDER
  add primary key (ORDER_ID);
alter table THE_ORDER
  add foreign key (CUSTOMER_ID)
  references CUSTOMER (CUSTOMER_ID);

prompt Creating BELONG...
create table BELONG
(
  amount   NUMBER(6) not null,
  dishs_id NUMBER(5) not null,
  order_id NUMBER(5) not null
)
;
alter table BELONG
  add primary key (DISHS_ID, ORDER_ID);
alter table BELONG
  add foreign key (DISHS_ID)
  references DISHS (DISHS_ID);
alter table BELONG
  add foreign key (ORDER_ID)
  references THE_ORDER (ORDER_ID);

prompt Creating REGISTRATION...
create table REGISTRATION
(
  registrationid_  NUMBER(3) not null,
  registrationdate DATE,
  r_language       VARCHAR2(20),
  status           VARCHAR2(20),
  k_type_id        NUMBER(3) not null,
  kindergartenid   NUMBER(3)
)
;
alter table REGISTRATION
  add primary key (REGISTRATIONID_);
alter table REGISTRATION
  add constraint FK_REGISTRATION_KINDERGARTEN foreign key (KINDERGARTENID)
  references KINDERGARTEN (KINDERGARTENID);
alter table REGISTRATION
  add foreign key (K_TYPE_ID)
  references K_TYPE (K_TYPE_ID);

prompt Creating CHILD...
create table CHILD
(
  childid               NUMBER(3) not null,
  first_name            VARCHAR2(20) not null,
  last_name             VARCHAR2(20) not null,
  dateofbirth           DATE,
  allergies             VARCHAR2(30),
  emergencycontactname  VARCHAR2(30),
  emergencycontactphone NUMBER(10),
  medicalconditions     VARCHAR2(30),
  registrationid_       NUMBER(3)
)
;
alter table CHILD
  add primary key (CHILDID);
alter table CHILD
  add constraint FK_CHILD_REGISTRATION foreign key (REGISTRATIONID_)
  references REGISTRATION (REGISTRATIONID_);

prompt Creating MATERIAL...
create table MATERIAL
(
  material_id NUMBER(5) not null,
  name        VARCHAR2(15) not null,
  type        VARCHAR2(15) default 'Unknown' not null,
  expirydate  DATE not null
)
;
alter table MATERIAL
  add primary key (MATERIAL_ID);

prompt Creating CONTAIN...
create table CONTAIN
(
  quantity    NUMBER(6) not null,
  dishs_id    NUMBER(5) not null,
  material_id NUMBER(5) not null
)
;
alter table CONTAIN
  add primary key (DISHS_ID, MATERIAL_ID);
alter table CONTAIN
  add foreign key (DISHS_ID)
  references DISHS (DISHS_ID);
alter table CONTAIN
  add foreign key (MATERIAL_ID)
  references MATERIAL (MATERIAL_ID);

prompt Creating MENU...
create table MENU
(
  menu_date       DATE not null,
  kindergarten_id NUMBER not null,
  menu_type       VARCHAR2(20),
  description     VARCHAR2(500)
)
;
alter table MENU
  add primary key (MENU_DATE, KINDERGARTEN_ID);
alter table MENU
  add foreign key (KINDERGARTEN_ID)
  references KINDERGARTEN (KINDERGARTENID);

prompt Creating INCLUDES...
create table INCLUDES
(
  menu_date       DATE not null,
  kindergarten_id NUMBER not null,
  dishes_id       NUMBER not null
)
;
alter table INCLUDES
  add primary key (MENU_DATE, KINDERGARTEN_ID, DISHES_ID);
alter table INCLUDES
  add foreign key (MENU_DATE, KINDERGARTEN_ID)
  references MENU (MENU_DATE, KINDERGARTEN_ID);
alter table INCLUDES
  add foreign key (DISHES_ID)
  references DISHS (DISHS_ID);

prompt Creating ISHAVING...
create table ISHAVING
(
  child_id       NUMBER not null,
  restriction_id NUMBER not null
)
;
alter table ISHAVING
  add primary key (CHILD_ID, RESTRICTION_ID);
alter table ISHAVING
  add foreign key (CHILD_ID)
  references CHILD (CHILDID);
alter table ISHAVING
  add foreign key (RESTRICTION_ID)
  references DIETARYRESTRICTIONS (RESTRICTION_ID);

prompt Creating TEACHER...
create table TEACHER
(
  teacher_id      NUMBER(3) not null,
  t_name          VARCHAR2(20),
  phone           NUMBER(10),
  experience_date DATE,
  t_role          VARCHAR2(10),
  kindergartenid  NUMBER(3) not null
)
;
alter table TEACHER
  add primary key (TEACHER_ID);
alter table TEACHER
  add foreign key (KINDERGARTENID)
  references KINDERGARTEN (KINDERGARTENID);

prompt Creating WORKER...
create table WORKER
(
  worker_id  NUMBER(5) not null,
  workhoures NUMBER(2) not null,
  name       VARCHAR2(15) not null,
  salary     NUMBER(6) not null
)
;
alter table WORKER
  add primary key (WORKER_ID);
alter table WORKER
  add constraint CHK_WORKER_SALARY
  check (Salary > 0);

prompt Creating WORKINGIN...
create table WORKINGIN
(
  worker_id   NUMBER(5) not null,
  catering_id NUMBER(5) not null
)
;
alter table WORKINGIN
  add primary key (WORKER_ID, CATERING_ID);
alter table WORKINGIN
  add foreign key (WORKER_ID)
  references WORKER (WORKER_ID);
alter table WORKINGIN
  add foreign key (CATERING_ID)
  references CATERING (CATERING_ID);

prompt Disabling triggers for ACTIVITY...
alter table ACTIVITY disable all triggers;
prompt Disabling triggers for K_TYPE...
alter table K_TYPE disable all triggers;
prompt Disabling triggers for BUILDINGS...
alter table BUILDINGS disable all triggers;
prompt Disabling triggers for CUSTOMER...
alter table CUSTOMER disable all triggers;
prompt Disabling triggers for KINDERGARTEN...
alter table KINDERGARTEN disable all triggers;
prompt Disabling triggers for ACTIVITYSCHEDULE...
alter table ACTIVITYSCHEDULE disable all triggers;
prompt Disabling triggers for DIETARYRESTRICTIONS...
alter table DIETARYRESTRICTIONS disable all triggers;
prompt Disabling triggers for CATERING...
alter table CATERING disable all triggers;
prompt Disabling triggers for DISHS...
alter table DISHS disable all triggers;
prompt Disabling triggers for AFFECTS...
alter table AFFECTS disable all triggers;
prompt Disabling triggers for THE_ORDER...
alter table THE_ORDER disable all triggers;
prompt Disabling triggers for BELONG...
alter table BELONG disable all triggers;
prompt Disabling triggers for REGISTRATION...
alter table REGISTRATION disable all triggers;
prompt Disabling triggers for CHILD...
alter table CHILD disable all triggers;
prompt Disabling triggers for MATERIAL...
alter table MATERIAL disable all triggers;
prompt Disabling triggers for CONTAIN...
alter table CONTAIN disable all triggers;
prompt Disabling triggers for MENU...
alter table MENU disable all triggers;
prompt Disabling triggers for INCLUDES...
alter table INCLUDES disable all triggers;
prompt Disabling triggers for ISHAVING...
alter table ISHAVING disable all triggers;
prompt Disabling triggers for TEACHER...
alter table TEACHER disable all triggers;
prompt Disabling triggers for WORKER...
alter table WORKER disable all triggers;
prompt Disabling triggers for WORKINGIN...
alter table WORKINGIN disable all triggers;
prompt Disabling foreign key constraints for KINDERGARTEN...
alter table KINDERGARTEN disable constraint FK_KINDERGARTEN_CUSTOMER;
alter table KINDERGARTEN disable constraint SYS_C007684;
alter table KINDERGARTEN disable constraint SYS_C007685;
prompt Disabling foreign key constraints for ACTIVITYSCHEDULE...
alter table ACTIVITYSCHEDULE disable constraint SYS_C007690;
alter table ACTIVITYSCHEDULE disable constraint SYS_C007691;
prompt Disabling foreign key constraints for DISHS...
alter table DISHS disable constraint SYS_C007473;
prompt Disabling foreign key constraints for AFFECTS...
alter table AFFECTS disable constraint SYS_C007724;
alter table AFFECTS disable constraint SYS_C007725;
prompt Disabling foreign key constraints for THE_ORDER...
alter table THE_ORDER disable constraint SYS_C007489;
prompt Disabling foreign key constraints for BELONG...
alter table BELONG disable constraint SYS_C007494;
alter table BELONG disable constraint SYS_C007495;
prompt Disabling foreign key constraints for REGISTRATION...
alter table REGISTRATION disable constraint FK_REGISTRATION_KINDERGARTEN;
alter table REGISTRATION disable constraint SYS_C007696;
prompt Disabling foreign key constraints for CHILD...
alter table CHILD disable constraint FK_CHILD_REGISTRATION;
prompt Disabling foreign key constraints for CONTAIN...
alter table CONTAIN disable constraint SYS_C007505;
alter table CONTAIN disable constraint SYS_C007506;
prompt Disabling foreign key constraints for MENU...
alter table MENU disable constraint SYS_C007715;
prompt Disabling foreign key constraints for INCLUDES...
alter table INCLUDES disable constraint SYS_C007721;
alter table INCLUDES disable constraint SYS_C007722;
prompt Disabling foreign key constraints for ISHAVING...
alter table ISHAVING disable constraint SYS_C007718;
alter table ISHAVING disable constraint SYS_C007719;
prompt Disabling foreign key constraints for TEACHER...
alter table TEACHER disable constraint SYS_C007705;
prompt Disabling foreign key constraints for WORKINGIN...
alter table WORKINGIN disable constraint SYS_C007515;
alter table WORKINGIN disable constraint SYS_C007516;
prompt Deleting WORKINGIN...
delete from WORKINGIN;
commit;
prompt Deleting WORKER...
delete from WORKER;
commit;
prompt Deleting TEACHER...
delete from TEACHER;
commit;
prompt Deleting ISHAVING...
delete from ISHAVING;
commit;
prompt Deleting INCLUDES...
delete from INCLUDES;
commit;
prompt Deleting MENU...
delete from MENU;
commit;
prompt Deleting CONTAIN...
delete from CONTAIN;
commit;
prompt Deleting MATERIAL...
delete from MATERIAL;
commit;
prompt Deleting CHILD...
delete from CHILD;
commit;
prompt Deleting REGISTRATION...
delete from REGISTRATION;
commit;
prompt Deleting BELONG...
delete from BELONG;
commit;
prompt Deleting THE_ORDER...
delete from THE_ORDER;
commit;
prompt Deleting AFFECTS...
delete from AFFECTS;
commit;
prompt Deleting DISHS...
delete from DISHS;
commit;
prompt Deleting CATERING...
delete from CATERING;
commit;
prompt Deleting DIETARYRESTRICTIONS...
delete from DIETARYRESTRICTIONS;
commit;
prompt Deleting ACTIVITYSCHEDULE...
delete from ACTIVITYSCHEDULE;
commit;
prompt Deleting KINDERGARTEN...
delete from KINDERGARTEN;
commit;
prompt Deleting CUSTOMER...
delete from CUSTOMER;
commit;
prompt Deleting BUILDINGS...
delete from BUILDINGS;
commit;
prompt Deleting K_TYPE...
delete from K_TYPE;
commit;
prompt Deleting ACTIVITY...
delete from ACTIVITY;
commit;
prompt Loading ACTIVITY...
insert into ACTIVITY (activityid, act_description, activity_name)
values (1, ' Exploring outdoors ', ' Field trips');
insert into ACTIVITY (activityid, act_description, activity_name)
values (2, ' Hiking or exploring local trails ', ' Nature walks');
insert into ACTIVITY (activityid, act_description, activity_name)
values (3, 'exercises to develop gross motor skills', ' Gross motor activities');
insert into ACTIVITY (activityid, act_description, activity_name)
values (4, ' ', ' Outdoor play');
insert into ACTIVITY (activityid, act_description, activity_name)
values (5, 'Singing dancing and playing instruments ', ' Music & movement');
insert into ACTIVITY (activityid, act_description, activity_name)
values (6, 'creating plays to foster creativity', ' Dramatic play');
insert into ACTIVITY (activityid, act_description, activity_name)
values (7, ' ', ' Cooperative games');
insert into ACTIVITY (activityid, act_description, activity_name)
values (8, ' Programs focusing on managing emotions ', ' Social-emotional learning');
insert into ACTIVITY (activityid, act_description, activity_name)
values (9, ' activities with basic science concepts ', ' Science experiments');
insert into ACTIVITY (activityid, act_description, activity_name)
values (10, ' ', ' Water play');
insert into ACTIVITY (activityid, act_description, activity_name)
values (11, ' ', ' Storytime');
insert into ACTIVITY (activityid, act_description, activity_name)
values (12, ' painting and drawing ', ' Arts and crafts');
insert into ACTIVITY (activityid, act_description, activity_name)
values (13, null, ' Circle time');
insert into ACTIVITY (activityid, act_description, activity_name)
values (14, null, ' Puppet shows');
insert into ACTIVITY (activityid, act_description, activity_name)
values (15, ' Early exposure to a second language', ' Second language ');
insert into ACTIVITY (activityid, act_description, activity_name)
values (16, ' basic food prep and cooking skills', ' Cooking classes');
insert into ACTIVITY (activityid, act_description, activity_name)
values (17, 'lessons on nature', ' Gardening');
insert into ACTIVITY (activityid, act_description, activity_name)
values (18, ' ', ' Animal encounters');
insert into ACTIVITY (activityid, act_description, activity_name)
values (19, null, ' Fire safety education');
insert into ACTIVITY (activityid, act_description, activity_name)
values (20, null, ' Themed days');
insert into ACTIVITY (activityid, act_description, activity_name)
values (21, null, ' bbb');
insert into ACTIVITY (activityid, act_description, activity_name)
values (22, ' gyhjk', ' sss');
commit;
prompt 22 records loaded
prompt Loading K_TYPE...
insert into K_TYPE (k_type_id, type_name, age_groupe)
values (123, ' Therapeutic-Preschool', ' 4-5');
insert into K_TYPE (k_type_id, type_name, age_groupe)
values (124, ' Preschool', ' 4-5');
insert into K_TYPE (k_type_id, type_name, age_groupe)
values (135, '  Therapeutic-Nursery-school', '3-4');
insert into K_TYPE (k_type_id, type_name, age_groupe)
values (136, ' nursery-school', ' 3-4');
insert into K_TYPE (k_type_id, type_name, age_groupe)
values (142, ' Therapeutic-Kindergarten', ' 5-6');
insert into K_TYPE (k_type_id, type_name, age_groupe)
values (143, ' kindergarten', ' 5-6');
commit;
prompt 6 records loaded
prompt Loading BUILDINGS...
insert into BUILDINGS (b_num, address, accesible)
values (1, '1 Stiers Street', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (2, '31 Lakeville Drive', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (3, '535 Melrose park Ave', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (4, '62nd Street', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (5, '55 Russell Street', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (6, '40 Morse Road', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (7, '75 Ronny Drive', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (8, '80 Fairbanks Street', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (9, '98 Cruise Road', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (10, '69 Tara Street', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (11, '25 Fountain Hills Drive', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (12, '28 Portland Street', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (13, '62 Moriarty Drive', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (14, '518 Hunter', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (15, '96 Myles', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (16, '22 Gallant Street', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (17, '29 Forster Road', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (18, '13 McKellen Blvd', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (19, '79 Midler Road', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (20, '25 Diffie Street', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (21, '816 Freda Ave', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (22, '172 Karachi Drive', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (23, '51st Street', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (24, '73 Etta', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (25, '83rd Street', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (26, '17 Hatchet Drive', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (27, '58 Craig Road', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (28, '44 Pierce Road', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (29, '71st Street', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (30, '1 Speaks Blvd', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (31, '87 Mississauga Drive', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (32, '10 Pat Street', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (33, '47 Lee Drive', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (34, '861 Dan Drive', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (35, '89 Price Street', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (36, '795 Vince Drive', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (37, '44 Carolyn Road', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (38, '85 Dolenz Drive', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (39, '17 Coyote Street', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (40, '13 Bragg Drive', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (41, '30 Eckhart Drive', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (42, '650 Stiles Drive', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (43, '88 Pusan-city Drive', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (44, '21st Street', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (45, '77 Anjelica Road', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (46, '92 Franco Road', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (47, '24 Key Biscayne Drive', 'yes');
insert into BUILDINGS (b_num, address, accesible)
values (48, '47 Terrence Blvd', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (49, '862 Burstyn Street', 'no');
insert into BUILDINGS (b_num, address, accesible)
values (50, '82nd Street', 'yes');
commit;
prompt 50 records loaded
prompt Loading CUSTOMER...
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (76784, 'Chris Miller', 'chris.mi@hotmail.com', '680 High Riverside N', '628-3754265', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (56477, 'Alex Davis', 'alex.dav@example.com', '237 Maple Greenfield', '413-9079902', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (65687, 'Chris Jones', 'chris.jone@yahoo.com', '187 Broadway Bristol', '703-2911076', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (59374, 'Laura Brown', 'laura.br@outlook.com', '462 Main Springfield', '418-2185103', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (37149, 'Michael Davis', 'michael.@outlook.com', '616 2nd Madison FL', '464-7254100', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (79696, 'Sarah Jones', 'sarah.jo@example.com', '230 Oak Fairview MI', '749-5773304', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (17352, 'Emily Moore', 'emily.mo@example.com', '536 2nd Madison GA', '213-6238357', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (91393, 'Sarah Davis', 'sarah.davi@gmail.com', '940 3rd Bristol GA', '925-8928440', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (56199, 'Katie Wilson', 'katie.wi@outlook.com', '117 2nd Fairview CA', '499-3533741', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (68339, 'Chris Davis', 'chris.davi@gmail.com', '948 3rd Springfield ', '773-2229995', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (37588, 'Jane Jones', 'jane.jon@hotmail.com', '577 Cedar Bristol MI', '467-9936932', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (10744, 'Emily Taylor', 'emily.tayl@yahoo.com', '821 Oak Clinton FL', '973-4339439', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (89204, 'John Brown', 'john.bro@outlook.com', '318 Main Georgetown ', '157-5465081', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (1808, 'Michael Wilson', 'michael.@outlook.com', '969 High Greenville ', '184-4587140', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (32075, 'Alex Jones', 'alex.jon@example.com', '626 2nd Springfield ', '393-5183207', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (69827, 'David Miller', 'david.mi@example.com', '729 Oak Bristol TX', '559-3214137', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (22818, 'Laura Moore', 'laura.mo@hotmail.com', '722 Elm Greenville F', '107-7699389', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (30106, 'Laura Smith', 'laura.sm@example.com', '328 2nd Greenville F', '667-7284259', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (43410, 'Chris Wilson', 'chris.wi@hotmail.com', '671 2nd Madison TX', '504-1245948', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (65489, 'Emily Brown', 'emily.br@hotmail.com', '325 Main Bristol NY', '897-5529802', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (689, 'David Miller', 'david.mill@gmail.com', '925 Pine Madison TX', '641-4297856', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (7961, 'David Moore', 'david.moor@gmail.com', '974 Oak Clinton FL', '972-4931089', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (78711, 'Sarah Miller', 'sarah.mill@gmail.com', '926 Elm Greenville O', '773-1767196', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (69306, 'Laura Williams', 'laura.wi@hotmail.com', '312 3rd Riverside GA', '735-3148708', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (92207, 'John Miller', 'john.mil@hotmail.com', '140 Cedar Riverside ', '200-4955673', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (19682, 'Katie Moore', 'katie.moor@yahoo.com', '743 Maple Greenville', '837-7784397', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (21008, 'Sarah Johnson', 'sarah.john@gmail.com', '958 Pine Franklin NC', '202-2814612', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (44605, 'Katie Miller', 'katie.mill@gmail.com', '632 High Bristol GA', '493-9427433', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (33796, 'Alex Johnson', 'alex.joh@example.com', '683 3rd Fairview TX', '899-4834016', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (72636, 'Laura Williams', 'laura.wi@outlook.com', '229 3rd Clinton IL', '853-4227521', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (27070, 'Sarah Brown', 'sarah.brow@yahoo.com', '552 3rd Fairview NC', '864-3377763', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (27971, 'Sarah Taylor', 'sarah.ta@example.com', '543 Elm Georgetown N', '805-8386908', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (96613, 'David Moore', 'david.mo@example.com', '782 Main Fairview IL', '951-5316785', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (64137, 'Katie Brown', 'katie.br@hotmail.com', '377 Oak Georgetown I', '266-1551215', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (17421, 'Chris Jones', 'chris.jo@example.com', '521 Oak Riverside FL', '986-5161204', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (15424, 'Laura Moore', 'laura.moor@gmail.com', '396 Cedar Georgetown', '882-2237103', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (61528, 'Laura Davis', 'laura.da@hotmail.com', '360 High Madison IL', '406-1283019', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (94944, 'Sarah Taylor', 'sarah.tayl@yahoo.com', '458 Cedar Fairview G', '973-2777486', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (93334, 'Chris Miller', 'chris.mi@outlook.com', '278 3rd Greenfield O', '383-3673109', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (21318, 'Emily Williams', 'emily.wi@outlook.com', '188 Oak Madison IL', '852-7594221', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (66276, 'Chris Johnson', 'chris.john@gmail.com', '360 Oak Springfield ', '950-7678486', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (61363, 'Laura Moore', 'laura.moor@gmail.com', '132 High Greenfield ', '348-4438180', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (4304, 'David Smith', 'david.sm@hotmail.com', '290 Elm Madison GA', '401-3923552', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (57300, 'Sarah Wilson', 'sarah.wils@yahoo.com', '660 Oak Georgetown N', '270-3372375', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (3131, 'John Wilson', 'john.wil@outlook.com', '408 3rd Bristol NY', '840-4338673', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (95704, 'Katie Wilson', 'katie.wi@example.com', '337 High Greenville ', '450-1683456', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (42102, 'Chris Moore', 'chris.mo@hotmail.com', '619 Elm Greenfield N', '850-8827373', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (38753, 'Sarah Davis', 'sarah.da@example.com', '849 High Greenville ', '978-6385337', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (21210, 'Katie Jones', 'katie.jo@outlook.com', '181 High Madison PA', '458-7673277', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (25113, 'Michael Miller', 'michael.@hotmail.com', '568 2nd Greenville I', '524-6066247', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (94272, 'Chris Moore', 'chris.mo@outlook.com', '381 Broadway Riversi', '529-7171379', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (37101, 'Michael Davis', 'michael.da@gmail.com', '561 2nd Greenville P', '772-2579343', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (84726, 'Laura Davis', 'laura.davi@yahoo.com', '282 Maple Franklin C', '976-5444144', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (75891, 'Emily Jones', 'emily.jone@yahoo.com', '606 Oak Clinton PA', '958-1898720', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (44678, 'Chris Smith', 'chris.sm@example.com', '253 Oak Springfield ', '927-2564046', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (63084, 'Jane Williams', 'jane.wil@outlook.com', '455 Cedar Fairview C', '807-1027049', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (41976, 'Katie Williams', 'katie.will@gmail.com', '115 Main Springfield', '831-9575658', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (34839, 'Emily Smith', 'emily.sm@example.com', '829 Oak Greenville P', '816-8735213', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (76036, 'John Brown', 'john.brown@gmail.com', '495 Pine Madison TX', '544-1093082', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (42201, 'Laura Davis', 'laura.davi@yahoo.com', '918 Oak Springfield ', '628-8901427', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (92025, 'Alex Miller', 'alex.mil@example.com', '448 Maple Georgetown', '497-1283398', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (95197, 'Emily Williams', 'emily.wi@hotmail.com', '103 2nd Greenville M', '705-7992508', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (19683, 'Chris Miller', 'chris.mi@hotmail.com', '103 Pine Springfield', '551-9825490', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (8778, 'Michael Brown', 'michael.br@yahoo.com', '133 Pine Springfield', '676-6266229', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (45593, 'Chris Davis', 'chris.da@outlook.com', '712 3rd Fairview TX', '261-2937270', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (24008, 'Sarah Taylor', 'sarah.ta@example.com', '589 Cedar Greenville', '816-3723627', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (82096, 'Chris Smith', 'chris.sm@example.com', '609 Pine Springfield', '889-7646629', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (88114, 'Michael Smith', 'michael.@example.com', '514 3rd Georgetown N', '971-5698084', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (39213, 'Emily Williams', 'emily.wi@example.com', '921 Pine Georgetown ', '347-1545258', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (26024, 'Alex Moore', 'alex.moo@example.com', '454 Pine Fairview OH', '296-2236961', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (36377, 'Emily Wilson', 'emily.wi@hotmail.com', '185 2nd Greenville F', '444-4303948', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (64909, 'Katie Johnson', 'katie.jo@example.com', '888 3rd Bristol MI', '280-3059689', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (78122, 'Michael Taylor', 'michael.@example.com', '824 Maple Springfiel', '639-2048976', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (65557, 'Alex Moore', 'alex.moore@gmail.com', '241 Elm Fairview TX', '304-8002578', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (32912, 'Jane Taylor', 'jane.taylo@gmail.com', '267 High Franklin NC', '334-7089852', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (63004, 'Laura Taylor', 'laura.ta@hotmail.com', '484 Broadway Georget', '857-9687288', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (59705, 'Chris Miller', 'chris.mill@gmail.com', '226 Maple Clinton PA', '118-2991768', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (61882, 'Alex Miller', 'alex.mil@example.com', '250 Main Greenfield ', '405-6282425', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (97861, 'Alex Davis', 'alex.davis@gmail.com', '603 High Greenfield ', '756-8941882', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (92450, 'Jane Brown', 'jane.brown@yahoo.com', '166 Elm Clinton OH', '755-3477448', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (36098, 'Laura Taylor', 'laura.tayl@yahoo.com', '385 Broadway Bristol', '744-2035160', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (51737, 'Katie Moore', 'katie.mo@example.com', '589 2nd Bristol GA', '619-6692694', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (16425, 'Emily Brown', 'emily.br@example.com', '500 2nd Franklin TX', '352-9067451', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (19416, 'Emily Moore', 'emily.mo@hotmail.com', '971 Main Georgetown ', '191-9935580', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (11541, 'Chris Smith', 'chris.sm@hotmail.com', '933 Elm Franklin TX', '870-4296518', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (85019, 'David Williams', 'david.wi@example.com', '385 High Fairview MI', '147-4639829', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (14323, 'John Jones', 'john.jon@hotmail.com', '502 Maple Franklin T', '369-9516322', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (70323, 'Sarah Davis', 'sarah.davi@gmail.com', '766 Cedar Madison IL', '563-9112019', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (41634, 'Jane Smith', 'jane.smith@yahoo.com', '863 3rd Fairview OH', '898-7884126', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (42636, 'Katie Williams', 'katie.wi@hotmail.com', '198 2nd Fairview MI', '535-6993688', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (62025, 'John Jones', 'john.jon@hotmail.com', '371 Oak Georgetown O', '939-5788288', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (29964, 'Katie Miller', 'katie.mi@hotmail.com', '801 Oak Bristol GA', '404-3009407', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (11050, 'Sarah Moore', 'sarah.mo@outlook.com', '737 Main Georgetown ', '454-5975413', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (14382, 'Katie Wilson', 'katie.wi@outlook.com', '725 Main Springfield', '702-5164666', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (54325, 'David Taylor', 'david.tayl@gmail.com', '794 Pine Greenville ', '198-6586291', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (22674, 'Sarah Miller', 'sarah.mi@outlook.com', '574 Main Fairview MI', '795-3477730', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (37772, 'Alex Brown', 'alex.brown@yahoo.com', '877 Cedar Greenville', '887-4315586', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (26035, 'John Davis', 'john.dav@outlook.com', '985 Cedar Madison PA', '623-1937204', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (28759, 'Jane Davis', 'jane.dav@outlook.com', '944 Elm Greenfield N', '117-1757880', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (26650, 'Emily Davis', 'emily.da@outlook.com', '778 Maple Springfiel', '109-3199555', 'Bit', null);
commit;
prompt 100 records committed...
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (30132, 'Laura Johnson', 'laura.jo@outlook.com', '886 Elm Clinton PA', '304-6206327', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (97677, 'Emily Smith', 'emily.smit@gmail.com', '779 Cedar Franklin G', '394-5454992', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (15512, 'Chris Moore', 'chris.mo@example.com', '189 Pine Greenville ', '276-5936964', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (70360, 'Katie Johnson', 'katie.jo@outlook.com', '637 Elm Georgetown O', '584-8323027', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (57091, 'Jane Williams', 'jane.willi@yahoo.com', '545 3rd Fairview IL', '650-6803421', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (21621, 'Chris Miller', 'chris.mi@outlook.com', '130 Maple Greenville', '846-7197817', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (34822, 'Jane Jones', 'jane.jon@hotmail.com', '547 Pine Georgetown ', '405-2416525', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (98425, 'David Brown', 'david.brow@gmail.com', '857 Broadway Frankli', '212-2165218', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (69795, 'Laura Taylor', 'laura.ta@outlook.com', '341 Oak Madison CA', '861-9075734', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (5421, 'Jane Taylor', 'jane.taylo@gmail.com', '437 Cedar Georgetown', '331-4116953', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (54553, 'John Williams', 'john.willi@gmail.com', '126 Pine Franklin PA', '792-9002023', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (7915, 'Laura Smith', 'laura.sm@outlook.com', '926 Maple Georgetown', '466-8275181', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (40098, 'Michael Smith', 'michael.@example.com', '544 Maple Fairview N', '211-4268749', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (71464, 'Katie Davis', 'katie.davi@gmail.com', '520 Elm Riverside IL', '518-9174557', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (6990, 'Katie Brown', 'katie.br@example.com', '595 Main Clinton GA', '715-7504238', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (21876, 'Emily Taylor', 'emily.ta@example.com', '114 3rd Clinton CA', '538-6266611', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (73696, 'John Taylor', 'john.tay@hotmail.com', '398 Cedar Greenville', '316-4356077', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (60059, 'Michael Jones', 'michael.@example.com', '601 High Madison FL', '151-7005896', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (969, 'Chris Smith', 'chris.smit@gmail.com', '764 Elm Greenfield T', '712-1707642', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (65479, 'Emily Miller', 'emily.mi@hotmail.com', '142 Oak Clinton NC', '342-7295959', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (25581, 'David Moore', 'david.moor@gmail.com', '716 Oak Fairview OH', '547-6274084', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (61931, 'Chris Davis', 'chris.da@hotmail.com', '750 High Clinton GA', '643-3661921', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (73319, 'Katie Williams', 'katie.will@gmail.com', '893 High Greenfield ', '684-2966566', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (37976, 'Alex Moore', 'alex.moore@gmail.com', '525 Oak Madison TX', '766-3226203', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (93754, 'John Williams', 'john.willi@yahoo.com', '177 Pine Clinton OH', '959-6055972', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (9612, 'Emily Taylor', 'emily.tayl@gmail.com', '303 Elm Greenfield M', '319-6111245', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (39925, 'Chris Davis', 'chris.da@example.com', '165 Broadway Greenvi', '781-8884765', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (86783, 'David Miller', 'david.mi@example.com', '300 Pine Franklin GA', '799-5728771', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (42806, 'Alex Williams', 'alex.willi@gmail.com', '328 Elm Clinton NY', '240-4004152', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (30174, 'David Taylor', 'david.ta@hotmail.com', '340 Cedar Springfiel', '862-6169102', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (78485, 'Michael Brown', 'michael.br@yahoo.com', '509 Oak Georgetown G', '711-5901997', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (62576, 'Michael Davis', 'michael.da@gmail.com', '443 2nd Georgetown O', '488-6574512', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (63036, 'Michael Jones', 'michael.@hotmail.com', '305 3rd Madison MI', '277-7004890', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (48677, 'Jane Smith', 'jane.smi@example.com', '286 Pine Springfield', '777-1394117', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (64901, 'Katie Moore', 'katie.mo@outlook.com', '259 Oak Franklin GA', '417-6068810', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (47026, 'Chris Davis', 'chris.davi@gmail.com', '798 Cedar Madison NY', '241-1552438', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (55688, 'Jane Brown', 'jane.bro@hotmail.com', '117 Pine Greenfield ', '572-6319127', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (86943, 'Emily Johnson', 'emily.jo@hotmail.com', '483 Elm Georgetown O', '252-2541542', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (63220, 'Laura Taylor', 'laura.ta@hotmail.com', '952 3rd Georgetown N', '774-1826438', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (69825, 'Jane Brown', 'jane.brown@gmail.com', '407 High Georgetown ', '101-5229522', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (61000, 'Emily Williams', 'emily.wi@hotmail.com', '895 Elm Georgetown O', '264-4624539', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (84191, 'Laura Jones', 'laura.jo@hotmail.com', '344 3rd Bristol PA', '486-7788483', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (96987, 'John Williams', 'john.wil@example.com', '769 3rd Georgetown P', '296-4855439', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (35942, 'John Johnson', 'john.joh@example.com', '230 Broadway Frankli', '166-5755318', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (66975, 'Michael Jones', 'michael.jo@gmail.com', '728 Maple Springfiel', '125-6479907', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (84609, 'John Brown', 'john.brown@yahoo.com', '911 Main Springfield', '181-8298878', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (68534, 'Emily Moore', 'emily.mo@example.com', '129 Broadway Greenfi', '901-2665646', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (66224, 'Emily Miller', 'emily.mi@example.com', '672 Main Springfield', '282-2688044', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (74286, 'Jane Williams', 'jane.willi@yahoo.com', '269 Broadway Frankli', '440-9098668', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (52324, 'David Brown', 'david.br@example.com', '384 3rd Clinton PA', '587-8604042', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (71391, 'Katie Moore', 'katie.mo@outlook.com', '315 High Georgetown ', '400-3815204', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (91873, 'Alex Johnson', 'alex.joh@hotmail.com', '550 Main Greenfield ', '522-8081371', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (79361, 'Katie Williams', 'katie.wi@example.com', '213 Main Riverside P', '550-7511276', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (39945, 'John Brown', 'john.bro@outlook.com', '235 Pine Madison CA', '436-9264337', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (93298, 'Katie Jones', 'katie.jo@outlook.com', '933 Broadway Greenfi', '624-6472791', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (11706, 'Laura Brown', 'laura.br@outlook.com', '746 2nd Fairview NY', '382-4681095', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (1067, 'Katie Taylor', 'katie.ta@hotmail.com', '322 Pine Greenfield ', '252-7183804', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (69664, 'Alex Wilson', 'alex.wilso@yahoo.com', '918 Elm Georgetown T', '343-5918073', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (79861, 'John Brown', 'john.brown@gmail.com', '122 Oak Springfield ', '366-5374829', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (15681, 'Sarah Moore', 'sarah.moor@yahoo.com', '774 Cedar Greenville', '584-9525982', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (81596, 'Emily Brown', 'emily.br@hotmail.com', '673 Cedar Greenville', '561-8913519', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (8358, 'Chris Taylor', 'chris.ta@hotmail.com', '721 Main Franklin OH', '487-4362221', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (62454, 'Michael Jones', 'michael.jo@gmail.com', '795 Elm Madison NC', '854-1817479', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (47195, 'Jane Davis', 'jane.dav@outlook.com', '834 Broadway Clinton', '808-9288402', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (3305, 'John Johnson', 'john.johns@gmail.com', '839 Elm Greenville N', '272-7694227', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (20720, 'Jane Johnson', 'jane.joh@outlook.com', '578 Pine Fairview PA', '696-4353335', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (57611, 'Jane Moore', 'jane.moo@hotmail.com', '507 3rd Springfield ', '299-5322274', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (26189, 'Emily Jones', 'emily.jo@example.com', '244 Elm Bristol IL', '747-1244794', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (33040, 'Katie Miller', 'katie.mill@yahoo.com', '979 2nd Greenfield C', '299-2474396', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (49645, 'Sarah Smith', 'sarah.sm@example.com', '837 Pine Fairview CA', '859-2905573', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (55703, 'Alex Moore', 'alex.moore@gmail.com', '500 Elm Greenville T', '632-2388548', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (54590, 'Michael Wilson', 'michael.wi@yahoo.com', '282 Pine Bristol TX', '799-7762339', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (51101, 'Sarah Miller', 'sarah.mill@yahoo.com', '928 Pine Madison OH', '210-3775555', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (97930, 'Jane Taylor', 'jane.taylo@yahoo.com', '541 Pine Springfield', '345-3082846', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (24115, 'Sarah Johnson', 'sarah.jo@hotmail.com', '904 Pine Clinton IL', '830-3369935', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (2526, 'Jane Jones', 'jane.jon@example.com', '531 Main Riverside M', '227-4001302', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (87841, 'Emily Moore', 'emily.moor@gmail.com', '312 3rd Franklin PA', '375-3139332', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (55531, 'Jane Wilson', 'jane.wilso@gmail.com', '397 Oak Greenville C', '380-5257069', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (21291, 'John Moore', 'john.moo@hotmail.com', '169 Main Bristol TX', '607-2974445', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (45017, 'Emily Moore', 'emily.mo@hotmail.com', '113 High Franklin MI', '172-3018264', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (44681, 'John Johnson', 'john.johns@gmail.com', '316 3rd Franklin TX', '927-1677900', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (22555, 'Michael Taylor', 'michael.ta@gmail.com', '126 Elm Springfield ', '255-5309341', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (4048, 'Katie Wilson', 'katie.wi@example.com', '844 Elm Riverside IL', '424-2818860', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (73599, 'Sarah Brown', 'sarah.brow@gmail.com', '790 3rd Georgetown F', '940-1307058', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (97929, 'Chris Smith', 'chris.sm@hotmail.com', '920 Oak Greenfield O', '629-5141950', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (5324, 'Jane Smith', 'jane.smi@hotmail.com', '106 3rd Greenville T', '466-6626642', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (86659, 'Sarah Davis', 'sarah.da@hotmail.com', '870 Elm Madison NY', '440-6727736', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (93405, 'Chris Jones', 'chris.jone@gmail.com', '391 High Riverside N', '256-1139885', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (28182, 'John Davis', 'john.davis@yahoo.com', '985 2nd Springfield ', '959-9915687', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (88664, 'Katie Miller', 'katie.mill@gmail.com', '595 Cedar Madison PA', '885-9211107', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (83181, 'Emily Johnson', 'emily.jo@example.com', '257 Elm Greenville I', '142-4098209', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (90416, 'Michael Smith', 'michael.sm@gmail.com', '877 3rd Riverside FL', '326-1711824', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (22498, 'Laura Wilson', 'laura.wils@gmail.com', '162 Maple Springfiel', '111-4676734', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (98467, 'Katie Miller', 'katie.mi@hotmail.com', '463 Main Georgetown ', '813-6464142', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (91694, 'Jane Miller', 'jane.mil@hotmail.com', '449 2nd Fairview NY', '364-8474032', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (57213, 'Katie Taylor', 'katie.tayl@yahoo.com', '152 3rd Greenville I', '707-5134390', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (82702, 'Emily Jones', 'emily.jo@outlook.com', '417 Pine Fairview PA', '396-5367149', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (79147, 'Jane Johnson', 'jane.joh@hotmail.com', '967 High Madison MI', '827-1985393', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (54956, 'Emily Taylor', 'emily.ta@hotmail.com', '736 Elm Springfield ', '329-8871782', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (91928, 'John Brown', 'john.bro@outlook.com', '961 Oak Franklin MI', '645-9018307', 'Bit', null);
commit;
prompt 200 records committed...
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (31638, 'Chris Williams', 'chris.wi@hotmail.com', '666 Cedar Georgetown', '477-8939664', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (91445, 'Chris Williams', 'chris.will@yahoo.com', '256 High Greenville ', '580-4328093', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (74187, 'Alex Johnson', 'alex.joh@outlook.com', '639 High Clinton GA', '889-4081060', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (71975, 'David Johnson', 'david.john@gmail.com', '481 2nd Franklin GA', '334-7597333', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (85098, 'Alex Smith', 'alex.smi@outlook.com', '500 Broadway Fairvie', '386-4234125', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (29702, 'David Moore', 'david.moor@gmail.com', '701 Broadway Fairvie', '673-8748860', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (18702, 'Sarah Taylor', 'sarah.ta@hotmail.com', '997 Main Clinton TX', '337-9995398', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (63489, 'Emily Miller', 'emily.mi@example.com', '880 Maple Springfiel', '158-7992149', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (11713, 'Michael Smith', 'michael.@example.com', '717 Elm Riverside TX', '518-3643990', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (25980, 'Katie Davis', 'katie.davi@yahoo.com', '131 Cedar Greenfield', '875-3419793', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (94578, 'David Taylor', 'david.tayl@gmail.com', '678 3rd Springfield ', '713-4104557', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (41762, 'Sarah Miller', 'sarah.mill@yahoo.com', '492 3rd Springfield ', '436-5929666', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (7029, 'Emily Williams', 'emily.will@yahoo.com', '778 Maple Greenfield', '397-4195544', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (96382, 'Alex Taylor', 'alex.tay@outlook.com', '957 Main Fairview PA', '163-5823845', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (33584, 'Katie Brown', 'katie.br@example.com', '331 3rd Madison IL', '743-8999983', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (16596, 'Katie Wilson', 'katie.wils@yahoo.com', '492 High Clinton NY', '600-6805545', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (67227, 'Alex Johnson', 'alex.joh@example.com', '556 Cedar Madison FL', '714-1332627', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (58806, 'Chris Miller', 'chris.mi@example.com', '218 Pine Franklin MI', '648-9071860', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (57243, 'Emily Wilson', 'emily.wi@hotmail.com', '728 Elm Fairview IL', '591-2307588', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (64193, 'David Miller', 'david.mill@gmail.com', '199 Oak Clinton TX', '163-1117571', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (19348, 'Chris Johnson', 'chris.john@gmail.com', '186 Pine Madison CA', '506-6388662', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (66299, 'Michael Smith', 'michael.@example.com', '510 Broadway Clinton', '308-5006077', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (77906, 'Alex Jones', 'alex.jones@yahoo.com', '409 Main Clinton TX', '988-6412426', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (16243, 'Michael Smith', 'michael.@example.com', '582 Elm Fairview PA', '309-2558871', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (19936, 'Emily Taylor', 'emily.ta@outlook.com', '965 Elm Clinton PA', '106-3945909', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (50786, 'Emily Moore', 'emily.mo@example.com', '585 Pine Springfield', '940-4561336', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (18952, 'Katie Miller', 'katie.mill@gmail.com', '111 2nd Greenfield O', '855-4844322', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (44652, 'Sarah Miller', 'sarah.mi@hotmail.com', '439 Oak Franklin IL', '536-4992829', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (29478, 'Jane Davis', 'jane.dav@example.com', '159 Cedar Madison MI', '484-8036281', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (42377, 'Sarah Brown', 'sarah.brow@gmail.com', '688 High Clinton IL', '733-3289069', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (15217, 'David Davis', 'david.da@outlook.com', '699 Oak Clinton NC', '251-1565707', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (3877, 'Katie Miller', 'katie.mi@example.com', '180 Cedar Riverside ', '449-7618322', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (19080, 'Chris Johnson', 'chris.john@yahoo.com', '533 Pine Franklin NC', '463-2732977', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (82022, 'Chris Jones', 'chris.jo@hotmail.com', '388 Pine Springfield', '518-4197807', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (99958, 'Katie Wilson', 'katie.wi@example.com', '658 Maple Bristol CA', '919-3448806', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (97712, 'Laura Brown', 'laura.br@example.com', '539 High Greenville ', '846-3929178', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (60528, 'Alex Johnson', 'alex.joh@outlook.com', '758 Maple Greenfield', '535-7563690', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (71890, 'Laura Williams', 'laura.will@gmail.com', '759 High Madison TX', '944-7698428', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (50747, 'Alex Wilson', 'alex.wilso@gmail.com', '996 Maple Fairview N', '406-7766161', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (64456, 'Alex Brown', 'alex.bro@outlook.com', '498 Maple Greenfield', '890-7139177', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (51223, 'David Smith', 'david.smit@yahoo.com', '760 Broadway Greenvi', '579-7939113', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (74937, 'Emily Taylor', 'emily.ta@outlook.com', '883 Maple Springfiel', '529-1534852', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (42953, 'Katie Johnson', 'katie.jo@outlook.com', '382 Elm Greenfield I', '159-6005766', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (70755, 'David Jones', 'david.jone@yahoo.com', '867 Elm Madison NY', '276-3859674', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (3645, 'Chris Miller', 'chris.mi@hotmail.com', '276 Pine Bristol CA', '288-6473149', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (64893, 'Katie Wilson', 'katie.wi@example.com', '576 Cedar Madison NC', '901-2336453', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (41744, 'John Williams', 'john.willi@gmail.com', '618 Oak Fairview TX', '588-8529969', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (84145, 'Jane Williams', 'jane.wil@outlook.com', '241 3rd Greenfield P', '468-7186753', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (10215, 'Jane Smith', 'jane.smith@gmail.com', '555 Elm Greenfield I', '953-3719662', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (23284, 'Chris Taylor', 'chris.ta@example.com', '892 3rd Georgetown P', '218-1759549', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (5810, 'Sarah Miller', 'sarah.mill@gmail.com', '964 Maple Madison PA', '859-7539095', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (46454, 'Chris Davis', 'chris.da@hotmail.com', '946 2nd Greenfield T', '644-8928678', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (37844, 'Alex Miller', 'alex.mil@example.com', '402 Pine Riverside P', '315-2132540', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (46523, 'Sarah Taylor', 'sarah.ta@hotmail.com', '302 Cedar Madison GA', '172-4841790', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (62962, 'Jane Johnson', 'jane.joh@example.com', '254 Pine Franklin CA', '651-6138480', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (647, 'John Moore', 'john.moore@yahoo.com', '585 3rd Franklin NY', '140-2689837', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (86505, 'Chris Taylor', 'chris.ta@outlook.com', '904 Broadway Georget', '726-5338436', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (79427, 'Emily Miller', 'emily.mi@hotmail.com', '506 2nd Georgetown P', '989-5265854', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (11110, 'Katie Smith', 'katie.smit@yahoo.com', '493 Pine Bristol TX', '288-2565545', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (91311, 'Michael Brown', 'michael.@hotmail.com', '199 Pine Madison PA', '583-5607592', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (70061, 'Katie Smith', 'katie.smit@yahoo.com', '588 Cedar Madison NC', '573-2783146', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (67425, 'Laura Moore', 'laura.mo@example.com', '889 Main Springfield', '445-8765859', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (38940, 'David Miller', 'david.mill@gmail.com', '105 Pine Greenville ', '753-8485671', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (82382, 'David Johnson', 'david.jo@example.com', '594 High Springfield', '119-5656340', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (6133, 'Michael Miller', 'michael.mi@gmail.com', '541 3rd Greenville I', '451-5065082', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (92239, 'Laura Smith', 'laura.sm@hotmail.com', '805 Broadway Greenvi', '774-7496277', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (38357, 'Jane Jones', 'jane.jon@outlook.com', '125 Main Fairview CA', '766-2168044', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (24658, 'Sarah Taylor', 'sarah.tayl@gmail.com', '239 3rd Georgetown T', '232-5771717', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (26544, 'Sarah Johnson', 'sarah.john@yahoo.com', '412 Elm Georgetown P', '274-9598147', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (86400, 'Alex Jones', 'alex.jon@outlook.com', '663 Cedar Georgetown', '750-5921122', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (4665, 'Jane Smith', 'jane.smi@hotmail.com', '234 Pine Fairview GA', '919-7097439', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (83675, 'Katie Moore', 'katie.mo@outlook.com', '164 Main Clinton PA', '851-1176416', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (42158, 'Sarah Brown', 'sarah.brow@yahoo.com', '744 3rd Fairview NY', '443-2922937', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (97144, 'Jane Johnson', 'jane.joh@outlook.com', '206 Cedar Georgetown', '225-9258296', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (27641, 'Chris Smith', 'chris.smit@yahoo.com', '471 High Greenville ', '955-5736933', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (74651, 'Katie Williams', 'katie.wi@outlook.com', '705 High Bristol PA', '119-5846937', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (55303, 'Michael Davis', 'michael.@example.com', '803 High Clinton TX', '772-9043487', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (14244, 'Chris Jones', 'chris.jone@yahoo.com', '711 3rd Greenfield G', '889-8043072', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (32409, 'Laura Moore', 'laura.mo@hotmail.com', '669 Elm Greenville F', '329-5891605', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (36176, 'Alex Taylor', 'alex.tay@example.com', '798 Broadway Riversi', '860-2124322', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (37209, 'Katie Brown', 'katie.br@hotmail.com', '477 Main Clinton NY', '659-2102763', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (97912, 'Laura Smith', 'laura.sm@example.com', '685 Broadway Frankli', '717-6479085', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (72048, 'John Johnson', 'john.joh@outlook.com', '636 Elm Springfield ', '695-4635260', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (18219, 'Michael Moore', 'michael.mo@yahoo.com', '983 Maple Madison CA', '496-7241046', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (53393, 'Jane Jones', 'jane.jon@example.com', '996 Main Bristol IL', '869-9595358', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (71521, 'Sarah Moore', 'sarah.moor@gmail.com', '456 Cedar Springfiel', '485-9292141', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (60222, 'Alex Smith', 'alex.smi@hotmail.com', '945 2nd Franklin IL', '423-6402263', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (4820, 'Michael Johnson', 'michael.@outlook.com', '529 2nd Greenfield M', '960-9447014', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (1828, 'John Davis', 'john.dav@example.com', '640 3rd Springfield ', '445-1257717', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (10344, 'Alex Moore', 'alex.moo@outlook.com', '781 Elm Franklin NY', '400-6857959', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (87977, 'Alex Wilson', 'alex.wil@outlook.com', '549 Cedar Springfiel', '421-3678665', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (10721, 'Sarah Wilson', 'sarah.wi@outlook.com', '360 2nd Springfield ', '607-7729924', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (71500, 'Michael Johnson', 'michael.@hotmail.com', '910 Maple Clinton PA', '415-4434459', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (38391, 'Laura Wilson', 'laura.wi@outlook.com', '235 Maple Madison OH', '335-1767479', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (50594, 'Sarah Smith', 'sarah.sm@example.com', '102 2nd Georgetown N', '164-8706773', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (94309, 'Sarah Wilson', 'sarah.wi@hotmail.com', '263 Main Bristol CA', '247-3863078', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (52106, 'Chris Miller', 'chris.mi@hotmail.com', '866 3rd Georgetown M', '703-6301852', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (48566, 'Laura Miller', 'laura.mi@hotmail.com', '362 2nd Franklin TX', '987-8465870', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (49187, 'Michael Brown', 'michael.br@yahoo.com', '128 Oak Greenfield N', '121-2207751', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (92453, 'Emily Williams', 'emily.will@gmail.com', '897 Oak Clinton NC', '232-1634107', 'Bit', null);
commit;
prompt 300 records committed...
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (95931, 'Laura Miller', 'laura.mi@outlook.com', '608 High Greenville ', '742-6902562', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (84712, 'Laura Williams', 'laura.wi@hotmail.com', '843 Broadway Madison', '169-9063898', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (9437, 'Michael Taylor', 'michael.@example.com', '561 2nd Springfield ', '484-9183993', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (44275, 'Jane Johnson', 'jane.joh@example.com', '592 Oak Fairview GA', '102-1379332', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (68611, 'Chris Moore', 'chris.moor@yahoo.com', '130 2nd Springfield ', '897-9084615', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (80481, 'Sarah Davis', 'sarah.da@example.com', '991 Main Georgetown ', '129-2762380', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (86150, 'Katie Johnson', 'katie.john@yahoo.com', '844 Oak Greenfield N', '109-1937711', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (72700, 'David Taylor', 'david.tayl@yahoo.com', '774 Broadway Madison', '839-1637680', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (80219, 'Chris Jones', 'chris.jo@outlook.com', '781 3rd Franklin TX', '177-8787376', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (25370, 'Sarah Miller', 'sarah.mill@yahoo.com', '980 Cedar Bristol NY', '717-3767543', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (33470, 'Laura Taylor', 'laura.tayl@yahoo.com', '712 Elm Fairview OH', '972-4595434', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (11020, 'Jane Moore', 'jane.moo@example.com', '215 Elm Franklin TX', '914-3367868', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (27133, 'Emily Miller', 'emily.mi@example.com', '941 Oak Bristol NY', '439-4839567', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (49215, 'Katie Miller', 'katie.mill@gmail.com', '314 3rd Georgetown N', '485-2818773', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (77193, 'John Jones', 'john.jones@gmail.com', '499 Elm Springfield ', '401-1502488', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (72669, 'Laura Jones', 'laura.jo@outlook.com', '968 Pine Springfield', '600-2593051', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (80825, 'David Taylor', 'david.tayl@gmail.com', '104 Broadway Madison', '484-9649907', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (22904, 'Jane Taylor', 'jane.tay@outlook.com', '449 3rd Franklin TX', '804-5706725', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (45268, 'Jane Brown', 'jane.brown@gmail.com', '516 Main Madison PA', '461-3065078', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (55374, 'Chris Brown', 'chris.br@outlook.com', '765 Cedar Greenfield', '865-1196841', 'Bit', null);
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails, customer_type)
values (5630, 'Michael Jones', 'michael.@hotmail.com', '408 2nd Greenville N', '444-2858787', 'Bit', null);
commit;
prompt 321 records loaded
prompt Loading KINDERGARTEN...
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (1, 30, 'russian', 29, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (2, 25, 'russian', 37, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (3, 15, 'hebrew', 38, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (4, 20, 'english', 50, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (5, 20, 'hebrew', 2, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (6, 25, 'hebrew', 5, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (7, 15, 'hebrew', 29, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (8, 20, 'english', 6, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (9, 20, 'english', 16, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (10, 30, 'english', 3, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (11, 25, 'english', 6, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (12, 30, 'english', 47, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (13, 30, 'russian', 12, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (14, 20, 'english', 31, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (15, 15, 'russian', 14, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (16, 25, 'hebrew', 44, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (17, 30, 'english', 43, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (18, 25, 'hebrew', 37, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (19, 15, 'hebrew', 40, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (20, 15, 'english', 46, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (21, 15, 'russian', 23, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (22, 25, 'hebrew', 31, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (23, 25, 'hebrew', 10, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (24, 25, 'english', 7, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (25, 25, 'russian', 9, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (26, 20, 'russian', 28, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (27, 25, 'russian', 49, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (28, 30, 'hebrew', 39, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (29, 15, 'hebrew', 45, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (30, 20, 'english', 40, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (31, 25, 'english', 8, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (32, 25, 'hebrew', 2, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (33, 30, 'english', 12, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (34, 25, 'russian', 10, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (35, 20, 'hebrew', 5, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (36, 15, 'russian', 20, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (37, 15, 'russian', 11, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (38, 25, 'russian', 50, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (39, 20, 'english', 47, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (40, 15, 'english', 30, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (41, 15, 'russian', 27, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (42, 20, 'english', 42, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (43, 25, 'english', 3, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (44, 20, 'russian', 50, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (45, 20, 'hebrew', 28, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (46, 25, 'english', 45, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (47, 30, 'russian', 36, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (48, 15, 'hebrew', 44, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (49, 15, 'english', 25, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (50, 30, 'russian', 31, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (51, 20, 'english', 20, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (52, 15, 'hebrew', 33, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (53, 25, 'hebrew', 19, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (54, 15, 'english', 33, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (55, 30, 'russian', 34, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (56, 30, 'english', 23, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (57, 15, 'hebrew', 50, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (58, 25, 'russian', 41, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (59, 30, 'russian', 35, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (60, 15, 'russian', 10, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (61, 20, 'russian', 28, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (62, 30, 'english', 10, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (63, 30, 'hebrew', 26, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (64, 15, 'english', 10, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (65, 15, 'hebrew', 44, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (66, 15, 'english', 45, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (67, 20, 'hebrew', 45, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (68, 15, 'russian', 15, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (69, 30, 'english', 21, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (70, 25, 'english', 28, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (71, 15, 'english', 10, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (72, 15, 'english', 18, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (73, 20, 'russian', 31, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (74, 30, 'english', 20, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (75, 20, 'hebrew', 38, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (76, 15, 'english', 8, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (77, 15, 'english', 48, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (78, 30, 'hebrew', 39, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (79, 25, 'hebrew', 31, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (80, 25, 'hebrew', 48, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (81, 30, 'hebrew', 46, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (82, 20, 'hebrew', 32, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (83, 20, 'english', 21, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (84, 15, 'english', 6, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (85, 25, 'russian', 45, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (86, 20, 'russian', 37, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (87, 25, 'russian', 19, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (88, 25, 'english', 27, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (89, 25, 'english', 29, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (90, 20, 'english', 3, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (91, 25, 'hebrew', 45, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (92, 20, 'russian', 46, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (93, 30, 'hebrew', 11, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (94, 30, 'russian', 45, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (95, 20, 'hebrew', 36, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (96, 20, 'hebrew', 8, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (97, 30, 'hebrew', 6, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (98, 25, 'russian', 36, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (99, 25, 'russian', 36, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (100, 25, 'russian', 4, 136, null);
commit;
prompt 100 records committed...
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (101, 15, 'hebrew', 8, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (102, 15, 'hebrew', 32, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (103, 25, 'english', 18, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (104, 30, 'hebrew', 38, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (105, 15, 'english', 45, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (106, 20, 'hebrew', 10, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (107, 30, 'hebrew', 34, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (108, 30, 'russian', 34, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (109, 30, 'russian', 49, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (110, 25, 'english', 29, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (111, 25, 'hebrew', 23, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (112, 30, 'english', 41, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (113, 20, 'hebrew', 36, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (114, 15, 'russian', 34, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (115, 20, 'russian', 27, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (116, 30, 'hebrew', 17, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (117, 25, 'russian', 2, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (118, 30, 'english', 32, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (119, 25, 'english', 36, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (120, 20, 'hebrew', 15, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (121, 15, 'hebrew', 7, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (122, 15, 'hebrew', 29, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (123, 15, 'english', 42, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (124, 25, 'russian', 36, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (125, 25, 'russian', 33, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (126, 25, 'english', 46, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (127, 20, 'russian', 23, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (128, 25, 'russian', 47, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (129, 15, 'english', 12, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (130, 20, 'hebrew', 8, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (131, 30, 'hebrew', 42, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (132, 25, 'english', 4, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (133, 30, 'english', 24, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (134, 30, 'russian', 20, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (135, 20, 'hebrew', 38, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (136, 30, 'english', 42, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (137, 25, 'hebrew', 1, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (138, 15, 'russian', 40, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (139, 15, 'english', 21, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (140, 20, 'hebrew', 17, 142, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (141, 20, 'russian', 11, 123, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (142, 25, 'hebrew', 26, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (143, 30, 'english', 33, 135, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (144, 30, 'russian', 19, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (145, 20, 'russian', 15, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (146, 20, 'hebrew', 15, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (147, 15, 'hebrew', 3, 136, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (148, 15, 'english', 21, 124, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (149, 15, 'hebrew', 16, 143, null);
insert into KINDERGARTEN (kindergartenid, capacity, k_language, b_num, k_type_id, customer_id)
values (150, 30, 'english', 20, 123, null);
commit;
prompt 150 records loaded
prompt Loading ACTIVITYSCHEDULE...
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('30-03-2024', 'dd-mm-yyyy'), 4, 138);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('04-06-2024', 'dd-mm-yyyy'), 14, 140);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:00', to_date('27-02-2024', 'dd-mm-yyyy'), 16, 102);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:15', to_date('04-09-2024', 'dd-mm-yyyy'), 9, 34);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('14-04-2024', 'dd-mm-yyyy'), 5, 144);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('27-07-2024', 'dd-mm-yyyy'), 14, 52);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:30', to_date('01-09-2024', 'dd-mm-yyyy'), 15, 135);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('04-05-2024', 'dd-mm-yyyy'), 10, 22);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:45', to_date('30-06-2024', 'dd-mm-yyyy'), 9, 20);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:45', to_date('25-05-2024', 'dd-mm-yyyy'), 14, 106);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:30', to_date('05-05-2024', 'dd-mm-yyyy'), 2, 22);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:15', to_date('29-02-2024', 'dd-mm-yyyy'), 2, 126);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('12-06-2024', 'dd-mm-yyyy'), 18, 106);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:00', to_date('01-05-2024', 'dd-mm-yyyy'), 5, 38);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('30-06-2024', 'dd-mm-yyyy'), 5, 6);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('15-06-2024', 'dd-mm-yyyy'), 18, 83);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('02-05-2024', 'dd-mm-yyyy'), 20, 48);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:15', to_date('03-04-2024', 'dd-mm-yyyy'), 5, 138);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:15', to_date('14-09-2024', 'dd-mm-yyyy'), 14, 143);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:30', to_date('21-02-2024', 'dd-mm-yyyy'), 9, 54);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:00', to_date('21-08-2024', 'dd-mm-yyyy'), 1, 28);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('05-08-2024', 'dd-mm-yyyy'), 18, 111);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:30', to_date('23-05-2024', 'dd-mm-yyyy'), 15, 101);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('20-09-2024', 'dd-mm-yyyy'), 16, 76);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:30', to_date('17-08-2024', 'dd-mm-yyyy'), 2, 85);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:45', to_date('21-04-2024', 'dd-mm-yyyy'), 13, 134);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:00', to_date('08-03-2024', 'dd-mm-yyyy'), 10, 29);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:15', to_date('27-03-2024', 'dd-mm-yyyy'), 4, 104);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:30', to_date('15-07-2024', 'dd-mm-yyyy'), 20, 79);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('21-04-2024', 'dd-mm-yyyy'), 20, 67);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:30', to_date('15-05-2024', 'dd-mm-yyyy'), 6, 93);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:30', to_date('14-08-2024', 'dd-mm-yyyy'), 10, 67);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:00', to_date('01-06-2024', 'dd-mm-yyyy'), 1, 19);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:45', to_date('22-08-2024', 'dd-mm-yyyy'), 13, 43);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:30', to_date('16-09-2024', 'dd-mm-yyyy'), 1, 100);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('15-03-2024', 'dd-mm-yyyy'), 14, 39);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:15', to_date('02-02-2024', 'dd-mm-yyyy'), 13, 133);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:15', to_date('02-02-2024', 'dd-mm-yyyy'), 1, 44);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('13-08-2024', 'dd-mm-yyyy'), 15, 27);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:00', to_date('26-02-2024', 'dd-mm-yyyy'), 12, 73);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:00', to_date('25-06-2024', 'dd-mm-yyyy'), 18, 66);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('19-02-2024', 'dd-mm-yyyy'), 5, 100);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:00', to_date('21-08-2024', 'dd-mm-yyyy'), 13, 23);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('19-03-2024', 'dd-mm-yyyy'), 7, 45);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:15', to_date('19-04-2024', 'dd-mm-yyyy'), 5, 59);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:30', to_date('23-04-2024', 'dd-mm-yyyy'), 3, 53);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:45', to_date('13-08-2024', 'dd-mm-yyyy'), 4, 117);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('13-07-2024', 'dd-mm-yyyy'), 17, 108);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:45', to_date('10-05-2024', 'dd-mm-yyyy'), 16, 65);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:00', to_date('21-06-2024', 'dd-mm-yyyy'), 1, 70);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:45', to_date('11-04-2024', 'dd-mm-yyyy'), 7, 87);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:15', to_date('01-09-2024', 'dd-mm-yyyy'), 5, 119);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:45', to_date('15-03-2024', 'dd-mm-yyyy'), 4, 95);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:00', to_date('18-08-2024', 'dd-mm-yyyy'), 8, 6);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:45', to_date('20-07-2024', 'dd-mm-yyyy'), 3, 122);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:30', to_date('29-03-2024', 'dd-mm-yyyy'), 19, 113);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:00', to_date('28-05-2024', 'dd-mm-yyyy'), 16, 18);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:00', to_date('28-08-2024', 'dd-mm-yyyy'), 12, 87);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:00', to_date('07-03-2024', 'dd-mm-yyyy'), 4, 134);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:45', to_date('16-03-2024', 'dd-mm-yyyy'), 19, 94);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:45', to_date('20-03-2024', 'dd-mm-yyyy'), 5, 109);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('14-02-2024', 'dd-mm-yyyy'), 14, 86);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:30', to_date('09-07-2024', 'dd-mm-yyyy'), 17, 44);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('23-02-2024', 'dd-mm-yyyy'), 16, 3);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:30', to_date('02-06-2024', 'dd-mm-yyyy'), 14, 150);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('21-02-2024', 'dd-mm-yyyy'), 2, 10);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:00', to_date('10-04-2024', 'dd-mm-yyyy'), 2, 6);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('15-04-2024', 'dd-mm-yyyy'), 10, 58);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:45', to_date('10-05-2024', 'dd-mm-yyyy'), 13, 144);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('08-05-2024', 'dd-mm-yyyy'), 14, 87);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:45', to_date('12-02-2024', 'dd-mm-yyyy'), 17, 91);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:30', to_date('18-06-2024', 'dd-mm-yyyy'), 16, 112);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:00', to_date('24-06-2024', 'dd-mm-yyyy'), 12, 55);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:00', to_date('21-08-2024', 'dd-mm-yyyy'), 7, 131);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:30', to_date('01-02-2024', 'dd-mm-yyyy'), 17, 145);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:45', to_date('17-08-2024', 'dd-mm-yyyy'), 18, 76);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('11-05-2024', 'dd-mm-yyyy'), 14, 128);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:00', to_date('28-03-2024', 'dd-mm-yyyy'), 18, 74);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('19-04-2024', 'dd-mm-yyyy'), 19, 144);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:30', to_date('06-03-2024', 'dd-mm-yyyy'), 7, 53);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:45', to_date('19-05-2024', 'dd-mm-yyyy'), 10, 141);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:00', to_date('05-02-2024', 'dd-mm-yyyy'), 3, 148);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:30', to_date('23-05-2024', 'dd-mm-yyyy'), 13, 101);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:00', to_date('05-03-2024', 'dd-mm-yyyy'), 17, 1);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('19-03-2024', 'dd-mm-yyyy'), 4, 47);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('04-06-2024', 'dd-mm-yyyy'), 16, 28);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:30', to_date('26-04-2024', 'dd-mm-yyyy'), 14, 114);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:15', to_date('21-04-2024', 'dd-mm-yyyy'), 4, 42);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:30', to_date('04-06-2024', 'dd-mm-yyyy'), 4, 40);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('25-04-2024', 'dd-mm-yyyy'), 14, 14);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:30', to_date('23-07-2024', 'dd-mm-yyyy'), 19, 118);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:00', to_date('20-08-2024', 'dd-mm-yyyy'), 7, 148);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('13-06-2024', 'dd-mm-yyyy'), 13, 114);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:00', to_date('04-05-2024', 'dd-mm-yyyy'), 8, 80);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('11-03-2024', 'dd-mm-yyyy'), 6, 144);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('18-02-2024', 'dd-mm-yyyy'), 14, 109);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:15', to_date('06-08-2024', 'dd-mm-yyyy'), 20, 36);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:45', to_date('27-02-2024', 'dd-mm-yyyy'), 8, 82);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('27-09-2024', 'dd-mm-yyyy'), 19, 22);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('10-07-2024', 'dd-mm-yyyy'), 16, 99);
commit;
prompt 100 records committed...
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:15', to_date('26-05-2024', 'dd-mm-yyyy'), 8, 72);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:15', to_date('29-02-2024', 'dd-mm-yyyy'), 19, 139);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:30', to_date('03-09-2024', 'dd-mm-yyyy'), 14, 8);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('08-04-2024', 'dd-mm-yyyy'), 17, 17);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('20-04-2024', 'dd-mm-yyyy'), 8, 112);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('24-04-2024', 'dd-mm-yyyy'), 20, 39);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:15', to_date('02-06-2024', 'dd-mm-yyyy'), 15, 149);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('12-03-2024', 'dd-mm-yyyy'), 8, 12);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('19-02-2024', 'dd-mm-yyyy'), 10, 139);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:45', to_date('24-09-2024', 'dd-mm-yyyy'), 4, 105);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:45', to_date('08-04-2024', 'dd-mm-yyyy'), 7, 58);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:15', to_date('06-05-2024', 'dd-mm-yyyy'), 19, 116);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('02-06-2024', 'dd-mm-yyyy'), 8, 43);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:00', to_date('01-05-2024', 'dd-mm-yyyy'), 4, 17);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:15', to_date('26-08-2024', 'dd-mm-yyyy'), 12, 149);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:15', to_date('03-02-2024', 'dd-mm-yyyy'), 20, 83);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('19-09-2024', 'dd-mm-yyyy'), 3, 123);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('12-02-2024', 'dd-mm-yyyy'), 2, 34);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('18-04-2024', 'dd-mm-yyyy'), 18, 115);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:00', to_date('21-07-2024', 'dd-mm-yyyy'), 19, 110);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('26-03-2024', 'dd-mm-yyyy'), 14, 113);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:45', to_date('09-08-2024', 'dd-mm-yyyy'), 1, 134);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('29-05-2024', 'dd-mm-yyyy'), 8, 9);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:45', to_date('27-03-2024', 'dd-mm-yyyy'), 15, 93);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:15', to_date('05-06-2024', 'dd-mm-yyyy'), 11, 11);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:15', to_date('03-09-2024', 'dd-mm-yyyy'), 13, 81);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:00', to_date('31-07-2024', 'dd-mm-yyyy'), 13, 130);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:15', to_date('11-06-2024', 'dd-mm-yyyy'), 2, 99);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:45', to_date('27-02-2024', 'dd-mm-yyyy'), 8, 86);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('06-08-2024', 'dd-mm-yyyy'), 6, 133);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('17-09-2024', 'dd-mm-yyyy'), 15, 82);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('26-07-2024', 'dd-mm-yyyy'), 20, 9);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:30', to_date('18-08-2024', 'dd-mm-yyyy'), 10, 84);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:45', to_date('07-07-2024', 'dd-mm-yyyy'), 5, 12);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('09-02-2024', 'dd-mm-yyyy'), 15, 116);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:30', to_date('13-05-2024', 'dd-mm-yyyy'), 14, 105);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:45', to_date('11-06-2024', 'dd-mm-yyyy'), 12, 35);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:00', to_date('26-02-2024', 'dd-mm-yyyy'), 1, 91);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('14-06-2024', 'dd-mm-yyyy'), 10, 101);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('03-07-2024', 'dd-mm-yyyy'), 16, 37);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:15', to_date('22-08-2024', 'dd-mm-yyyy'), 5, 20);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:30', to_date('05-07-2024', 'dd-mm-yyyy'), 14, 50);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:45', to_date('27-08-2024', 'dd-mm-yyyy'), 15, 9);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('23-07-2024', 'dd-mm-yyyy'), 5, 145);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:30', to_date('26-04-2024', 'dd-mm-yyyy'), 3, 124);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:30', to_date('21-07-2024', 'dd-mm-yyyy'), 16, 78);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('06-09-2024', 'dd-mm-yyyy'), 17, 140);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:15', to_date('06-04-2024', 'dd-mm-yyyy'), 9, 23);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:00', to_date('27-02-2024', 'dd-mm-yyyy'), 7, 50);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:45', to_date('30-08-2024', 'dd-mm-yyyy'), 5, 128);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('05-09-2024', 'dd-mm-yyyy'), 19, 66);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:15', to_date('11-03-2024', 'dd-mm-yyyy'), 9, 150);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('07-06-2024', 'dd-mm-yyyy'), 10, 115);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:15', to_date('07-09-2024', 'dd-mm-yyyy'), 13, 67);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:30', to_date('07-04-2024', 'dd-mm-yyyy'), 5, 51);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:00', to_date('18-06-2024', 'dd-mm-yyyy'), 17, 18);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:15', to_date('07-06-2024', 'dd-mm-yyyy'), 20, 2);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:00', to_date('17-07-2024', 'dd-mm-yyyy'), 17, 122);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('25-05-2024', 'dd-mm-yyyy'), 4, 94);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:15', to_date('24-03-2024', 'dd-mm-yyyy'), 3, 85);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('13-05-2024', 'dd-mm-yyyy'), 17, 149);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:00', to_date('14-08-2024', 'dd-mm-yyyy'), 3, 130);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:30', to_date('05-09-2024', 'dd-mm-yyyy'), 8, 146);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('01-04-2024', 'dd-mm-yyyy'), 1, 94);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:30', to_date('04-06-2024', 'dd-mm-yyyy'), 7, 22);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:45', to_date('02-06-2024', 'dd-mm-yyyy'), 6, 124);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:30', to_date('04-09-2024', 'dd-mm-yyyy'), 17, 89);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('14-08-2024', 'dd-mm-yyyy'), 16, 41);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:15', to_date('26-04-2024', 'dd-mm-yyyy'), 10, 85);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:45', to_date('29-04-2024', 'dd-mm-yyyy'), 16, 74);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:15', to_date('09-09-2024', 'dd-mm-yyyy'), 12, 1);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('05-02-2024', 'dd-mm-yyyy'), 19, 2);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('15-06-2024', 'dd-mm-yyyy'), 12, 84);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:45', to_date('23-04-2024', 'dd-mm-yyyy'), 20, 11);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('16-09-2024', 'dd-mm-yyyy'), 20, 112);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('30-03-2024', 'dd-mm-yyyy'), 19, 83);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:30', to_date('24-07-2024', 'dd-mm-yyyy'), 10, 148);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('01-04-2024', 'dd-mm-yyyy'), 17, 103);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('05-09-2024', 'dd-mm-yyyy'), 5, 137);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:30', to_date('24-02-2024', 'dd-mm-yyyy'), 5, 108);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:00', to_date('30-08-2024', 'dd-mm-yyyy'), 14, 17);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:30', to_date('26-05-2024', 'dd-mm-yyyy'), 9, 73);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:15', to_date('09-05-2024', 'dd-mm-yyyy'), 16, 61);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('20-04-2024', 'dd-mm-yyyy'), 18, 113);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('06-09-2024', 'dd-mm-yyyy'), 1, 50);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:00', to_date('12-06-2024', 'dd-mm-yyyy'), 7, 65);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:30', to_date('14-08-2024', 'dd-mm-yyyy'), 20, 72);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:30', to_date('20-03-2024', 'dd-mm-yyyy'), 3, 46);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('07-07-2024', 'dd-mm-yyyy'), 12, 7);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:00', to_date('21-06-2024', 'dd-mm-yyyy'), 1, 107);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('20-08-2024', 'dd-mm-yyyy'), 6, 112);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('23-05-2024', 'dd-mm-yyyy'), 6, 77);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:45', to_date('31-05-2024', 'dd-mm-yyyy'), 5, 2);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('27-06-2024', 'dd-mm-yyyy'), 3, 42);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:45', to_date('08-06-2024', 'dd-mm-yyyy'), 17, 136);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:45', to_date('07-05-2024', 'dd-mm-yyyy'), 9, 119);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('01-09-2024', 'dd-mm-yyyy'), 15, 123);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('11-03-2024', 'dd-mm-yyyy'), 15, 83);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:15', to_date('08-08-2024', 'dd-mm-yyyy'), 10, 130);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:30', to_date('24-08-2024', 'dd-mm-yyyy'), 19, 91);
commit;
prompt 200 records committed...
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:15', to_date('25-03-2024', 'dd-mm-yyyy'), 8, 89);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:45', to_date('20-04-2024', 'dd-mm-yyyy'), 13, 19);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:15', to_date('02-08-2024', 'dd-mm-yyyy'), 9, 32);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:30', to_date('19-07-2024', 'dd-mm-yyyy'), 12, 115);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('18-02-2024', 'dd-mm-yyyy'), 19, 14);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:15', to_date('21-03-2024', 'dd-mm-yyyy'), 17, 76);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('17-07-2024', 'dd-mm-yyyy'), 6, 5);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:30', to_date('23-09-2024', 'dd-mm-yyyy'), 7, 77);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:45', to_date('25-05-2024', 'dd-mm-yyyy'), 18, 54);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('13-06-2024', 'dd-mm-yyyy'), 9, 102);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('25-03-2024', 'dd-mm-yyyy'), 1, 128);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:00', to_date('31-03-2024', 'dd-mm-yyyy'), 13, 24);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('03-07-2024', 'dd-mm-yyyy'), 4, 126);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('03-06-2024', 'dd-mm-yyyy'), 11, 135);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:45', to_date('18-02-2024', 'dd-mm-yyyy'), 13, 142);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:45', to_date('16-04-2024', 'dd-mm-yyyy'), 10, 127);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:30', to_date('22-05-2024', 'dd-mm-yyyy'), 18, 28);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('26-02-2024', 'dd-mm-yyyy'), 12, 44);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('08-09-2024', 'dd-mm-yyyy'), 9, 144);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:15', to_date('08-06-2024', 'dd-mm-yyyy'), 16, 34);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('06-05-2024', 'dd-mm-yyyy'), 3, 126);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:00', to_date('17-07-2024', 'dd-mm-yyyy'), 9, 136);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('24-05-2024', 'dd-mm-yyyy'), 13, 105);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:45', to_date('27-05-2024', 'dd-mm-yyyy'), 13, 60);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:15', to_date('05-04-2024', 'dd-mm-yyyy'), 7, 121);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('17-06-2024', 'dd-mm-yyyy'), 2, 130);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('19-08-2024', 'dd-mm-yyyy'), 6, 80);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:30', to_date('19-02-2024', 'dd-mm-yyyy'), 2, 28);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:30', to_date('25-06-2024', 'dd-mm-yyyy'), 12, 91);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:00', to_date('23-07-2024', 'dd-mm-yyyy'), 1, 115);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:30', to_date('19-07-2024', 'dd-mm-yyyy'), 14, 19);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:45', to_date('06-05-2024', 'dd-mm-yyyy'), 15, 65);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:30', to_date('14-05-2024', 'dd-mm-yyyy'), 3, 104);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('16-08-2024', 'dd-mm-yyyy'), 1, 60);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('21-05-2024', 'dd-mm-yyyy'), 16, 130);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:30', to_date('06-07-2024', 'dd-mm-yyyy'), 10, 125);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:45', to_date('24-09-2024', 'dd-mm-yyyy'), 8, 85);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('25-08-2024', 'dd-mm-yyyy'), 11, 21);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:15', to_date('13-02-2024', 'dd-mm-yyyy'), 17, 70);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:15', to_date('29-03-2024', 'dd-mm-yyyy'), 10, 109);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:00', to_date('25-03-2024', 'dd-mm-yyyy'), 17, 115);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('15-08-2024', 'dd-mm-yyyy'), 10, 132);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:30', to_date('20-08-2024', 'dd-mm-yyyy'), 18, 102);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('15-07-2024', 'dd-mm-yyyy'), 19, 79);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:00', to_date('17-05-2024', 'dd-mm-yyyy'), 1, 104);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:30', to_date('12-04-2024', 'dd-mm-yyyy'), 11, 78);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:45', to_date('23-05-2024', 'dd-mm-yyyy'), 4, 49);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:30', to_date('05-05-2024', 'dd-mm-yyyy'), 15, 144);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:00', to_date('10-03-2024', 'dd-mm-yyyy'), 18, 90);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:45', to_date('12-05-2024', 'dd-mm-yyyy'), 7, 15);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:30', to_date('26-02-2024', 'dd-mm-yyyy'), 19, 11);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('21-02-2024', 'dd-mm-yyyy'), 12, 80);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:30', to_date('07-09-2024', 'dd-mm-yyyy'), 18, 133);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('09-02-2024', 'dd-mm-yyyy'), 16, 128);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:30', to_date('16-06-2024', 'dd-mm-yyyy'), 14, 74);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('08-02-2024', 'dd-mm-yyyy'), 10, 122);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('02-05-2024', 'dd-mm-yyyy'), 6, 1);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:00', to_date('25-03-2024', 'dd-mm-yyyy'), 6, 150);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:00', to_date('25-07-2024', 'dd-mm-yyyy'), 3, 3);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:00', to_date('15-06-2024', 'dd-mm-yyyy'), 5, 47);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:30', to_date('23-08-2024', 'dd-mm-yyyy'), 18, 57);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('18-06-2024', 'dd-mm-yyyy'), 11, 76);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:00', to_date('10-09-2024', 'dd-mm-yyyy'), 12, 107);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:15', to_date('26-08-2024', 'dd-mm-yyyy'), 19, 46);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('06-07-2024', 'dd-mm-yyyy'), 1, 11);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:00', to_date('26-04-2024', 'dd-mm-yyyy'), 17, 71);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('04-03-2024', 'dd-mm-yyyy'), 17, 27);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:45', to_date('06-05-2024', 'dd-mm-yyyy'), 10, 91);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:45', to_date('29-05-2024', 'dd-mm-yyyy'), 4, 4);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:45', to_date('07-06-2024', 'dd-mm-yyyy'), 8, 22);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:15', to_date('19-08-2024', 'dd-mm-yyyy'), 13, 62);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('05-08-2024', 'dd-mm-yyyy'), 20, 6);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('12-05-2024', 'dd-mm-yyyy'), 5, 134);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:00', to_date('08-09-2024', 'dd-mm-yyyy'), 9, 146);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:15', to_date('15-06-2024', 'dd-mm-yyyy'), 7, 96);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('17-08-2024', 'dd-mm-yyyy'), 6, 102);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:15', to_date('12-05-2024', 'dd-mm-yyyy'), 15, 34);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('31-05-2024', 'dd-mm-yyyy'), 6, 92);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:45', to_date('20-03-2024', 'dd-mm-yyyy'), 14, 116);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:00', to_date('11-02-2024', 'dd-mm-yyyy'), 8, 39);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:30', to_date('07-07-2024', 'dd-mm-yyyy'), 1, 109);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:45', to_date('03-08-2024', 'dd-mm-yyyy'), 18, 45);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:30', to_date('10-07-2024', 'dd-mm-yyyy'), 1, 30);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('09-03-2024', 'dd-mm-yyyy'), 1, 21);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:15', to_date('23-03-2024', 'dd-mm-yyyy'), 7, 35);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('24-04-2024', 'dd-mm-yyyy'), 13, 48);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:30', to_date('02-02-2024', 'dd-mm-yyyy'), 17, 11);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:00', to_date('24-03-2024', 'dd-mm-yyyy'), 15, 94);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:00', to_date('09-09-2024', 'dd-mm-yyyy'), 5, 91);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('24-07-2024', 'dd-mm-yyyy'), 15, 50);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:30', to_date('12-02-2024', 'dd-mm-yyyy'), 19, 96);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('13-05-2024', 'dd-mm-yyyy'), 16, 144);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:15', to_date('07-06-2024', 'dd-mm-yyyy'), 2, 92);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:30', to_date('10-05-2024', 'dd-mm-yyyy'), 7, 128);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:30', to_date('26-06-2024', 'dd-mm-yyyy'), 17, 73);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:00', to_date('17-07-2024', 'dd-mm-yyyy'), 3, 41);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:30', to_date('02-08-2024', 'dd-mm-yyyy'), 3, 146);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:15', to_date('14-08-2024', 'dd-mm-yyyy'), 14, 67);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('02-04-2024', 'dd-mm-yyyy'), 1, 111);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:15', to_date('28-05-2024', 'dd-mm-yyyy'), 17, 49);
commit;
prompt 300 records committed...
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('29-02-2024', 'dd-mm-yyyy'), 20, 68);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:15', to_date('25-04-2024', 'dd-mm-yyyy'), 6, 47);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:30', to_date('22-08-2024', 'dd-mm-yyyy'), 15, 73);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:30', to_date('02-06-2024', 'dd-mm-yyyy'), 18, 75);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:30', to_date('16-05-2024', 'dd-mm-yyyy'), 9, 94);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:30', to_date('30-05-2024', 'dd-mm-yyyy'), 11, 3);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:45', to_date('14-04-2024', 'dd-mm-yyyy'), 12, 46);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:45', to_date('18-04-2024', 'dd-mm-yyyy'), 7, 129);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('24-03-2024', 'dd-mm-yyyy'), 20, 28);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:15', to_date('24-03-2024', 'dd-mm-yyyy'), 16, 7);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:30', to_date('21-03-2024', 'dd-mm-yyyy'), 19, 130);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:45', to_date('12-06-2024', 'dd-mm-yyyy'), 6, 94);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:30', to_date('23-06-2024', 'dd-mm-yyyy'), 11, 125);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('10-02-2024', 'dd-mm-yyyy'), 17, 43);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:15', to_date('17-05-2024', 'dd-mm-yyyy'), 5, 132);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:45', to_date('01-05-2024', 'dd-mm-yyyy'), 9, 143);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('28-05-2024', 'dd-mm-yyyy'), 19, 59);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:15', to_date('26-06-2024', 'dd-mm-yyyy'), 9, 76);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:00', to_date('21-05-2024', 'dd-mm-yyyy'), 13, 136);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:30', to_date('25-08-2024', 'dd-mm-yyyy'), 6, 68);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:30', to_date('18-02-2024', 'dd-mm-yyyy'), 9, 61);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:15', to_date('25-03-2024', 'dd-mm-yyyy'), 7, 76);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:45', to_date('24-09-2024', 'dd-mm-yyyy'), 13, 112);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:00', to_date('11-08-2024', 'dd-mm-yyyy'), 12, 119);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('25-03-2024', 'dd-mm-yyyy'), 4, 101);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:45', to_date('21-04-2024', 'dd-mm-yyyy'), 17, 134);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('26-02-2024', 'dd-mm-yyyy'), 14, 46);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('28-05-2024', 'dd-mm-yyyy'), 8, 34);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:00', to_date('22-02-2024', 'dd-mm-yyyy'), 8, 68);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:45', to_date('02-05-2024', 'dd-mm-yyyy'), 9, 99);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('23-09-2024', 'dd-mm-yyyy'), 17, 39);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:30', to_date('06-07-2024', 'dd-mm-yyyy'), 19, 148);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:30', to_date('08-08-2024', 'dd-mm-yyyy'), 10, 43);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('22-08-2024', 'dd-mm-yyyy'), 10, 100);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:00', to_date('12-08-2024', 'dd-mm-yyyy'), 19, 47);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:00', to_date('05-08-2024', 'dd-mm-yyyy'), 7, 57);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:30', to_date('19-09-2024', 'dd-mm-yyyy'), 6, 97);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:30', to_date('22-07-2024', 'dd-mm-yyyy'), 5, 143);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:00', to_date('09-07-2024', 'dd-mm-yyyy'), 7, 55);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:00', to_date('22-02-2024', 'dd-mm-yyyy'), 4, 11);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:45', to_date('28-02-2024', 'dd-mm-yyyy'), 14, 88);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:15', to_date('08-07-2024', 'dd-mm-yyyy'), 18, 99);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:00', to_date('05-05-2024', 'dd-mm-yyyy'), 6, 34);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:00', to_date('17-06-2024', 'dd-mm-yyyy'), 13, 107);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:30', to_date('27-06-2024', 'dd-mm-yyyy'), 15, 148);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('03-02-2024', 'dd-mm-yyyy'), 18, 96);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:00', to_date('23-02-2024', 'dd-mm-yyyy'), 4, 90);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:15', to_date('16-02-2024', 'dd-mm-yyyy'), 11, 85);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:45', to_date('16-04-2024', 'dd-mm-yyyy'), 20, 15);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:15', to_date('24-03-2024', 'dd-mm-yyyy'), 14, 93);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:30', to_date('11-05-2024', 'dd-mm-yyyy'), 18, 34);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:30', to_date('22-03-2024', 'dd-mm-yyyy'), 6, 132);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:30', to_date('06-08-2024', 'dd-mm-yyyy'), 3, 17);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:00', to_date('20-04-2024', 'dd-mm-yyyy'), 12, 59);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:45', to_date('20-06-2024', 'dd-mm-yyyy'), 17, 97);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:00', to_date('11-07-2024', 'dd-mm-yyyy'), 12, 33);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:00', to_date('05-08-2024', 'dd-mm-yyyy'), 8, 143);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:30', to_date('05-06-2024', 'dd-mm-yyyy'), 19, 127);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:15', to_date('26-02-2024', 'dd-mm-yyyy'), 13, 115);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:15', to_date('12-05-2024', 'dd-mm-yyyy'), 10, 77);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:15', to_date('13-09-2024', 'dd-mm-yyyy'), 17, 117);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:45', to_date('06-03-2024', 'dd-mm-yyyy'), 19, 69);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:30', to_date('24-06-2024', 'dd-mm-yyyy'), 11, 119);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:45', to_date('27-07-2024', 'dd-mm-yyyy'), 19, 15);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:45', to_date('14-06-2024', 'dd-mm-yyyy'), 3, 33);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('11-09-2024', 'dd-mm-yyyy'), 9, 78);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('18-05-2024', 'dd-mm-yyyy'), 10, 104);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:15', to_date('28-07-2024', 'dd-mm-yyyy'), 1, 15);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:45', to_date('26-04-2024', 'dd-mm-yyyy'), 11, 32);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:30', to_date('28-05-2024', 'dd-mm-yyyy'), 2, 58);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:45', to_date('02-08-2024', 'dd-mm-yyyy'), 20, 87);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:30', to_date('26-03-2024', 'dd-mm-yyyy'), 12, 139);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:45', to_date('03-04-2024', 'dd-mm-yyyy'), 1, 85);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:15', to_date('08-02-2024', 'dd-mm-yyyy'), 19, 7);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:45', to_date('21-04-2024', 'dd-mm-yyyy'), 16, 24);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('10:45', to_date('24-05-2024', 'dd-mm-yyyy'), 1, 101);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:00', to_date('25-08-2024', 'dd-mm-yyyy'), 16, 124);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('23-05-2024', 'dd-mm-yyyy'), 1, 9);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:00', to_date('23-02-2024', 'dd-mm-yyyy'), 6, 63);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:45', to_date('17-04-2024', 'dd-mm-yyyy'), 6, 104);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('03-05-2024', 'dd-mm-yyyy'), 3, 106);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:00', to_date('25-05-2024', 'dd-mm-yyyy'), 2, 78);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:30', to_date('21-03-2024', 'dd-mm-yyyy'), 20, 120);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:45', to_date('02-08-2024', 'dd-mm-yyyy'), 20, 80);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('03-08-2024', 'dd-mm-yyyy'), 2, 88);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:45', to_date('16-04-2024', 'dd-mm-yyyy'), 13, 26);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('12:00', to_date('13-05-2024', 'dd-mm-yyyy'), 9, 13);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('11:45', to_date('03-02-2024', 'dd-mm-yyyy'), 17, 24);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('13-05-2024', 'dd-mm-yyyy'), 11, 134);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('8:45', to_date('09-05-2024', 'dd-mm-yyyy'), 7, 78);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:30', to_date('30-07-2024', 'dd-mm-yyyy'), 19, 136);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:45', to_date('03-03-2024', 'dd-mm-yyyy'), 17, 69);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('13:15', to_date('18-07-2024', 'dd-mm-yyyy'), 2, 113);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:30', to_date('27-08-2024', 'dd-mm-yyyy'), 18, 143);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('9:00', to_date('11-06-2024', 'dd-mm-yyyy'), 6, 13);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('14:45', to_date('02-03-2024', 'dd-mm-yyyy'), 15, 61);
insert into ACTIVITYSCHEDULE (act_hour, activity_date, activityid, kindergartenid)
values ('15:15', to_date('08-03-2024', 'dd-mm-yyyy'), 16, 45);
commit;
prompt 397 records loaded
prompt Loading DIETARYRESTRICTIONS...
prompt Table is empty
prompt Loading CATERING...
insert into CATERING (catering_id, name, cosher)
values (744, 'Renee', 'Y');
insert into CATERING (catering_id, name, cosher)
values (751, 'Kitty', 'Y');
insert into CATERING (catering_id, name, cosher)
values (754, 'Ritchie', 'Y');
insert into CATERING (catering_id, name, cosher)
values (779, 'Gailard', 'Y');
insert into CATERING (catering_id, name, cosher)
values (781, 'Suzy', 'N');
insert into CATERING (catering_id, name, cosher)
values (18, 'Chubby', 'N');
insert into CATERING (catering_id, name, cosher)
values (19, 'Patty', 'Y');
insert into CATERING (catering_id, name, cosher)
values (23, 'Emm', 'N');
insert into CATERING (catering_id, name, cosher)
values (31, 'Tom', 'Y');
insert into CATERING (catering_id, name, cosher)
values (39, 'Sal', 'Y');
insert into CATERING (catering_id, name, cosher)
values (40, 'Dianne', 'Y');
insert into CATERING (catering_id, name, cosher)
values (48, 'Joanna', 'Y');
insert into CATERING (catering_id, name, cosher)
values (59, 'Neil', 'Y');
insert into CATERING (catering_id, name, cosher)
values (61, 'Brenda', 'N');
insert into CATERING (catering_id, name, cosher)
values (75, 'Timothy', 'N');
insert into CATERING (catering_id, name, cosher)
values (91, 'Tal', 'Y');
insert into CATERING (catering_id, name, cosher)
values (94, 'Freddy', 'Y');
insert into CATERING (catering_id, name, cosher)
values (116, 'Busta', 'N');
insert into CATERING (catering_id, name, cosher)
values (126, 'Bobby', 'N');
insert into CATERING (catering_id, name, cosher)
values (127, 'Andre', 'Y');
insert into CATERING (catering_id, name, cosher)
values (131, 'Steven', 'N');
insert into CATERING (catering_id, name, cosher)
values (137, 'Salma', 'N');
insert into CATERING (catering_id, name, cosher)
values (140, 'Nastassja', 'Y');
insert into CATERING (catering_id, name, cosher)
values (144, 'Peter', 'N');
insert into CATERING (catering_id, name, cosher)
values (145, 'Howie', 'N');
insert into CATERING (catering_id, name, cosher)
values (191, 'Angie', 'N');
insert into CATERING (catering_id, name, cosher)
values (192, 'Chloe', 'N');
insert into CATERING (catering_id, name, cosher)
values (197, 'Amanda', 'Y');
insert into CATERING (catering_id, name, cosher)
values (206, 'Joshua', 'Y');
insert into CATERING (catering_id, name, cosher)
values (208, 'Colm', 'N');
insert into CATERING (catering_id, name, cosher)
values (212, 'Jody', 'Y');
insert into CATERING (catering_id, name, cosher)
values (214, 'Daryle', 'N');
insert into CATERING (catering_id, name, cosher)
values (218, 'Davey', 'N');
insert into CATERING (catering_id, name, cosher)
values (229, 'Glenn', 'N');
insert into CATERING (catering_id, name, cosher)
values (264, 'Nik', 'Y');
insert into CATERING (catering_id, name, cosher)
values (271, 'Forest', 'Y');
insert into CATERING (catering_id, name, cosher)
values (288, 'Rachael', 'N');
insert into CATERING (catering_id, name, cosher)
values (316, 'Barbara', 'Y');
insert into CATERING (catering_id, name, cosher)
values (332, 'Horace', 'N');
insert into CATERING (catering_id, name, cosher)
values (25, 'Stephen', 'N');
insert into CATERING (catering_id, name, cosher)
values (33, 'Joaquin', 'Y');
insert into CATERING (catering_id, name, cosher)
values (47, 'Randall', 'Y');
insert into CATERING (catering_id, name, cosher)
values (80, 'Jean-Luc', 'Y');
insert into CATERING (catering_id, name, cosher)
values (90, 'Dennis', 'N');
insert into CATERING (catering_id, name, cosher)
values (93, 'Curt', 'Y');
insert into CATERING (catering_id, name, cosher)
values (97, 'Sydney', 'N');
insert into CATERING (catering_id, name, cosher)
values (104, 'Uma', 'Y');
insert into CATERING (catering_id, name, cosher)
values (129, 'Hank', 'N');
insert into CATERING (catering_id, name, cosher)
values (153, 'Ashton', 'Y');
insert into CATERING (catering_id, name, cosher)
values (155, 'Carlene', 'N');
insert into CATERING (catering_id, name, cosher)
values (180, 'Josh', 'N');
insert into CATERING (catering_id, name, cosher)
values (186, 'Nathan', 'Y');
insert into CATERING (catering_id, name, cosher)
values (194, 'Curtis', 'N');
insert into CATERING (catering_id, name, cosher)
values (199, 'Alice', 'Y');
insert into CATERING (catering_id, name, cosher)
values (245, 'Mili', 'N');
insert into CATERING (catering_id, name, cosher)
values (249, 'Albertina', 'Y');
insert into CATERING (catering_id, name, cosher)
values (251, 'Emm', 'N');
insert into CATERING (catering_id, name, cosher)
values (258, 'Angie', 'N');
insert into CATERING (catering_id, name, cosher)
values (263, 'Frances', 'N');
insert into CATERING (catering_id, name, cosher)
values (286, 'Paul', 'Y');
insert into CATERING (catering_id, name, cosher)
values (318, 'Warren', 'Y');
insert into CATERING (catering_id, name, cosher)
values (322, 'Rose', 'N');
insert into CATERING (catering_id, name, cosher)
values (323, 'Ashton', 'Y');
insert into CATERING (catering_id, name, cosher)
values (329, 'Herbie', 'Y');
insert into CATERING (catering_id, name, cosher)
values (366, 'Jimmy', 'Y');
insert into CATERING (catering_id, name, cosher)
values (368, 'Frances', 'N');
insert into CATERING (catering_id, name, cosher)
values (377, 'Lindsay', 'N');
insert into CATERING (catering_id, name, cosher)
values (390, 'Liev', 'N');
insert into CATERING (catering_id, name, cosher)
values (397, 'Franco', 'N');
insert into CATERING (catering_id, name, cosher)
values (398, 'Kylie', 'Y');
insert into CATERING (catering_id, name, cosher)
values (423, 'Judge', 'N');
insert into CATERING (catering_id, name, cosher)
values (434, 'Albertina', 'Y');
insert into CATERING (catering_id, name, cosher)
values (441, 'Debbie', 'N');
insert into CATERING (catering_id, name, cosher)
values (446, 'Mary Beth', 'Y');
insert into CATERING (catering_id, name, cosher)
values (450, 'Omar', 'Y');
insert into CATERING (catering_id, name, cosher)
values (451, 'Ritchie', 'N');
insert into CATERING (catering_id, name, cosher)
values (463, 'Rodney', 'N');
insert into CATERING (catering_id, name, cosher)
values (467, 'Rowan', 'Y');
insert into CATERING (catering_id, name, cosher)
values (469, 'Mandy', 'Y');
insert into CATERING (catering_id, name, cosher)
values (474, 'Marc', 'N');
insert into CATERING (catering_id, name, cosher)
values (480, 'Jill', 'N');
insert into CATERING (catering_id, name, cosher)
values (482, 'Guy', 'Y');
insert into CATERING (catering_id, name, cosher)
values (510, 'King', 'Y');
insert into CATERING (catering_id, name, cosher)
values (530, 'Brenda', 'N');
insert into CATERING (catering_id, name, cosher)
values (538, 'Latin', 'Y');
insert into CATERING (catering_id, name, cosher)
values (542, 'Sean', 'N');
insert into CATERING (catering_id, name, cosher)
values (545, 'Joey', 'Y');
insert into CATERING (catering_id, name, cosher)
values (553, 'Ahmad', 'N');
insert into CATERING (catering_id, name, cosher)
values (559, 'Wally', 'Y');
insert into CATERING (catering_id, name, cosher)
values (570, 'Frankie', 'N');
insert into CATERING (catering_id, name, cosher)
values (571, 'Chaka', 'Y');
insert into CATERING (catering_id, name, cosher)
values (575, 'Kirk', 'N');
insert into CATERING (catering_id, name, cosher)
values (579, 'Garland', 'N');
insert into CATERING (catering_id, name, cosher)
values (629, 'Hilary', 'N');
insert into CATERING (catering_id, name, cosher)
values (631, 'Gavin', 'N');
insert into CATERING (catering_id, name, cosher)
values (656, 'Kieran', 'N');
insert into CATERING (catering_id, name, cosher)
values (677, 'Bernard', 'Y');
insert into CATERING (catering_id, name, cosher)
values (688, 'Curtis', 'Y');
insert into CATERING (catering_id, name, cosher)
values (695, 'Richard', 'Y');
insert into CATERING (catering_id, name, cosher)
values (755, 'Kieran', 'N');
commit;
prompt 100 records committed...
insert into CATERING (catering_id, name, cosher)
values (769, 'Alan', 'Y');
insert into CATERING (catering_id, name, cosher)
values (771, 'Rufus', 'Y');
insert into CATERING (catering_id, name, cosher)
values (794, 'Neve', 'N');
insert into CATERING (catering_id, name, cosher)
values (799, 'Leonardo', 'Y');
insert into CATERING (catering_id, name, cosher)
values (16, 'Ivan', 'Y');
insert into CATERING (catering_id, name, cosher)
values (336, 'Tara', 'N');
insert into CATERING (catering_id, name, cosher)
values (432, 'Halle', 'Y');
insert into CATERING (catering_id, name, cosher)
values (437, 'Gena', 'Y');
insert into CATERING (catering_id, name, cosher)
values (440, 'Todd', 'N');
insert into CATERING (catering_id, name, cosher)
values (457, 'Zooey', 'Y');
insert into CATERING (catering_id, name, cosher)
values (458, 'Denzel', 'Y');
insert into CATERING (catering_id, name, cosher)
values (511, 'Tcheky', 'Y');
insert into CATERING (catering_id, name, cosher)
values (522, 'Percy', 'Y');
insert into CATERING (catering_id, name, cosher)
values (527, 'Ice', 'Y');
insert into CATERING (catering_id, name, cosher)
values (540, 'Kurtwood', 'Y');
insert into CATERING (catering_id, name, cosher)
values (647, 'Charlie', 'Y');
insert into CATERING (catering_id, name, cosher)
values (651, 'Victor', 'N');
insert into CATERING (catering_id, name, cosher)
values (652, 'Raul', 'N');
insert into CATERING (catering_id, name, cosher)
values (665, 'Ronnie', 'N');
insert into CATERING (catering_id, name, cosher)
values (670, 'Lea', 'N');
insert into CATERING (catering_id, name, cosher)
values (706, 'Parker', 'N');
insert into CATERING (catering_id, name, cosher)
values (732, 'Vanessa', 'Y');
insert into CATERING (catering_id, name, cosher)
values (758, 'Mint', 'Y');
insert into CATERING (catering_id, name, cosher)
values (762, 'Jonny', 'N');
insert into CATERING (catering_id, name, cosher)
values (784, 'Peabo', 'N');
insert into CATERING (catering_id, name, cosher)
values (787, 'Elle', 'Y');
insert into CATERING (catering_id, name, cosher)
values (12, 'Rolando', 'Y');
insert into CATERING (catering_id, name, cosher)
values (53, 'Tim', 'N');
insert into CATERING (catering_id, name, cosher)
values (76, 'Leo', 'Y');
insert into CATERING (catering_id, name, cosher)
values (86, 'Lena', 'N');
insert into CATERING (catering_id, name, cosher)
values (100, 'Noah', 'Y');
insert into CATERING (catering_id, name, cosher)
values (103, 'Robbie', 'Y');
insert into CATERING (catering_id, name, cosher)
values (111, 'Nile', 'N');
insert into CATERING (catering_id, name, cosher)
values (121, 'Charlize', 'N');
insert into CATERING (catering_id, name, cosher)
values (151, 'Stellan', 'Y');
insert into CATERING (catering_id, name, cosher)
values (164, 'Kyle', 'Y');
insert into CATERING (catering_id, name, cosher)
values (190, 'Andrae', 'Y');
insert into CATERING (catering_id, name, cosher)
values (213, 'Nikka', 'N');
insert into CATERING (catering_id, name, cosher)
values (224, 'Mary-Louise', 'Y');
insert into CATERING (catering_id, name, cosher)
values (226, 'Don', 'Y');
insert into CATERING (catering_id, name, cosher)
values (230, 'Al', 'N');
insert into CATERING (catering_id, name, cosher)
values (232, 'Ricardo', 'Y');
insert into CATERING (catering_id, name, cosher)
values (237, 'Will', 'N');
insert into CATERING (catering_id, name, cosher)
values (240, 'Jonny Lee', 'N');
insert into CATERING (catering_id, name, cosher)
values (247, 'Gene', 'N');
insert into CATERING (catering_id, name, cosher)
values (250, 'Leslie', 'N');
insert into CATERING (catering_id, name, cosher)
values (281, 'Rowan', 'N');
insert into CATERING (catering_id, name, cosher)
values (337, 'Rosco', 'Y');
insert into CATERING (catering_id, name, cosher)
values (352, 'Don', 'N');
insert into CATERING (catering_id, name, cosher)
values (355, 'Bonnie', 'N');
insert into CATERING (catering_id, name, cosher)
values (372, 'Angela', 'N');
insert into CATERING (catering_id, name, cosher)
values (401, 'Ming-Na', 'N');
insert into CATERING (catering_id, name, cosher)
values (403, 'Moe', 'N');
insert into CATERING (catering_id, name, cosher)
values (408, 'Saul', 'N');
insert into CATERING (catering_id, name, cosher)
values (464, 'Loreena', 'Y');
insert into CATERING (catering_id, name, cosher)
values (465, 'Elias', 'N');
insert into CATERING (catering_id, name, cosher)
values (490, 'Sally', 'Y');
insert into CATERING (catering_id, name, cosher)
values (502, 'Dabney', 'Y');
insert into CATERING (catering_id, name, cosher)
values (505, 'Humberto', 'Y');
insert into CATERING (catering_id, name, cosher)
values (519, 'Omar', 'Y');
insert into CATERING (catering_id, name, cosher)
values (526, 'Dabney', 'Y');
insert into CATERING (catering_id, name, cosher)
values (544, 'Cameron', 'N');
insert into CATERING (catering_id, name, cosher)
values (547, 'Nickel', 'N');
insert into CATERING (catering_id, name, cosher)
values (548, 'Earl', 'Y');
insert into CATERING (catering_id, name, cosher)
values (574, 'Julianne', 'N');
insert into CATERING (catering_id, name, cosher)
values (586, 'Yolanda', 'N');
insert into CATERING (catering_id, name, cosher)
values (588, 'Ron', 'Y');
insert into CATERING (catering_id, name, cosher)
values (661, 'Trini', 'Y');
insert into CATERING (catering_id, name, cosher)
values (678, 'Anjelica', 'Y');
insert into CATERING (catering_id, name, cosher)
values (681, 'Wallace', 'Y');
insert into CATERING (catering_id, name, cosher)
values (714, 'Lizzy', 'N');
insert into CATERING (catering_id, name, cosher)
values (723, 'Brad', 'N');
insert into CATERING (catering_id, name, cosher)
values (726, 'Talvin', 'Y');
insert into CATERING (catering_id, name, cosher)
values (733, 'Bruce', 'Y');
insert into CATERING (catering_id, name, cosher)
values (741, 'Howard', 'Y');
insert into CATERING (catering_id, name, cosher)
values (743, 'Lauren', 'Y');
insert into CATERING (catering_id, name, cosher)
values (750, 'Michael', 'N');
insert into CATERING (catering_id, name, cosher)
values (753, 'Connie', 'Y');
insert into CATERING (catering_id, name, cosher)
values (761, 'Barbara', 'N');
insert into CATERING (catering_id, name, cosher)
values (775, 'Mae', 'N');
insert into CATERING (catering_id, name, cosher)
values (777, 'Paula', 'Y');
insert into CATERING (catering_id, name, cosher)
values (2, 'Mira', 'N');
insert into CATERING (catering_id, name, cosher)
values (4, 'Emilio', 'Y');
insert into CATERING (catering_id, name, cosher)
values (17, 'Treat', 'N');
insert into CATERING (catering_id, name, cosher)
values (38, 'Sander', 'N');
insert into CATERING (catering_id, name, cosher)
values (54, 'Jesse', 'Y');
insert into CATERING (catering_id, name, cosher)
values (72, 'Nikka', 'N');
insert into CATERING (catering_id, name, cosher)
values (83, 'Bernie', 'Y');
insert into CATERING (catering_id, name, cosher)
values (108, 'Samantha', 'Y');
insert into CATERING (catering_id, name, cosher)
values (161, 'Kathleen', 'Y');
insert into CATERING (catering_id, name, cosher)
values (175, 'Selma', 'Y');
insert into CATERING (catering_id, name, cosher)
values (185, 'Kazem', 'N');
insert into CATERING (catering_id, name, cosher)
values (195, 'Jean-Luc', 'N');
insert into CATERING (catering_id, name, cosher)
values (211, 'Ryan', 'Y');
insert into CATERING (catering_id, name, cosher)
values (215, 'Aidan', 'Y');
insert into CATERING (catering_id, name, cosher)
values (239, 'Dylan', 'Y');
insert into CATERING (catering_id, name, cosher)
values (280, 'Larry', 'Y');
insert into CATERING (catering_id, name, cosher)
values (282, 'Crystal', 'N');
insert into CATERING (catering_id, name, cosher)
values (297, 'Cherry', 'Y');
insert into CATERING (catering_id, name, cosher)
values (300, 'Rosario', 'N');
commit;
prompt 200 records committed...
insert into CATERING (catering_id, name, cosher)
values (343, 'Naomi', 'N');
insert into CATERING (catering_id, name, cosher)
values (362, 'Benjamin', 'Y');
insert into CATERING (catering_id, name, cosher)
values (373, 'Miguel', 'N');
insert into CATERING (catering_id, name, cosher)
values (413, 'Gaby', 'Y');
insert into CATERING (catering_id, name, cosher)
values (422, 'Juan', 'N');
insert into CATERING (catering_id, name, cosher)
values (459, 'Red', 'N');
insert into CATERING (catering_id, name, cosher)
values (500, 'Cate', 'N');
insert into CATERING (catering_id, name, cosher)
values (555, 'Kylie', 'Y');
insert into CATERING (catering_id, name, cosher)
values (560, 'Eileen', 'N');
insert into CATERING (catering_id, name, cosher)
values (591, 'Irene', 'N');
insert into CATERING (catering_id, name, cosher)
values (599, 'Lonnie', 'Y');
insert into CATERING (catering_id, name, cosher)
values (603, 'Brothers', 'Y');
insert into CATERING (catering_id, name, cosher)
values (645, 'Angie', 'Y');
insert into CATERING (catering_id, name, cosher)
values (669, 'Roddy', 'N');
insert into CATERING (catering_id, name, cosher)
values (680, 'Demi', 'N');
insert into CATERING (catering_id, name, cosher)
values (707, 'Cornell', 'Y');
insert into CATERING (catering_id, name, cosher)
values (711, 'Jared', 'N');
insert into CATERING (catering_id, name, cosher)
values (763, 'Jeremy', 'Y');
insert into CATERING (catering_id, name, cosher)
values (788, 'Jesus', 'Y');
insert into CATERING (catering_id, name, cosher)
values (21, 'Ming-Na', 'N');
insert into CATERING (catering_id, name, cosher)
values (65, 'Amy', 'Y');
insert into CATERING (catering_id, name, cosher)
values (69, 'Rik', 'Y');
insert into CATERING (catering_id, name, cosher)
values (78, 'Sean', 'Y');
insert into CATERING (catering_id, name, cosher)
values (141, 'Alessandro', 'Y');
insert into CATERING (catering_id, name, cosher)
values (157, 'Christian', 'N');
insert into CATERING (catering_id, name, cosher)
values (165, 'Juliet', 'Y');
insert into CATERING (catering_id, name, cosher)
values (183, 'First', 'N');
insert into CATERING (catering_id, name, cosher)
values (193, 'Allan', 'Y');
insert into CATERING (catering_id, name, cosher)
values (227, 'Beth', 'N');
insert into CATERING (catering_id, name, cosher)
values (243, 'Olga', 'Y');
insert into CATERING (catering_id, name, cosher)
values (256, 'Bobbi', 'N');
insert into CATERING (catering_id, name, cosher)
values (305, 'Nicky', 'N');
insert into CATERING (catering_id, name, cosher)
values (309, 'Sissy', 'N');
insert into CATERING (catering_id, name, cosher)
values (321, 'Freda', 'Y');
insert into CATERING (catering_id, name, cosher)
values (379, 'Roscoe', 'N');
insert into CATERING (catering_id, name, cosher)
values (392, 'Mike', 'Y');
insert into CATERING (catering_id, name, cosher)
values (396, 'Nigel', 'Y');
insert into CATERING (catering_id, name, cosher)
values (400, 'Tanya', 'N');
insert into CATERING (catering_id, name, cosher)
values (404, 'Hilary', 'N');
insert into CATERING (catering_id, name, cosher)
values (415, 'Heath', 'N');
insert into CATERING (catering_id, name, cosher)
values (427, 'Buffy', 'Y');
insert into CATERING (catering_id, name, cosher)
values (431, 'Rick', 'Y');
insert into CATERING (catering_id, name, cosher)
values (473, 'Caroline', 'Y');
insert into CATERING (catering_id, name, cosher)
values (484, 'Alfred', 'N');
insert into CATERING (catering_id, name, cosher)
values (528, 'Gina', 'Y');
insert into CATERING (catering_id, name, cosher)
values (536, 'Linda', 'N');
insert into CATERING (catering_id, name, cosher)
values (549, 'Joaquin', 'Y');
insert into CATERING (catering_id, name, cosher)
values (561, 'Davis', 'N');
insert into CATERING (catering_id, name, cosher)
values (590, 'Teena', 'Y');
insert into CATERING (catering_id, name, cosher)
values (598, 'Marisa', 'N');
insert into CATERING (catering_id, name, cosher)
values (625, 'Charles', 'N');
insert into CATERING (catering_id, name, cosher)
values (632, 'Swoosie', 'Y');
insert into CATERING (catering_id, name, cosher)
values (682, 'Ramsey', 'Y');
insert into CATERING (catering_id, name, cosher)
values (689, 'Danni', 'N');
insert into CATERING (catering_id, name, cosher)
values (709, 'Kiefer', 'Y');
insert into CATERING (catering_id, name, cosher)
values (747, 'Penelope', 'Y');
insert into CATERING (catering_id, name, cosher)
values (790, 'Toni', 'N');
insert into CATERING (catering_id, name, cosher)
values (791, 'Lena', 'Y');
insert into CATERING (catering_id, name, cosher)
values (793, 'Maceo', 'N');
insert into CATERING (catering_id, name, cosher)
values (795, 'Kazem', 'N');
insert into CATERING (catering_id, name, cosher)
values (797, 'Avril', 'N');
insert into CATERING (catering_id, name, cosher)
values (49, 'Debbie', 'N');
insert into CATERING (catering_id, name, cosher)
values (52, 'Micky', 'Y');
insert into CATERING (catering_id, name, cosher)
values (79, 'Hugh', 'Y');
insert into CATERING (catering_id, name, cosher)
values (82, 'Fiona', 'Y');
insert into CATERING (catering_id, name, cosher)
values (99, 'Rebeka', 'Y');
insert into CATERING (catering_id, name, cosher)
values (128, 'Thora', 'N');
insert into CATERING (catering_id, name, cosher)
values (143, 'Frank', 'Y');
insert into CATERING (catering_id, name, cosher)
values (149, 'Maury', 'Y');
insert into CATERING (catering_id, name, cosher)
values (178, 'Oro', 'Y');
insert into CATERING (catering_id, name, cosher)
values (179, 'Philip', 'N');
insert into CATERING (catering_id, name, cosher)
values (312, 'Ray', 'N');
insert into CATERING (catering_id, name, cosher)
values (367, 'Taye', 'N');
insert into CATERING (catering_id, name, cosher)
values (382, 'Teena', 'Y');
insert into CATERING (catering_id, name, cosher)
values (419, 'Ernie', 'N');
insert into CATERING (catering_id, name, cosher)
values (476, 'Kevn', 'N');
insert into CATERING (catering_id, name, cosher)
values (477, 'Loreena', 'Y');
insert into CATERING (catering_id, name, cosher)
values (478, 'Stewart', 'N');
insert into CATERING (catering_id, name, cosher)
values (503, 'Warren', 'N');
insert into CATERING (catering_id, name, cosher)
values (534, 'Tara', 'Y');
insert into CATERING (catering_id, name, cosher)
values (565, 'Russell', 'Y');
insert into CATERING (catering_id, name, cosher)
values (566, 'Machine', 'Y');
insert into CATERING (catering_id, name, cosher)
values (611, 'Andrae', 'Y');
insert into CATERING (catering_id, name, cosher)
values (619, 'Barbara', 'N');
insert into CATERING (catering_id, name, cosher)
values (679, 'Bebe', 'Y');
insert into CATERING (catering_id, name, cosher)
values (690, 'Nick', 'Y');
insert into CATERING (catering_id, name, cosher)
values (699, 'Vonda', 'Y');
insert into CATERING (catering_id, name, cosher)
values (756, 'Etta', 'Y');
insert into CATERING (catering_id, name, cosher)
values (759, 'Herbie', 'N');
insert into CATERING (catering_id, name, cosher)
values (8, 'Shannon', 'N');
insert into CATERING (catering_id, name, cosher)
values (9, 'Derrick', 'Y');
insert into CATERING (catering_id, name, cosher)
values (50, 'Bonnie', 'N');
insert into CATERING (catering_id, name, cosher)
values (55, 'Petula', 'Y');
insert into CATERING (catering_id, name, cosher)
values (58, 'Melanie', 'Y');
insert into CATERING (catering_id, name, cosher)
values (63, 'Clarence', 'N');
insert into CATERING (catering_id, name, cosher)
values (68, 'Jeroen', 'Y');
insert into CATERING (catering_id, name, cosher)
values (89, 'Phil', 'Y');
insert into CATERING (catering_id, name, cosher)
values (106, 'Lupe', 'N');
insert into CATERING (catering_id, name, cosher)
values (118, 'Tori', 'N');
insert into CATERING (catering_id, name, cosher)
values (158, 'Fred', 'N');
commit;
prompt 300 records committed...
insert into CATERING (catering_id, name, cosher)
values (160, 'Olga', 'N');
insert into CATERING (catering_id, name, cosher)
values (198, 'Derrick', 'Y');
insert into CATERING (catering_id, name, cosher)
values (223, 'Tom', 'N');
insert into CATERING (catering_id, name, cosher)
values (255, 'Sheryl', 'Y');
insert into CATERING (catering_id, name, cosher)
values (265, 'Alfred', 'N');
insert into CATERING (catering_id, name, cosher)
values (277, 'Keanu', 'N');
insert into CATERING (catering_id, name, cosher)
values (284, 'Sona', 'N');
insert into CATERING (catering_id, name, cosher)
values (325, 'Lennie', 'N');
insert into CATERING (catering_id, name, cosher)
values (334, 'Humberto', 'N');
insert into CATERING (catering_id, name, cosher)
values (347, 'Jonny Lee', 'N');
insert into CATERING (catering_id, name, cosher)
values (351, 'Kevin', 'Y');
insert into CATERING (catering_id, name, cosher)
values (354, 'Terence', 'Y');
insert into CATERING (catering_id, name, cosher)
values (374, 'Clay', 'N');
insert into CATERING (catering_id, name, cosher)
values (380, 'Freddy', 'Y');
insert into CATERING (catering_id, name, cosher)
values (394, 'Hugo', 'N');
insert into CATERING (catering_id, name, cosher)
values (426, 'Kevn', 'N');
insert into CATERING (catering_id, name, cosher)
values (445, 'Ryan', 'Y');
insert into CATERING (catering_id, name, cosher)
values (486, 'Chubby', 'Y');
insert into CATERING (catering_id, name, cosher)
values (533, 'Hikaru', 'N');
insert into CATERING (catering_id, name, cosher)
values (551, 'Heather', 'N');
insert into CATERING (catering_id, name, cosher)
values (639, 'Trey', 'N');
insert into CATERING (catering_id, name, cosher)
values (640, 'Mark', 'N');
insert into CATERING (catering_id, name, cosher)
values (676, 'Billy', 'N');
insert into CATERING (catering_id, name, cosher)
values (687, 'Martin', 'Y');
insert into CATERING (catering_id, name, cosher)
values (694, 'Sandra', 'Y');
insert into CATERING (catering_id, name, cosher)
values (718, 'David', 'Y');
insert into CATERING (catering_id, name, cosher)
values (720, 'Garland', 'Y');
insert into CATERING (catering_id, name, cosher)
values (731, 'Olympia', 'N');
insert into CATERING (catering_id, name, cosher)
values (748, 'Belinda', 'Y');
insert into CATERING (catering_id, name, cosher)
values (770, 'Ellen', 'Y');
insert into CATERING (catering_id, name, cosher)
values (785, 'Kathleen', 'Y');
insert into CATERING (catering_id, name, cosher)
values (786, 'Geoffrey', 'Y');
insert into CATERING (catering_id, name, cosher)
values (30, 'Charlize', 'N');
insert into CATERING (catering_id, name, cosher)
values (46, 'Chubby', 'N');
insert into CATERING (catering_id, name, cosher)
values (60, 'Roy', 'Y');
insert into CATERING (catering_id, name, cosher)
values (70, 'Gran', 'Y');
insert into CATERING (catering_id, name, cosher)
values (73, 'Wayman', 'Y');
insert into CATERING (catering_id, name, cosher)
values (87, 'Udo', 'Y');
insert into CATERING (catering_id, name, cosher)
values (102, 'Clarence', 'Y');
insert into CATERING (catering_id, name, cosher)
values (113, 'Alannah', 'Y');
insert into CATERING (catering_id, name, cosher)
values (135, 'Radney', 'N');
insert into CATERING (catering_id, name, cosher)
values (184, 'Rose', 'N');
insert into CATERING (catering_id, name, cosher)
values (200, 'Goran', 'N');
insert into CATERING (catering_id, name, cosher)
values (202, 'Mike', 'Y');
insert into CATERING (catering_id, name, cosher)
values (209, 'Samuel', 'Y');
insert into CATERING (catering_id, name, cosher)
values (267, 'Powers', 'Y');
insert into CATERING (catering_id, name, cosher)
values (290, 'Dennis', 'N');
insert into CATERING (catering_id, name, cosher)
values (291, 'Mia', 'Y');
insert into CATERING (catering_id, name, cosher)
values (313, 'Luke', 'N');
insert into CATERING (catering_id, name, cosher)
values (324, 'Hilary', 'Y');
insert into CATERING (catering_id, name, cosher)
values (326, 'Walter', 'Y');
insert into CATERING (catering_id, name, cosher)
values (344, 'Nicolas', 'N');
insert into CATERING (catering_id, name, cosher)
values (349, 'Fiona', 'N');
insert into CATERING (catering_id, name, cosher)
values (402, 'Gladys', 'N');
insert into CATERING (catering_id, name, cosher)
values (430, 'Howard', 'N');
insert into CATERING (catering_id, name, cosher)
values (433, 'Roberta', 'Y');
insert into CATERING (catering_id, name, cosher)
values (468, 'Horace', 'N');
insert into CATERING (catering_id, name, cosher)
values (520, 'Emm', 'Y');
insert into CATERING (catering_id, name, cosher)
values (532, 'Woody', 'N');
insert into CATERING (catering_id, name, cosher)
values (539, 'Lena', 'Y');
insert into CATERING (catering_id, name, cosher)
values (550, 'Debra', 'N');
insert into CATERING (catering_id, name, cosher)
values (568, 'Linda', 'N');
insert into CATERING (catering_id, name, cosher)
values (572, 'Christopher', 'Y');
insert into CATERING (catering_id, name, cosher)
values (580, 'Susan', 'N');
insert into CATERING (catering_id, name, cosher)
values (585, 'Mary', 'N');
insert into CATERING (catering_id, name, cosher)
values (594, 'Chad', 'N');
insert into CATERING (catering_id, name, cosher)
values (608, 'Warren', 'N');
insert into CATERING (catering_id, name, cosher)
values (618, 'Trace', 'N');
insert into CATERING (catering_id, name, cosher)
values (624, 'Maceo', 'N');
insert into CATERING (catering_id, name, cosher)
values (638, 'Rade', 'N');
insert into CATERING (catering_id, name, cosher)
values (653, 'Benjamin', 'N');
insert into CATERING (catering_id, name, cosher)
values (666, 'Wayman', 'Y');
insert into CATERING (catering_id, name, cosher)
values (671, 'Sara', 'N');
insert into CATERING (catering_id, name, cosher)
values (675, 'Carolyn', 'Y');
insert into CATERING (catering_id, name, cosher)
values (729, 'Ronnie', 'N');
insert into CATERING (catering_id, name, cosher)
values (740, 'Clay', 'Y');
commit;
prompt 376 records loaded
prompt Loading DISHS...
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (2, 218, 'Kerak Telor', 'Meat', 79, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (4, 197, 'Sate Padang Pad', 'Meat', 16, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (6, 66, 'Dim Sum', 'Meat', 769, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (8, 39, 'Fajitas', 'None', 121, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (10, 229, 'Sate Padang Saw', 'None', 2, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (12, 141, 'Sate Taoco', 'Dairy', 143, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (14, 114, 'Sate Padang Buk', 'Dairy', 23, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (16, 116, 'Bruschetta', 'Dairy', 286, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (18, 227, 'Sate Ayam Kampu', 'None', 474, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (20, 53, 'Bihun', 'None', 640, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (22, 138, 'Shawarma', 'Dairy', 666, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (24, 192, 'Sate Lilit', 'None', 198, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (26, 94, 'Pad Thai', 'None', 52, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (28, 207, 'Sate Padang Buk', 'Dairy', 379, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (30, 167, 'Sate Padang Sol', 'Dairy', 689, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (32, 178, 'Risotto', 'None', 59, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (34, 164, 'Sate Padang Tan', 'None', 611, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (36, 246, 'Sate Padang Pes', 'Meat', 661, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (38, 71, 'Schnitzel', 'Dairy', 284, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (40, 120, 'Sate Padang Saw', 'None', 706, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (42, 111, 'Sate Lilit', 'Dairy', 223, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (44, 29, 'Sate Kikil', 'None', 80, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (46, 177, 'Sambal', 'None', 213, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (48, 134, 'Crepe', 'None', 379, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (50, 33, 'Sate Padang Pad', 'Dairy', 284, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (52, 20, 'Risotto', 'Dairy', 349, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (54, 46, 'Soto Medan', 'None', 72, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (56, 96, 'Lo Mie', 'Dairy', 368, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (58, 147, 'Sate Burung', 'None', 599, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (60, 69, 'Sate Padang Sol', 'Dairy', 459, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (62, 246, 'Kroket', 'Meat', 656, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (64, 35, 'Sate Padang Lim', 'Meat', 12, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (66, 27, 'Sate Daging Sap', 'Dairy', 158, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (68, 22, 'Soto Ayam', 'Dairy', 690, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (70, 202, 'Soto Kudus', 'Meat', 761, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (72, 63, 'Sate Lilit', 'Dairy', 694, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (74, 145, 'Bakpao', 'None', 355, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (76, 118, 'Sate Padang Aga', 'None', 131, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (78, 205, 'Sate Tempe', 'Meat', 290, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (80, 65, 'Sate Padang Men', 'None', 218, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (82, 184, 'Baklava', 'None', 65, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (84, 222, 'Sate Padang Saw', 'Dairy', 762, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (86, 179, 'Sate Padang Sij', 'Meat', 313, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (88, 98, 'Sate Padang Lim', 'Dairy', 58, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (90, 122, 'Sate Padang Lub', 'Dairy', 373, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (92, 215, 'Sate Usus', 'Dairy', 770, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (94, 77, 'Sate Tomat', 'Dairy', 413, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (96, 79, 'Sate Padang Lim', 'None', 209, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (98, 157, 'Sate Usus', 'Meat', 640, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (100, 150, 'Sate Padang Pas', 'Meat', 286, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (102, 37, 'Sate Padang Pas', 'None', 396, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (104, 182, 'Asinan', 'None', 316, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (106, 173, 'Kimchi', 'Meat', 709, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (108, 185, 'Sate Padang Sol', 'Dairy', 555, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (110, 77, 'Sate Padang Dha', 'Dairy', 183, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (112, 67, 'Sate Gulai', 'None', 108, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (114, 134, 'Sate Padang Par', 'None', 131, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (116, 44, 'Sate Padang Pas', 'Meat', 490, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (118, 28, 'Sate Padang Par', 'Dairy', 590, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (120, 197, 'Mie Goreng', 'Dairy', 349, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (122, 238, 'Sate Jeroan', 'Dairy', 588, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (124, 103, 'Soto Kudus', 'None', 17, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (126, 148, 'Sate Padang Pay', 'Meat', 53, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (128, 150, 'Sate Padang Par', 'None', 265, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (130, 152, 'Sate Padang Pas', 'Dairy', 72, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (132, 161, 'Sate Tegal', 'Dairy', 707, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (134, 133, 'Sate Vegetarian', 'None', 140, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (136, 160, 'Lemper', 'Dairy', 30, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (138, 99, 'Sate Daging Sap', 'Dairy', 143, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (140, 61, 'Enchilada', 'Dairy', 164, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (142, 194, 'Kroket', 'Meat', 39, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (144, 123, 'Sate Padang Pes', 'None', 490, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (146, 89, 'Sate Ikan', 'Meat', 297, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (148, 83, 'Sate Padang Pes', 'None', 76, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (150, 63, 'Schnitzel', 'None', 282, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (152, 219, 'Sate Padang Sol', 'Dairy', 191, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (154, 79, 'Sate Padang Pad', 'None', 251, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (156, 172, 'Sate Padang Tan', 'Meat', 343, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (158, 78, 'Sate Padang Dha', 'None', 579, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (160, 145, 'Sate Meranggi', 'Dairy', 755, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (162, 131, 'Sate Padang Lim', 'Dairy', 777, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (164, 103, 'Sate Padang Saw', 'Meat', 49, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (166, 183, 'Sate Padang Buk', 'None', 284, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (168, 197, 'Lasagna', 'None', 380, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (170, 112, 'Sate Padang Sij', 'Dairy', 243, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (172, 101, 'Sate Padang Sol', 'Dairy', 427, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (174, 88, 'Sate Padang Tan', 'Meat', 164, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (176, 45, 'Paella', 'Meat', 422, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (178, 78, 'Sate Keong', 'Dairy', 545, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (180, 71, 'Sate Kambing', 'Dairy', 180, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (182, 122, 'Sate Padang Pas', 'None', 631, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (184, 47, 'Sate Padang Lim', 'Meat', 280, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (186, 209, 'Sate Padang Men', 'None', 224, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (188, 226, 'Sate Padang Aga', 'None', 111, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (190, 238, 'Sate Daging Sap', 'Dairy', 76, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (192, 250, 'Sate Padang Buk', 'Meat', 770, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (194, 38, 'Sate Kikil', 'None', 377, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (196, 85, 'Sup Buntut', 'Dairy', 751, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (198, 167, 'Lemper', 'Dairy', 549, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (200, 90, 'Sate Padang Tan', 'None', 647, 0);
commit;
prompt 100 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (202, 228, 'Soto Ayam', 'None', 336, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (204, 20, 'Laksa', 'Dairy', 550, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (206, 43, 'Sate Burung', 'Dairy', 373, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (208, 164, 'Sate Padang Sol', 'None', 781, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (210, 192, 'Sate Padang Saw', 'Dairy', 200, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (212, 29, 'Sate Ambal', 'Dairy', 99, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (214, 99, 'Crepe', 'None', 570, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (216, 85, 'Maki', 'None', 761, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (218, 99, 'Sate Padang Par', 'None', 743, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (220, 127, 'Sate Padang Sol', 'None', 240, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (222, 131, 'Sate Maranggi', 'Dairy', 787, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (224, 249, 'Empanada', 'Dairy', 486, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (226, 107, 'Sate Padang Sol', 'Meat', 9, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (228, 39, 'Sate Padang Aga', 'Meat', 551, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (230, 123, 'Sate Padang Par', 'Dairy', 8, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (232, 156, 'Sate Padang Men', 'Meat', 165, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (234, 61, 'Sate Padang Sol', 'Meat', 750, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (236, 56, 'Rendang', 'None', 794, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (238, 170, 'Sate Usus', 'Meat', 579, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (240, 176, 'Sate Padang Pay', 'Meat', 183, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (242, 115, 'Sate Padang Pas', 'Meat', 503, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (244, 35, 'Ketoprak', 'None', 116, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (246, 175, 'Sate Padang Sij', 'None', 137, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (248, 99, 'Pad Thai', 'Dairy', 258, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (250, 197, 'Ceviche', 'Dairy', 544, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (252, 25, 'Sate Burung', 'Dairy', 281, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (254, 245, 'Sate Padang Dha', 'Dairy', 322, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (256, 212, 'Soto Betawi', 'Dairy', 305, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (258, 166, 'Sate Lilit', 'Meat', 89, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (260, 189, 'Sate Padang Par', 'Dairy', 709, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (262, 149, 'Tempura', 'None', 337, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (264, 75, 'Kue Lapis', 'Meat', 208, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (266, 205, 'Sate Padang Aga', 'Dairy', 332, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (268, 41, 'Kue Lapis', 'Meat', 777, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (270, 175, 'Focaccia', 'None', 137, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (272, 65, 'Sate Padang Sij', 'Dairy', 761, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (274, 52, 'Sate Padang Pas', 'None', 367, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (276, 226, 'Bibimbap', 'None', 751, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (278, 131, 'Sate Ayam', 'Dairy', 334, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (280, 147, 'Sate Padang Aga', 'Dairy', 186, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (282, 88, 'Sate', 'None', 318, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (284, 129, 'Lumpia', 'Meat', 786, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (286, 199, 'Sate Padang Men', 'Dairy', 580, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (288, 37, 'Sate Padang Pay', 'None', 790, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (290, 104, 'Nasi Uduk', 'Dairy', 540, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (292, 122, 'Sate Padang Tan', 'Dairy', 128, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (294, 168, 'Fajitas', 'None', 280, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (296, 50, 'Sate Padang Pas', 'None', 580, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (298, 157, 'Sate Ayam Kampu', 'None', 714, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (300, 99, 'Tacos', 'Dairy', 316, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (302, 55, 'Sate Blora', 'None', 197, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (304, 104, 'Capcay', 'Meat', 726, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (306, 34, 'Sate Padang Dha', 'Meat', 603, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (308, 101, 'Sate Padang Men', 'None', 198, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (310, 34, 'Batagor', 'Meat', 777, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (312, 113, 'Karedok', 'None', 401, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (314, 105, 'Sate Krecek', 'Dairy', 86, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (316, 242, 'Sate Padang Lim', 'Dairy', 33, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (318, 133, 'Sushi', 'Meat', 394, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (320, 142, 'Tumpeng', 'None', 230, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (322, 95, 'Sate Padang Saw', 'None', 599, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (324, 175, 'Bakpao', 'Dairy', 468, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (326, 159, 'Sate Padang Pes', 'Meat', 325, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (328, 107, 'Sate Padang Pas', 'None', 473, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (330, 165, 'Sate Daging Sap', 'Dairy', 323, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (332, 176, 'Lumpia', 'Meat', 286, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (334, 92, 'Sate Klatak', 'None', 534, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (336, 162, 'Sate Padang Buk', 'None', 121, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (338, 150, 'Sate Padang Aga', 'Dairy', 568, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (340, 144, 'Tiramisu', 'None', 229, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (342, 240, 'Sate Padang Buk', 'Dairy', 400, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (344, 167, 'Sate Padang Aga', 'Dairy', 212, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (346, 180, 'Sate Padang Dha', 'Dairy', 70, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (348, 227, 'Sate Ayam', 'Meat', 585, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (350, 244, 'Sate Padang Sol', 'Dairy', 402, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (352, 78, 'Risotto', 'None', 484, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (354, 142, 'Sate Blora', 'None', 565, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (356, 53, 'Sate Padang Dha', 'Dairy', 265, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (358, 163, 'Sate Padang Sol', 'Dairy', 367, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (360, 101, 'Sate Daging', 'Dairy', 99, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (362, 72, 'Kroket', 'None', 352, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (364, 48, 'Kroket', 'None', 127, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (366, 167, 'Sate Padang Pas', 'None', 229, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (368, 166, 'Sate Padang Buk', 'None', 76, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (370, 86, 'Sate Padang Pas', 'Dairy', 666, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (372, 201, 'Sate Padang Buk', 'None', 323, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (374, 238, 'Sate Padang Sol', 'Dairy', 65, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (376, 79, 'Sate Padang Pas', 'Dairy', 785, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (378, 69, 'Tagine', 'Dairy', 689, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (380, 233, 'Bruschetta', 'Meat', 398, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (382, 94, 'Sushi', 'Dairy', 681, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (384, 146, 'Sate Padang Lub', 'Meat', 243, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (386, 74, 'Sate Padang Pas', 'None', 93, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (388, 209, 'Sate Blora', 'None', 775, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (390, 43, 'Soto Medan', 'Dairy', 510, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (392, 176, 'Sate Padang Tan', 'Dairy', 699, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (394, 243, 'Sate Padang Sol', 'Dairy', 520, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (396, 240, 'Sate Klatak', 'Meat', 243, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (398, 217, 'Sate Padang Sol', 'None', 312, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (400, 100, 'Sate Padang Saw', 'None', 198, 0);
commit;
prompt 200 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (402, 45, 'Nasi Kuning', 'None', 618, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (404, 178, 'Karedok', 'None', 140, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (406, 39, 'Sate Padang Sij', 'Dairy', 758, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (408, 136, 'Sate Padang Pad', 'None', 137, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (410, 49, 'Sushi', 'Meat', 143, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (412, 238, 'Bihun', 'Dairy', 8, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (414, 227, 'Fajitas', 'None', 651, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (416, 245, 'Sashimi', 'Meat', 111, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (418, 241, 'Sate Padang Buk', 'Dairy', 690, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (420, 229, 'Sate Padang Sij', 'Meat', 82, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (422, 185, 'Siomay', 'Dairy', 214, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (424, 69, 'Sate Sosis', 'Dairy', 432, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (426, 174, 'Sate Padang Lim', 'None', 726, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (428, 182, 'Ketoprak', 'Meat', 526, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (430, 237, 'Bubur', 'None', 271, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (432, 238, 'Sate Padang Lub', 'Meat', 392, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (434, 59, 'Sate Ayam', 'Meat', 430, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (436, 38, 'Sate Tempe', 'None', 377, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (438, 172, 'Sate Padang Pas', 'None', 437, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (440, 220, 'Pizza', 'Dairy', 678, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (442, 224, 'Sate Padang Buk', 'Meat', 97, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (444, 46, 'Sate Padang Dha', 'Dairy', 108, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (446, 90, 'Pierogi', 'None', 762, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (448, 100, 'Kolak', 'Dairy', 48, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (450, 125, 'Sate Padang Par', 'None', 793, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (452, 222, 'Sate Padang Saw', 'None', 669, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (454, 109, 'Kimchi', 'None', 58, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (456, 41, 'Sate Padang Aga', 'Dairy', 144, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (458, 113, 'Pecel', 'None', 255, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (460, 52, 'Sate Padang Pas', 'Meat', 128, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (462, 50, 'Sate Padang Saw', 'None', 729, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (464, 217, 'Sate Padang Pas', 'Dairy', 690, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (466, 217, 'Sate Vegetarian', 'None', 264, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (468, 32, 'Lumpia', 'Meat', 318, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (470, 68, 'Sate Padang Pes', 'None', 555, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (472, 43, 'Sate Padang Pay', 'None', 49, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (474, 62, 'Lumpia', 'Dairy', 779, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (476, 211, 'Tacos', 'None', 91, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (478, 112, 'Soto Ayam', 'None', 68, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (480, 185, 'Karedok', 'Dairy', 157, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (482, 190, 'Sate Padang Par', 'Dairy', 689, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (484, 121, 'Bibimbap', 'None', 224, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (486, 83, 'Sate Taoco', 'None', 678, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (488, 177, 'Sate Padang Pay', 'Dairy', 65, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (490, 136, 'Soto Medan', 'None', 325, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (492, 88, 'Sate Padang Pad', 'Meat', 149, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (494, 228, 'Sate Klatak', 'Meat', 748, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (496, 195, 'Fajitas', 'Dairy', 544, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (498, 204, 'Sate Ayam Kampu', 'None', 542, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (500, 238, 'Sate Padang Pes', 'None', 239, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (502, 143, 'Bibimbap', 'Dairy', 280, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (504, 65, 'Sate Padang Aga', 'None', 178, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (506, 244, 'Sate Padang Lub', 'Meat', 145, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (508, 191, 'Sate Padang Saw', 'None', 256, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (510, 84, 'Sate Kikil', 'Meat', 211, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (512, 110, 'Pad Thai', 'Dairy', 73, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (514, 35, 'Burger', 'Dairy', 52, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (516, 149, 'Sate Padang Pan', 'None', 50, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (518, 203, 'Sate Padang Lim', 'Dairy', 568, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (520, 157, 'Sate Padang Pas', 'Dairy', 566, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (522, 142, 'Enchilada', 'Dairy', 619, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (524, 123, 'Sashimi', 'None', 206, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (526, 247, 'Biryani', 'Dairy', 490, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (528, 157, 'Sate Padang Lub', 'Dairy', 432, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (530, 225, 'Empanada', 'Meat', 175, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (532, 99, 'Sate Maranggi', 'Dairy', 681, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (534, 175, 'Lemper', 'None', 656, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (536, 112, 'Sate Padang Tan', 'Dairy', 12, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (538, 122, 'Sate Kuda', 'Dairy', 505, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (540, 195, 'Sate Padang', 'None', 377, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (542, 90, 'Lasagna', 'Dairy', 695, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (544, 235, 'Ceviche', 'None', 312, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (546, 240, 'Sate Banjar', 'Meat', 343, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (548, 123, 'Bihun', 'Dairy', 652, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (550, 163, 'Pad Thai', 'Meat', 69, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (552, 183, 'Sate Gulai', 'None', 694, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (554, 92, 'Sate Daging', 'Dairy', 215, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (556, 46, 'Churros', 'Meat', 149, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (558, 102, 'Sate Lilit', 'Meat', 351, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (560, 144, 'Kroket', 'Dairy', 208, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (562, 80, 'Sate Padang Pad', 'Dairy', 786, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (564, 41, 'Sate Padang Pay', 'Dairy', 666, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (566, 231, 'Bibimbap', 'Meat', 403, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (568, 67, 'Sayur Lodeh', 'Dairy', 202, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (570, 32, 'Panna Cotta', 'None', 213, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (572, 26, 'Cannoli', 'Meat', 351, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (574, 38, 'Ketoprak', 'None', 280, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (576, 52, 'Sate Kikil', 'Dairy', 65, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (578, 56, 'Sate Padang Lim', 'None', 73, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (580, 152, 'Sate Padang Aga', 'Dairy', 419, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (582, 173, 'Goulash', 'None', 451, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (584, 52, 'Sate Padang Saw', 'Dairy', 422, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (586, 233, 'Bratwurst', 'Dairy', 111, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (588, 39, 'Sate Padang Pad', 'None', 17, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (590, 76, 'Sate Padang Sol', 'None', 70, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (592, 26, 'Pempek', 'Dairy', 781, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (594, 89, 'Martabak', 'None', 89, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (596, 83, 'Siomay', 'Meat', 264, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (598, 206, 'Pho', 'Dairy', 184, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (600, 102, 'Sate Padang Aga', 'None', 126, 0);
commit;
prompt 300 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (602, 135, 'Sate Usus', 'Dairy', 352, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (604, 239, 'Sate Padang Dha', 'Dairy', 332, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (606, 124, 'Lumpia', 'None', 490, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (608, 38, 'Sate Babi', 'Dairy', 251, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (610, 179, 'Sate Padang Lim', 'Meat', 277, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (612, 170, 'Kue Lapis', 'None', 372, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (614, 42, 'Sate Vegetarian', 'None', 39, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (616, 80, 'Sate', 'Meat', 2, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (618, 178, 'Lumpia', 'None', 599, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (620, 105, 'Baklava', 'Meat', 17, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (622, 50, 'Sate Ambal', 'Dairy', 372, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (624, 192, 'Sate Padang Pas', 'None', 748, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (626, 168, 'Hummus', 'Dairy', 111, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (628, 73, 'Sate Padang Par', 'Meat', 670, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (630, 50, 'Sate Daging', 'None', 794, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (632, 216, 'Sate Padang Pay', 'Meat', 65, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (634, 187, 'Cannoli', 'Dairy', 528, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (636, 60, 'Sate Taoco', 'None', 679, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (638, 144, 'Sate Padang Pay', 'Meat', 544, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (640, 33, 'Sate Padang Saw', 'Meat', 505, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (642, 207, 'Sate Padang Sol', 'None', 680, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (644, 167, 'Sate Padang Sol', 'Dairy', 82, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (646, 96, 'Sate Padang Pad', 'Meat', 490, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (648, 179, 'Sate Padang Pay', 'Dairy', 618, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (650, 60, 'Focaccia', 'Dairy', 591, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (652, 80, 'Sate Padang Sij', 'Dairy', 588, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (654, 193, 'Borscht', 'Meat', 638, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (656, 163, 'Sate Padang Pay', 'None', 566, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (658, 59, 'Sate Padang Pes', 'None', 632, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (660, 148, 'Sate Oncom', 'Meat', 669, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (662, 237, 'Sate Taichan', 'None', 4, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (664, 235, 'Sate Banjar', 'None', 528, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (666, 235, 'Gelato', 'Meat', 536, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (668, 160, 'Sushi', 'None', 251, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (670, 177, 'Ketupat', 'None', 694, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (672, 164, 'Bibimbap', 'Meat', 527, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (674, 27, 'Sate Padang Pay', 'None', 277, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (676, 193, 'Otak-Otak', 'None', 135, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (678, 29, 'Sate Padang Lub', 'None', 548, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (680, 89, 'Karedok', 'Dairy', 480, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (682, 68, 'Sate Padang Men', 'None', 40, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (684, 83, 'Goulash', 'Dairy', 9, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (686, 37, 'Sate Vegetarian', 'None', 367, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (688, 213, 'Sate Padang Pay', 'Meat', 143, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (690, 26, 'Sate Padang', 'None', 790, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (692, 38, 'Soto Banjar', 'Dairy', 153, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (694, 141, 'Klepon', 'Dairy', 625, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (696, 42, 'Sate Padang Sol', 'Meat', 619, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (698, 150, 'Sate Padang Sol', 'Dairy', 415, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (700, 111, 'Sate Padang Pay', 'Dairy', 706, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (702, 134, 'Sushi', 'Meat', 566, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (704, 157, 'Rawon', 'None', 264, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (706, 47, 'Karedok', 'Meat', 33, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (708, 125, 'Ceviche', 'None', 536, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (710, 50, 'Lemper', 'Dairy', 699, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (712, 67, 'Pad Thai', 'Dairy', 427, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (714, 220, 'Kerak Telor', 'Meat', 639, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (716, 63, 'Sushi', 'Meat', 679, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (718, 97, 'Borscht', 'None', 151, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (720, 211, 'Mie Goreng', 'None', 326, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (722, 156, 'Sate Oncom', 'None', 777, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (724, 226, 'Sate Padang Pes', 'None', 73, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (726, 117, 'Sate Padang Par', 'Meat', 55, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (728, 40, 'Martabak', 'Meat', 458, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (730, 95, 'Sate Babi', 'Meat', 402, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (732, 238, 'Sate', 'Meat', 464, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (734, 210, 'Cannoli', 'Dairy', 54, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (736, 26, 'Sate Padang Lub', 'Dairy', 769, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (738, 36, 'Soto Betawi', 'None', 137, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (740, 127, 'Sate Padang Pas', 'None', 651, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (742, 200, 'Carbonara', 'Dairy', 21, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (744, 200, 'Sate Padang Pay', 'Meat', 669, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (746, 128, 'Sate Gulai', 'Dairy', 305, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (748, 27, 'Sate Padang Lim', 'Dairy', 430, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (750, 23, 'Sate Padang Pay', 'Dairy', 756, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (752, 83, 'Sate Padang Pes', 'Meat', 585, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (754, 136, 'Kebab', 'Dairy', 135, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (756, 98, 'Sate Padang Saw', 'None', 681, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (758, 118, 'Sate Padang Dha', 'None', 709, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (760, 228, 'Serabi', 'Dairy', 355, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (762, 57, 'Biryani', 'Dairy', 108, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (764, 228, 'Pepes', 'None', 747, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (766, 200, 'Kue Lapis', 'Dairy', 781, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (768, 72, 'Tahu Gejrot', 'Meat', 714, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (770, 56, 'Kerak Telor', 'Dairy', 323, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (772, 192, 'Tahu Sumedang', 'Dairy', 54, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (774, 112, 'Sate Jeroan', 'None', 211, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (776, 169, 'Sate Padang Sol', 'None', 781, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (778, 156, 'Karedok', 'Meat', 404, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (780, 38, 'Sate Padang Aga', 'None', 533, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (782, 213, 'Sate Padang Tan', 'Dairy', 677, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (784, 46, 'Sate Padang', 'None', 561, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (786, 168, 'Sate Banjar', 'None', 284, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (788, 20, 'Dim Sum', 'None', 52, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (790, 153, 'Sate Padang Pay', 'Dairy', 343, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (792, 201, 'Sate Padang Buk', 'Dairy', 52, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (794, 83, 'Sate Tegal', 'Dairy', 179, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (796, 59, 'Sate Lilit', 'Dairy', 413, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (798, 186, 'Kimchi', 'Dairy', 574, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (800, 192, 'Sate Madura', 'Dairy', 682, 0);
commit;
prompt 400 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (802, 225, 'Sate Padang Lub', 'None', 450, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (804, 136, 'Sate Padang Par', 'None', 141, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (806, 172, 'Sate Padang Tan', 'Meat', 31, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (808, 175, 'Sate Blora', 'Dairy', 580, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (810, 32, 'Sate Padang Pas', 'None', 53, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (812, 218, 'Sate Padang', 'None', 797, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (814, 202, 'Sate Padang Pes', 'Meat', 258, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (816, 140, 'Sate Padang Aga', 'Dairy', 118, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (818, 55, 'Tongseng', 'Dairy', 400, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (820, 187, 'Sate Ayam Kampu', 'None', 469, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (822, 59, 'Sate Padang Pas', 'Dairy', 199, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (824, 73, 'Sate Tahu', 'None', 195, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (826, 44, 'Sate Padang Sij', 'Dairy', 629, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (828, 229, 'Sate Padang Buk', 'None', 249, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (830, 75, 'Sate Padang Dha', 'Meat', 750, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (832, 113, 'Rendang', 'Meat', 656, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (834, 25, 'Carbonara', 'None', 579, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (836, 68, 'Biryani', 'None', 121, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (838, 129, 'Lasagna', 'Dairy', 720, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (840, 245, 'Croissant', 'Dairy', 111, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (842, 234, 'Bihun', 'None', 129, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (844, 53, 'Sate Padang Pad', 'Dairy', 463, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (846, 41, 'Sate Padang Sij', 'None', 121, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (848, 236, 'Sambal', 'Dairy', 135, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (850, 116, 'Sate Padang Pas', 'Dairy', 640, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (852, 157, 'Sate Padang Par', 'Dairy', 446, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (854, 193, 'Rendang', 'Meat', 82, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (856, 248, 'Jambalaya', 'None', 157, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (858, 102, 'Sate Padang Buk', 'None', 58, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (860, 136, 'Sate Padang Par', 'None', 415, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (862, 66, 'Sate Lilit', 'Dairy', 255, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (864, 77, 'Sate Padang Pad', 'None', 781, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (866, 152, 'Sate Padang Par', 'None', 192, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (868, 153, 'Tabbouleh', 'Dairy', 164, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (870, 22, 'Sate Padang Dha', 'Meat', 566, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (872, 234, 'Sate Padang Sol', 'Dairy', 379, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (874, 145, 'Sate Jamur', 'None', 202, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (876, 243, 'Pizza', 'Dairy', 572, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (878, 74, 'Sate Keong', 'None', 161, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (880, 28, 'Sate Padang Lub', 'Dairy', 70, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (882, 35, 'Sate Padang Pas', 'None', 553, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (884, 239, 'Bibimbap', 'Meat', 243, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (886, 43, 'Capcay', 'Dairy', 781, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (888, 30, 'Mie Goreng', 'Dairy', 215, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (890, 244, 'Focaccia', 'Meat', 519, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (892, 162, 'Quiche', 'Dairy', 400, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (894, 182, 'Sate Telur Puyu', 'None', 59, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (896, 156, 'Baklava', 'Dairy', 611, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (898, 204, 'Perkedel', 'Dairy', 571, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (900, 151, 'Sate Padang Lim', 'Dairy', 682, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (902, 178, 'Sate Padang Sij', 'Dairy', 526, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (904, 55, 'Sate Padang Saw', 'Meat', 180, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (906, 127, 'Rendang', 'None', 17, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (908, 158, 'Soto Mie', 'None', 785, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (910, 236, 'Tumpeng', 'None', 551, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (912, 195, 'Klepon', 'None', 366, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (914, 249, 'Sate Padang Lub', 'None', 763, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (916, 107, 'Sate Padang Sol', 'None', 392, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (918, 82, 'Sate Padang Sol', 'None', 59, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (920, 170, 'Sate Padang Saw', 'Dairy', 111, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (922, 56, 'Sate Padang Par', 'None', 197, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (924, 53, 'Serabi', 'Meat', 779, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (926, 43, 'Sate Padang Sol', 'None', 318, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (928, 247, 'Sate Padang Sol', 'None', 751, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (930, 67, 'Sate Padang Sij', 'Meat', 794, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (932, 111, 'Empanada', 'Dairy', 611, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (934, 59, 'Rawon', 'None', 52, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (936, 139, 'Clafoutis', 'None', 129, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (938, 141, 'Sate Ayam', 'Meat', 212, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (940, 150, 'Sate Padang Buk', 'Dairy', 79, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (942, 63, 'Sate Padang Pas', 'Dairy', 33, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (944, 85, 'Kebab', 'Dairy', 94, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (946, 95, 'Sate Padang Pad', 'None', 392, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (948, 186, 'Sate Padang Buk', 'None', 748, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (950, 146, 'Sate Padang Par', 'Dairy', 762, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (952, 89, 'Sate Banjar', 'Meat', 545, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (954, 102, 'Sate Padang Pas', 'Dairy', 791, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (956, 76, 'Sate Padang Pay', 'Dairy', 647, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (958, 21, 'Sate Padang Pas', 'None', 750, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (960, 76, 'Sate Padang Sij', 'Dairy', 281, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (962, 150, 'Mie Goreng', 'Meat', 94, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (964, 141, 'Tiramisu', 'Meat', 784, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (966, 107, 'Bratwurst', 'Meat', 451, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (968, 52, 'Sate Daging Sap', 'Meat', 237, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (970, 202, 'Sate Padang Pad', 'None', 195, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (972, 168, 'Sate Padang Buk', 'Dairy', 137, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (974, 67, 'Sate Padang Tan', 'None', 750, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (976, 29, 'Sate Ayam Kampu', 'None', 126, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (978, 126, 'Sate Tegal', 'Meat', 451, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (980, 34, 'Sate Padang Par', 'None', 559, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (982, 129, 'Sate Padang Saw', 'None', 230, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (984, 191, 'Sate Banjar', 'Dairy', 17, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (986, 82, 'Sate Padang Pes', 'None', 55, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (988, 91, 'Sate Padang Saw', 'None', 141, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (990, 81, 'Otak-Otak', 'Dairy', 318, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (992, 118, 'Pierogi', 'Meat', 243, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (994, 223, 'Sate Padang Sol', 'Dairy', 398, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (996, 174, 'Sate Padang Men', 'Meat', 544, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (998, 129, 'Sate Padang Saw', 'Dairy', 52, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1000, 110, 'Sate Padang Aga', 'Dairy', 758, 0);
commit;
prompt 500 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1002, 155, 'Sate Padang Dha', 'None', 249, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1004, 219, 'Capcay', 'Dairy', 397, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1006, 131, 'Sate Sapi', 'Dairy', 208, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1008, 186, 'Baklava', 'Dairy', 744, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1010, 25, 'Sate Padang Saw', 'None', 519, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1012, 193, 'Sate Ponorogo', 'Dairy', 160, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1014, 215, 'Sate Gulai', 'Dairy', 144, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1016, 242, 'Sate Padang Par', 'Dairy', 423, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1018, 215, 'Sate Padang Pad', 'Meat', 47, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1020, 250, 'Sate Padang Pas', 'Dairy', 446, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1022, 247, 'Sate Padang Saw', 'None', 763, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1024, 212, 'Sate Padang Aga', 'None', 183, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1026, 115, 'Sate Padang Tan', 'Dairy', 553, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1028, 203, 'Sate Padang Sij', 'Meat', 305, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1030, 223, 'Sate Padang Par', 'None', 520, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1032, 226, 'Dodol', 'Dairy', 419, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1034, 132, 'Jambalaya', 'Meat', 127, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1036, 134, 'Lo Mie', 'Meat', 474, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1038, 190, 'Sroto', 'Meat', 230, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1040, 77, 'Sate Padang Pan', 'Meat', 751, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1042, 228, 'Sate Padang Pas', 'Meat', 324, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1044, 104, 'Sate Padang Sij', 'None', 55, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1046, 181, 'Sate Padang Sol', 'Meat', 677, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1048, 69, 'Es Teler', 'Dairy', 729, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1050, 84, 'Sate Sapi', 'Dairy', 560, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1052, 68, 'Sate Padang Pas', 'Dairy', 467, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1054, 140, 'Rawon', 'None', 679, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1056, 26, 'Kroket', 'None', 656, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1058, 176, 'Otak-Otak', 'None', 437, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1060, 45, 'Sate Padang Par', 'None', 680, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1062, 79, 'Bakso', 'None', 559, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1064, 139, 'Sate Padang Lim', 'None', 707, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1066, 92, 'Risotto', 'None', 536, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1068, 37, 'Otak-Otak', 'Dairy', 208, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1070, 240, 'Es Teler', 'Dairy', 354, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1072, 206, 'Sate Padang Sij', 'Dairy', 33, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1074, 74, 'Tahu Sumedang', 'Dairy', 711, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1076, 193, 'Sate Sapi', 'None', 79, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1078, 96, 'Sate Padang Buk', 'Dairy', 570, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1080, 248, 'Sate Padang Par', 'Dairy', 786, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1082, 23, 'Pho', 'Dairy', 61, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1084, 42, 'Sate Padang Buk', 'Meat', 137, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1086, 130, 'Sate Padang Sij', 'Dairy', 526, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1088, 207, 'Sate Padang Pas', 'Dairy', 795, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1090, 118, 'Sate Kuda', 'Dairy', 121, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1092, 39, 'Sate Padang Par', 'None', 8, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1094, 142, 'Sate Padang Pas', 'None', 695, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1096, 108, 'Sate Padang Lim', 'None', 787, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1098, 52, 'Sate Padang Pay', 'None', 791, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1100, 105, 'Sate Padang Aga', 'Dairy', 464, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1102, 103, 'Sate Telur Puyu', 'None', 297, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1104, 213, 'Sate Ayam Kampu', 'None', 243, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1106, 114, 'Sate Padang Tan', 'Dairy', 175, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1108, 248, 'Sate Padang Pay', 'Dairy', 344, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1110, 85, 'Sate Lilit', 'Dairy', 482, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1112, 27, 'Sate Padang Pay', 'None', 748, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1114, 196, 'Martabak', 'Dairy', 336, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1116, 33, 'Ceviche', 'Dairy', 408, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1118, 183, 'Bakpao', 'Dairy', 140, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1120, 77, 'Sate Padang Tan', 'None', 790, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1122, 177, 'Sate Ayam', 'None', 714, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1124, 118, 'Sate Padang Pas', 'None', 82, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1126, 218, 'Sate Padang Pas', 'Dairy', 795, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1128, 217, 'Bakso', 'None', 78, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1130, 87, 'Sate Kikil', 'Dairy', 404, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1132, 114, 'Ketupat', 'Dairy', 656, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1134, 122, 'Tongseng', 'Meat', 49, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1136, 22, 'Sate Padang Lim', 'Dairy', 93, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1138, 33, 'Sate Padang Tan', 'Meat', 763, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1140, 119, 'Sate Gulai', 'Dairy', 344, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1142, 99, 'Sate Padang Pas', 'Dairy', 401, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1144, 99, 'Sate Meranggi', 'None', 80, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1146, 126, 'Sate Padang Lim', 'Dairy', 229, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1148, 191, 'Sate Telur Puyu', 'None', 21, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1150, 93, 'Sate Padang Pad', 'Dairy', 404, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1152, 169, 'Sate Susu', 'Meat', 179, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1154, 180, 'Sate Sapi', 'None', 206, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1156, 44, 'Soto', 'Dairy', 527, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1158, 173, 'Falooda', 'None', 157, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1160, 149, 'Sate Padang Par', 'None', 624, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1162, 98, 'Soto Mie', 'Dairy', 758, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1164, 128, 'Pizza', 'Meat', 396, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1166, 232, 'Sate Padang Men', 'None', 503, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1168, 81, 'Sate Padang Pas', 'None', 17, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1170, 35, 'Sate Padang Pas', 'Meat', 586, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1172, 170, 'Perkedel', 'None', 561, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1174, 149, 'Kebab', 'Meat', 528, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1176, 57, 'Biryani', 'None', 144, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1178, 92, 'Panna Cotta', 'None', 390, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1180, 33, 'Sate Padang Sol', 'None', 263, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1182, 173, 'Sate Krecek', 'None', 771, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1184, 148, 'Sate Padang Par', 'Dairy', 352, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1186, 246, 'Bratwurst', 'Meat', 158, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1188, 97, 'Sate Padang Aga', 'None', 265, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1190, 161, 'Sate Padang Saw', 'None', 743, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1192, 104, 'Kroket', 'Dairy', 591, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1194, 44, 'Sate Padang Pas', 'Dairy', 93, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1196, 37, 'Sate Padang Pay', 'Meat', 352, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1198, 200, 'Kimchi', 'None', 441, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1200, 201, 'Sate Padang Sol', 'Dairy', 656, 0);
commit;
prompt 600 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1202, 151, 'Bubur', 'None', 467, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1204, 135, 'Tempura', 'Dairy', 78, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1206, 70, 'Sate Padang Lub', 'None', 433, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1208, 247, 'Sate Padang Sij', 'None', 55, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1210, 197, 'Gado-Gado', 'None', 4, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1212, 55, 'Karedok', 'Dairy', 343, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1214, 99, 'Sate Padang Par', 'Meat', 48, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1216, 203, 'Sate Padang Sij', 'Dairy', 469, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1218, 89, 'Samosa', 'Dairy', 625, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1220, 153, 'Sate Maranggi', 'Meat', 157, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1222, 162, 'Crepe', 'None', 549, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1224, 111, 'Sate Padang Pas', 'None', 47, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1226, 174, 'Tahu Sumedang', 'None', 198, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1228, 21, 'Sate Padang Tan', 'Dairy', 568, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1230, 77, 'Sate Padang Sij', 'Dairy', 419, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1232, 20, 'Sate Padang Aga', 'Dairy', 468, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1234, 241, 'Sate Padang Pes', 'Meat', 555, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1236, 34, 'Soto Banjar', 'Dairy', 574, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1238, 220, 'Sashimi', 'Dairy', 769, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1240, 148, 'Sate Padang Pas', 'Dairy', 690, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1242, 139, 'Baklava', 'Dairy', 87, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1244, 119, 'Sate Padang Sol', 'Meat', 351, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1246, 70, 'Tapenade', 'Dairy', 490, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1248, 114, 'Sate Pentol', 'Dairy', 689, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1250, 172, 'Sate Padang', 'Dairy', 226, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1252, 145, 'Sate Lilit', 'Meat', 349, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1254, 216, 'Pecel', 'None', 347, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1256, 22, 'Kolak', 'Meat', 755, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1258, 99, 'Rawon', 'Dairy', 591, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1260, 86, 'Laksa', 'Dairy', 463, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1262, 206, 'Sate Padang Par', 'Dairy', 368, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1264, 157, 'Shawarma', 'None', 549, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1266, 218, 'Sate Taoco', 'Dairy', 433, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1268, 176, 'Sate Padang Pes', 'Meat', 769, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1270, 87, 'Sate Padang Pay', 'Meat', 680, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1272, 221, 'Sate Buah', 'Dairy', 779, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1274, 139, 'Sate Padang Sol', 'None', 284, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1276, 143, 'Sate Padang Sol', 'None', 661, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1278, 110, 'Sate Padang Aga', 'Dairy', 575, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1280, 185, 'Sate Padang Sol', 'Meat', 547, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1282, 95, 'Sate Pentol', 'Dairy', 312, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1284, 66, 'Paella', 'Meat', 434, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1286, 188, 'Serabi', 'Dairy', 213, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1288, 214, 'Sate Padang', 'Dairy', 744, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1290, 184, 'Sate Padang Pes', 'Dairy', 178, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1292, 65, 'Sate Padang Saw', 'Dairy', 474, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1294, 61, 'Sate Padang Men', 'None', 457, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1296, 136, 'Sate Lada Hitam', 'Meat', 545, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1298, 58, 'Bratwurst', 'None', 688, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1300, 234, 'Tahu Sumedang', 'None', 277, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1302, 144, 'Kwetiau', 'None', 377, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1304, 61, 'Sate Daging Sap', 'None', 16, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1306, 241, 'Satay', 'Meat', 440, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1308, 106, 'Hummus', 'Dairy', 137, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1310, 69, 'Tabbouleh', 'Dairy', 548, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1312, 81, 'Siomay', 'Dairy', 640, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1314, 207, 'Sate Padang Pas', 'Dairy', 740, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1316, 195, 'Sate Padang Pad', 'Dairy', 192, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1318, 231, 'Perkedel', 'Dairy', 476, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1320, 193, 'Sate Padang Saw', 'Meat', 598, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1322, 157, 'Sate Tahu', 'Meat', 484, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1324, 79, 'Tiramisu', 'None', 445, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1326, 101, 'Pizza', 'None', 202, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1328, 228, 'Sate Padang Par', 'Meat', 300, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1330, 23, 'Tacos', 'Dairy', 451, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1332, 173, 'Pho', 'None', 682, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1334, 227, 'Sate Padang Buk', 'Dairy', 277, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1336, 244, 'Sroto', 'Meat', 741, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1338, 88, 'Sate Pentol', 'Dairy', 548, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1340, 43, 'Sate Padang Pan', 'Dairy', 396, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1342, 87, 'Sate Padang Saw', 'None', 52, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1344, 221, 'Croissant', 'None', 91, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1346, 220, 'Lumpia', 'Meat', 733, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1348, 179, 'Sate Udang', 'Dairy', 426, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1350, 96, 'Pho', 'Meat', 8, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1352, 218, 'Sate Padang Pad', 'Meat', 377, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1354, 34, 'Perkedel', 'Meat', 54, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1356, 77, 'Soto Kudus', 'Dairy', 408, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1358, 147, 'Sate Padang Sol', 'Dairy', 197, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1360, 72, 'Sate Taoco', 'Dairy', 740, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1362, 201, 'Martabak', 'None', 756, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1364, 243, 'Sate Padang Pas', 'Dairy', 390, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1366, 230, 'Sate Ambal', 'Meat', 190, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1368, 250, 'Sate Klatak', 'Meat', 625, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1370, 71, 'Croissant', 'Dairy', 49, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1372, 46, 'Schnitzel', 'None', 751, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1374, 131, 'Sate Padang Pay', 'Meat', 526, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1376, 156, 'Sate Padang Lub', 'Meat', 729, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1378, 138, 'Sate Padang Pay', 'None', 580, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1380, 182, 'Cannoli', 'None', 510, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1382, 52, 'Sate Ayam', 'Meat', 277, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1384, 145, 'Sate Kambing', 'Meat', 256, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1386, 121, 'Sate Padang Sol', 'Dairy', 788, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1388, 64, 'Sate Meranggi', 'None', 608, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1390, 79, 'Sate Vegetarian', 'Dairy', 372, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1392, 58, 'Sate Padang Dha', 'Dairy', 422, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1394, 47, 'Goulash', 'Dairy', 300, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1396, 61, 'Sate Padang Pes', 'Dairy', 534, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1398, 105, 'Sate Padang', 'Dairy', 91, 0);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1400, 76, 'Ramen', 'Meat', 21, 0);
commit;
prompt 700 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (1, 90, 'Bolonez', 'Meat', 58, 1);
insert into DISHS (dishs_id, price, name, coshertype, catering_id, isspecial)
values (5, 100, 'Gourmet Platter', 'Meat', 744, 1);
commit;
prompt 702 records loaded
prompt Loading AFFECTS...
prompt Table is empty
prompt Loading THE_ORDER...
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (28283, 1000000, to_date('29-08-2023', 'dd-mm-yyyy'), '58 Rains Blvd', '995-4963084', 18219, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (82852, 5113651, to_date('07-03-2021', 'dd-mm-yyyy'), '31 Harris', '995-4889461', 73696, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (66529, 1000000, to_date('07-09-2022', 'dd-mm-yyyy'), '93rd Street', '762-3802611', 97712, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (80048, 774873, to_date('14-03-2022', 'dd-mm-yyyy'), '68 Sylvester Drive', '522-4865122', 91311, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (2114, 5271254, to_date('11-08-2020', 'dd-mm-yyyy'), '94 O''Connor Ave', '736-2919258', 92450, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (81540, 1000000, to_date('16-07-2023', 'dd-mm-yyyy'), '81 DiFranco Street', '350-1071802', 58806, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (16969, 1000000, to_date('11-06-2023', 'dd-mm-yyyy'), '500 Katie Street', '610-4464147', 52106, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (2533, 1000000, to_date('21-04-2023', 'dd-mm-yyyy'), '65 New Hope Road', '907-3335966', 93405, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (66973, 1000000, to_date('28-02-2021', 'dd-mm-yyyy'), '315 Frederiksberg Ro', '633-6101038', 3645, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (33352, 6760835, to_date('21-03-2023', 'dd-mm-yyyy'), '441 Wolf Drive', '695-9932510', 86783, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (61383, 6128358, to_date('04-12-2022', 'dd-mm-yyyy'), '33 Vassar Road', '245-9850195', 63004, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (11223, 8198249, to_date('06-02-2021', 'dd-mm-yyyy'), '99 Mariano Comense A', '803-9540975', 59374, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (59136, 1000000, to_date('02-12-2023', 'dd-mm-yyyy'), '63rd Street', '933-4989917', 11713, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (87178, 1407192, to_date('08-09-2022', 'dd-mm-yyyy'), '50 Bad Oeynhausen St', '364-8032812', 84191, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (66539, 1000000, to_date('21-02-2022', 'dd-mm-yyyy'), '93rd Street', '152-6390629', 44605, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (2812, 1000000, to_date('03-03-2023', 'dd-mm-yyyy'), '72 Janeane Drive', '672-7207503', 23284, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (10259, 7714557, to_date('16-07-2020', 'dd-mm-yyyy'), '66 Omaha Drive', '602-6796847', 16243, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (51130, 3793171, to_date('16-02-2024', 'dd-mm-yyyy'), '91 Burke Road', '132-5650871', 3131, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (14559, 1000000, to_date('13-12-2020', 'dd-mm-yyyy'), '6 Talvin Street', '257-1692772', 94944, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (67327, 1000000, to_date('20-09-2022', 'dd-mm-yyyy'), '96 Kier Drive', '895-2469230', 18702, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (90574, 1000000, to_date('27-10-2021', 'dd-mm-yyyy'), '33 Trevino Drive', '329-1616267', 63220, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (36202, 1000000, to_date('07-09-2020', 'dd-mm-yyyy'), '50 Lippetal Blvd', '978-9954373', 21318, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (49131, 1000000, to_date('05-08-2020', 'dd-mm-yyyy'), '50 Porto alegre Stre', '263-9279472', 61882, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (63965, 9464071, to_date('24-09-2020', 'dd-mm-yyyy'), '3 Elizabeth Street', '529-7520686', 71391, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (97566, 1000000, to_date('29-04-2023', 'dd-mm-yyyy'), '45 Winans Road', '888-1864310', 37209, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (21754, 1000000, to_date('27-10-2020', 'dd-mm-yyyy'), '9 Sugar Hill Street', '485-2075647', 74187, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (78900, 1000000, to_date('15-07-2023', 'dd-mm-yyyy'), '29 Uggams Blvd', '737-1742549', 27971, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (22197, 1843019, to_date('18-06-2022', 'dd-mm-yyyy'), '8 Tampa Blvd', '524-6235850', 39945, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (47843, 1984093, to_date('17-12-2023', 'dd-mm-yyyy'), '2 Fariq Road', '449-5333331', 4665, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (10932, 1000000, to_date('10-08-2020', 'dd-mm-yyyy'), '19 Logue Street', '287-2048506', 32409, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (18177, 1000000, to_date('23-11-2020', 'dd-mm-yyyy'), '97 Shand Street', '258-2111295', 16596, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (91407, 1000000, to_date('11-05-2022', 'dd-mm-yyyy'), '85 Hjallerup', '879-4357808', 98467, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (43408, 1000000, to_date('15-02-2024', 'dd-mm-yyyy'), '72nd Street', '145-7741204', 21621, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (10356, 3586990, to_date('13-07-2022', 'dd-mm-yyyy'), '28 Drew Drive', '619-8123958', 71521, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (28183, 1000000, to_date('17-09-2020', 'dd-mm-yyyy'), '400 Lahr Drive', '413-8641609', 54590, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (34345, 74700, to_date('22-05-2023', 'dd-mm-yyyy'), '44 Ledger Street', '583-8865730', 99958, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (91588, 1000000, to_date('25-04-2022', 'dd-mm-yyyy'), '36 Macy Road', '664-1368715', 25581, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (24369, 1000000, to_date('02-12-2021', 'dd-mm-yyyy'), '347 Alessandria Road', '362-9093990', 88664, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (66102, 1000000, to_date('12-11-2021', 'dd-mm-yyyy'), '18 Kejae City Blvd', '826-7167565', 84726, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (60877, 1000000, to_date('29-08-2022', 'dd-mm-yyyy'), '62 Atlanta Road', '793-5783326', 46454, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (84015, 9755518, to_date('27-09-2021', 'dd-mm-yyyy'), '23 Pleasence', '610-7556358', 65687, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (13698, 1000000, to_date('06-02-2022', 'dd-mm-yyyy'), '92 Spacek Road', '176-7905876', 54956, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (39336, 706326, to_date('23-04-2023', 'dd-mm-yyyy'), '51 Crowe Drive', '963-1984772', 87977, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (57784, 4750077, to_date('04-03-2021', 'dd-mm-yyyy'), '92nd Street', '290-3616022', 15424, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (81884, 1000000, to_date('18-07-2022', 'dd-mm-yyyy'), '81 Rita Road', '396-9099843', 55703, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (82274, 5472711, to_date('04-01-2024', 'dd-mm-yyyy'), '65 Li Blvd', '159-2098912', 54325, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (60128, 548851, to_date('19-02-2023', 'dd-mm-yyyy'), '588 Frankfurt am Mai', '990-2781942', 79427, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (34506, 1000000, to_date('06-06-2020', 'dd-mm-yyyy'), '96 Santa Cruz Street', '367-5974747', 9612, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (20547, 1000000, to_date('31-12-2021', 'dd-mm-yyyy'), '61st Street', '225-6452819', 30106, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (38522, 1000000, to_date('09-09-2020', 'dd-mm-yyyy'), '34 Albright Drive', '614-3918022', 64909, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (29984, 1000000, to_date('15-10-2022', 'dd-mm-yyyy'), '60 Haverhill Blvd', '582-7157389', 79147, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (96486, 1000000, to_date('27-11-2020', 'dd-mm-yyyy'), '63rd Street', '506-5041182', 70323, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (72589, 1000000, to_date('30-08-2020', 'dd-mm-yyyy'), '22 Gerald Street', '233-4293709', 7961, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (39025, 1000000, to_date('07-06-2020', 'dd-mm-yyyy'), '13 Frost', '360-1343833', 46523, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (97337, 3874947, to_date('15-09-2020', 'dd-mm-yyyy'), '96 Adkins', '988-9826430', 42953, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (85934, 9332730, to_date('10-06-2023', 'dd-mm-yyyy'), '33 Schlieren Drive', '546-5444306', 83181, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (53565, 1000000, to_date('24-11-2022', 'dd-mm-yyyy'), '20 Tallahassee Drive', '928-9116851', 55703, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (97948, 486562, to_date('07-05-2022', 'dd-mm-yyyy'), '80 Thorton Street', '442-4207896', 61931, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (36094, 1000000, to_date('23-01-2021', 'dd-mm-yyyy'), '88 Ruth Drive', '906-6097266', 38357, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (4421, 152469, to_date('22-01-2022', 'dd-mm-yyyy'), '43 Southampton Stree', '921-3121501', 65489, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (20764, 1000000, to_date('15-08-2021', 'dd-mm-yyyy'), '44 Lisa Blvd', '888-8874699', 63036, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (6926, 4396435, to_date('14-09-2020', 'dd-mm-yyyy'), '89 Macau Ave', '918-7574014', 22555, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (85394, 1000000, to_date('20-07-2020', 'dd-mm-yyyy'), '89 Dupree Ave', '675-1511117', 88114, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (19840, 2701156, to_date('21-12-2023', 'dd-mm-yyyy'), '52 Thurman', '624-5891693', 57243, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (81066, 7253204, to_date('05-12-2021', 'dd-mm-yyyy'), '280 Colorado Springs', '738-5834244', 87841, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (38771, 1000000, to_date('10-12-2020', 'dd-mm-yyyy'), '81st Street', '879-9068006', 63036, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (78159, 1000000, to_date('15-09-2021', 'dd-mm-yyyy'), '84 Thurman Road', '951-9404370', 27070, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (91439, 1000000, to_date('03-01-2023', 'dd-mm-yyyy'), '49 Jamal Street', '807-5468148', 69306, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (48609, 255127, to_date('28-05-2022', 'dd-mm-yyyy'), '52nd Street', '668-3012634', 25980, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (85507, 1000000, to_date('23-02-2022', 'dd-mm-yyyy'), '91 Lawrence Drive', '412-5439762', 68611, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (61206, 1000000, to_date('08-07-2021', 'dd-mm-yyyy'), '53 Scaggs Street', '956-2102002', 91873, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (76900, 1376345, to_date('15-10-2021', 'dd-mm-yyyy'), '14 Lake worth Drive', '312-4846282', 74651, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (30593, 1000000, to_date('16-01-2022', 'dd-mm-yyyy'), '12 Horizon Blvd', '241-9448132', 86400, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (83726, 1000000, to_date('28-06-2020', 'dd-mm-yyyy'), '39 Long Island City ', '380-5220497', 60222, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (69316, 787505, to_date('03-02-2024', 'dd-mm-yyyy'), '45 Magnuson Street', '599-5190206', 69306, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (32932, 6548485, to_date('05-11-2023', 'dd-mm-yyyy'), '18 Tisdale Road', '449-5419777', 14382, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (10575, 1000000, to_date('17-02-2021', 'dd-mm-yyyy'), '80 Arjona Street', '170-4944212', 55374, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (14188, 1000000, to_date('30-01-2022', 'dd-mm-yyyy'), '21 Lucinda Street', '250-8161309', 1828, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (50866, 1000000, to_date('26-04-2021', 'dd-mm-yyyy'), '81 Green bay Street', '950-8929837', 4304, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (57797, 1000000, to_date('22-01-2022', 'dd-mm-yyyy'), '77 Salt Road', '950-8577494', 97912, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (21459, 194912, to_date('04-07-2021', 'dd-mm-yyyy'), '63 Balaban Drive', '458-9543328', 37844, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (11265, 2085286, to_date('20-05-2021', 'dd-mm-yyyy'), '14 Leimen Drive', '681-1783415', 5421, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (25427, 1000000, to_date('03-08-2022', 'dd-mm-yyyy'), '3 Lennox Road', '675-6110158', 98425, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (57878, 7657944, to_date('01-05-2021', 'dd-mm-yyyy'), '23rd Street', '563-1613378', 56477, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (16942, 4088586, to_date('01-01-2021', 'dd-mm-yyyy'), '76 Leelee Road', '536-5280762', 11110, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (50415, 1749101, to_date('19-12-2021', 'dd-mm-yyyy'), '82 Noseworthy Blvd', '954-8051606', 57300, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (34856, 1000000, to_date('29-09-2022', 'dd-mm-yyyy'), '53rd Street', '652-2352627', 85019, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (86294, 1000000, to_date('01-08-2022', 'dd-mm-yyyy'), '4 Tillis', '965-9871539', 81596, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (24034, 1000000, to_date('09-08-2022', 'dd-mm-yyyy'), '358 Worrell Street', '666-9229049', 18952, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (40181, 9427058, to_date('02-12-2023', 'dd-mm-yyyy'), '68 Luzern Street', '112-8005594', 82702, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (26959, 1386143, to_date('04-09-2021', 'dd-mm-yyyy'), '12 Janice Road', '851-9484789', 44275, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (62607, 1000000, to_date('08-04-2021', 'dd-mm-yyyy'), '91st Street', '540-3634245', 69827, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (29501, 1000000, to_date('30-04-2023', 'dd-mm-yyyy'), '37 Monk Street', '876-1114364', 7029, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (93832, 1000000, to_date('22-11-2021', 'dd-mm-yyyy'), '36 Lisbon', '110-4896953', 80219, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (56170, 319051, to_date('24-07-2021', 'dd-mm-yyyy'), '36 Trejo Drive', '291-2974652', 30132, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (33702, 9231246, to_date('27-12-2020', 'dd-mm-yyyy'), '54 McAnally Drive', '738-3833362', 77193, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (27220, 841115, to_date('29-04-2022', 'dd-mm-yyyy'), '59 Davidson Road', '237-3788833', 86659, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (95415, 1000000, to_date('13-03-2022', 'dd-mm-yyyy'), '63rd Street', '398-4961685', 41762, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (84219, 1000000, to_date('14-11-2020', 'dd-mm-yyyy'), '26 Carlisle Drive', '377-5310447', 15217, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (59106, 1000000, to_date('24-06-2023', 'dd-mm-yyyy'), '86 Bo Drive', '171-4140884', 93298, 'Pending');
commit;
prompt 100 records committed...
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (39006, 1000000, to_date('03-10-2023', 'dd-mm-yyyy'), '56 Noumea Blvd', '279-2397753', 85019, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (89775, 5727267, to_date('20-03-2023', 'dd-mm-yyyy'), '65 Campbell Drive', '602-2797170', 61528, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (54338, 1000000, to_date('25-01-2022', 'dd-mm-yyyy'), '52 Frost Blvd', '780-1457522', 72636, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (81115, 1000000, to_date('21-08-2023', 'dd-mm-yyyy'), '68 Karon Ave', '638-6849086', 91873, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (10587, 7913289, to_date('10-08-2021', 'dd-mm-yyyy'), '25 Lemmon Ave', '123-2362777', 75891, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (90546, 1528304, to_date('23-11-2021', 'dd-mm-yyyy'), '48 DeGraw Road', '810-2133151', 3877, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (34515, 6843644, to_date('22-09-2020', 'dd-mm-yyyy'), '44 Torino Street', '501-9508643', 30174, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (76831, 7456757, to_date('08-11-2020', 'dd-mm-yyyy'), '23 Kirk', '269-9863474', 64193, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (81549, 310961, to_date('28-06-2023', 'dd-mm-yyyy'), '87 Vern Ave', '753-3900576', 45268, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (40788, 1000000, to_date('06-06-2020', 'dd-mm-yyyy'), '61 Taylor Blvd', '408-8478724', 48566, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (67007, 9569081, to_date('18-04-2021', 'dd-mm-yyyy'), '17 Yucca Ave', '427-3032694', 22674, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (565, 1262981, to_date('04-10-2023', 'dd-mm-yyyy'), '64 McLean Road', '896-4720649', 79861, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (25303, 1000000, to_date('06-12-2022', 'dd-mm-yyyy'), '88 Grand-mere Drive', '511-4772023', 88114, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (10691, 1000000, to_date('09-11-2020', 'dd-mm-yyyy'), '28 Garry Street', '488-1440045', 9437, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (18748, 10453, to_date('28-07-2023', 'dd-mm-yyyy'), '77 McGovern Drive', '368-3481572', 30106, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (96301, 8303666, to_date('12-11-2022', 'dd-mm-yyyy'), '86 Groton Blvd', '652-3099394', 42201, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (5929, 531498, to_date('02-11-2021', 'dd-mm-yyyy'), '31 Vanessa', '877-7701466', 34839, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (31980, 1000000, to_date('21-07-2021', 'dd-mm-yyyy'), '26 Carradine Ave', '791-3615273', 39213, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (15121, 8473898, to_date('21-09-2021', 'dd-mm-yyyy'), '790 Rickles Street', '941-9484552', 32075, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (60079, 9701636, to_date('06-06-2021', 'dd-mm-yyyy'), '48 Gavin Street', '611-3998270', 51223, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (69961, 1000000, to_date('17-01-2022', 'dd-mm-yyyy'), '30 McAnally Street', '144-4745282', 15217, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (13205, 2873083, to_date('14-11-2023', 'dd-mm-yyyy'), '50 Belles Drive', '371-7468214', 71500, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (14707, 1000000, to_date('16-01-2022', 'dd-mm-yyyy'), '66 Rip Road', '160-9555097', 70755, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (88163, 2451806, to_date('06-08-2023', 'dd-mm-yyyy'), '216 Condition Road', '582-6870571', 33796, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (81550, 1000000, to_date('30-05-2021', 'dd-mm-yyyy'), '69 Caine Road', '623-3484993', 92025, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (94582, 1000000, to_date('10-06-2021', 'dd-mm-yyyy'), '4 Levy Street', '428-3753553', 70061, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (94770, 1000000, to_date('18-08-2020', 'dd-mm-yyyy'), '36 Merle Drive', '441-1683855', 27641, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (81252, 1000000, to_date('16-04-2022', 'dd-mm-yyyy'), '19 Loring Drive', '424-6537491', 82382, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (86420, 3308944, to_date('16-12-2022', 'dd-mm-yyyy'), '54 Ani Drive', '997-4416153', 33584, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (84163, 1000000, to_date('19-09-2021', 'dd-mm-yyyy'), '98 Rhys-Davies Blvd', '927-6025805', 82022, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (70939, 1000000, to_date('06-07-2023', 'dd-mm-yyyy'), '43 Ludbreg Drive', '169-1019924', 39213, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (63297, 3936941, to_date('06-09-2023', 'dd-mm-yyyy'), '89 LeVar Road', '882-7053707', 21876, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (28484, 1000000, to_date('18-03-2022', 'dd-mm-yyyy'), '62 Joli Ave', '760-9591898', 97912, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (20873, 6534852, to_date('02-04-2022', 'dd-mm-yyyy'), '20 Rapaport Street', '484-9340544', 66276, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (86619, 9306684, to_date('25-05-2023', 'dd-mm-yyyy'), '87 Koteas Road', '219-1541334', 59705, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (99877, 9982906, to_date('16-08-2022', 'dd-mm-yyyy'), '35 Stoltz Road', '523-7091364', 90416, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (6819, 3092466, to_date('16-06-2023', 'dd-mm-yyyy'), '44 Rock Blvd', '317-4711247', 2526, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (37096, 1000000, to_date('21-11-2020', 'dd-mm-yyyy'), '40 Jesus Drive', '926-6168456', 54553, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (77933, 1000000, to_date('30-11-2023', 'dd-mm-yyyy'), '614 Woodland Hills R', '675-3080528', 93754, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (17955, 6768899, to_date('23-12-2023', 'dd-mm-yyyy'), '24 McDowall Road', '280-4390796', 36098, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (39372, 9171278, to_date('20-07-2022', 'dd-mm-yyyy'), '642 Karlstad Drive', '428-4646701', 14323, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (81604, 1000000, to_date('29-09-2023', 'dd-mm-yyyy'), '73 Helen Street', '854-8702752', 37588, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (40160, 1000000, to_date('21-08-2021', 'dd-mm-yyyy'), '56 Maintenon Ave', '304-3916873', 37209, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (31048, 3896664, to_date('03-08-2023', 'dd-mm-yyyy'), '88 Wong Drive', '602-6485932', 68339, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (76150, 1000000, to_date('23-04-2021', 'dd-mm-yyyy'), '15 Kloten Road', '163-4594794', 25581, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (80904, 1000000, to_date('27-10-2021', 'dd-mm-yyyy'), '20 Dartmouth Drive', '882-7840112', 11541, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (10784, 7220444, to_date('22-10-2022', 'dd-mm-yyyy'), '90 St Leonards', '152-3524299', 91694, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (78280, 1000000, to_date('12-06-2022', 'dd-mm-yyyy'), '92 Evett Street', '579-8253952', 57091, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (93930, 1000000, to_date('12-12-2020', 'dd-mm-yyyy'), '348 Edison', '266-9442887', 34822, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (76176, 2480178, to_date('08-11-2020', 'dd-mm-yyyy'), '29 Rupert Drive', '834-3788316', 73319, 'Pending');
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id, status)
values (25987, 7197697, to_date('26-02-2022', 'dd-mm-yyyy'), '73 Sorvino Road', '734-9127108', 4820, 'Pending');
commit;
prompt 151 records loaded
prompt Loading BELONG...
insert into BELONG (amount, dishs_id, order_id)
values (655239, 42, 40160);
insert into BELONG (amount, dishs_id, order_id)
values (471115, 780, 86420);
insert into BELONG (amount, dishs_id, order_id)
values (214624, 918, 80904);
insert into BELONG (amount, dishs_id, order_id)
values (508938, 1388, 54338);
insert into BELONG (amount, dishs_id, order_id)
values (388520, 1132, 29984);
insert into BELONG (amount, dishs_id, order_id)
values (794745, 682, 91407);
insert into BELONG (amount, dishs_id, order_id)
values (597745, 1278, 60877);
insert into BELONG (amount, dishs_id, order_id)
values (950038, 76, 91588);
insert into BELONG (amount, dishs_id, order_id)
values (931659, 568, 84219);
insert into BELONG (amount, dishs_id, order_id)
values (804636, 158, 97948);
insert into BELONG (amount, dishs_id, order_id)
values (21273, 1260, 59136);
insert into BELONG (amount, dishs_id, order_id)
values (418661, 412, 20547);
insert into BELONG (amount, dishs_id, order_id)
values (525475, 932, 63965);
insert into BELONG (amount, dishs_id, order_id)
values (285298, 994, 24034);
insert into BELONG (amount, dishs_id, order_id)
values (984079, 1252, 10259);
insert into BELONG (amount, dishs_id, order_id)
values (960425, 76, 69961);
insert into BELONG (amount, dishs_id, order_id)
values (32009, 406, 34506);
insert into BELONG (amount, dishs_id, order_id)
values (217804, 182, 83726);
insert into BELONG (amount, dishs_id, order_id)
values (884593, 214, 37096);
insert into BELONG (amount, dishs_id, order_id)
values (689672, 1220, 39336);
insert into BELONG (amount, dishs_id, order_id)
values (925012, 1228, 81884);
insert into BELONG (amount, dishs_id, order_id)
values (913942, 1092, 95415);
insert into BELONG (amount, dishs_id, order_id)
values (112472, 368, 70939);
insert into BELONG (amount, dishs_id, order_id)
values (866443, 156, 95415);
insert into BELONG (amount, dishs_id, order_id)
values (717520, 1312, 10691);
insert into BELONG (amount, dishs_id, order_id)
values (488107, 1130, 6819);
insert into BELONG (amount, dishs_id, order_id)
values (770941, 518, 69316);
insert into BELONG (amount, dishs_id, order_id)
values (685284, 1312, 21754);
insert into BELONG (amount, dishs_id, order_id)
values (178992, 646, 66973);
insert into BELONG (amount, dishs_id, order_id)
values (856085, 294, 29984);
insert into BELONG (amount, dishs_id, order_id)
values (122609, 856, 18748);
insert into BELONG (amount, dishs_id, order_id)
values (928292, 314, 13698);
insert into BELONG (amount, dishs_id, order_id)
values (688688, 852, 66973);
insert into BELONG (amount, dishs_id, order_id)
values (284690, 1048, 28283);
insert into BELONG (amount, dishs_id, order_id)
values (267737, 790, 10587);
insert into BELONG (amount, dishs_id, order_id)
values (836706, 236, 17955);
insert into BELONG (amount, dishs_id, order_id)
values (971976, 796, 22197);
insert into BELONG (amount, dishs_id, order_id)
values (748790, 230, 78900);
insert into BELONG (amount, dishs_id, order_id)
values (279968, 666, 10259);
insert into BELONG (amount, dishs_id, order_id)
values (412139, 1008, 10784);
insert into BELONG (amount, dishs_id, order_id)
values (654956, 822, 11265);
insert into BELONG (amount, dishs_id, order_id)
values (252887, 296, 6926);
insert into BELONG (amount, dishs_id, order_id)
values (203346, 180, 59136);
insert into BELONG (amount, dishs_id, order_id)
values (784940, 904, 82852);
insert into BELONG (amount, dishs_id, order_id)
values (571995, 1324, 31980);
insert into BELONG (amount, dishs_id, order_id)
values (319855, 698, 82852);
insert into BELONG (amount, dishs_id, order_id)
values (168687, 682, 96301);
insert into BELONG (amount, dishs_id, order_id)
values (752755, 378, 96486);
insert into BELONG (amount, dishs_id, order_id)
values (659983, 212, 89775);
insert into BELONG (amount, dishs_id, order_id)
values (629369, 152, 5929);
insert into BELONG (amount, dishs_id, order_id)
values (238049, 450, 81884);
insert into BELONG (amount, dishs_id, order_id)
values (618874, 1286, 67327);
insert into BELONG (amount, dishs_id, order_id)
values (941371, 350, 82274);
insert into BELONG (amount, dishs_id, order_id)
values (438751, 668, 67327);
insert into BELONG (amount, dishs_id, order_id)
values (872452, 30, 57878);
insert into BELONG (amount, dishs_id, order_id)
values (906062, 958, 94770);
insert into BELONG (amount, dishs_id, order_id)
values (272858, 60, 67007);
insert into BELONG (amount, dishs_id, order_id)
values (96946, 102, 81550);
insert into BELONG (amount, dishs_id, order_id)
values (725241, 496, 40788);
insert into BELONG (amount, dishs_id, order_id)
values (773854, 1226, 18748);
insert into BELONG (amount, dishs_id, order_id)
values (73635, 1194, 14707);
insert into BELONG (amount, dishs_id, order_id)
values (250603, 402, 18177);
insert into BELONG (amount, dishs_id, order_id)
values (735360, 716, 94582);
insert into BELONG (amount, dishs_id, order_id)
values (171582, 976, 63965);
insert into BELONG (amount, dishs_id, order_id)
values (597190, 700, 63297);
insert into BELONG (amount, dishs_id, order_id)
values (301584, 842, 15121);
insert into BELONG (amount, dishs_id, order_id)
values (425833, 292, 86294);
insert into BELONG (amount, dishs_id, order_id)
values (554395, 886, 40181);
insert into BELONG (amount, dishs_id, order_id)
values (187484, 1066, 10932);
insert into BELONG (amount, dishs_id, order_id)
values (746502, 858, 50866);
insert into BELONG (amount, dishs_id, order_id)
values (583939, 28, 14559);
insert into BELONG (amount, dishs_id, order_id)
values (965616, 1252, 59136);
insert into BELONG (amount, dishs_id, order_id)
values (349780, 222, 78159);
insert into BELONG (amount, dishs_id, order_id)
values (89016, 334, 10932);
insert into BELONG (amount, dishs_id, order_id)
values (358149, 392, 31048);
insert into BELONG (amount, dishs_id, order_id)
values (996349, 94, 86420);
insert into BELONG (amount, dishs_id, order_id)
values (8314, 1370, 57797);
insert into BELONG (amount, dishs_id, order_id)
values (605826, 306, 5929);
insert into BELONG (amount, dishs_id, order_id)
values (258403, 988, 25987);
insert into BELONG (amount, dishs_id, order_id)
values (326934, 1300, 63965);
insert into BELONG (amount, dishs_id, order_id)
values (491676, 656, 81550);
insert into BELONG (amount, dishs_id, order_id)
values (873150, 880, 81604);
insert into BELONG (amount, dishs_id, order_id)
values (327605, 56, 96486);
insert into BELONG (amount, dishs_id, order_id)
values (365154, 428, 81540);
insert into BELONG (amount, dishs_id, order_id)
values (515620, 408, 50415);
insert into BELONG (amount, dishs_id, order_id)
values (641718, 652, 37096);
insert into BELONG (amount, dishs_id, order_id)
values (327794, 98, 11223);
insert into BELONG (amount, dishs_id, order_id)
values (429054, 720, 33352);
insert into BELONG (amount, dishs_id, order_id)
values (46011, 416, 24034);
insert into BELONG (amount, dishs_id, order_id)
values (804050, 412, 34345);
insert into BELONG (amount, dishs_id, order_id)
values (73873, 144, 67327);
insert into BELONG (amount, dishs_id, order_id)
values (506016, 284, 29984);
insert into BELONG (amount, dishs_id, order_id)
values (597542, 16, 4421);
insert into BELONG (amount, dishs_id, order_id)
values (780565, 736, 90574);
insert into BELONG (amount, dishs_id, order_id)
values (281146, 926, 61206);
insert into BELONG (amount, dishs_id, order_id)
values (713920, 1080, 14188);
insert into BELONG (amount, dishs_id, order_id)
values (615666, 842, 78280);
insert into BELONG (amount, dishs_id, order_id)
values (933671, 966, 81540);
insert into BELONG (amount, dishs_id, order_id)
values (12206, 578, 2114);
insert into BELONG (amount, dishs_id, order_id)
values (434500, 142, 29984);
commit;
prompt 100 records committed...
insert into BELONG (amount, dishs_id, order_id)
values (52173, 818, 33702);
insert into BELONG (amount, dishs_id, order_id)
values (674675, 878, 91439);
insert into BELONG (amount, dishs_id, order_id)
values (776446, 670, 30593);
insert into BELONG (amount, dishs_id, order_id)
values (287458, 862, 81549);
insert into BELONG (amount, dishs_id, order_id)
values (762433, 1374, 80048);
insert into BELONG (amount, dishs_id, order_id)
values (195659, 674, 81549);
insert into BELONG (amount, dishs_id, order_id)
values (946451, 404, 14188);
insert into BELONG (amount, dishs_id, order_id)
values (42064, 64, 43408);
insert into BELONG (amount, dishs_id, order_id)
values (52920, 558, 76176);
insert into BELONG (amount, dishs_id, order_id)
values (534242, 60, 10356);
insert into BELONG (amount, dishs_id, order_id)
values (12982, 730, 5929);
insert into BELONG (amount, dishs_id, order_id)
values (758762, 282, 37096);
insert into BELONG (amount, dishs_id, order_id)
values (792871, 22, 33352);
insert into BELONG (amount, dishs_id, order_id)
values (671411, 396, 31980);
insert into BELONG (amount, dishs_id, order_id)
values (114000, 902, 76900);
insert into BELONG (amount, dishs_id, order_id)
values (614542, 810, 49131);
insert into BELONG (amount, dishs_id, order_id)
values (883582, 1106, 25427);
insert into BELONG (amount, dishs_id, order_id)
values (896830, 1206, 43408);
insert into BELONG (amount, dishs_id, order_id)
values (925725, 806, 6926);
insert into BELONG (amount, dishs_id, order_id)
values (181298, 888, 21459);
insert into BELONG (amount, dishs_id, order_id)
values (780735, 270, 54338);
insert into BELONG (amount, dishs_id, order_id)
values (430059, 386, 16942);
insert into BELONG (amount, dishs_id, order_id)
values (643648, 122, 17955);
insert into BELONG (amount, dishs_id, order_id)
values (265203, 392, 87178);
insert into BELONG (amount, dishs_id, order_id)
values (347791, 344, 77933);
insert into BELONG (amount, dishs_id, order_id)
values (368942, 452, 56170);
insert into BELONG (amount, dishs_id, order_id)
values (858082, 850, 97948);
insert into BELONG (amount, dishs_id, order_id)
values (933341, 948, 94582);
insert into BELONG (amount, dishs_id, order_id)
values (38829, 846, 39006);
insert into BELONG (amount, dishs_id, order_id)
values (601350, 1336, 66529);
insert into BELONG (amount, dishs_id, order_id)
values (93336, 764, 81252);
insert into BELONG (amount, dishs_id, order_id)
values (491143, 1032, 53565);
insert into BELONG (amount, dishs_id, order_id)
values (89591, 406, 10587);
insert into BELONG (amount, dishs_id, order_id)
values (793540, 1106, 96486);
insert into BELONG (amount, dishs_id, order_id)
values (935770, 132, 10784);
insert into BELONG (amount, dishs_id, order_id)
values (517959, 386, 51130);
insert into BELONG (amount, dishs_id, order_id)
values (543027, 664, 39006);
insert into BELONG (amount, dishs_id, order_id)
values (866290, 338, 49131);
insert into BELONG (amount, dishs_id, order_id)
values (816040, 844, 81540);
insert into BELONG (amount, dishs_id, order_id)
values (517385, 876, 28484);
insert into BELONG (amount, dishs_id, order_id)
values (739649, 50, 2533);
insert into BELONG (amount, dishs_id, order_id)
values (355227, 356, 76831);
insert into BELONG (amount, dishs_id, order_id)
values (474192, 1160, 6819);
insert into BELONG (amount, dishs_id, order_id)
values (573453, 526, 88163);
insert into BELONG (amount, dishs_id, order_id)
values (806448, 918, 60877);
insert into BELONG (amount, dishs_id, order_id)
values (621055, 188, 10259);
insert into BELONG (amount, dishs_id, order_id)
values (667795, 670, 13698);
insert into BELONG (amount, dishs_id, order_id)
values (53065, 1208, 13698);
insert into BELONG (amount, dishs_id, order_id)
values (561479, 218, 57784);
insert into BELONG (amount, dishs_id, order_id)
values (293851, 642, 60079);
insert into BELONG (amount, dishs_id, order_id)
values (475447, 230, 61206);
insert into BELONG (amount, dishs_id, order_id)
values (216547, 154, 90546);
insert into BELONG (amount, dishs_id, order_id)
values (911881, 492, 31980);
insert into BELONG (amount, dishs_id, order_id)
values (121105, 1378, 81066);
insert into BELONG (amount, dishs_id, order_id)
values (500253, 1336, 13205);
insert into BELONG (amount, dishs_id, order_id)
values (704765, 1330, 97337);
insert into BELONG (amount, dishs_id, order_id)
values (854209, 522, 57797);
insert into BELONG (amount, dishs_id, order_id)
values (494063, 988, 29501);
insert into BELONG (amount, dishs_id, order_id)
values (347842, 1044, 72589);
insert into BELONG (amount, dishs_id, order_id)
values (756068, 418, 28484);
insert into BELONG (amount, dishs_id, order_id)
values (873260, 1344, 39025);
insert into BELONG (amount, dishs_id, order_id)
values (455638, 700, 6926);
insert into BELONG (amount, dishs_id, order_id)
values (907289, 1060, 21754);
insert into BELONG (amount, dishs_id, order_id)
values (662746, 592, 40181);
insert into BELONG (amount, dishs_id, order_id)
values (856018, 194, 13698);
insert into BELONG (amount, dishs_id, order_id)
values (438944, 194, 81549);
insert into BELONG (amount, dishs_id, order_id)
values (2973, 638, 25303);
insert into BELONG (amount, dishs_id, order_id)
values (833381, 96, 39372);
insert into BELONG (amount, dishs_id, order_id)
values (904852, 1304, 2812);
insert into BELONG (amount, dishs_id, order_id)
values (620027, 820, 25987);
insert into BELONG (amount, dishs_id, order_id)
values (475145, 584, 17955);
insert into BELONG (amount, dishs_id, order_id)
values (904715, 50, 565);
insert into BELONG (amount, dishs_id, order_id)
values (449021, 1292, 97337);
insert into BELONG (amount, dishs_id, order_id)
values (157697, 1088, 16969);
insert into BELONG (amount, dishs_id, order_id)
values (493728, 1308, 81066);
insert into BELONG (amount, dishs_id, order_id)
values (874485, 224, 36202);
insert into BELONG (amount, dishs_id, order_id)
values (187517, 1344, 86619);
insert into BELONG (amount, dishs_id, order_id)
values (849718, 812, 84163);
insert into BELONG (amount, dishs_id, order_id)
values (221562, 28, 85507);
insert into BELONG (amount, dishs_id, order_id)
values (875772, 16, 66102);
insert into BELONG (amount, dishs_id, order_id)
values (318502, 798, 10259);
insert into BELONG (amount, dishs_id, order_id)
values (532564, 718, 84015);
insert into BELONG (amount, dishs_id, order_id)
values (884890, 1244, 11223);
insert into BELONG (amount, dishs_id, order_id)
values (645815, 186, 39025);
insert into BELONG (amount, dishs_id, order_id)
values (569577, 302, 565);
insert into BELONG (amount, dishs_id, order_id)
values (484340, 888, 30593);
insert into BELONG (amount, dishs_id, order_id)
values (93541, 234, 62607);
insert into BELONG (amount, dishs_id, order_id)
values (962775, 1310, 78900);
insert into BELONG (amount, dishs_id, order_id)
values (301473, 1040, 10259);
insert into BELONG (amount, dishs_id, order_id)
values (341159, 1198, 57878);
insert into BELONG (amount, dishs_id, order_id)
values (889024, 1010, 76176);
insert into BELONG (amount, dishs_id, order_id)
values (337318, 1074, 93832);
insert into BELONG (amount, dishs_id, order_id)
values (586082, 1356, 10575);
insert into BELONG (amount, dishs_id, order_id)
values (797873, 1128, 97337);
insert into BELONG (amount, dishs_id, order_id)
values (604574, 982, 85394);
insert into BELONG (amount, dishs_id, order_id)
values (567702, 1318, 39336);
insert into BELONG (amount, dishs_id, order_id)
values (276242, 838, 99877);
insert into BELONG (amount, dishs_id, order_id)
values (925934, 182, 34506);
insert into BELONG (amount, dishs_id, order_id)
values (503766, 198, 81115);
insert into BELONG (amount, dishs_id, order_id)
values (99616, 1276, 27220);
commit;
prompt 200 records committed...
insert into BELONG (amount, dishs_id, order_id)
values (853895, 1032, 76150);
insert into BELONG (amount, dishs_id, order_id)
values (926817, 1396, 26959);
insert into BELONG (amount, dishs_id, order_id)
values (989926, 38, 84163);
insert into BELONG (amount, dishs_id, order_id)
values (737524, 832, 60128);
insert into BELONG (amount, dishs_id, order_id)
values (34458, 856, 93930);
insert into BELONG (amount, dishs_id, order_id)
values (597740, 1320, 13205);
insert into BELONG (amount, dishs_id, order_id)
values (979116, 644, 69961);
insert into BELONG (amount, dishs_id, order_id)
values (980584, 262, 63297);
insert into BELONG (amount, dishs_id, order_id)
values (417613, 38, 61383);
insert into BELONG (amount, dishs_id, order_id)
values (400429, 846, 11265);
insert into BELONG (amount, dishs_id, order_id)
values (967180, 1080, 47843);
insert into BELONG (amount, dishs_id, order_id)
values (518127, 218, 38522);
insert into BELONG (amount, dishs_id, order_id)
values (558895, 904, 20873);
insert into BELONG (amount, dishs_id, order_id)
values (8254, 1054, 20764);
insert into BELONG (amount, dishs_id, order_id)
values (142701, 160, 2114);
insert into BELONG (amount, dishs_id, order_id)
values (45880, 1304, 94770);
insert into BELONG (amount, dishs_id, order_id)
values (328591, 1178, 62607);
insert into BELONG (amount, dishs_id, order_id)
values (457822, 1032, 10932);
insert into BELONG (amount, dishs_id, order_id)
values (531004, 1058, 2812);
insert into BELONG (amount, dishs_id, order_id)
values (270014, 96, 28183);
insert into BELONG (amount, dishs_id, order_id)
values (19873, 990, 36094);
insert into BELONG (amount, dishs_id, order_id)
values (691797, 1306, 86294);
insert into BELONG (amount, dishs_id, order_id)
values (800391, 114, 56170);
insert into BELONG (amount, dishs_id, order_id)
values (367866, 174, 83726);
insert into BELONG (amount, dishs_id, order_id)
values (159702, 798, 85934);
insert into BELONG (amount, dishs_id, order_id)
values (204745, 978, 10784);
insert into BELONG (amount, dishs_id, order_id)
values (540320, 1254, 97566);
insert into BELONG (amount, dishs_id, order_id)
values (433947, 1118, 38771);
insert into BELONG (amount, dishs_id, order_id)
values (555647, 598, 88163);
insert into BELONG (amount, dishs_id, order_id)
values (35471, 882, 36202);
insert into BELONG (amount, dishs_id, order_id)
values (239964, 418, 19840);
insert into BELONG (amount, dishs_id, order_id)
values (284136, 538, 61383);
insert into BELONG (amount, dishs_id, order_id)
values (229445, 522, 49131);
insert into BELONG (amount, dishs_id, order_id)
values (378756, 162, 48609);
insert into BELONG (amount, dishs_id, order_id)
values (755428, 1022, 26959);
insert into BELONG (amount, dishs_id, order_id)
values (366788, 6, 97948);
insert into BELONG (amount, dishs_id, order_id)
values (806996, 386, 59106);
insert into BELONG (amount, dishs_id, order_id)
values (723076, 712, 39006);
insert into BELONG (amount, dishs_id, order_id)
values (619004, 1310, 69316);
insert into BELONG (amount, dishs_id, order_id)
values (252492, 798, 34856);
insert into BELONG (amount, dishs_id, order_id)
values (249857, 518, 34515);
insert into BELONG (amount, dishs_id, order_id)
values (193542, 1124, 24369);
insert into BELONG (amount, dishs_id, order_id)
values (835430, 464, 34856);
insert into BELONG (amount, dishs_id, order_id)
values (858348, 72, 32932);
insert into BELONG (amount, dishs_id, order_id)
values (103268, 596, 2114);
insert into BELONG (amount, dishs_id, order_id)
values (346022, 1172, 66539);
insert into BELONG (amount, dishs_id, order_id)
values (175026, 440, 78159);
insert into BELONG (amount, dishs_id, order_id)
values (666344, 94, 10259);
insert into BELONG (amount, dishs_id, order_id)
values (907854, 206, 57784);
insert into BELONG (amount, dishs_id, order_id)
values (952972, 62, 63297);
commit;
prompt 250 records loaded
prompt Loading REGISTRATION...
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (100, to_date('26-11-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 114);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (103, to_date('05-07-2022', 'dd-mm-yyyy'), 'hebrew', 'notAccepted', 124, 51);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (104, to_date('16-10-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 37);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (105, to_date('08-07-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 88);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (108, to_date('23-01-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 123);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (109, to_date('13-06-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 109);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (111, to_date('14-09-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 20);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (112, to_date('22-04-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 55);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (113, to_date('24-06-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 36);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (114, to_date('25-03-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 88);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (115, to_date('24-08-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 120);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (116, to_date('08-06-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 66);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (120, to_date('21-12-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 1);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (121, to_date('20-01-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 108);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (123, to_date('07-11-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 105);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (126, to_date('07-12-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 111);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (127, to_date('29-09-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 126);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (128, to_date('02-07-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 101);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (129, to_date('29-01-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 32);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (131, to_date('15-02-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 56);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (133, to_date('09-06-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 9);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (134, to_date('22-10-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 97);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (135, to_date('19-11-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 25);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (140, to_date('06-01-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 48);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (141, to_date('11-08-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 32);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (142, to_date('21-01-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 53);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (143, to_date('22-03-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 31);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (144, to_date('28-06-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 126);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (146, to_date('11-05-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 145);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (147, to_date('15-03-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 29);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (149, to_date('16-03-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 24);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (151, to_date('11-10-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 30);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (152, to_date('21-11-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 36);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (153, to_date('14-02-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 91);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (157, to_date('26-11-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 130);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (158, to_date('12-03-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 55);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (159, to_date('14-07-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 23);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (160, to_date('07-01-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 103);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (161, to_date('21-06-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 57);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (162, to_date('29-10-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 18);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (163, to_date('10-02-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 95);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (165, to_date('01-11-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 85);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (168, to_date('06-02-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 43);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (169, to_date('16-04-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 80);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (170, to_date('29-10-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 123);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (171, to_date('27-06-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 55);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (172, to_date('27-05-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 69);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (174, to_date('06-06-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 119);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (175, to_date('06-05-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 78);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (180, to_date('17-03-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 43);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (182, to_date('23-07-2020', 'dd-mm-yyyy'), 'english', 'notAccepted', 143, 26);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (183, to_date('16-02-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 132);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (184, to_date('19-07-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 123);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (185, to_date('19-01-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 57);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (187, to_date('27-02-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 75);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (188, to_date('09-08-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 19);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (189, to_date('06-03-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 73);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (191, to_date('27-07-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 84);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (193, to_date('24-06-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 109);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (195, to_date('14-07-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 94);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (196, to_date('13-01-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 47);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (198, to_date('30-07-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 127);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (199, to_date('30-05-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 92);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (200, to_date('03-02-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 28);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (201, to_date('07-05-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 27);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (202, to_date('23-02-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 99);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (203, to_date('02-12-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 92);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (204, to_date('18-08-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 149);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (205, to_date('31-05-2022', 'dd-mm-yyyy'), 'english', 'notAccepted', 136, 26);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (206, to_date('07-10-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 76);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (208, to_date('08-12-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 46);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (209, to_date('12-01-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 43);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (210, to_date('19-04-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 60);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (211, to_date('30-09-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 125);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (212, to_date('27-03-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 90);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (215, to_date('21-01-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 11);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (217, to_date('13-05-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 133);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (218, to_date('15-10-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 104);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (219, to_date('20-05-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 78);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (220, to_date('25-05-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 76);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (222, to_date('12-04-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 93);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (224, to_date('24-12-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 86);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (226, to_date('16-02-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 20);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (227, to_date('02-03-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 133);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (229, to_date('16-04-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 74);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (230, to_date('14-02-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 27);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (231, to_date('08-02-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 101);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (233, to_date('18-07-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 17);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (234, to_date('10-01-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 40);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (238, to_date('18-09-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 35);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (239, to_date('10-07-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 139);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (241, to_date('26-04-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 108);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (242, to_date('27-05-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 72);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (243, to_date('10-04-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 136);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (244, to_date('22-03-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 91);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (245, to_date('27-05-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 148);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (246, to_date('25-10-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 5);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (247, to_date('02-11-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 111);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (248, to_date('10-09-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 124);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (249, to_date('31-07-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 116);
commit;
prompt 100 records committed...
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (250, to_date('17-05-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 98);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (251, to_date('10-01-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 48);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (252, to_date('15-02-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 125);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (254, to_date('26-05-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 32);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (255, to_date('20-06-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 71);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (256, to_date('22-03-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 5);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (257, to_date('06-06-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 144);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (258, to_date('09-04-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 31);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (259, to_date('14-10-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 92);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (260, to_date('09-11-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 45);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (262, to_date('23-08-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 37);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (263, to_date('14-10-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 21);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (266, to_date('12-08-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 150);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (267, to_date('25-08-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 34);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (268, to_date('06-03-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 25);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (269, to_date('04-09-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 49);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (271, to_date('13-02-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 87);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (272, to_date('22-02-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 21);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (274, to_date('16-02-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 43);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (275, to_date('03-09-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 61);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (276, to_date('25-07-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 150);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (277, to_date('22-08-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 150);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (278, to_date('24-10-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 112);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (285, to_date('19-03-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 129);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (286, to_date('07-02-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 72);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (287, to_date('17-11-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 140);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (288, to_date('02-07-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 68);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (289, to_date('03-06-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 40);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (290, to_date('12-08-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 22);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (291, to_date('27-02-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 126);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (292, to_date('25-11-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 38);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (295, to_date('22-09-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 104);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (297, to_date('20-06-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 78);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (298, to_date('22-01-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 13);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (299, to_date('28-06-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 48);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (300, to_date('20-04-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 129);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (302, to_date('12-01-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 110);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (304, to_date('11-04-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 120);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (306, to_date('16-08-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 94);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (308, to_date('30-08-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 10);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (309, to_date('03-09-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 49);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (310, to_date('03-04-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 111);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (311, to_date('14-01-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 64);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (312, to_date('02-08-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 87);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (314, to_date('20-01-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 56);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (315, to_date('26-08-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 91);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (316, to_date('19-12-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 21);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (317, to_date('15-01-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 29);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (318, to_date('15-01-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 121);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (319, to_date('19-08-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 72);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (320, to_date('18-09-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 127);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (321, to_date('14-02-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 137);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (322, to_date('20-04-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 66);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (324, to_date('25-11-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 34);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (325, to_date('19-06-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 134);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (326, to_date('09-03-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 145);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (327, to_date('15-03-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 103);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (328, to_date('15-12-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 74);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (329, to_date('29-03-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 27);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (330, to_date('05-07-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 119);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (331, to_date('05-09-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 9);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (332, to_date('08-11-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 127);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (334, to_date('14-09-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 146);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (335, to_date('10-09-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 15);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (336, to_date('19-04-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 115);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (337, to_date('22-10-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 52);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (338, to_date('13-01-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 27);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (339, to_date('05-03-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 12);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (340, to_date('01-12-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 54);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (341, to_date('11-07-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 38);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (343, to_date('02-01-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 99);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (344, to_date('08-06-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 144);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (345, to_date('26-11-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 112);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (346, to_date('09-06-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 100);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (347, to_date('06-03-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 135);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (349, to_date('26-10-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 105);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (352, to_date('06-10-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 66);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (353, to_date('20-01-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 23);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (355, to_date('10-04-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 101);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (356, to_date('03-04-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 58);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (358, to_date('06-07-2022', 'dd-mm-yyyy'), 'english', 'notAccepted', 124, 57);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (360, to_date('21-05-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 71);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (363, to_date('28-12-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 16);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (364, to_date('26-03-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 22);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (365, to_date('23-12-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 9);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (367, to_date('20-03-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 51);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (368, to_date('06-02-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 31);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (369, to_date('05-12-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 71);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (371, to_date('28-10-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 97);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (373, to_date('20-03-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 50);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (374, to_date('24-01-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 14);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (376, to_date('02-06-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 17);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (377, to_date('23-12-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 142);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (378, to_date('20-01-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 66);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (379, to_date('19-03-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 125);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (380, to_date('29-04-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 138);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (381, to_date('26-07-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 7);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (382, to_date('14-03-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 115);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (383, to_date('02-04-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 114);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (384, to_date('19-07-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 131);
commit;
prompt 200 records committed...
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (385, to_date('28-09-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 81);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (387, to_date('23-07-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 74);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (388, to_date('12-05-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 125);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (389, to_date('07-11-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 93);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (392, to_date('25-05-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 55);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (393, to_date('08-01-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 109);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (394, to_date('09-01-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 9);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (396, to_date('02-11-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 135);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (397, to_date('05-05-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 34);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (399, to_date('06-04-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 17);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (401, to_date('24-01-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 85);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (403, to_date('09-06-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 115);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (405, to_date('08-10-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 136);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (406, to_date('24-09-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 104);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (407, to_date('17-01-2019', 'dd-mm-yyyy'), 'hebrew', 'notAccepted', 142, 26);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (409, to_date('29-07-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 27);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (411, to_date('14-07-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 118);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (417, to_date('16-09-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 71);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (418, to_date('26-11-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 100);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (419, to_date('10-09-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 39);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (420, to_date('13-08-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 50);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (422, to_date('04-07-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 20);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (423, to_date('22-07-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 47);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (425, to_date('28-01-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 30);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (426, to_date('20-05-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 85);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (428, to_date('26-01-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 117);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (429, to_date('19-09-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 131);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (431, to_date('10-02-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 134);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (432, to_date('27-08-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 141);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (434, to_date('08-04-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 121);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (438, to_date('08-06-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 94);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (440, to_date('20-05-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 7);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (441, to_date('21-03-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 71);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (442, to_date('23-07-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 9);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (444, to_date('21-05-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 121);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (445, to_date('26-01-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 55);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (446, to_date('24-01-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 71);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (447, to_date('06-07-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 56);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (448, to_date('27-11-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 101);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (449, to_date('23-06-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 134);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (450, to_date('14-06-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 113);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (451, to_date('14-06-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 124);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (452, to_date('02-06-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 11);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (454, to_date('22-06-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 138);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (456, to_date('07-10-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 70);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (457, to_date('09-12-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 16);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (463, to_date('09-01-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 139);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (464, to_date('15-03-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 110);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (465, to_date('26-06-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 107);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (466, to_date('03-11-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 118);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (471, to_date('17-01-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 129);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (472, to_date('27-02-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 109);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (474, to_date('01-10-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 77);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (478, to_date('19-11-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 18);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (479, to_date('24-01-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 85);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (481, to_date('28-07-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 47);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (484, to_date('04-03-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 99);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (485, to_date('22-04-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 144);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (487, to_date('20-02-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 87);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (488, to_date('01-12-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 78);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (490, to_date('19-01-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 65);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (493, to_date('31-07-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 106);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (494, to_date('30-01-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 113);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (495, to_date('14-04-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 110);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (496, to_date('15-02-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 135);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (497, to_date('24-10-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 62);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (498, to_date('26-01-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 138);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (499, to_date('18-10-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 112);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (500, to_date('07-06-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 87);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (502, to_date('20-07-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 126);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (503, to_date('19-06-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 109);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (506, to_date('06-10-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 7);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (507, to_date('02-12-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 86);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (508, to_date('03-05-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 127);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (509, to_date('27-09-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 123);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (510, to_date('30-10-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 21);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (512, to_date('23-12-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 36);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (513, to_date('07-07-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 40);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (515, to_date('08-12-2021', 'dd-mm-yyyy'), 'hebrew', 'notAccepted', 135, 41);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (516, to_date('08-04-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 10);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (517, to_date('26-04-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 80);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (520, to_date('30-03-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 47);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (521, to_date('09-03-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 19);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (524, to_date('30-06-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 2);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (525, to_date('10-02-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 7);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (526, to_date('15-09-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 61);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (527, to_date('28-02-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 140);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (528, to_date('29-04-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 143);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (529, to_date('02-04-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 30);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (530, to_date('10-02-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 16);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (531, to_date('31-12-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 21);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (532, to_date('23-12-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 81);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (533, to_date('04-02-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 34);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (534, to_date('05-04-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 97);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (535, to_date('12-03-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 133);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (536, to_date('15-10-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 2);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (538, to_date('30-09-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 36);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (539, to_date('06-02-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 23);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (540, to_date('23-05-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 121);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (541, to_date('11-09-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 131);
commit;
prompt 300 records committed...
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (542, to_date('17-07-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 130);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (544, to_date('26-11-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 33);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (545, to_date('30-10-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 14);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (546, to_date('14-03-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 14);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (548, to_date('09-02-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 71);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (549, to_date('20-10-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 102);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (552, to_date('25-08-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 145);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (553, to_date('12-08-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 4);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (555, to_date('24-09-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 94);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (556, to_date('16-03-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 118);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (558, to_date('03-06-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 6);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (559, to_date('05-12-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 136);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (560, to_date('12-09-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 61);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (561, to_date('28-04-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 106);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (563, to_date('12-01-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 119);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (564, to_date('19-06-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 76);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (565, to_date('27-04-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 26);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (566, to_date('09-08-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 111);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (568, to_date('09-06-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 133);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (569, to_date('23-09-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 21);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (570, to_date('07-11-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 48);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (571, to_date('07-06-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 19);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (574, to_date('03-09-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 94);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (575, to_date('13-09-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 81);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (576, to_date('14-12-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 98);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (577, to_date('16-01-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 27);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (578, to_date('24-12-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 64);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (580, to_date('03-02-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 112);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (581, to_date('10-10-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 127);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (583, to_date('01-01-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 132);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (584, to_date('09-01-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 68);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (586, to_date('24-02-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 131);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (587, to_date('21-07-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 6);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (588, to_date('16-07-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 121);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (590, to_date('18-11-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 34);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (591, to_date('10-11-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 127);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (593, to_date('21-07-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 4);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (594, to_date('18-03-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 71);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (595, to_date('03-09-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 118);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (601, to_date('15-06-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 52);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (602, to_date('22-03-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 96);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (603, to_date('08-09-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 6);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (604, to_date('27-08-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 99);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (606, to_date('15-11-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 132);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (607, to_date('25-10-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 63);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (608, to_date('09-01-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 132);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (609, to_date('03-09-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 102);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (610, to_date('11-06-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 85);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (613, to_date('07-04-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 25);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (616, to_date('10-04-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 112);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (619, to_date('06-09-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 108);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (620, to_date('19-11-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 114);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (621, to_date('29-05-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 20);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (623, to_date('24-03-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 101);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (624, to_date('26-07-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 78);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (625, to_date('19-06-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 131);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (626, to_date('26-07-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 139);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (628, to_date('10-11-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 97);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (630, to_date('10-10-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 16);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (631, to_date('24-12-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 91);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (632, to_date('29-11-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 80);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (634, to_date('03-01-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 113);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (635, to_date('21-08-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 41);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (637, to_date('29-04-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 22);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (638, to_date('16-10-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 25);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (639, to_date('02-01-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 1);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (641, to_date('31-03-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 54);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (642, to_date('24-09-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 47);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (643, to_date('04-06-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 31);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (644, to_date('29-01-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 73);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (645, to_date('17-04-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 6);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (647, to_date('03-06-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 88);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (648, to_date('16-04-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 24);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (649, to_date('27-05-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 26);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (650, to_date('04-01-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 125);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (651, to_date('23-11-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 23);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (652, to_date('23-08-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 87);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (653, to_date('24-06-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 29);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (656, to_date('08-11-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 122);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (657, to_date('01-08-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 132);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (658, to_date('29-04-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 99);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (660, to_date('26-07-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 68);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (661, to_date('10-02-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 53);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (666, to_date('11-05-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 105);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (668, to_date('09-10-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 147);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (669, to_date('14-11-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 68);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (671, to_date('17-07-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 113);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (673, to_date('15-04-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 117);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (674, to_date('30-12-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 19);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (677, to_date('20-11-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 99);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (678, to_date('09-11-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 103);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (679, to_date('22-10-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 137);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (680, to_date('23-12-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 39);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (681, to_date('30-07-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 141);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (682, to_date('29-04-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 110);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (683, to_date('19-12-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 130);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (684, to_date('20-03-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 30);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (687, to_date('15-05-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 147);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (688, to_date('30-11-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 93);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (689, to_date('05-06-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 19);
commit;
prompt 400 records committed...
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (690, to_date('20-08-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 49);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (691, to_date('12-12-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 92);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (692, to_date('23-10-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 133);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (693, to_date('29-06-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 125);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (695, to_date('25-01-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 8);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (697, to_date('07-11-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 101);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (698, to_date('04-06-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 48);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (699, to_date('20-09-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 91);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (706, to_date('21-05-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 39);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (707, to_date('20-10-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 36);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (708, to_date('01-06-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 35);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (709, to_date('24-01-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 123);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (710, to_date('25-01-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 35);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (712, to_date('25-03-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 71);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (715, to_date('01-09-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 33);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (716, to_date('30-12-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 106);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (720, to_date('20-08-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 134);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (721, to_date('10-07-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 27);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (723, to_date('27-09-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 35);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (724, to_date('28-12-2023', 'dd-mm-yyyy'), 'english', 'notAccepted', 123, 51);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (725, to_date('22-12-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 32);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (727, to_date('28-05-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 45);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (728, to_date('04-01-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 102);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (732, to_date('08-12-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 110);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (733, to_date('05-08-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 50);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (735, to_date('02-10-2023', 'dd-mm-yyyy'), 'english', 'notAccepted', 136, 65);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (736, to_date('30-06-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 142);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (739, to_date('25-12-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 58);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (740, to_date('31-01-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 52);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (741, to_date('08-11-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 56);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (742, to_date('23-12-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 98);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (743, to_date('18-04-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 46);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (744, to_date('13-12-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 73);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (745, to_date('10-06-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 127);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (746, to_date('19-06-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 40);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (747, to_date('08-10-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 105);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (748, to_date('23-05-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 18);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (749, to_date('16-12-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 30);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (750, to_date('11-01-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 150);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (753, to_date('24-05-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 120);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (754, to_date('03-07-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 129);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (755, to_date('01-01-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 60);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (756, to_date('03-07-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 61);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (759, to_date('18-12-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 147);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (760, to_date('03-09-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 53);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (761, to_date('12-05-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 53);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (762, to_date('15-04-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 83);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (763, to_date('14-11-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 134);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (764, to_date('13-10-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 94);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (768, to_date('26-02-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 127);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (770, to_date('20-02-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 134);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (771, to_date('10-07-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 15);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (772, to_date('16-04-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 62);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (773, to_date('10-04-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 86);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (774, to_date('26-03-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 45);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (775, to_date('11-12-2022', 'dd-mm-yyyy'), 'hebrew', 'notAccepted', 136, 51);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (776, to_date('13-01-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 143);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (777, to_date('04-03-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 19);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (778, to_date('03-08-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 40);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (779, to_date('18-01-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 38);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (780, to_date('15-10-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 132);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (781, to_date('12-12-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 128);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (782, to_date('26-07-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 41);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (784, to_date('04-09-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 149);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (785, to_date('25-07-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 91);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (786, to_date('10-05-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 135);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (787, to_date('05-07-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 94);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (789, to_date('29-04-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 114);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (792, to_date('24-02-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 144);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (793, to_date('23-01-2022', 'dd-mm-yyyy'), 'hebrew', 'notAccepted', 124, 65);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (794, to_date('20-05-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 48);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (795, to_date('26-11-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 78);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (797, to_date('01-05-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 139);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (799, to_date('20-08-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 56);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (800, to_date('23-03-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 145);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (802, to_date('18-10-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 81);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (805, to_date('09-05-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 100);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (806, to_date('26-06-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 6);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (1, to_date('16-06-2024 14:26:08', 'dd-mm-yyyy hh24:mi:ss'), 'English', 'Pending', 143, 1);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (808, to_date('19-05-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 82);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (809, to_date('21-06-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 64);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (810, to_date('10-12-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 49);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (812, to_date('05-08-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 52);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (813, to_date('24-03-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 126);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (815, to_date('08-12-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 53);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (816, to_date('16-10-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 63);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (817, to_date('21-07-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 61);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (818, to_date('10-05-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 143, 43);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (820, to_date('14-02-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 131);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (821, to_date('28-03-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 18);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (823, to_date('07-11-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 67);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (826, to_date('13-10-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 49);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (827, to_date('10-04-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 57);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (828, to_date('28-12-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 89);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (829, to_date('20-02-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 135, 94);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (830, to_date('20-08-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 50);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (831, to_date('05-01-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 43);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (832, to_date('11-08-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 60);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (834, to_date('04-03-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 124, 15);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (837, to_date('11-02-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 89);
commit;
prompt 500 records committed...
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (838, to_date('18-05-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 103);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (839, to_date('03-06-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 126);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (840, to_date('20-11-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 149);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (842, to_date('04-09-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 83);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (843, to_date('27-03-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 3);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (844, to_date('15-03-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 145);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (847, to_date('09-01-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 57);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (848, to_date('02-03-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 103);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (849, to_date('22-11-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 50);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (852, to_date('10-01-2020', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 143);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (854, to_date('11-02-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 142, 149);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (856, to_date('20-02-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 109);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (858, to_date('22-08-2022', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 105);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (859, to_date('03-10-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 49);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (860, to_date('25-02-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 95);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (861, to_date('06-04-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 123, 29);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (862, to_date('20-09-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 15);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (863, to_date('18-05-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 61);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (864, to_date('15-03-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 127);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (866, to_date('02-06-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 144);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (867, to_date('08-01-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 136, 29);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (870, to_date('26-07-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 5);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (871, to_date('17-10-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 42);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (872, to_date('15-06-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 123, 115);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (873, to_date('11-11-2021', 'dd-mm-yyyy'), 'russian', 'Accepted', 136, 89);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (875, to_date('07-09-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 119);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (876, to_date('06-01-2023', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 145);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (877, to_date('27-09-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 135);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (879, to_date('25-09-2020', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 45);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (880, to_date('13-09-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 80);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (881, to_date('05-02-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 107);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (882, to_date('19-05-2022', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 23);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (886, to_date('09-06-2020', 'dd-mm-yyyy'), 'russian', 'Accepted', 142, 15);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (887, to_date('30-11-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 124, 6);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (888, to_date('12-06-2023', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 28);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (889, to_date('23-03-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 143, 83);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (890, to_date('06-02-2019', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 135, 104);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (892, to_date('20-03-2019', 'dd-mm-yyyy'), 'english', 'Accepted', 135, 121);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (894, to_date('15-09-2023', 'dd-mm-yyyy'), 'russian', 'Accepted', 124, 148);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (895, to_date('02-01-2022', 'dd-mm-yyyy'), 'english', 'Accepted', 142, 39);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (896, to_date('25-11-2021', 'dd-mm-yyyy'), 'english', 'Accepted', 136, 117);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (897, to_date('05-08-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 8);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (898, to_date('04-09-2021', 'dd-mm-yyyy'), 'hebrew', 'Accepted', 143, 144);
insert into REGISTRATION (registrationid_, registrationdate, r_language, status, k_type_id, kindergartenid)
values (899, to_date('23-09-2019', 'dd-mm-yyyy'), 'russian', 'Accepted', 123, 14);
commit;
prompt 544 records loaded
prompt Loading CHILD...
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (1, 'Harper', 'Miller', to_date('04-10-2022', 'dd-mm-yyyy'), 'Gluten', 'Madeline Miller', 588847873, null, 100);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (2, 'Lila', 'Clark', to_date('15-11-2023', 'dd-mm-yyyy'), 'Gluten', 'Nora Clark', 574842398, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (3, 'Madison', 'Ramirez', to_date('06-12-2018', 'dd-mm-yyyy'), 'Peanuts', 'John Ramirez', 517582087, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (4, 'Dylan', 'Johnson', to_date('06-12-2023', 'dd-mm-yyyy'), 'Gluten', 'David Johnson', 534016128, null, 103);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (5, 'Jack', 'Thomas', to_date('24-06-2023', 'dd-mm-yyyy'), 'Dairy', 'Aurora Thomas', 532572143, null, 104);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (6, 'Gregory', 'Rogers', to_date('03-04-2021', 'dd-mm-yyyy'), 'Gluten', 'Amelia Rogers', 587717904, null, 105);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (7, 'Aubree', 'Robinson', to_date('19-09-2023', 'dd-mm-yyyy'), 'Peanuts', 'Aaliyah Robinson', 592101363, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (8, 'Juan', 'Evans', to_date('25-03-2021', 'dd-mm-yyyy'), null, 'Kinsley Evans', 520604331, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (9, 'Leilani', 'Miller', to_date('20-11-2020', 'dd-mm-yyyy'), null, 'Piper Miller', 551767273, null, 108);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (10, 'Cameron', 'Diaz', to_date('11-05-2020', 'dd-mm-yyyy'), 'Dairy', 'Maya Diaz', 566202456, null, 109);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (11, 'Rosalie', 'Garcia', to_date('05-06-2023', 'dd-mm-yyyy'), 'Gluten', 'Gabriel Garcia', 540570590, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (12, 'Sloane', 'Nguyen', to_date('06-09-2019', 'dd-mm-yyyy'), 'Gluten', 'Lucy Nguyen', 545214792, null, 111);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (13, 'Brianna', 'Miller', to_date('21-10-2021', 'dd-mm-yyyy'), null, 'Elena Miller', 596031271, null, 112);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (14, 'Leonardo', 'Campbell', to_date('29-12-2020', 'dd-mm-yyyy'), null, 'Charlotte Campbell', 531389515, null, 113);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (15, 'Ava', 'Wilson', to_date('03-12-2018', 'dd-mm-yyyy'), 'Dairy', 'Juan Wilson', 545262964, null, 114);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (16, 'Eva', 'Clark', to_date('26-04-2020', 'dd-mm-yyyy'), 'Gluten', 'Dustin Clark', 524562705, null, 115);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (17, 'Ezekiel', 'Carter', to_date('27-03-2020', 'dd-mm-yyyy'), 'Dairy', 'Juan Carter', 585414418, null, 116);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (18, 'Autumn', 'Walker', to_date('17-04-2018', 'dd-mm-yyyy'), null, 'Adalyn Walker', 537264958, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (19, 'Olivia', 'Johnson', to_date('25-03-2022', 'dd-mm-yyyy'), null, 'Felipe Johnson', 536018837, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (20, 'Alexandra', 'Thompson', to_date('07-02-2021', 'dd-mm-yyyy'), 'Gluten', 'Douglas Thompson', 594226641, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (21, 'Daniel', 'Walker', to_date('29-09-2018', 'dd-mm-yyyy'), null, 'Gregory Walker', 539049290, null, 120);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (22, 'Lucy', 'Rodriguez', to_date('03-04-2023', 'dd-mm-yyyy'), null, 'Allison Rodriguez', 569980433, null, 121);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (23, 'Luna', 'Hernandez', to_date('07-05-2022', 'dd-mm-yyyy'), 'Dairy', 'Callie Hernandez', 529556355, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (24, 'Amelia', 'Carter', to_date('17-08-2023', 'dd-mm-yyyy'), null, 'Nathan Carter', 565330607, null, 123);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (25, 'Serenity', 'Robinson', to_date('25-12-2020', 'dd-mm-yyyy'), 'Peanuts', 'Madilyn Robinson', 561405746, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (26, 'Naomi', 'Clark', to_date('14-05-2018', 'dd-mm-yyyy'), null, 'Cora Clark', 565628708, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (27, 'Mia', 'Nelson', to_date('30-11-2021', 'dd-mm-yyyy'), 'Peanuts', 'Daisy Nelson', 546208389, null, 126);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (28, 'Rylee', 'Scott', to_date('01-09-2023', 'dd-mm-yyyy'), null, 'Emma Scott', 584067767, null, 127);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (29, 'Andrea', 'Anderson', to_date('13-02-2018', 'dd-mm-yyyy'), null, 'Nora Anderson', 513023771, null, 128);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (30, 'Jack', 'Scott', to_date('22-12-2021', 'dd-mm-yyyy'), 'Dairy', 'Joan Scott', 512708817, null, 129);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (31, 'Leilani', 'Rogers', to_date('07-12-2019', 'dd-mm-yyyy'), 'Dairy', 'Dustin Rogers', 510690950, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (32, 'Alexis', 'Cruz', to_date('03-08-2020', 'dd-mm-yyyy'), null, 'Adeline Cruz', 590769216, null, 131);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (33, 'Nora', 'Nguyen', to_date('26-03-2023', 'dd-mm-yyyy'), null, 'Isabelle Nguyen', 540231576, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (34, 'Avery', 'Rodriguez', to_date('23-06-2021', 'dd-mm-yyyy'), null, 'Samantha Rodriguez', 560032805, null, 133);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (35, 'Antonio', 'Clark', to_date('06-02-2019', 'dd-mm-yyyy'), 'Gluten', 'Vivienne Clark', 560907331, null, 134);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (36, 'Jordan', 'Campbell', to_date('15-01-2021', 'dd-mm-yyyy'), null, 'Callie Campbell', 543464520, null, 135);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (37, 'Samantha', 'Allen', to_date('22-02-2019', 'dd-mm-yyyy'), 'Gluten', 'Andrea Allen', 598205958, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (38, 'Brian', 'Carter', to_date('21-04-2021', 'dd-mm-yyyy'), 'Dairy', 'Peyton Carter', 549650000, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (39, 'Harper', 'Hall', to_date('22-01-2019', 'dd-mm-yyyy'), 'Dairy', 'Paisley Hall', 598347962, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (40, 'Nathan', 'Harris', to_date('07-11-2023', 'dd-mm-yyyy'), 'Peanuts', 'Teagan Harris', 548123208, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (41, 'Henry', 'Allen', to_date('12-08-2021', 'dd-mm-yyyy'), 'Gluten', 'Gracie Allen', 512571173, null, 140);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (42, 'Keira', 'Kim', to_date('28-06-2022', 'dd-mm-yyyy'), 'Gluten', 'Isabelle Kim', 533854435, null, 141);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (43, 'Juan', 'Scott', to_date('21-12-2018', 'dd-mm-yyyy'), 'Gluten', 'Addison Scott', 562529742, null, 142);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (44, 'Emery', 'Wright', to_date('30-03-2018', 'dd-mm-yyyy'), 'Gluten', 'Andrew Wright', 513899954, null, 143);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (45, 'Joshua', 'Hall', to_date('02-08-2019', 'dd-mm-yyyy'), 'Gluten', 'Molly Hall', 560859403, null, 144);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (46, 'Jayden', 'Anderson', to_date('16-08-2019', 'dd-mm-yyyy'), 'Dairy', 'Gabriel Anderson', 599558177, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (47, 'Isabelle', 'Moore', to_date('01-02-2019', 'dd-mm-yyyy'), 'Dairy', 'Jack Moore', 537224781, null, 146);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (48, 'Aurora', 'Walker', to_date('11-05-2022', 'dd-mm-yyyy'), 'Peanuts', 'Sadie Walker', 586474668, null, 147);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (49, 'Adeline', 'Kim', to_date('11-11-2023', 'dd-mm-yyyy'), 'Gluten', 'Isabelle Kim', 564328212, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (50, 'Adalyn', 'Brown', to_date('15-06-2020', 'dd-mm-yyyy'), 'Dairy', 'Adeline Brown', 552273227, null, 149);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (51, 'Melanie', 'Thomas', to_date('23-06-2020', 'dd-mm-yyyy'), 'Peanuts', 'Natalie Thomas', 577515662, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (52, 'Isabelle', 'Mitchell', to_date('24-05-2023', 'dd-mm-yyyy'), 'Peanuts', 'Dylan Mitchell', 565490836, null, 151);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (53, 'Alexis', 'Miller', to_date('06-11-2023', 'dd-mm-yyyy'), null, 'Piper Miller', 590171539, null, 152);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (54, 'Vivienne', 'Hernandez', to_date('15-03-2023', 'dd-mm-yyyy'), null, 'Lydia Hernandez', 529003172, null, 153);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (55, 'Riley', 'Allen', to_date('20-04-2023', 'dd-mm-yyyy'), 'Peanuts', 'Aria Allen', 555764266, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (56, 'Mackenzie', 'Hernandez', to_date('18-02-2022', 'dd-mm-yyyy'), null, 'Antonio Hernandez', 584316069, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (57, 'Luke', 'Clark', to_date('04-07-2018', 'dd-mm-yyyy'), 'Dairy', 'Gabriel Clark', 574352333, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (58, 'Juliet', 'Garcia', to_date('05-02-2021', 'dd-mm-yyyy'), 'Gluten', 'Christopher Garcia', 549520620, null, 157);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (59, 'Amelia', 'Wright', to_date('15-04-2021', 'dd-mm-yyyy'), 'Peanuts', 'Maya Wright', 560491684, null, 158);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (60, 'Molly', 'Adams', to_date('17-07-2020', 'dd-mm-yyyy'), 'Gluten', 'Chloe Adams', 524885320, null, 159);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (61, 'Alice', 'Robinson', to_date('26-04-2022', 'dd-mm-yyyy'), null, 'Ivy Robinson', 562515890, null, 160);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (62, 'Teagan', 'Allen', to_date('26-04-2018', 'dd-mm-yyyy'), 'Gluten', 'Aaliyah Allen', 518300471, null, 161);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (63, 'Eliana', 'Clark', to_date('18-09-2019', 'dd-mm-yyyy'), 'Dairy', 'Lillian Clark', 540737888, null, 162);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (64, 'Ivy', 'Moore', to_date('14-03-2023', 'dd-mm-yyyy'), null, 'Isaiah Moore', 565196838, null, 163);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (65, 'Ruby', 'Walker', to_date('13-02-2018', 'dd-mm-yyyy'), 'Gluten', 'Derek Walker', 558605350, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (66, 'Claire', 'Robinson', to_date('28-02-2019', 'dd-mm-yyyy'), null, 'Juan Robinson', 553821900, null, 165);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (67, 'Addison', 'Garcia', to_date('29-05-2022', 'dd-mm-yyyy'), 'Peanuts', 'Lucy Garcia', 555337890, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (68, 'Amelia', 'Adams', to_date('17-10-2019', 'dd-mm-yyyy'), 'Dairy', 'Jayden Adams', 561829258, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (69, 'Luke', 'Thomas', to_date('01-01-2020', 'dd-mm-yyyy'), 'Dairy', 'Allison Thomas', 592711488, null, 168);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (70, 'Diego', 'Wilson', to_date('10-08-2018', 'dd-mm-yyyy'), 'Dairy', 'Joshua Wilson', 520971921, null, 169);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (71, 'Austin', 'Scott', to_date('10-02-2018', 'dd-mm-yyyy'), 'Dairy', 'Riley Scott', 517315934, null, 170);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (72, 'Abraham', 'Thompson', to_date('13-04-2020', 'dd-mm-yyyy'), 'Gluten', 'Alaina Thompson', 516638606, null, 171);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (73, 'Adalyn', 'Phillips', to_date('06-01-2023', 'dd-mm-yyyy'), null, 'Gabriel Phillips', 536133010, null, 172);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (74, 'Scarlett', 'Young', to_date('08-04-2020', 'dd-mm-yyyy'), null, 'Hazel Young', 588523956, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (75, 'Gabriel', 'Scott', to_date('17-05-2020', 'dd-mm-yyyy'), null, 'Natalia Scott', 557488948, null, 174);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (76, 'Allison', 'Jones', to_date('08-06-2021', 'dd-mm-yyyy'), 'Gluten', 'Emery Jones', 567655148, null, 175);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (77, 'Ava', 'Rodriguez', to_date('02-06-2022', 'dd-mm-yyyy'), null, 'Mia Rodriguez', 562033122, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (78, 'Henry', 'Clark', to_date('03-10-2018', 'dd-mm-yyyy'), 'Dairy', 'Harper Clark', 590485288, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (79, 'Javier', 'Young', to_date('03-09-2022', 'dd-mm-yyyy'), null, 'Alice Young', 534656300, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (80, 'Lawrence', 'Rogers', to_date('07-05-2019', 'dd-mm-yyyy'), null, 'Eliana Rogers', 527334370, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (81, 'Evelyn', 'Clark', to_date('09-08-2018', 'dd-mm-yyyy'), null, 'Leonardo Clark', 553870768, null, 180);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (82, 'Ariana', 'Scott', to_date('23-03-2022', 'dd-mm-yyyy'), 'Peanuts', 'Edward Scott', 517985037, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (83, 'Aurora', 'Taylor', to_date('25-05-2023', 'dd-mm-yyyy'), 'Peanuts', 'Serenity Taylor', 586920851, null, 182);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (84, 'Joshua', 'Wilson', to_date('19-03-2023', 'dd-mm-yyyy'), 'Gluten', 'Eliza Wilson', 527869846, null, 183);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (85, 'Olivia', 'Hernandez', to_date('30-05-2020', 'dd-mm-yyyy'), 'Gluten', 'Charlotte Hernandez', 529146047, null, 184);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (86, 'Josephine', 'Nelson', to_date('11-01-2019', 'dd-mm-yyyy'), null, 'Penelope Nelson', 594548438, null, 185);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (87, 'Rose', 'Hernandez', to_date('18-04-2022', 'dd-mm-yyyy'), 'Dairy', 'Isabella Hernandez', 557636365, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (88, 'Cora', 'Walker', to_date('12-12-2021', 'dd-mm-yyyy'), null, 'Dennis Walker', 582480874, null, 187);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (89, 'Diego', 'Rogers', to_date('23-08-2021', 'dd-mm-yyyy'), null, 'Madison Rogers', 578274445, null, 188);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (90, 'Harper', 'Harris', to_date('12-11-2022', 'dd-mm-yyyy'), null, 'Kevin Harris', 592280631, null, 189);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (91, 'Kaitlyn', 'Hernandez', to_date('11-06-2023', 'dd-mm-yyyy'), null, 'Clara Hernandez', 599957387, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (92, 'Luna', 'Miller', to_date('19-07-2023', 'dd-mm-yyyy'), 'Dairy', 'Alexis Miller', 547501127, null, 191);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (93, 'Leonardo', 'Hernandez', to_date('24-02-2023', 'dd-mm-yyyy'), 'Peanuts', 'Chloe Hernandez', 590995731, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (94, 'Aurora', 'Allen', to_date('03-06-2018', 'dd-mm-yyyy'), 'Gluten', 'Jacob Allen', 523992563, null, 193);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (95, 'Eric', 'Walker', to_date('03-07-2019', 'dd-mm-yyyy'), 'Peanuts', 'Nathan Walker', 591846409, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (96, 'Lucy', 'Smith', to_date('07-07-2022', 'dd-mm-yyyy'), 'Peanuts', 'Dennis Smith', 567261881, null, 195);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (97, 'Adalyn', 'Garcia', to_date('10-01-2023', 'dd-mm-yyyy'), 'Peanuts', 'Jade Garcia', 520489344, null, 196);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (98, 'Lillian', 'Hernandez', to_date('12-12-2018', 'dd-mm-yyyy'), 'Dairy', 'Austin Hernandez', 582262945, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (99, 'Kyle', 'Hernandez', to_date('24-08-2021', 'dd-mm-yyyy'), 'Gluten', 'Brian Hernandez', 586344651, null, 198);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (100, 'Daisy', 'Rogers', to_date('29-10-2020', 'dd-mm-yyyy'), 'Peanuts', 'Sarah Rogers', 511357835, null, 199);
commit;
prompt 100 records committed...
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (101, 'Dustin', 'Lewis', to_date('02-07-2018', 'dd-mm-yyyy'), 'Dairy', 'Lucas Lewis', 542052286, null, 200);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (102, 'Leilani', 'Davis', to_date('05-10-2019', 'dd-mm-yyyy'), null, 'Anthony Davis', 596566574, null, 201);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (103, 'Amaya', 'Sanchez', to_date('13-01-2019', 'dd-mm-yyyy'), 'Dairy', 'Teagan Sanchez', 539091978, null, 202);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (104, 'Caroline', 'Lee', to_date('01-01-2023', 'dd-mm-yyyy'), 'Gluten', 'Alice Lee', 566988890, null, 203);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (105, 'Callie', 'Nelson', to_date('17-12-2019', 'dd-mm-yyyy'), null, 'Adeline Nelson', 590632990, null, 204);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (106, 'Lila', 'Lopez', to_date('17-05-2021', 'dd-mm-yyyy'), 'Gluten', 'Elena Lopez', 584024462, null, 205);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (107, 'Nicole', 'Hernandez', to_date('28-10-2018', 'dd-mm-yyyy'), 'Gluten', 'Eloise Hernandez', 574392735, null, 206);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (108, 'Zoey', 'Rogers', to_date('20-01-2018', 'dd-mm-yyyy'), 'Peanuts', 'Lila Rogers', 566413855, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (109, 'Zoey', 'Jones', to_date('19-10-2021', 'dd-mm-yyyy'), 'Peanuts', 'Brooklyn Jones', 544078891, null, 208);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (110, 'Grace', 'Moore', to_date('21-01-2022', 'dd-mm-yyyy'), null, 'Felipe Moore', 559722260, null, 209);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (111, 'Carlos', 'Adams', to_date('13-12-2023', 'dd-mm-yyyy'), 'Dairy', 'Maya Adams', 515893255, null, 210);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (112, 'Eloise', 'Davis', to_date('18-12-2023', 'dd-mm-yyyy'), 'Dairy', 'Eva Davis', 515084382, null, 211);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (113, 'Chloe', 'Anderson', to_date('01-07-2021', 'dd-mm-yyyy'), 'Peanuts', 'Lillian Anderson', 535973306, null, 212);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (114, 'Jayden', 'Walker', to_date('31-03-2023', 'dd-mm-yyyy'), null, 'Cora Walker', 590404617, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (115, 'Vivian', 'Rogers', to_date('17-06-2018', 'dd-mm-yyyy'), 'Dairy', 'Taylor Rogers', 590337353, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (116, 'Ellie', 'Scott', to_date('22-07-2022', 'dd-mm-yyyy'), null, 'Grace Scott', 534261828, null, 215);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (117, 'Keira', 'Jones', to_date('21-11-2022', 'dd-mm-yyyy'), 'Dairy', 'Clara Jones', 592709469, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (118, 'Jayden', 'Young', to_date('02-04-2022', 'dd-mm-yyyy'), 'Gluten', 'Clara Young', 538885685, null, 217);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (119, 'Skylar', 'Moore', to_date('08-02-2020', 'dd-mm-yyyy'), 'Dairy', 'Joseph Moore', 582716826, null, 218);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (120, 'John', 'Johnson', to_date('09-05-2023', 'dd-mm-yyyy'), 'Dairy', 'Henry Johnson', 518122540, null, 219);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (121, 'Samantha', 'Miller', to_date('26-03-2021', 'dd-mm-yyyy'), 'Gluten', 'Kaitlyn Miller', 555740243, null, 220);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (122, 'Vivian', 'Nelson', to_date('15-02-2022', 'dd-mm-yyyy'), 'Peanuts', 'Ezekiel Nelson', 575527737, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (123, 'Autumn', 'Cruz', to_date('28-09-2022', 'dd-mm-yyyy'), null, 'Isaac Cruz', 517823424, null, 222);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (124, 'Serenity', 'Green', to_date('12-03-2021', 'dd-mm-yyyy'), null, 'Paisley Green', 562651693, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (125, 'Delilah', 'Young', to_date('06-01-2023', 'dd-mm-yyyy'), 'Gluten', 'Everly Young', 547664211, null, 224);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (126, 'Sadie', 'Rogers', to_date('18-04-2020', 'dd-mm-yyyy'), null, 'Ivy Rogers', 582144323, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (127, 'Everly', 'Garcia', to_date('02-09-2019', 'dd-mm-yyyy'), 'Dairy', 'Justin Garcia', 561409207, null, 226);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (128, 'Juliet', 'Allen', to_date('24-01-2021', 'dd-mm-yyyy'), 'Peanuts', 'Justin Allen', 574966456, null, 227);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (129, 'Luna', 'Wright', to_date('05-06-2022', 'dd-mm-yyyy'), 'Peanuts', 'Keira Wright', 577263236, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (130, 'Valentina', 'Watson', to_date('24-08-2022', 'dd-mm-yyyy'), 'Gluten', 'Abigail Watson', 532191280, null, 229);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (131, 'Madeline', 'Davis', to_date('25-02-2018', 'dd-mm-yyyy'), null, 'Eric Davis', 510383295, null, 230);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (132, 'Jacob', 'Diaz', to_date('11-06-2019', 'dd-mm-yyyy'), null, 'Mackenzie Diaz', 557010880, null, 231);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (133, 'Valentina', 'Watson', to_date('03-05-2023', 'dd-mm-yyyy'), 'Peanuts', 'Ella Watson', 579648817, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (134, 'Ava', 'Lopez', to_date('26-04-2022', 'dd-mm-yyyy'), null, 'Javier Lopez', 541035924, null, 233);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (135, 'Valentina', 'Campbell', to_date('16-09-2021', 'dd-mm-yyyy'), 'Peanuts', 'Isla Campbell', 567119206, null, 234);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (136, 'Joseph', 'Robinson', to_date('08-02-2022', 'dd-mm-yyyy'), 'Peanuts', 'Vivienne Robinson', 519654379, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (137, 'Justin', 'Campbell', to_date('03-05-2020', 'dd-mm-yyyy'), 'Dairy', 'Taylor Campbell', 535206449, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (138, 'Jayden', 'Nelson', to_date('04-11-2022', 'dd-mm-yyyy'), 'Dairy', 'Nicole Nelson', 559206635, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (139, 'Ruby', 'Hernandez', to_date('28-04-2020', 'dd-mm-yyyy'), null, 'Josephine Hernandez', 557083711, null, 238);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (140, 'Eliana', 'Allen', to_date('03-07-2020', 'dd-mm-yyyy'), null, 'Ethan Allen', 595595574, null, 239);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (141, 'Alyssa', 'Evans', to_date('28-02-2021', 'dd-mm-yyyy'), 'Dairy', 'Edward Evans', 522031324, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (142, 'Caroline', 'Lewis', to_date('13-07-2023', 'dd-mm-yyyy'), 'Dairy', 'Cole Lewis', 511685028, null, 241);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (143, 'Eva', 'Garcia', to_date('17-11-2021', 'dd-mm-yyyy'), 'Gluten', 'Brandon Garcia', 552800683, null, 242);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (144, 'Alexis', 'Lewis', to_date('22-06-2021', 'dd-mm-yyyy'), null, 'Josephine Lewis', 539176965, null, 243);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (145, 'Claire', 'Campbell', to_date('20-08-2021', 'dd-mm-yyyy'), 'Gluten', 'Ezekiel Campbell', 550252300, null, 244);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (146, 'Serenity', 'Mitchell', to_date('29-04-2020', 'dd-mm-yyyy'), null, 'Lucy Mitchell', 551982965, null, 245);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (147, 'Amaya', 'Young', to_date('07-12-2021', 'dd-mm-yyyy'), 'Peanuts', 'Adalyn Young', 519961217, null, 246);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (148, 'Madeline', 'Brown', to_date('08-07-2020', 'dd-mm-yyyy'), 'Dairy', 'Madison Brown', 554807251, null, 247);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (149, 'Everly', 'Diaz', to_date('06-05-2021', 'dd-mm-yyyy'), null, 'Scarlett Diaz', 586326229, null, 248);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (150, 'Addison', 'Allen', to_date('07-01-2020', 'dd-mm-yyyy'), null, 'David Allen', 550727962, null, 249);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (151, 'Aaliyah', 'Miller', to_date('01-01-2018', 'dd-mm-yyyy'), 'Dairy', 'Grace Miller', 542247393, null, 250);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (152, 'Rylee', 'Thomas', to_date('21-12-2021', 'dd-mm-yyyy'), null, 'Sophie Thomas', 548870108, null, 251);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (153, 'Isaac', 'Robinson', to_date('15-08-2020', 'dd-mm-yyyy'), 'Gluten', 'Everly Robinson', 577193168, null, 252);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (154, 'Arabella', 'Robinson', to_date('14-04-2019', 'dd-mm-yyyy'), null, 'Alyssa Robinson', 571889772, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (155, 'Rose', 'Taylor', to_date('23-05-2023', 'dd-mm-yyyy'), null, 'Kyle Taylor', 517282462, null, 254);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (156, 'Andrea', 'Johnson', to_date('22-11-2021', 'dd-mm-yyyy'), 'Gluten', 'Cora Johnson', 589969056, null, 255);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (157, 'Naomi', 'Hernandez', to_date('29-11-2018', 'dd-mm-yyyy'), 'Gluten', 'Eliza Hernandez', 596811489, null, 256);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (158, 'Emery', 'Robinson', to_date('01-02-2022', 'dd-mm-yyyy'), null, 'Chloe Robinson', 582816652, null, 257);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (159, 'Mila', 'Sanchez', to_date('29-08-2018', 'dd-mm-yyyy'), null, 'Piper Sanchez', 553868356, null, 258);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (160, 'Aaliyah', 'Sanchez', to_date('17-03-2020', 'dd-mm-yyyy'), null, 'Sloane Sanchez', 524648281, null, 259);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (161, 'Antonio', 'Lewis', to_date('02-06-2019', 'dd-mm-yyyy'), null, 'Amelia Lewis', 588099850, null, 260);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (162, 'Delilah', 'Johnson', to_date('16-09-2022', 'dd-mm-yyyy'), null, 'Piper Johnson', 562222759, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (163, 'Kaitlyn', 'Nguyen', to_date('17-06-2018', 'dd-mm-yyyy'), 'Gluten', 'Aurora Nguyen', 514438751, null, 262);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (164, 'David', 'Jones', to_date('03-05-2018', 'dd-mm-yyyy'), 'Dairy', 'Isabelle Jones', 552938437, null, 263);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (165, 'Rose', 'Hernandez', to_date('30-10-2021', 'dd-mm-yyyy'), 'Dairy', 'Hope Hernandez', 597009499, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (166, 'Madelyn', 'Allen', to_date('05-08-2021', 'dd-mm-yyyy'), null, 'Lola Allen', 570748233, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (167, 'Paisley', 'Rogers', to_date('24-02-2018', 'dd-mm-yyyy'), null, 'Scarlett Rogers', 598457872, null, 266);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (168, 'Callie', 'Campbell', to_date('19-06-2019', 'dd-mm-yyyy'), 'Gluten', 'Natalie Campbell', 566638853, null, 267);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (169, 'Sarah', 'Moore', to_date('28-03-2022', 'dd-mm-yyyy'), null, 'Valentina Moore', 540375882, null, 268);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (170, 'Ella', 'Clark', to_date('30-10-2021', 'dd-mm-yyyy'), 'Peanuts', 'Olivia Clark', 572519572, null, 269);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (171, 'Claire', 'Lewis', to_date('03-04-2023', 'dd-mm-yyyy'), null, 'Brandon Lewis', 589694966, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (172, 'Gracie', 'Mitchell', to_date('25-04-2019', 'dd-mm-yyyy'), 'Dairy', 'Quinn Mitchell', 513184783, null, 271);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (173, 'Lillian', 'Hall', to_date('28-02-2020', 'dd-mm-yyyy'), null, 'Autumn Hall', 549043349, null, 272);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (174, 'Nicole', 'Garcia', to_date('14-07-2018', 'dd-mm-yyyy'), 'Dairy', 'Adeline Garcia', 550111833, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (175, 'George', 'Hernandez', to_date('21-11-2022', 'dd-mm-yyyy'), null, 'Charlotte Hernandez', 548652440, null, 274);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (176, 'Lola', 'Moore', to_date('10-10-2020', 'dd-mm-yyyy'), 'Dairy', 'Harper Moore', 582355503, null, 275);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (177, 'Ariana', 'Roberts', to_date('23-11-2022', 'dd-mm-yyyy'), 'Dairy', 'Gabriel Roberts', 540311238, null, 276);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (178, 'Genevieve', 'Rogers', to_date('13-03-2020', 'dd-mm-yyyy'), null, 'Caleb Rogers', 580471597, null, 277);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (179, 'Vivian', 'Nguyen', to_date('22-10-2021', 'dd-mm-yyyy'), 'Peanuts', 'Nathan Nguyen', 573938837, null, 278);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (180, 'Sophie', 'Davis', to_date('02-01-2021', 'dd-mm-yyyy'), 'Peanuts', 'Caleb Davis', 594633382, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (181, 'Jasmine', 'Wilson', to_date('11-03-2018', 'dd-mm-yyyy'), null, 'Claire Wilson', 533350500, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (182, 'Alice', 'Rogers', to_date('15-09-2023', 'dd-mm-yyyy'), 'Dairy', 'Caleb Rogers', 584989537, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (183, 'Alice', 'Ramirez', to_date('25-03-2021', 'dd-mm-yyyy'), null, 'Lily Ramirez', 553718172, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (184, 'Juliet', 'Hernandez', to_date('01-02-2021', 'dd-mm-yyyy'), 'Dairy', 'Quinn Hernandez', 520191602, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (185, 'Joshua', 'Campbell', to_date('24-07-2020', 'dd-mm-yyyy'), null, 'Charlotte Campbell', 585686586, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (186, 'Luna', 'Jones', to_date('24-11-2023', 'dd-mm-yyyy'), 'Dairy', 'Reagan Jones', 571029455, null, 285);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (187, 'Chloe', 'Campbell', to_date('02-12-2022', 'dd-mm-yyyy'), 'Gluten', 'Peyton Campbell', 522172435, null, 286);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (188, 'Adalyn', 'Walker', to_date('28-09-2020', 'dd-mm-yyyy'), null, 'Addison Walker', 536491070, null, 287);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (189, 'David', 'Martinez', to_date('18-05-2020', 'dd-mm-yyyy'), 'Gluten', 'Adrian Martinez', 543931725, null, 288);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (190, 'Chloe', 'Moore', to_date('14-10-2023', 'dd-mm-yyyy'), 'Gluten', 'Lillian Moore', 521115014, null, 289);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (191, 'Cole', 'Kim', to_date('02-04-2020', 'dd-mm-yyyy'), null, 'Brandon Kim', 543493359, null, 290);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (192, 'Brielle', 'Anderson', to_date('27-04-2021', 'dd-mm-yyyy'), 'Gluten', 'Amelia Anderson', 536222394, null, 291);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (193, 'Leah', 'Nelson', to_date('25-09-2023', 'dd-mm-yyyy'), 'Peanuts', 'Isabella Nelson', 544021005, null, 292);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (194, 'Emery', 'Rogers', to_date('01-04-2020', 'dd-mm-yyyy'), 'Peanuts', 'Bella Rogers', 550657017, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (195, 'Miguel', 'Allen', to_date('19-08-2021', 'dd-mm-yyyy'), 'Dairy', 'Dylan Allen', 521764740, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (196, 'Leonardo', 'Brown', to_date('12-10-2023', 'dd-mm-yyyy'), 'Gluten', 'Gracie Brown', 560180520, null, 295);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (197, 'Adam', 'Rogers', to_date('22-11-2023', 'dd-mm-yyyy'), 'Peanuts', 'Lawrence Rogers', 549884169, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (198, 'Diego', 'Nguyen', to_date('28-04-2023', 'dd-mm-yyyy'), 'Gluten', 'Emery Nguyen', 565632963, null, 297);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (199, 'John', 'Watson', to_date('01-07-2018', 'dd-mm-yyyy'), 'Peanuts', 'Lucas Watson', 592973176, null, 298);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (200, 'Brian', 'Cruz', to_date('08-07-2023', 'dd-mm-yyyy'), 'Gluten', 'Caroline Cruz', 527677051, null, 299);
commit;
prompt 200 records committed...
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (201, 'Autumn', 'Evans', to_date('18-03-2023', 'dd-mm-yyyy'), null, 'Lila Evans', 594186487, null, 300);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (202, 'Miguel', 'Campbell', to_date('29-09-2023', 'dd-mm-yyyy'), 'Dairy', 'Emilia Campbell', 579738087, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (203, 'Olivia', 'Watson', to_date('19-08-2022', 'dd-mm-yyyy'), 'Dairy', 'Bella Watson', 592270731, null, 302);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (204, 'Adrian', 'Hernandez', to_date('02-06-2023', 'dd-mm-yyyy'), 'Dairy', 'Rosalie Hernandez', 580107527, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (205, 'Ellie', 'Garcia', to_date('01-06-2022', 'dd-mm-yyyy'), 'Peanuts', 'Nathan Garcia', 553331266, null, 304);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (206, 'Juliet', 'Thomas', to_date('02-01-2019', 'dd-mm-yyyy'), 'Peanuts', 'Penelope Thomas', 566498130, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (207, 'Justin', 'Lee', to_date('20-06-2018', 'dd-mm-yyyy'), null, 'Douglas Lee', 574821944, null, 306);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (208, 'Molly', 'Moore', to_date('20-05-2018', 'dd-mm-yyyy'), null, 'Brian Moore', 574917352, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (209, 'Ruby', 'Harris', to_date('11-12-2021', 'dd-mm-yyyy'), 'Gluten', 'Lucas Harris', 598930873, null, 308);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (210, 'Elena', 'Allen', to_date('28-09-2022', 'dd-mm-yyyy'), null, 'Claire Allen', 542065490, null, 309);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (211, 'Keira', 'Sanchez', to_date('04-09-2022', 'dd-mm-yyyy'), 'Dairy', 'Antonio Sanchez', 528140566, null, 310);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (212, 'Luke', 'Nguyen', to_date('23-04-2022', 'dd-mm-yyyy'), 'Gluten', 'Madeline Nguyen', 547462633, null, 311);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (213, 'Adalyn', 'Walker', to_date('22-05-2021', 'dd-mm-yyyy'), null, 'Josephine Walker', 553969988, null, 312);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (214, 'Eliana', 'Clark', to_date('16-04-2021', 'dd-mm-yyyy'), 'Gluten', 'Gabriella Clark', 588733279, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (215, 'Emilia', 'Allen', to_date('26-11-2021', 'dd-mm-yyyy'), null, 'Albert Allen', 527818412, null, 314);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (216, 'Willow', 'Young', to_date('11-09-2022', 'dd-mm-yyyy'), null, 'Sophie Young', 513483423, null, 315);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (217, 'Javier', 'Roy', to_date('26-09-2020', 'dd-mm-yyyy'), 'Dairy', 'Daniel Roy', 565990827, null, 316);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (218, 'Brianna', 'Diaz', to_date('18-12-2020', 'dd-mm-yyyy'), 'Dairy', 'Leilani Diaz', 586182802, null, 317);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (219, 'Dennis', 'Lewis', to_date('05-11-2022', 'dd-mm-yyyy'), null, 'Lily Lewis', 545227182, null, 318);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (220, 'Natalie', 'Moore', to_date('18-09-2022', 'dd-mm-yyyy'), 'Dairy', 'Kaitlyn Moore', 597057673, null, 319);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (221, 'Ivy', 'Miller', to_date('11-02-2019', 'dd-mm-yyyy'), 'Peanuts', 'Harold Miller', 577608301, null, 320);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (222, 'Mackenzie', 'Young', to_date('14-05-2022', 'dd-mm-yyyy'), null, 'Rosalie Young', 545203523, null, 321);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (223, 'Jonathan', 'Hernandez', to_date('15-04-2022', 'dd-mm-yyyy'), null, 'Elena Hernandez', 534897789, null, 322);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (224, 'Aria', 'Campbell', to_date('04-03-2020', 'dd-mm-yyyy'), null, 'Aurora Campbell', 519873300, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (225, 'Mackenzie', 'Walker', to_date('09-05-2021', 'dd-mm-yyyy'), 'Gluten', 'Chloe Walker', 514074744, null, 324);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (226, 'Genevieve', 'Robinson', to_date('11-03-2018', 'dd-mm-yyyy'), 'Gluten', 'Ezekiel Robinson', 527310445, null, 325);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (227, 'Carlos', 'Robinson', to_date('16-07-2019', 'dd-mm-yyyy'), 'Gluten', 'Makenna Robinson', 565617958, null, 326);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (228, 'Millie', 'Williams', to_date('23-05-2023', 'dd-mm-yyyy'), 'Dairy', 'Maya Williams', 515153842, null, 327);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (229, 'Alice', 'Walker', to_date('21-09-2023', 'dd-mm-yyyy'), 'Peanuts', 'Mila Walker', 554318993, null, 328);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (230, 'Avery', 'Johnson', to_date('04-06-2023', 'dd-mm-yyyy'), 'Gluten', 'Bella Johnson', 587865739, null, 329);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (231, 'Piper', 'Hernandez', to_date('18-12-2021', 'dd-mm-yyyy'), null, 'Lola Hernandez', 583054162, null, 330);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (232, 'Sloane', 'Campbell', to_date('21-09-2018', 'dd-mm-yyyy'), 'Gluten', 'Leilani Campbell', 530019130, null, 331);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (233, 'Violet', 'Scott', to_date('14-05-2020', 'dd-mm-yyyy'), null, 'Madilyn Scott', 566601524, null, 332);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (234, 'Adrian', 'Hernandez', to_date('05-08-2023', 'dd-mm-yyyy'), 'Peanuts', 'Cameron Hernandez', 570085654, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (235, 'Teagan', 'Lewis', to_date('05-01-2018', 'dd-mm-yyyy'), 'Dairy', 'Valentina Lewis', 596801959, null, 334);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (236, 'Gracie', 'Scott', to_date('30-08-2018', 'dd-mm-yyyy'), null, 'Isaiah Scott', 582724410, null, 335);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (237, 'Aaliyah', 'Moore', to_date('19-01-2023', 'dd-mm-yyyy'), 'Peanuts', 'Alice Moore', 574301277, null, 336);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (238, 'Bailey', 'Martinez', to_date('04-08-2019', 'dd-mm-yyyy'), 'Gluten', 'Amelia Martinez', 578595711, null, 337);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (239, 'Josephine', 'Rodriguez', to_date('07-11-2021', 'dd-mm-yyyy'), 'Peanuts', 'Sadie Rodriguez', 592805661, null, 338);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (240, 'George', 'Robinson', to_date('17-02-2022', 'dd-mm-yyyy'), null, 'Henry Robinson', 595917890, null, 339);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (241, 'Lillian', 'Hernandez', to_date('06-06-2022', 'dd-mm-yyyy'), 'Peanuts', 'Eloise Hernandez', 586453604, null, 340);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (242, 'David', 'Lewis', to_date('26-09-2018', 'dd-mm-yyyy'), 'Peanuts', 'George Lewis', 525399546, null, 341);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (243, 'Cameron', 'Walker', to_date('18-08-2022', 'dd-mm-yyyy'), null, 'Layla Walker', 573589985, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (244, 'Isla', 'Allen', to_date('07-03-2020', 'dd-mm-yyyy'), 'Peanuts', 'Jayden Allen', 554070821, null, 343);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (245, 'Serenity', 'Lopez', to_date('06-06-2019', 'dd-mm-yyyy'), 'Gluten', 'Nora Lopez', 548919814, null, 344);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (246, 'Skylar', 'Wilson', to_date('14-07-2023', 'dd-mm-yyyy'), 'Gluten', 'Arabella Wilson', 560337842, null, 345);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (247, 'Grace', 'Lee', to_date('15-02-2018', 'dd-mm-yyyy'), 'Gluten', 'Ariana Lee', 599539404, null, 346);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (248, 'Jonathan', 'Hernandez', to_date('04-03-2021', 'dd-mm-yyyy'), null, 'Albert Hernandez', 594443739, null, 347);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (249, 'Brianna', 'Nguyen', to_date('09-01-2023', 'dd-mm-yyyy'), null, 'Allison Nguyen', 518532960, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (250, 'Ava', 'Phillips', to_date('16-10-2019', 'dd-mm-yyyy'), null, 'Harold Phillips', 556910314, null, 349);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (251, 'Joan', 'Adams', to_date('24-06-2022', 'dd-mm-yyyy'), null, 'Sloane Adams', 578813040, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (252, 'Madilyn', 'Moore', to_date('07-12-2019', 'dd-mm-yyyy'), 'Peanuts', 'Douglas Moore', 598043541, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (253, 'Bailey', 'Mitchell', to_date('03-04-2023', 'dd-mm-yyyy'), 'Dairy', 'Andrew Mitchell', 556542361, null, 352);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (254, 'Leilani', 'Mitchell', to_date('03-11-2018', 'dd-mm-yyyy'), null, 'Emilia Mitchell', 532976801, null, 353);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (255, 'Bailey', 'Williams', to_date('08-09-2019', 'dd-mm-yyyy'), null, 'Nicole Williams', 561829909, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (256, 'Javier', 'Robinson', to_date('04-02-2020', 'dd-mm-yyyy'), 'Gluten', 'Austin Robinson', 582704326, null, 355);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (257, 'Cody', 'Wilson', to_date('11-01-2018', 'dd-mm-yyyy'), null, 'Mia Wilson', 517882756, null, 356);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (258, 'Lydia', 'Lopez', to_date('19-12-2019', 'dd-mm-yyyy'), null, 'Peyton Lopez', 594109782, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (259, 'Kinsley', 'Clark', to_date('19-04-2020', 'dd-mm-yyyy'), 'Gluten', 'Abigail Clark', 533159408, null, 358);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (260, 'Stella', 'Scott', to_date('18-10-2019', 'dd-mm-yyyy'), 'Gluten', 'Lillian Scott', 557916105, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (261, 'Joshua', 'Wright', to_date('22-09-2018', 'dd-mm-yyyy'), 'Gluten', 'Eva Wright', 595512890, null, 360);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (262, 'Aurora', 'Thomas', to_date('16-12-2023', 'dd-mm-yyyy'), 'Dairy', 'Felipe Thomas', 565145292, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (263, 'Hazel', 'Walker', to_date('25-04-2020', 'dd-mm-yyyy'), 'Peanuts', 'Violet Walker', 581737423, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (264, 'Gianna', 'Harris', to_date('08-08-2022', 'dd-mm-yyyy'), null, 'Anthony Harris', 592392226, null, 363);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (265, 'Andrea', 'Young', to_date('22-10-2020', 'dd-mm-yyyy'), null, 'Rose Young', 567718942, null, 364);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (266, 'Aaron', 'Brown', to_date('24-09-2021', 'dd-mm-yyyy'), null, 'Madilyn Brown', 554570020, null, 365);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (267, 'Diego', 'Williams', to_date('19-07-2020', 'dd-mm-yyyy'), null, 'Henry Williams', 537864059, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (268, 'Paisley', 'Mitchell', to_date('02-06-2021', 'dd-mm-yyyy'), 'Dairy', 'John Mitchell', 513960949, null, 367);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (269, 'Luke', 'Carter', to_date('19-10-2023', 'dd-mm-yyyy'), null, 'Derek Carter', 596700609, null, 368);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (270, 'Lucas', 'Lopez', to_date('22-04-2019', 'dd-mm-yyyy'), 'Peanuts', 'Paisley Lopez', 557843438, null, 369);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (271, 'Brian', 'Miller', to_date('07-05-2022', 'dd-mm-yyyy'), null, 'Aaron Miller', 597378243, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (272, 'Andrew', 'Allen', to_date('15-05-2022', 'dd-mm-yyyy'), null, 'Catalina Allen', 513620217, null, 371);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (273, 'Andrea', 'Walker', to_date('13-04-2019', 'dd-mm-yyyy'), 'Dairy', 'Scarlett Walker', 519849522, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (274, 'Elena', 'Clark', to_date('10-02-2020', 'dd-mm-yyyy'), null, 'Gregory Clark', 567403393, null, 373);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (275, 'Allison', 'Davis', to_date('03-12-2018', 'dd-mm-yyyy'), null, 'Scarlett Davis', 555218270, null, 374);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (276, 'Alaina', 'Anderson', to_date('20-10-2019', 'dd-mm-yyyy'), 'Gluten', 'Mila Anderson', 549075977, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (277, 'Juliet', 'Hernandez', to_date('05-11-2018', 'dd-mm-yyyy'), 'Peanuts', 'Avery Hernandez', 546984031, null, 376);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (278, 'Kyle', 'Campbell', to_date('28-10-2023', 'dd-mm-yyyy'), null, 'Diego Campbell', 560514378, null, 377);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (279, 'Piper', 'Miller', to_date('10-09-2020', 'dd-mm-yyyy'), 'Dairy', 'Julia Miller', 563360457, null, 378);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (280, 'Kyle', 'Garcia', to_date('26-10-2020', 'dd-mm-yyyy'), 'Peanuts', 'Lola Garcia', 546871949, null, 379);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (281, 'Alexis', 'Lopez', to_date('05-12-2022', 'dd-mm-yyyy'), 'Peanuts', 'Makenna Lopez', 599941137, null, 380);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (282, 'Vivian', 'Roy', to_date('08-06-2020', 'dd-mm-yyyy'), null, 'Charles Roy', 518364624, null, 381);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (283, 'Skylar', 'Rogers', to_date('25-01-2020', 'dd-mm-yyyy'), 'Gluten', 'Andrea Rogers', 599818425, null, 382);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (284, 'Natalia', 'Carter', to_date('07-02-2022', 'dd-mm-yyyy'), 'Gluten', 'John Carter', 590463076, null, 383);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (285, 'Keira', 'Lopez', to_date('21-08-2021', 'dd-mm-yyyy'), 'Dairy', 'Genevieve Lopez', 588023643, null, 384);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (286, 'Isla', 'Brown', to_date('18-11-2018', 'dd-mm-yyyy'), 'Peanuts', 'Cameron Brown', 537254253, null, 385);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (287, 'Lawrence', 'Campbell', to_date('23-03-2022', 'dd-mm-yyyy'), 'Gluten', 'Daniel Campbell', 537593553, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (288, 'Edward', 'Robinson', to_date('19-05-2022', 'dd-mm-yyyy'), null, 'Amelia Robinson', 536577471, null, 387);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (289, 'Isla', 'Lee', to_date('22-11-2018', 'dd-mm-yyyy'), 'Gluten', 'Claire Lee', 558243740, null, 388);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (290, 'Charlotte', 'Anderson', to_date('08-11-2021', 'dd-mm-yyyy'), 'Dairy', 'Adalyn Anderson', 541791326, null, 389);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (291, 'Emma', 'Phillips', to_date('18-01-2021', 'dd-mm-yyyy'), 'Peanuts', 'Ruby Phillips', 569257714, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (292, 'Nathan', 'Williams', to_date('25-11-2022', 'dd-mm-yyyy'), null, 'Cody Williams', 572389874, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (293, 'Aurora', 'Lopez', to_date('26-07-2021', 'dd-mm-yyyy'), 'Dairy', 'Stella Lopez', 517859890, null, 392);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (294, 'Julian', 'Thomas', to_date('10-09-2018', 'dd-mm-yyyy'), null, 'Genevieve Thomas', 525460162, null, 393);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (295, 'Andrew', 'Hernandez', to_date('18-11-2018', 'dd-mm-yyyy'), 'Gluten', 'Reagan Hernandez', 550826712, null, 394);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (296, 'Luke', 'Clark', to_date('28-03-2019', 'dd-mm-yyyy'), null, 'Natalie Clark', 544692839, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (297, 'Quinn', 'Hernandez', to_date('12-10-2020', 'dd-mm-yyyy'), null, 'Skylar Hernandez', 587973408, null, 396);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (298, 'Bailey', 'Cruz', to_date('12-06-2022', 'dd-mm-yyyy'), 'Dairy', 'Kinsley Cruz', 577823059, null, 397);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (299, 'Natalia', 'Campbell', to_date('20-04-2022', 'dd-mm-yyyy'), null, 'Kinsley Campbell', 518779677, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (300, 'Juan', 'Allen', to_date('27-10-2021', 'dd-mm-yyyy'), 'Dairy', 'Aria Allen', 561349540, null, 399);
commit;
prompt 300 records committed...
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (301, 'Millie', 'Taylor', to_date('28-03-2019', 'dd-mm-yyyy'), 'Dairy', 'Gianna Taylor', 560815172, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (302, 'Millie', 'Allen', to_date('24-08-2021', 'dd-mm-yyyy'), 'Peanuts', 'Bella Allen', 540082725, null, 401);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (303, 'Ivy', 'Wright', to_date('22-01-2018', 'dd-mm-yyyy'), 'Dairy', 'Jack Wright', 587101839, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (304, 'Mila', 'Thomas', to_date('08-04-2019', 'dd-mm-yyyy'), 'Dairy', 'Andrea Thomas', 522777009, null, 403);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (305, 'Ezekiel', 'Wilson', to_date('09-01-2018', 'dd-mm-yyyy'), null, 'Millie Wilson', 584092203, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (306, 'David', 'Hernandez', to_date('30-06-2020', 'dd-mm-yyyy'), 'Dairy', 'Riley Hernandez', 598722217, null, 405);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (307, 'Cody', 'Mitchell', to_date('19-02-2020', 'dd-mm-yyyy'), null, 'Eva Mitchell', 558933461, null, 406);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (308, 'Isabella', 'Rogers', to_date('15-01-2023', 'dd-mm-yyyy'), 'Gluten', 'Olivia Rogers', 581351383, null, 407);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (309, 'Madeline', 'Wilson', to_date('17-11-2019', 'dd-mm-yyyy'), 'Peanuts', 'Riley Wilson', 549215425, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (310, 'Daniel', 'Moore', to_date('07-01-2020', 'dd-mm-yyyy'), null, 'Lola Moore', 560154336, null, 409);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (311, 'Adalyn', 'Allen', to_date('18-03-2019', 'dd-mm-yyyy'), 'Dairy', 'Claire Allen', 553934751, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (312, 'Juliet', 'Scott', to_date('20-09-2023', 'dd-mm-yyyy'), 'Gluten', 'Benjamin Scott', 534030524, null, 411);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (313, 'Catalina', 'Anderson', to_date('22-12-2023', 'dd-mm-yyyy'), 'Gluten', 'Brooklyn Anderson', 587157296, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (314, 'Nora', 'Rogers', to_date('24-05-2021', 'dd-mm-yyyy'), 'Gluten', 'Kinsley Rogers', 514052490, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (315, 'Chloe', 'Robinson', to_date('19-12-2019', 'dd-mm-yyyy'), 'Peanuts', 'Naomi Robinson', 540091002, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (316, 'Alexis', 'Lopez', to_date('08-02-2021', 'dd-mm-yyyy'), 'Peanuts', 'Paisley Lopez', 572961998, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (317, 'Caroline', 'Garcia', to_date('14-10-2021', 'dd-mm-yyyy'), 'Peanuts', 'Henry Garcia', 555835552, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (318, 'Isaac', 'Rodriguez', to_date('01-08-2018', 'dd-mm-yyyy'), 'Peanuts', 'Benjamin Rodriguez', 558680279, null, 417);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (319, 'Juan', 'Lee', to_date('20-12-2018', 'dd-mm-yyyy'), 'Gluten', 'Alexis Lee', 525140800, null, 418);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (320, 'Charlotte', 'Moore', to_date('09-01-2021', 'dd-mm-yyyy'), 'Peanuts', 'Madeline Moore', 525085861, null, 419);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (321, 'Emery', 'Rogers', to_date('15-02-2022', 'dd-mm-yyyy'), null, 'Justin Rogers', 510917394, null, 420);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (322, 'Luna', 'Moore', to_date('03-02-2021', 'dd-mm-yyyy'), 'Dairy', 'Keith Moore', 599785749, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (323, 'Vivian', 'Miller', to_date('25-10-2021', 'dd-mm-yyyy'), null, 'Keith Miller', 513301123, null, 422);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (324, 'Aubree', 'Walker', to_date('06-09-2018', 'dd-mm-yyyy'), 'Dairy', 'Juan Walker', 547153829, null, 423);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (325, 'Keith', 'Allen', to_date('11-02-2020', 'dd-mm-yyyy'), null, 'Melanie Allen', 576096187, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (326, 'Harold', 'Mitchell', to_date('11-08-2022', 'dd-mm-yyyy'), 'Gluten', 'Eva Mitchell', 579973789, null, 425);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (327, 'Samantha', 'Anderson', to_date('09-05-2022', 'dd-mm-yyyy'), null, 'Brielle Anderson', 529575762, null, 426);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (328, 'Bella', 'Nguyen', to_date('08-06-2019', 'dd-mm-yyyy'), null, 'Hazel Nguyen', 512574503, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (329, 'Josephine', 'Carter', to_date('15-12-2018', 'dd-mm-yyyy'), 'Dairy', 'Molly Carter', 551146245, null, 428);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (330, 'Bella', 'Wilson', to_date('16-01-2021', 'dd-mm-yyyy'), null, 'Amaya Wilson', 548053321, null, 429);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (331, 'Gracie', 'Sanchez', to_date('23-11-2020', 'dd-mm-yyyy'), null, 'Bailey Sanchez', 557738458, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (332, 'Lucas', 'Allen', to_date('05-02-2019', 'dd-mm-yyyy'), null, 'Charlotte Allen', 550947155, null, 431);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (333, 'Delilah', 'King', to_date('28-10-2018', 'dd-mm-yyyy'), 'Gluten', 'Autumn King', 539768119, null, 432);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (334, 'Skylar', 'Nelson', to_date('07-12-2023', 'dd-mm-yyyy'), 'Peanuts', 'Arabella Nelson', 587031810, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (335, 'Eliza', 'Thomas', to_date('22-11-2022', 'dd-mm-yyyy'), 'Peanuts', 'Mackenzie Thomas', 583738494, null, 434);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (336, 'Chloe', 'Rogers', to_date('21-05-2020', 'dd-mm-yyyy'), 'Peanuts', 'Madelyn Rogers', 522706090, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (337, 'Dustin', 'Hernandez', to_date('29-07-2023', 'dd-mm-yyyy'), 'Dairy', 'Alyssa Hernandez', 518193967, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (338, 'Edward', 'Allen', to_date('11-05-2019', 'dd-mm-yyyy'), 'Peanuts', 'Layla Allen', 537242544, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (339, 'Joshua', 'Allen', to_date('23-06-2020', 'dd-mm-yyyy'), null, 'Dustin Allen', 590579127, null, 438);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (340, 'Samantha', 'Lewis', to_date('01-07-2021', 'dd-mm-yyyy'), 'Dairy', 'Isla Lewis', 540747430, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (341, 'Chloe', 'Young', to_date('30-06-2018', 'dd-mm-yyyy'), 'Gluten', 'Maya Young', 540643961, null, 440);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (342, 'Natalie', 'King', to_date('26-11-2022', 'dd-mm-yyyy'), 'Peanuts', 'Daniel King', 514619349, null, 441);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (343, 'Joseph', 'Davis', to_date('30-07-2023', 'dd-mm-yyyy'), 'Dairy', 'Dustin Davis', 516463287, null, 442);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (344, 'Callie', 'Robinson', to_date('28-09-2020', 'dd-mm-yyyy'), 'Peanuts', 'Abraham Robinson', 550726262, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (345, 'Penelope', 'Lewis', to_date('07-11-2022', 'dd-mm-yyyy'), null, 'Keith Lewis', 518641062, null, 444);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (346, 'Eliana', 'Campbell', to_date('09-02-2019', 'dd-mm-yyyy'), 'Dairy', 'Juliet Campbell', 579469475, null, 445);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (347, 'Isaac', 'Wright', to_date('04-03-2020', 'dd-mm-yyyy'), 'Dairy', 'Charlotte Wright', 540935049, null, 446);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (348, 'Aaron', 'Allen', to_date('13-06-2022', 'dd-mm-yyyy'), null, 'Chad Allen', 529524046, null, 447);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (349, 'Jasmine', 'Moore', to_date('20-09-2020', 'dd-mm-yyyy'), null, 'Clara Moore', 565150433, null, 448);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (350, 'Rosalie', 'Scott', to_date('22-09-2019', 'dd-mm-yyyy'), 'Gluten', 'Dylan Scott', 552686733, null, 449);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (351, 'Adalyn', 'Clark', to_date('29-08-2021', 'dd-mm-yyyy'), 'Dairy', 'Brandon Clark', 592034206, null, 450);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (352, 'Abraham', 'Rodriguez', to_date('23-07-2018', 'dd-mm-yyyy'), 'Peanuts', 'Rose Rodriguez', 531470420, null, 451);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (353, 'Lila', 'Hernandez', to_date('23-04-2023', 'dd-mm-yyyy'), 'Dairy', 'Valentina Hernandez', 575538684, null, 452);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (354, 'Aria', 'Allen', to_date('09-09-2023', 'dd-mm-yyyy'), 'Gluten', 'Taylor Allen', 570987440, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (355, 'Skylar', 'Taylor', to_date('01-02-2022', 'dd-mm-yyyy'), 'Dairy', 'Luna Taylor', 553295136, null, 454);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (356, 'Stella', 'Garcia', to_date('05-09-2022', 'dd-mm-yyyy'), 'Peanuts', 'Autumn Garcia', 583550358, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (357, 'Antonio', 'Nelson', to_date('05-04-2022', 'dd-mm-yyyy'), null, 'Luna Nelson', 510766150, null, 456);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (358, 'Ivy', 'Rodriguez', to_date('12-09-2022', 'dd-mm-yyyy'), 'Dairy', 'Molly Rodriguez', 528274297, null, 457);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (359, 'Joseph', 'Lee', to_date('27-02-2022', 'dd-mm-yyyy'), 'Peanuts', 'Millie Lee', 549095539, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (360, 'Lucas', 'Anderson', to_date('16-12-2021', 'dd-mm-yyyy'), null, 'Alexis Anderson', 554945668, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (361, 'Evelyn', 'Lewis', to_date('31-03-2018', 'dd-mm-yyyy'), 'Dairy', 'Ruby Lewis', 544185285, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (362, 'Kaitlyn', 'Harris', to_date('21-05-2023', 'dd-mm-yyyy'), 'Peanuts', 'Andrea Harris', 532288948, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (363, 'Eden', 'Mitchell', to_date('14-12-2023', 'dd-mm-yyyy'), 'Dairy', 'Sophie Mitchell', 512989387, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (364, 'Ava', 'Robinson', to_date('09-03-2023', 'dd-mm-yyyy'), 'Gluten', 'Joseph Robinson', 541400445, null, 463);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (365, 'Anna', 'Young', to_date('16-07-2019', 'dd-mm-yyyy'), null, 'Adalyn Young', 595736864, null, 464);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (366, 'Mackenzie', 'Lewis', to_date('30-07-2019', 'dd-mm-yyyy'), null, 'Mila Lewis', 539864282, null, 465);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (367, 'Keith', 'Wright', to_date('17-01-2021', 'dd-mm-yyyy'), null, 'Isaac Wright', 539777152, null, 466);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (368, 'Javier', 'Lopez', to_date('29-09-2022', 'dd-mm-yyyy'), 'Gluten', 'Madelyn Lopez', 535399909, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (369, 'Leah', 'Scott', to_date('18-03-2021', 'dd-mm-yyyy'), 'Peanuts', 'Samantha Scott', 567009302, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (370, 'Christopher', 'Johnson', to_date('02-03-2020', 'dd-mm-yyyy'), null, 'Alexandra Johnson', 591567143, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (371, 'Layla', 'Clark', to_date('27-10-2018', 'dd-mm-yyyy'), 'Dairy', 'Isabella Clark', 586967796, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (372, 'Douglas', 'Williams', to_date('10-02-2019', 'dd-mm-yyyy'), 'Dairy', 'Henry Williams', 558315389, null, 471);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (373, 'Eliana', 'Scott', to_date('02-02-2021', 'dd-mm-yyyy'), null, 'Abraham Scott', 513648837, null, 472);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (374, 'Emma', 'Moore', to_date('08-05-2022', 'dd-mm-yyyy'), null, 'Caleb Moore', 529591137, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (375, 'Taylor', 'Garcia', to_date('01-11-2021', 'dd-mm-yyyy'), 'Gluten', 'Madeline Garcia', 532693335, null, 474);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (376, 'David', 'Hernandez', to_date('24-05-2020', 'dd-mm-yyyy'), null, 'Eloise Hernandez', 513377811, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (377, 'Daisy', 'Robinson', to_date('31-10-2022', 'dd-mm-yyyy'), null, 'Stella Robinson', 513416027, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (378, 'Savannah', 'Lee', to_date('28-09-2022', 'dd-mm-yyyy'), null, 'Amelia Lee', 596910755, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (379, 'Eliza', 'Hernandez', to_date('04-01-2022', 'dd-mm-yyyy'), null, 'Lily Hernandez', 563023088, null, 478);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (380, 'Alice', 'Brown', to_date('11-12-2018', 'dd-mm-yyyy'), 'Dairy', 'Caleb Brown', 599093750, null, 479);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (381, 'Lydia', 'Rodriguez', to_date('23-01-2019', 'dd-mm-yyyy'), null, 'Juliet Rodriguez', 585558865, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (382, 'Eric', 'Harris', to_date('15-07-2018', 'dd-mm-yyyy'), 'Peanuts', 'Nicole Harris', 513561765, null, 481);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (383, 'Leilani', 'Walker', to_date('13-10-2019', 'dd-mm-yyyy'), null, 'Zoey Walker', 523774075, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (384, 'Molly', 'Robinson', to_date('03-09-2022', 'dd-mm-yyyy'), 'Peanuts', 'Ethan Robinson', 552538531, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (385, 'Dennis', 'Rodriguez', to_date('26-04-2020', 'dd-mm-yyyy'), null, 'Cora Rodriguez', 530358851, null, 484);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (386, 'Alexis', 'Davis', to_date('25-06-2020', 'dd-mm-yyyy'), null, 'Ava Davis', 577066673, null, 485);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (387, 'Katherine', 'Thomas', to_date('01-02-2021', 'dd-mm-yyyy'), 'Gluten', 'Lila Thomas', 519552719, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (388, 'Eloise', 'Johnson', to_date('30-06-2021', 'dd-mm-yyyy'), 'Peanuts', 'Harper Johnson', 550966624, null, 487);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (389, 'Ruby', 'Campbell', to_date('20-02-2019', 'dd-mm-yyyy'), 'Gluten', 'Lucas Campbell', 544857438, null, 488);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (390, 'Skylar', 'Rogers', to_date('20-10-2019', 'dd-mm-yyyy'), 'Peanuts', 'Aurora Rogers', 585890564, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (391, 'Sloane', 'Taylor', to_date('19-12-2018', 'dd-mm-yyyy'), null, 'Mila Taylor', 550038106, null, 490);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (392, 'Aurora', 'Lopez', to_date('25-11-2019', 'dd-mm-yyyy'), 'Dairy', 'Sadie Lopez', 528829729, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (393, 'Teagan', 'Taylor', to_date('12-11-2018', 'dd-mm-yyyy'), 'Dairy', 'George Taylor', 571008754, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (394, 'Grace', 'Carter', to_date('07-05-2018', 'dd-mm-yyyy'), null, 'Savannah Carter', 518067254, null, 493);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (395, 'Elena', 'Johnson', to_date('21-04-2020', 'dd-mm-yyyy'), 'Peanuts', 'Lucy Johnson', 597120164, null, 494);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (396, 'Miguel', 'Johnson', to_date('02-03-2020', 'dd-mm-yyyy'), 'Peanuts', 'Kyle Johnson', 546455856, null, 495);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (397, 'Clara', 'Hall', to_date('19-11-2022', 'dd-mm-yyyy'), 'Gluten', 'Ruby Hall', 512668045, null, 496);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (398, 'Josephine', 'Miller', to_date('28-01-2023', 'dd-mm-yyyy'), 'Peanuts', 'Eliza Miller', 581962277, null, 497);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (399, 'Lillian', 'Walker', to_date('04-01-2020', 'dd-mm-yyyy'), 'Dairy', 'Savannah Walker', 566597370, null, 498);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (400, 'Andrea', 'Moore', to_date('04-05-2022', 'dd-mm-yyyy'), null, 'Grace Moore', 599948095, null, 499);
commit;
prompt 400 records committed...
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (401, 'Everly', 'Rogers', to_date('18-07-2023', 'dd-mm-yyyy'), 'Dairy', 'Clara Rogers', 586879920, null, 500);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (402, 'Genevieve', 'Phillips', to_date('30-03-2019', 'dd-mm-yyyy'), null, 'Felipe Phillips', 514368785, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (403, 'Lillian', 'Nguyen', to_date('18-05-2023', 'dd-mm-yyyy'), 'Gluten', 'Brooklyn Nguyen', 562297614, null, 502);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (404, 'Sophie', 'Davis', to_date('17-05-2018', 'dd-mm-yyyy'), 'Peanuts', 'Layla Davis', 511210424, null, 503);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (405, 'Grace', 'Moore', to_date('26-05-2018', 'dd-mm-yyyy'), 'Gluten', 'Molly Moore', 542882255, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (406, 'Athena', 'Lopez', to_date('12-05-2019', 'dd-mm-yyyy'), null, 'Mia Lopez', 544809925, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (407, 'Isabella', 'Nelson', to_date('30-04-2018', 'dd-mm-yyyy'), 'Peanuts', 'Dennis Nelson', 583210549, null, 506);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (408, 'Albert', 'Lewis', to_date('27-12-2021', 'dd-mm-yyyy'), 'Dairy', 'Zoey Lewis', 566318085, null, 507);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (409, 'Alexandra', 'Sanchez', to_date('20-09-2022', 'dd-mm-yyyy'), null, 'Piper Sanchez', 563861976, null, 508);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (410, 'Madilyn', 'Clark', to_date('15-01-2023', 'dd-mm-yyyy'), 'Peanuts', 'Lily Clark', 571344279, null, 509);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (411, 'Clara', 'Nguyen', to_date('20-05-2018', 'dd-mm-yyyy'), 'Dairy', 'Emilia Nguyen', 532694176, null, 510);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (412, 'Kyle', 'Moore', to_date('05-10-2023', 'dd-mm-yyyy'), 'Gluten', 'Edward Moore', 527486842, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (413, 'Dennis', 'Nelson', to_date('04-01-2020', 'dd-mm-yyyy'), 'Dairy', 'Juliet Nelson', 543937954, null, 512);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (414, 'Rylee', 'Scott', to_date('18-07-2021', 'dd-mm-yyyy'), 'Dairy', 'Jordan Scott', 592479520, null, 513);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (415, 'Javier', 'Garcia', to_date('06-12-2023', 'dd-mm-yyyy'), null, 'Lillian Garcia', 536862595, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (416, 'Lucy', 'Allen', to_date('19-04-2022', 'dd-mm-yyyy'), 'Gluten', 'George Allen', 532943145, null, 515);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (417, 'Bella', 'Watson', to_date('03-12-2019', 'dd-mm-yyyy'), 'Dairy', 'Lillian Watson', 520617562, null, 516);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (418, 'Albert', 'Garcia', to_date('17-03-2021', 'dd-mm-yyyy'), null, 'Eva Garcia', 565626535, null, 517);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (419, 'Ezekiel', 'Miller', to_date('09-02-2022', 'dd-mm-yyyy'), 'Peanuts', 'Bella Miller', 517423717, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (420, 'Elena', 'Cruz', to_date('17-12-2019', 'dd-mm-yyyy'), null, 'Jesse Cruz', 568844946, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (421, 'Valentina', 'Evans', to_date('25-02-2021', 'dd-mm-yyyy'), 'Dairy', 'Aubree Evans', 560463896, null, 520);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (422, 'Jasmine', 'Anderson', to_date('24-09-2023', 'dd-mm-yyyy'), 'Gluten', 'Catalina Anderson', 562053743, null, 521);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (423, 'Claire', 'Thomas', to_date('05-08-2021', 'dd-mm-yyyy'), 'Peanuts', 'Gabriel Thomas', 584450210, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (424, 'Gregory', 'Moore', to_date('25-11-2022', 'dd-mm-yyyy'), null, 'Edward Moore', 565549248, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (425, 'Grace', 'Lee', to_date('24-05-2018', 'dd-mm-yyyy'), 'Peanuts', 'Aubrey Lee', 583128371, null, 524);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (426, 'Leilani', 'Wilson', to_date('10-05-2018', 'dd-mm-yyyy'), 'Dairy', 'Brian Wilson', 526045638, null, 525);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (427, 'Julian', 'Anderson', to_date('15-02-2021', 'dd-mm-yyyy'), 'Gluten', 'Ezekiel Anderson', 585396669, null, 526);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (428, 'Dustin', 'Moore', to_date('04-12-2023', 'dd-mm-yyyy'), 'Dairy', 'Jade Moore', 515791482, null, 527);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (429, 'Brianna', 'Thomas', to_date('26-02-2020', 'dd-mm-yyyy'), 'Peanuts', 'Clara Thomas', 566485075, null, 528);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (430, 'Aaliyah', 'Sanchez', to_date('25-08-2019', 'dd-mm-yyyy'), 'Peanuts', 'Charles Sanchez', 577548895, null, 529);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (431, 'Alexis', 'Wright', to_date('01-02-2023', 'dd-mm-yyyy'), 'Peanuts', 'Luna Wright', 534628299, null, 530);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (432, 'Savannah', 'Johnson', to_date('24-06-2019', 'dd-mm-yyyy'), 'Gluten', 'Aaron Johnson', 521882184, null, 531);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (433, 'Lily', 'Hernandez', to_date('07-08-2019', 'dd-mm-yyyy'), 'Dairy', 'Isaiah Hernandez', 546464999, null, 532);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (434, 'Chloe', 'Young', to_date('13-01-2020', 'dd-mm-yyyy'), 'Gluten', 'Sophie Young', 513475266, null, 533);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (435, 'Penelope', 'Kim', to_date('14-10-2021', 'dd-mm-yyyy'), 'Peanuts', 'Aurora Kim', 535960424, null, 534);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (436, 'Callie', 'Watson', to_date('07-11-2020', 'dd-mm-yyyy'), null, 'Eric Watson', 544567619, null, 535);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (437, 'Grace', 'Hernandez', to_date('01-05-2022', 'dd-mm-yyyy'), null, 'Piper Hernandez', 559557270, null, 536);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (438, 'Sloane', 'Carter', to_date('10-12-2021', 'dd-mm-yyyy'), 'Dairy', 'Gracie Carter', 517706207, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (439, 'Carlos', 'Lewis', to_date('21-08-2020', 'dd-mm-yyyy'), null, 'Cole Lewis', 562649541, null, 538);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (440, 'Delilah', 'Hall', to_date('25-08-2020', 'dd-mm-yyyy'), 'Dairy', 'Brandon Hall', 514577512, null, 539);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (441, 'Madeline', 'Garcia', to_date('31-01-2018', 'dd-mm-yyyy'), 'Gluten', 'Brian Garcia', 594786246, null, 540);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (442, 'Vivian', 'Mitchell', to_date('27-08-2023', 'dd-mm-yyyy'), null, 'Nora Mitchell', 528787567, null, 541);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (443, 'Emilia', 'Ramirez', to_date('07-10-2021', 'dd-mm-yyyy'), null, 'Caleb Ramirez', 540420690, null, 542);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (444, 'Isabella', 'Hernandez', to_date('15-03-2019', 'dd-mm-yyyy'), 'Peanuts', 'Chloe Hernandez', 526745346, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (445, 'Aubree', 'Thomas', to_date('01-09-2022', 'dd-mm-yyyy'), null, 'Ava Thomas', 591163331, null, 544);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (446, 'Harold', 'Sanchez', to_date('04-10-2022', 'dd-mm-yyyy'), 'Dairy', 'Adrian Sanchez', 529315730, null, 545);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (447, 'Skylar', 'Kim', to_date('21-11-2023', 'dd-mm-yyyy'), 'Gluten', 'Emma Kim', 584121275, null, 546);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (448, 'Leonardo', 'Moore', to_date('31-12-2019', 'dd-mm-yyyy'), 'Peanuts', 'Clara Moore', 532471052, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (449, 'Genevieve', 'Garcia', to_date('24-07-2021', 'dd-mm-yyyy'), 'Peanuts', 'Scarlett Garcia', 549306126, null, 548);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (450, 'Anna', 'Roy', to_date('27-11-2021', 'dd-mm-yyyy'), 'Gluten', 'Cole Roy', 573565506, null, 549);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (451, 'Sarah', 'Rodriguez', to_date('13-08-2021', 'dd-mm-yyyy'), 'Gluten', 'Brianna Rodriguez', 596172653, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (452, 'Eric', 'Rodriguez', to_date('04-06-2022', 'dd-mm-yyyy'), null, 'Abigail Rodriguez', 578297178, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (453, 'Aurora', 'Clark', to_date('22-10-2023', 'dd-mm-yyyy'), null, 'Josephine Clark', 567636016, null, 552);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (454, 'Lila', 'Robinson', to_date('11-11-2019', 'dd-mm-yyyy'), null, 'Aubrey Robinson', 585983418, null, 553);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (455, 'Brandon', 'Nelson', to_date('03-10-2023', 'dd-mm-yyyy'), null, 'Emma Nelson', 536585025, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (456, 'Julian', 'Davis', to_date('21-01-2022', 'dd-mm-yyyy'), 'Peanuts', 'Daisy Davis', 533409085, null, 555);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (457, 'Ava', 'Jones', to_date('28-11-2019', 'dd-mm-yyyy'), 'Peanuts', 'Eliza Jones', 571433029, null, 556);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (458, 'Olivia', 'Walker', to_date('15-12-2021', 'dd-mm-yyyy'), 'Peanuts', 'Austin Walker', 537372988, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (459, 'Alice', 'Rogers', to_date('14-09-2022', 'dd-mm-yyyy'), 'Gluten', 'Emilia Rogers', 527894442, null, 558);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (460, 'Rylee', 'Adams', to_date('22-02-2018', 'dd-mm-yyyy'), null, 'Everly Adams', 526657490, null, 559);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (461, 'Millie', 'Scott', to_date('10-04-2021', 'dd-mm-yyyy'), null, 'Hope Scott', 520714548, null, 560);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (462, 'Nora', 'Martinez', to_date('22-11-2018', 'dd-mm-yyyy'), null, 'Keira Martinez', 578139943, null, 561);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (463, 'Carlos', 'Garcia', to_date('07-04-2020', 'dd-mm-yyyy'), 'Peanuts', 'Emilia Garcia', 574400117, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (464, 'Alyssa', 'Lewis', to_date('29-08-2021', 'dd-mm-yyyy'), null, 'Brooklyn Lewis', 592529731, null, 563);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (465, 'Sophia', 'Miller', to_date('05-05-2023', 'dd-mm-yyyy'), 'Dairy', 'Jordan Miller', 531744060, null, 564);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (466, 'Brooklyn', 'Lee', to_date('24-03-2019', 'dd-mm-yyyy'), 'Gluten', 'Jordan Lee', 553581591, null, 565);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (467, 'Hannah', 'Young', to_date('31-03-2019', 'dd-mm-yyyy'), null, 'Lola Young', 551531634, null, 566);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (468, 'Gabriel', 'Williams', to_date('07-09-2023', 'dd-mm-yyyy'), 'Dairy', 'Juliet Williams', 566610799, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (469, 'Aaron', 'Rodriguez', to_date('28-08-2022', 'dd-mm-yyyy'), 'Gluten', 'Christopher Rodriguez', 548449378, null, 568);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (470, 'Sophia', 'Johnson', to_date('04-03-2018', 'dd-mm-yyyy'), null, 'Eloise Johnson', 574864651, null, 569);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (471, 'Molly', 'Diaz', to_date('20-04-2021', 'dd-mm-yyyy'), 'Gluten', 'Sloane Diaz', 584312547, null, 570);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (472, 'Ivy', 'Phillips', to_date('01-05-2022', 'dd-mm-yyyy'), null, 'John Phillips', 531085853, null, 571);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (473, 'Everly', 'Ramirez', to_date('24-01-2023', 'dd-mm-yyyy'), 'Peanuts', 'Natalia Ramirez', 597340259, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (474, 'Athena', 'Robinson', to_date('18-01-2020', 'dd-mm-yyyy'), 'Peanuts', 'Vivienne Robinson', 597069681, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (475, 'Teagan', 'Garcia', to_date('15-11-2019', 'dd-mm-yyyy'), 'Peanuts', 'Vivienne Garcia', 576606621, null, 574);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (476, 'Mia', 'Moore', to_date('03-04-2019', 'dd-mm-yyyy'), null, 'Gracie Moore', 590593158, null, 575);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (477, 'Rose', 'Hernandez', to_date('30-04-2022', 'dd-mm-yyyy'), 'Gluten', 'Julian Hernandez', 572817630, null, 576);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (478, 'Javier', 'Hernandez', to_date('24-04-2021', 'dd-mm-yyyy'), 'Gluten', 'Eva Hernandez', 517886584, null, 577);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (479, 'Benjamin', 'Rodriguez', to_date('30-12-2020', 'dd-mm-yyyy'), 'Peanuts', 'Harold Rodriguez', 511444113, null, 578);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (480, 'Naomi', 'Allen', to_date('03-07-2023', 'dd-mm-yyyy'), 'Peanuts', 'Madelyn Allen', 595170872, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (481, 'Adalyn', 'Harris', to_date('26-04-2019', 'dd-mm-yyyy'), 'Gluten', 'Brianna Harris', 573305029, null, 580);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (482, 'Eliana', 'Green', to_date('26-05-2019', 'dd-mm-yyyy'), 'Gluten', 'Adam Green', 570357774, null, 581);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (483, 'Natalia', 'Anderson', to_date('11-02-2021', 'dd-mm-yyyy'), 'Peanuts', 'Callie Anderson', 587199718, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (484, 'Cody', 'Mitchell', to_date('18-03-2022', 'dd-mm-yyyy'), null, 'Vivian Mitchell', 526469770, null, 583);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (485, 'Juan', 'Lopez', to_date('25-03-2022', 'dd-mm-yyyy'), null, 'Alyssa Lopez', 555025150, null, 584);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (486, 'Jack', 'Scott', to_date('26-03-2023', 'dd-mm-yyyy'), 'Dairy', 'Benjamin Scott', 538168407, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (487, 'Lola', 'Clark', to_date('22-07-2022', 'dd-mm-yyyy'), 'Dairy', 'Ellie Clark', 549921745, null, 586);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (488, 'Alexis', 'Hernandez', to_date('23-08-2023', 'dd-mm-yyyy'), null, 'Willow Hernandez', 540327238, null, 587);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (489, 'Stella', 'Moore', to_date('17-12-2021', 'dd-mm-yyyy'), null, 'Sloane Moore', 531321411, null, 588);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (490, 'Jordan', 'Walker', to_date('03-09-2018', 'dd-mm-yyyy'), null, 'Lucas Walker', 526796378, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (491, 'Makenna', 'Wright', to_date('03-06-2019', 'dd-mm-yyyy'), 'Dairy', 'Clara Wright', 558357285, null, 590);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (492, 'Eva', 'Hall', to_date('18-06-2019', 'dd-mm-yyyy'), 'Peanuts', 'Riley Hall', 530767423, null, 591);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (493, 'Melanie', 'Rogers', to_date('28-05-2020', 'dd-mm-yyyy'), 'Peanuts', 'David Rogers', 548627110, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (494, 'Charlotte', 'Allen', to_date('12-01-2018', 'dd-mm-yyyy'), null, 'Caleb Allen', 596873086, null, 593);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (495, 'Brian', 'Moore', to_date('13-09-2019', 'dd-mm-yyyy'), null, 'Diego Moore', 590958485, null, 594);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (496, 'Clara', 'Thomas', to_date('19-02-2022', 'dd-mm-yyyy'), 'Peanuts', 'Mila Thomas', 552095354, null, 595);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (497, 'Brianna', 'Moore', to_date('30-06-2022', 'dd-mm-yyyy'), 'Peanuts', 'Autumn Moore', 575292663, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (498, 'Aubrey', 'Anderson', to_date('17-09-2022', 'dd-mm-yyyy'), 'Peanuts', 'David Anderson', 580907445, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (499, 'Eliza', 'Allen', to_date('19-09-2022', 'dd-mm-yyyy'), null, 'Kyle Allen', 557934706, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (500, 'Natalie', 'Nguyen', to_date('12-08-2023', 'dd-mm-yyyy'), 'Peanuts', 'Sophia Nguyen', 556293055, null, null);
commit;
prompt 500 records committed...
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (501, 'Violet', 'Campbell', to_date('26-06-2018', 'dd-mm-yyyy'), 'Gluten', 'Diego Campbell', 512441543, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (502, 'Gabriella', 'Allen', to_date('19-11-2022', 'dd-mm-yyyy'), 'Dairy', 'Luna Allen', 582627630, null, 601);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (503, 'Claire', 'Lopez', to_date('09-05-2018', 'dd-mm-yyyy'), 'Gluten', 'Savannah Lopez', 589845119, null, 602);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (504, 'John', 'Robinson', to_date('23-04-2020', 'dd-mm-yyyy'), 'Gluten', 'Miguel Robinson', 545137275, null, 603);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (505, 'Lawrence', 'Hernandez', to_date('13-07-2021', 'dd-mm-yyyy'), 'Peanuts', 'Kyle Hernandez', 565439313, null, 604);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (506, 'Alexandra', 'Nelson', to_date('24-12-2018', 'dd-mm-yyyy'), null, 'Cole Nelson', 549811078, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (507, 'Sarah', 'Martinez', to_date('30-01-2020', 'dd-mm-yyyy'), 'Gluten', 'Avery Martinez', 545854906, null, 606);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (508, 'Lola', 'Hernandez', to_date('08-07-2019', 'dd-mm-yyyy'), null, 'Avery Hernandez', 531437148, null, 607);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (509, 'Madeline', 'Moore', to_date('19-04-2018', 'dd-mm-yyyy'), 'Peanuts', 'Katherine Moore', 581068392, null, 608);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (510, 'Sadie', 'Lopez', to_date('01-11-2021', 'dd-mm-yyyy'), 'Dairy', 'Julian Lopez', 516268364, null, 609);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (511, 'Anna', 'Walker', to_date('08-05-2019', 'dd-mm-yyyy'), null, 'Grace Walker', 549415909, null, 610);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (512, 'Eric', 'Scott', to_date('06-01-2021', 'dd-mm-yyyy'), null, 'Isaiah Scott', 594864457, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (513, 'Dylan', 'Lewis', to_date('11-09-2021', 'dd-mm-yyyy'), null, 'Bella Lewis', 521530711, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (514, 'Jonathan', 'Lewis', to_date('30-03-2020', 'dd-mm-yyyy'), null, 'Diego Lewis', 580653918, null, 613);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (515, 'Sarah', 'Rogers', to_date('01-10-2023', 'dd-mm-yyyy'), 'Peanuts', 'Samantha Rogers', 516829888, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (516, 'Jordan', 'Hernandez', to_date('09-01-2019', 'dd-mm-yyyy'), 'Peanuts', 'Madilyn Hernandez', 541141419, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (517, 'Ava', 'Nelson', to_date('10-10-2023', 'dd-mm-yyyy'), null, 'Kaitlyn Nelson', 530771055, null, 616);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (518, 'Luna', 'Moore', to_date('08-12-2019', 'dd-mm-yyyy'), 'Gluten', 'Ivy Moore', 559702678, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (519, 'Nicole', 'Brown', to_date('07-03-2022', 'dd-mm-yyyy'), 'Gluten', 'Isabella Brown', 577636908, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (520, 'Ethan', 'Campbell', to_date('09-05-2021', 'dd-mm-yyyy'), 'Peanuts', 'Joshua Campbell', 556138948, null, 619);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (521, 'Andrew', 'Moore', to_date('23-11-2022', 'dd-mm-yyyy'), 'Gluten', 'Samantha Moore', 537861534, null, 620);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (522, 'Ezekiel', 'Garcia', to_date('27-06-2020', 'dd-mm-yyyy'), null, 'Valentina Garcia', 568475780, null, 621);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (523, 'Brianna', 'Hernandez', to_date('08-01-2023', 'dd-mm-yyyy'), 'Dairy', 'Dennis Hernandez', 517976820, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (524, 'Mila', 'Clark', to_date('29-08-2019', 'dd-mm-yyyy'), null, 'Makenna Clark', 537158668, null, 623);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (525, 'Autumn', 'Harris', to_date('07-04-2023', 'dd-mm-yyyy'), null, 'Ruby Harris', 583331735, null, 624);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (526, 'Ella', 'Moore', to_date('14-05-2018', 'dd-mm-yyyy'), null, 'Cole Moore', 577378165, null, 625);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (527, 'Amaya', 'Williams', to_date('30-12-2020', 'dd-mm-yyyy'), 'Dairy', 'Sadie Williams', 555949388, null, 626);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (528, 'Brandon', 'Nguyen', to_date('18-12-2021', 'dd-mm-yyyy'), 'Peanuts', 'Emilia Nguyen', 547597806, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (529, 'Claire', 'Clark', to_date('23-02-2019', 'dd-mm-yyyy'), 'Dairy', 'Bailey Clark', 516343621, null, 628);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (530, 'Christopher', 'Hernandez', to_date('03-10-2022', 'dd-mm-yyyy'), 'Dairy', 'Carlos Hernandez', 520881733, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (531, 'Javier', 'Rogers', to_date('15-06-2022', 'dd-mm-yyyy'), null, 'Sarah Rogers', 518064634, null, 630);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (532, 'Addison', 'Lee', to_date('05-05-2023', 'dd-mm-yyyy'), 'Gluten', 'John Lee', 587194224, null, 631);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (533, 'Felipe', 'Wilson', to_date('05-04-2021', 'dd-mm-yyyy'), null, 'Christopher Wilson', 524025596, null, 632);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (534, 'Aaliyah', 'Davis', to_date('27-03-2023', 'dd-mm-yyyy'), null, 'Zoey Davis', 583056136, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (535, 'Ava', 'Garcia', to_date('06-07-2018', 'dd-mm-yyyy'), 'Gluten', 'Kyle Garcia', 533201647, null, 634);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (536, 'Keith', 'Rodriguez', to_date('19-08-2023', 'dd-mm-yyyy'), 'Peanuts', 'Evelyn Rodriguez', 510006481, null, 635);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (537, 'Aurora', 'Nguyen', to_date('12-10-2019', 'dd-mm-yyyy'), null, 'Lola Nguyen', 537570056, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (538, 'Everly', 'Lee', to_date('31-10-2020', 'dd-mm-yyyy'), null, 'Alexandra Lee', 588778174, null, 637);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (539, 'Kaylee', 'Garcia', to_date('31-08-2018', 'dd-mm-yyyy'), 'Dairy', 'Riley Garcia', 586063167, null, 638);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (540, 'Alan', 'Cruz', to_date('02-12-2018', 'dd-mm-yyyy'), 'Dairy', 'Rose Cruz', 551440621, null, 639);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (541, 'Emery', 'Campbell', to_date('22-12-2021', 'dd-mm-yyyy'), null, 'Brianna Campbell', 550660267, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (542, 'Aubree', 'Garcia', to_date('07-04-2022', 'dd-mm-yyyy'), null, 'Dennis Garcia', 561975299, null, 641);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (543, 'Hannah', 'Moore', to_date('26-07-2018', 'dd-mm-yyyy'), null, 'Christopher Moore', 557394590, null, 642);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (544, 'Mackenzie', 'Nelson', to_date('03-11-2023', 'dd-mm-yyyy'), null, 'Benjamin Nelson', 546463981, null, 643);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (545, 'Isaac', 'Lewis', to_date('26-12-2020', 'dd-mm-yyyy'), null, 'Mackenzie Lewis', 542150938, null, 644);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (546, 'Charles', 'Hernandez', to_date('24-01-2020', 'dd-mm-yyyy'), 'Peanuts', 'Kaylee Hernandez', 510340401, null, 645);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (547, 'Adeline', 'Scott', to_date('20-01-2021', 'dd-mm-yyyy'), 'Peanuts', 'Edward Scott', 522665949, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (548, 'Daisy', 'Moore', to_date('24-06-2022', 'dd-mm-yyyy'), null, 'Evelyn Moore', 578094377, null, 647);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (549, 'Millie', 'Hernandez', to_date('16-05-2020', 'dd-mm-yyyy'), null, 'Serenity Hernandez', 540520286, null, 648);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (550, 'Isabella', 'Davis', to_date('26-03-2019', 'dd-mm-yyyy'), null, 'Antonio Davis', 537801101, null, 649);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (551, 'Charles', 'Wright', to_date('24-12-2018', 'dd-mm-yyyy'), null, 'Sophia Wright', 525528880, null, 650);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (552, 'Javier', 'Lopez', to_date('09-12-2020', 'dd-mm-yyyy'), 'Dairy', 'Daisy Lopez', 597011403, null, 651);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (553, 'Jade', 'Hernandez', to_date('03-06-2018', 'dd-mm-yyyy'), null, 'Jordan Hernandez', 516591109, null, 652);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (554, 'Brielle', 'Wright', to_date('13-06-2022', 'dd-mm-yyyy'), 'Peanuts', 'Grace Wright', 549668558, null, 653);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (555, 'Lola', 'Cruz', to_date('03-11-2019', 'dd-mm-yyyy'), 'Gluten', 'Aria Cruz', 578393812, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (556, 'Rosalie', 'Wilson', to_date('13-10-2019', 'dd-mm-yyyy'), 'Dairy', 'Charlotte Wilson', 593642123, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (557, 'Jack', 'Thomas', to_date('01-04-2019', 'dd-mm-yyyy'), 'Peanuts', 'Benjamin Thomas', 537154083, null, 656);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (558, 'Callie', 'Lopez', to_date('09-04-2019', 'dd-mm-yyyy'), 'Peanuts', 'Dennis Lopez', 545196694, null, 657);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (559, 'Joan', 'Walker', to_date('06-12-2018', 'dd-mm-yyyy'), 'Dairy', 'Hannah Walker', 532094533, null, 658);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (560, 'Samantha', 'Miller', to_date('14-01-2018', 'dd-mm-yyyy'), null, 'Genevieve Miller', 554528598, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (561, 'Anna', 'Walker', to_date('08-10-2021', 'dd-mm-yyyy'), null, 'Nora Walker', 550623016, null, 660);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (562, 'Christopher', 'Young', to_date('07-07-2019', 'dd-mm-yyyy'), null, 'Hope Young', 533218119, null, 661);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (563, 'Lydia', 'Nelson', to_date('28-01-2023', 'dd-mm-yyyy'), null, 'Ella Nelson', 573708971, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (564, 'Miguel', 'Garcia', to_date('21-03-2022', 'dd-mm-yyyy'), 'Gluten', 'Ava Garcia', 540741461, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (565, 'Leah', 'Scott', to_date('23-04-2023', 'dd-mm-yyyy'), null, 'Ruby Scott', 592965868, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (566, 'Kinsley', 'Roberts', to_date('15-09-2020', 'dd-mm-yyyy'), 'Dairy', 'Layla Roberts', 551193054, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (567, 'Reagan', 'Johnson', to_date('02-02-2019', 'dd-mm-yyyy'), null, 'Evelyn Johnson', 597960280, null, 666);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (568, 'Jonathan', 'Mitchell', to_date('13-10-2023', 'dd-mm-yyyy'), 'Dairy', 'Kaylee Mitchell', 544776575, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (569, 'Jordan', 'Young', to_date('29-09-2023', 'dd-mm-yyyy'), null, 'Emery Young', 561168155, null, 668);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (570, 'Amelia', 'Thomas', to_date('22-05-2018', 'dd-mm-yyyy'), 'Peanuts', 'Eric Thomas', 525391672, null, 669);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (571, 'Kevin', 'Robinson', to_date('28-02-2022', 'dd-mm-yyyy'), 'Dairy', 'Mila Robinson', 516804246, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (572, 'Isabelle', 'Rogers', to_date('20-02-2018', 'dd-mm-yyyy'), 'Dairy', 'Olivia Rogers', 559429017, null, 671);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (573, 'Ella', 'Moore', to_date('25-09-2022', 'dd-mm-yyyy'), null, 'Joan Moore', 533661142, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (574, 'Leilani', 'Rodriguez', to_date('20-03-2019', 'dd-mm-yyyy'), 'Dairy', 'Jordan Rodriguez', 588072382, null, 673);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (575, 'Avery', 'Clark', to_date('04-02-2019', 'dd-mm-yyyy'), null, 'Alexandra Clark', 517658922, null, 674);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (576, 'Eliana', 'Lopez', to_date('18-10-2019', 'dd-mm-yyyy'), 'Gluten', 'Brandon Lopez', 526993207, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (577, 'Leah', 'Davis', to_date('02-06-2020', 'dd-mm-yyyy'), null, 'Joseph Davis', 552418898, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (578, 'Anthony', 'Walker', to_date('13-04-2022', 'dd-mm-yyyy'), 'Peanuts', 'Olivia Walker', 567612673, null, 677);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (579, 'Nora', 'Allen', to_date('18-12-2020', 'dd-mm-yyyy'), null, 'Melanie Allen', 526119716, null, 678);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (580, 'Leilani', 'Thompson', to_date('27-05-2019', 'dd-mm-yyyy'), null, 'Maya Thompson', 577660846, null, 679);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (581, 'Hannah', 'Scott', to_date('01-11-2022', 'dd-mm-yyyy'), 'Dairy', 'Zoey Scott', 551471973, null, 680);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (582, 'Cameron', 'Young', to_date('23-02-2018', 'dd-mm-yyyy'), 'Gluten', 'Lily Young', 558168909, null, 681);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (583, 'Sadie', 'Kim', to_date('28-01-2021', 'dd-mm-yyyy'), 'Peanuts', 'Allison Kim', 587046453, null, 682);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (584, 'Delilah', 'Hernandez', to_date('06-06-2018', 'dd-mm-yyyy'), 'Dairy', 'Vivienne Hernandez', 540198348, null, 683);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (585, 'Lucas', 'Lopez', to_date('06-06-2019', 'dd-mm-yyyy'), null, 'Gianna Lopez', 515667833, null, 684);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (586, 'Brooklyn', 'Allen', to_date('22-09-2022', 'dd-mm-yyyy'), 'Gluten', 'Savannah Allen', 577653047, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (587, 'Anthony', 'Davis', to_date('16-08-2018', 'dd-mm-yyyy'), null, 'Cameron Davis', 515991972, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (588, 'Chad', 'Cruz', to_date('29-10-2018', 'dd-mm-yyyy'), null, 'Julia Cruz', 520082502, null, 687);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (589, 'David', 'Wright', to_date('03-03-2022', 'dd-mm-yyyy'), null, 'Cora Wright', 548591749, null, 688);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (590, 'Samantha', 'Hernandez', to_date('19-05-2023', 'dd-mm-yyyy'), 'Gluten', 'Gabriella Hernandez', 548177272, null, 689);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (591, 'Edward', 'Clark', to_date('15-08-2022', 'dd-mm-yyyy'), 'Peanuts', 'Piper Clark', 512682038, null, 690);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (592, 'Allison', 'Lewis', to_date('10-05-2020', 'dd-mm-yyyy'), null, 'Austin Lewis', 582492328, null, 691);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (593, 'Piper', 'Moore', to_date('02-05-2020', 'dd-mm-yyyy'), null, 'Samantha Moore', 525732705, null, 692);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (594, 'Anna', 'Roberts', to_date('25-09-2018', 'dd-mm-yyyy'), null, 'Jayden Roberts', 530842507, null, 693);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (595, 'Adalyn', 'Taylor', to_date('29-01-2022', 'dd-mm-yyyy'), null, 'Adeline Taylor', 599187570, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (596, 'Hazel', 'Evans', to_date('31-07-2021', 'dd-mm-yyyy'), null, 'Madilyn Evans', 529891675, null, 695);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (597, 'Aaliyah', 'Allen', to_date('22-06-2019', 'dd-mm-yyyy'), 'Gluten', 'Piper Allen', 554417989, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (598, 'Reagan', 'Garcia', to_date('11-03-2020', 'dd-mm-yyyy'), 'Peanuts', 'Benjamin Garcia', 598025101, null, 697);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (599, 'Henry', 'Nelson', to_date('21-08-2023', 'dd-mm-yyyy'), null, 'Sloane Nelson', 587679797, null, 698);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (600, 'Autumn', 'Evans', to_date('17-06-2020', 'dd-mm-yyyy'), 'Peanuts', 'Madeline Evans', 554843888, null, 699);
commit;
prompt 600 records committed...
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (601, 'Joshua', 'Carter', to_date('24-09-2022', 'dd-mm-yyyy'), null, 'Justin Carter', 561777302, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (602, 'Isaiah', 'Brown', to_date('22-01-2023', 'dd-mm-yyyy'), 'Gluten', 'Lila Brown', 588463654, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (603, 'Aria', 'Williams', to_date('07-03-2023', 'dd-mm-yyyy'), null, 'Cora Williams', 587312013, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (604, 'Catalina', 'Sanchez', to_date('12-09-2019', 'dd-mm-yyyy'), 'Peanuts', 'Nicole Sanchez', 523716282, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (605, 'Gabriella', 'Allen', to_date('22-06-2018', 'dd-mm-yyyy'), null, 'Dustin Allen', 599773224, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (606, 'Lawrence', 'Robinson', to_date('14-07-2021', 'dd-mm-yyyy'), null, 'Leonardo Robinson', 542244037, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (607, 'Nathan', 'Hernandez', to_date('11-05-2023', 'dd-mm-yyyy'), 'Gluten', 'Chloe Hernandez', 583243421, null, 706);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (608, 'Taylor', 'Smith', to_date('01-10-2018', 'dd-mm-yyyy'), 'Gluten', 'Clara Smith', 588354344, null, 707);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (609, 'Jonathan', 'Moore', to_date('26-04-2020', 'dd-mm-yyyy'), null, 'Alan Moore', 574490594, null, 708);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (610, 'Eva', 'Sanchez', to_date('07-01-2018', 'dd-mm-yyyy'), 'Dairy', 'Jack Sanchez', 599516522, null, 709);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (611, 'Brianna', 'Lopez', to_date('01-09-2019', 'dd-mm-yyyy'), 'Peanuts', 'Caleb Lopez', 571746241, null, 710);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (612, 'Claire', 'Lee', to_date('07-06-2021', 'dd-mm-yyyy'), null, 'Aurora Lee', 520854657, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (613, 'Cameron', 'Garcia', to_date('01-09-2018', 'dd-mm-yyyy'), 'Gluten', 'Everly Garcia', 542045620, null, 712);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (614, 'Henry', 'Hernandez', to_date('18-10-2018', 'dd-mm-yyyy'), null, 'Arabella Hernandez', 557597032, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (615, 'Lila', 'Moore', to_date('30-07-2020', 'dd-mm-yyyy'), null, 'Claire Moore', 571134822, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (616, 'Jesse', 'Robinson', to_date('15-12-2018', 'dd-mm-yyyy'), 'Gluten', 'Jonathan Robinson', 575911656, null, 715);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (617, 'Natalie', 'Hernandez', to_date('17-12-2021', 'dd-mm-yyyy'), null, 'Andrea Hernandez', 550433498, null, 716);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (618, 'Anthony', 'Nelson', to_date('28-02-2023', 'dd-mm-yyyy'), 'Peanuts', 'Chad Nelson', 578991936, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (619, 'Dustin', 'Carter', to_date('18-10-2022', 'dd-mm-yyyy'), 'Peanuts', 'Elena Carter', 520107809, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (620, 'Cody', 'Clark', to_date('26-08-2022', 'dd-mm-yyyy'), null, 'Hazel Clark', 534554614, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (621, 'Aurora', 'Walker', to_date('21-11-2021', 'dd-mm-yyyy'), null, 'Lucas Walker', 565571371, null, 720);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (622, 'Leah', 'Garcia', to_date('19-05-2020', 'dd-mm-yyyy'), null, 'Ezekiel Garcia', 523681128, null, 721);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (623, 'Antonio', 'Garcia', to_date('08-03-2023', 'dd-mm-yyyy'), null, 'Josephine Garcia', 551076076, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (624, 'Vivienne', 'Williams', to_date('07-01-2022', 'dd-mm-yyyy'), 'Dairy', 'Bailey Williams', 524114967, null, 723);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (625, 'Keira', 'Clark', to_date('26-09-2018', 'dd-mm-yyyy'), null, 'Kinsley Clark', 583902230, null, 724);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (626, 'Keira', 'Cruz', to_date('21-09-2022', 'dd-mm-yyyy'), null, 'Isaiah Cruz', 539439900, null, 725);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (627, 'Skylar', 'Nelson', to_date('06-06-2023', 'dd-mm-yyyy'), 'Dairy', 'Sloane Nelson', 540364597, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (628, 'Dylan', 'Miller', to_date('13-03-2019', 'dd-mm-yyyy'), 'Gluten', 'Gregory Miller', 541925194, null, 727);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (629, 'Nora', 'Lopez', to_date('08-08-2019', 'dd-mm-yyyy'), null, 'Daniel Lopez', 537182821, null, 728);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (630, 'Bailey', 'Thomas', to_date('03-07-2023', 'dd-mm-yyyy'), 'Gluten', 'Elena Thomas', 511359084, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (631, 'Sloane', 'Lopez', to_date('27-04-2023', 'dd-mm-yyyy'), 'Peanuts', 'Madelyn Lopez', 564868683, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (632, 'Chad', 'Evans', to_date('14-04-2019', 'dd-mm-yyyy'), 'Dairy', 'Anthony Evans', 531135702, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (633, 'Violet', 'Campbell', to_date('15-09-2023', 'dd-mm-yyyy'), 'Peanuts', 'Madeline Campbell', 523848478, null, 732);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (634, 'Alice', 'Lee', to_date('27-11-2022', 'dd-mm-yyyy'), 'Gluten', 'Jacob Lee', 596542065, null, 733);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (635, 'Lucy', 'Moore', to_date('12-10-2023', 'dd-mm-yyyy'), null, 'Ava Moore', 568501898, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (636, 'Isaiah', 'Jones', to_date('06-08-2018', 'dd-mm-yyyy'), 'Peanuts', 'Hannah Jones', 562468433, null, 735);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (637, 'Juan', 'Nelson', to_date('28-09-2020', 'dd-mm-yyyy'), 'Gluten', 'Zoey Nelson', 522823206, null, 736);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (638, 'Cora', 'Sanchez', to_date('25-02-2018', 'dd-mm-yyyy'), 'Dairy', 'Juliet Sanchez', 574742174, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (639, 'Sophia', 'Sanchez', to_date('17-05-2020', 'dd-mm-yyyy'), 'Gluten', 'Lola Sanchez', 597753559, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (640, 'Isaiah', 'Thompson', to_date('04-10-2023', 'dd-mm-yyyy'), null, 'Lillian Thompson', 512883900, null, 739);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (641, 'Dustin', 'Lee', to_date('25-06-2019', 'dd-mm-yyyy'), 'Gluten', 'Madison Lee', 530911364, null, 740);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (642, 'Juan', 'King', to_date('01-05-2023', 'dd-mm-yyyy'), 'Peanuts', 'David King', 518256808, null, 741);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (643, 'Dustin', 'Wilson', to_date('12-07-2018', 'dd-mm-yyyy'), null, 'Joseph Wilson', 589558609, null, 742);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (644, 'Vivienne', 'Evans', to_date('18-01-2018', 'dd-mm-yyyy'), null, 'Gianna Evans', 552546833, null, 743);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (645, 'Jonathan', 'Lopez', to_date('11-04-2021', 'dd-mm-yyyy'), null, 'Olivia Lopez', 535228153, null, 744);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (646, 'Caroline', 'Scott', to_date('01-10-2020', 'dd-mm-yyyy'), 'Dairy', 'Henry Scott', 569203857, null, 745);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (647, 'Isla', 'Allen', to_date('15-09-2023', 'dd-mm-yyyy'), 'Gluten', 'Callie Allen', 545762532, null, 746);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (648, 'Nora', 'Davis', to_date('23-06-2021', 'dd-mm-yyyy'), 'Peanuts', 'George Davis', 523834095, null, 747);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (649, 'Felipe', 'Moore', to_date('28-08-2023', 'dd-mm-yyyy'), null, 'Scarlett Moore', 559904494, null, 748);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (650, 'Lily', 'Young', to_date('22-10-2018', 'dd-mm-yyyy'), 'Gluten', 'Jasmine Young', 554481990, null, 749);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (651, 'Gregory', 'Nelson', to_date('01-12-2019', 'dd-mm-yyyy'), null, 'Amelia Nelson', 556335255, null, 750);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (652, 'Evelyn', 'Garcia', to_date('29-07-2020', 'dd-mm-yyyy'), 'Dairy', 'Quinn Garcia', 568940114, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (653, 'Alexis', 'Campbell', to_date('27-12-2020', 'dd-mm-yyyy'), null, 'Jordan Campbell', 555023396, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (654, 'Keith', 'Diaz', to_date('11-07-2023', 'dd-mm-yyyy'), null, 'Cole Diaz', 553404738, null, 753);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (655, 'Andrew', 'Lopez', to_date('26-02-2021', 'dd-mm-yyyy'), null, 'Eden Lopez', 558004193, null, 754);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (656, 'Genevieve', 'Ramirez', to_date('23-10-2019', 'dd-mm-yyyy'), null, 'Natalie Ramirez', 565672100, null, 755);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (657, 'Lillian', 'Davis', to_date('16-01-2019', 'dd-mm-yyyy'), 'Dairy', 'Jonathan Davis', 510614731, null, 756);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (658, 'Isabelle', 'Nguyen', to_date('28-05-2023', 'dd-mm-yyyy'), 'Peanuts', 'Jonathan Nguyen', 589320897, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (659, 'Henry', 'Rogers', to_date('20-06-2021', 'dd-mm-yyyy'), 'Peanuts', 'Addison Rogers', 571978640, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (660, 'Chloe', 'Garcia', to_date('28-11-2023', 'dd-mm-yyyy'), null, 'Derek Garcia', 563056508, null, 759);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (661, 'Madison', 'Allen', to_date('13-04-2018', 'dd-mm-yyyy'), null, 'Anthony Allen', 511761380, null, 760);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (662, 'George', 'Robinson', to_date('02-05-2019', 'dd-mm-yyyy'), null, 'Douglas Robinson', 524777503, null, 761);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (663, 'Gabriella', 'Walker', to_date('27-12-2018', 'dd-mm-yyyy'), null, 'Miguel Walker', 579839183, null, 762);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (664, 'Eden', 'Allen', to_date('11-08-2020', 'dd-mm-yyyy'), 'Peanuts', 'Alice Allen', 590925510, null, 763);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (665, 'Serenity', 'Mitchell', to_date('21-04-2021', 'dd-mm-yyyy'), 'Peanuts', 'Skylar Mitchell', 583931611, null, 764);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (666, 'Madelyn', 'Allen', to_date('30-08-2020', 'dd-mm-yyyy'), 'Peanuts', 'Brielle Allen', 597688730, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (667, 'Daisy', 'Adams', to_date('24-03-2022', 'dd-mm-yyyy'), 'Gluten', 'Aaliyah Adams', 556669124, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (668, 'Lillian', 'Lopez', to_date('10-08-2019', 'dd-mm-yyyy'), null, 'Adam Lopez', 567054683, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (669, 'Henry', 'Lee', to_date('05-01-2023', 'dd-mm-yyyy'), null, 'Caroline Lee', 583118597, null, 768);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (670, 'Juliet', 'Moore', to_date('13-08-2020', 'dd-mm-yyyy'), 'Dairy', 'Isabella Moore', 597318941, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (671, 'John', 'Thompson', to_date('05-04-2020', 'dd-mm-yyyy'), null, 'Melanie Thompson', 510219075, null, 770);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (672, 'Luna', 'Thomas', to_date('20-08-2023', 'dd-mm-yyyy'), 'Dairy', 'Eden Thomas', 567387124, null, 771);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (673, 'David', 'Nguyen', to_date('24-10-2022', 'dd-mm-yyyy'), 'Gluten', 'Brooklyn Nguyen', 560461856, null, 772);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (674, 'Eva', 'Clark', to_date('05-08-2020', 'dd-mm-yyyy'), 'Gluten', 'Brielle Clark', 556352351, null, 773);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (675, 'Chloe', 'Wilson', to_date('27-01-2020', 'dd-mm-yyyy'), null, 'Ellie Wilson', 570099660, null, 774);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (676, 'Douglas', 'Walker', to_date('15-01-2023', 'dd-mm-yyyy'), null, 'Alexis Walker', 543327062, null, 775);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (677, 'Christopher', 'Watson', to_date('28-12-2022', 'dd-mm-yyyy'), 'Peanuts', 'Chloe Watson', 515139839, null, 776);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (678, 'Delilah', 'Moore', to_date('10-02-2020', 'dd-mm-yyyy'), 'Dairy', 'Maya Moore', 510408518, null, 777);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (679, 'Lillian', 'Davis', to_date('17-06-2021', 'dd-mm-yyyy'), 'Dairy', 'Nathan Davis', 545768481, null, 778);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (680, 'Joshua', 'Allen', to_date('11-01-2022', 'dd-mm-yyyy'), null, 'Aaron Allen', 533779820, null, 779);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (681, 'Ezekiel', 'Rodriguez', to_date('12-10-2018', 'dd-mm-yyyy'), 'Peanuts', 'Nicole Rodriguez', 544323729, null, 780);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (682, 'Savannah', 'Thompson', to_date('17-07-2020', 'dd-mm-yyyy'), 'Gluten', 'Brielle Thompson', 595584090, null, 781);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (683, 'Elena', 'Clark', to_date('21-02-2019', 'dd-mm-yyyy'), null, 'Violet Clark', 547386942, null, 782);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (684, 'Kaitlyn', 'Hernandez', to_date('02-06-2019', 'dd-mm-yyyy'), 'Gluten', 'Ethan Hernandez', 558220451, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (685, 'Adam', 'Nguyen', to_date('08-09-2019', 'dd-mm-yyyy'), 'Gluten', 'Alan Nguyen', 593904398, null, 784);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (686, 'Sophia', 'Allen', to_date('27-06-2021', 'dd-mm-yyyy'), 'Dairy', 'Lawrence Allen', 521450074, null, 785);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (687, 'Benjamin', 'Roy', to_date('23-02-2023', 'dd-mm-yyyy'), 'Dairy', 'Amaya Roy', 571088165, null, 786);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (688, 'Everly', 'Carter', to_date('08-09-2018', 'dd-mm-yyyy'), null, 'Hope Carter', 526613506, null, 787);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (689, 'Sophia', 'Robinson', to_date('01-01-2022', 'dd-mm-yyyy'), 'Gluten', 'Dylan Robinson', 556608833, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (690, 'Madison', 'Smith', to_date('11-04-2020', 'dd-mm-yyyy'), null, 'Vivian Smith', 558693562, null, 789);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (691, 'Gregory', 'Wilson', to_date('11-05-2023', 'dd-mm-yyyy'), 'Dairy', 'Arabella Wilson', 580624509, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (692, 'Chloe', 'Wilson', to_date('03-07-2020', 'dd-mm-yyyy'), null, 'Isaiah Wilson', 584213398, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (693, 'Leilani', 'Brown', to_date('28-12-2019', 'dd-mm-yyyy'), 'Peanuts', 'Sloane Brown', 553788572, null, 792);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (694, 'Aurora', 'Young', to_date('05-11-2023', 'dd-mm-yyyy'), null, 'Willow Young', 522460390, null, 793);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (695, 'Kaitlyn', 'Carter', to_date('23-09-2019', 'dd-mm-yyyy'), 'Dairy', 'David Carter', 570516958, null, 794);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (696, 'Emery', 'Young', to_date('26-07-2022', 'dd-mm-yyyy'), null, 'Rosalie Young', 541634495, null, 795);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (697, 'Justin', 'Clark', to_date('19-05-2023', 'dd-mm-yyyy'), 'Gluten', 'Julia Clark', 557843191, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (698, 'Brianna', 'Young', to_date('25-10-2021', 'dd-mm-yyyy'), 'Peanuts', 'Ruby Young', 519585550, null, 797);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (699, 'Willow', 'Smith', to_date('13-03-2019', 'dd-mm-yyyy'), 'Dairy', 'Isaiah Smith', 594048435, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (700, 'Isaiah', 'Rodriguez', to_date('07-11-2018', 'dd-mm-yyyy'), null, 'Isaac Rodriguez', 577415946, null, 799);
commit;
prompt 700 records committed...
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (701, 'Albert', 'Lee', to_date('05-01-2023', 'dd-mm-yyyy'), 'Peanuts', 'Eden Lee', 541027876, null, 800);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (702, 'Joan', 'Garcia', to_date('14-05-2019', 'dd-mm-yyyy'), null, 'Derek Garcia', 575277786, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (703, 'Hannah', 'Lewis', to_date('13-12-2020', 'dd-mm-yyyy'), 'Gluten', 'Callie Lewis', 596896650, null, 802);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (704, 'Amelia', 'Rodriguez', to_date('25-11-2018', 'dd-mm-yyyy'), null, 'Aurora Rodriguez', 567178237, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (705, 'Leonardo', 'Jones', to_date('01-06-2023', 'dd-mm-yyyy'), 'Gluten', 'Layla Jones', 575086506, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (706, 'Sadie', 'Watson', to_date('20-11-2019', 'dd-mm-yyyy'), 'Peanuts', 'Kevin Watson', 587400513, null, 805);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (707, 'Alaina', 'Hall', to_date('15-03-2020', 'dd-mm-yyyy'), 'Dairy', 'Bella Hall', 587103254, null, 806);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (708, 'Quinn', 'Davis', to_date('24-10-2020', 'dd-mm-yyyy'), null, 'Eva Davis', 570132215, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (709, 'Albert', 'Moore', to_date('16-07-2018', 'dd-mm-yyyy'), null, 'Samantha Moore', 522025110, null, 808);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (710, 'Javier', 'Lopez', to_date('20-05-2023', 'dd-mm-yyyy'), 'Gluten', 'Hazel Lopez', 571522290, null, 809);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (711, 'Leilani', 'Thomas', to_date('04-12-2021', 'dd-mm-yyyy'), 'Dairy', 'Delilah Thomas', 573756558, null, 810);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (712, 'Dennis', 'Williams', to_date('01-11-2019', 'dd-mm-yyyy'), 'Peanuts', 'Hannah Williams', 539560187, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (713, 'Benjamin', 'King', to_date('28-11-2023', 'dd-mm-yyyy'), null, 'Ava King', 584601823, null, 812);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (714, 'Jordan', 'Hernandez', to_date('28-01-2020', 'dd-mm-yyyy'), null, 'Millie Hernandez', 538128684, null, 813);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (715, 'Aaron', 'Davis', to_date('25-07-2019', 'dd-mm-yyyy'), 'Dairy', 'Josephine Davis', 552677540, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (716, 'Clara', 'Wright', to_date('12-05-2019', 'dd-mm-yyyy'), 'Gluten', 'Benjamin Wright', 579764863, null, 815);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (717, 'Adalyn', 'Davis', to_date('01-08-2023', 'dd-mm-yyyy'), 'Dairy', 'Jacob Davis', 597297557, null, 816);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (718, 'Charlotte', 'Green', to_date('14-08-2018', 'dd-mm-yyyy'), 'Dairy', 'Felipe Green', 522032236, null, 817);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (719, 'David', 'Johnson', to_date('07-02-2023', 'dd-mm-yyyy'), 'Gluten', 'Alaina Johnson', 538242802, null, 818);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (720, 'Arabella', 'Taylor', to_date('19-03-2018', 'dd-mm-yyyy'), null, 'Quinn Taylor', 529052596, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (721, 'Javier', 'Garcia', to_date('24-03-2018', 'dd-mm-yyyy'), 'Dairy', 'Allison Garcia', 549635635, null, 820);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (722, 'Adam', 'Kim', to_date('19-02-2022', 'dd-mm-yyyy'), null, 'Ella Kim', 572835254, null, 821);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (723, 'Rylee', 'Williams', to_date('27-08-2023', 'dd-mm-yyyy'), null, 'Scarlett Williams', 553562760, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (724, 'Adalyn', 'Nelson', to_date('23-11-2018', 'dd-mm-yyyy'), 'Dairy', 'Isabella Nelson', 528809218, null, 823);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (725, 'Charles', 'Allen', to_date('09-11-2022', 'dd-mm-yyyy'), 'Gluten', 'Douglas Allen', 565769931, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (726, 'Antonio', 'Garcia', to_date('03-03-2019', 'dd-mm-yyyy'), null, 'Gabriel Garcia', 568027178, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (727, 'Jade', 'Mitchell', to_date('10-05-2020', 'dd-mm-yyyy'), 'Gluten', 'Isabelle Mitchell', 526803571, null, 826);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (728, 'Catalina', 'Nelson', to_date('05-12-2019', 'dd-mm-yyyy'), null, 'Antonio Nelson', 556170272, null, 827);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (729, 'Kennedy', 'Miller', to_date('09-09-2019', 'dd-mm-yyyy'), 'Peanuts', 'Madelyn Miller', 527195525, null, 828);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (730, 'Kennedy', 'Rogers', to_date('07-12-2018', 'dd-mm-yyyy'), 'Dairy', 'Gregory Rogers', 589218583, null, 829);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (731, 'Chloe', 'Johnson', to_date('02-02-2018', 'dd-mm-yyyy'), 'Gluten', 'Austin Johnson', 544464441, null, 830);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (732, 'Juan', 'Wright', to_date('20-06-2019', 'dd-mm-yyyy'), 'Dairy', 'Reagan Wright', 564878785, null, 831);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (733, 'Dennis', 'Rogers', to_date('06-09-2023', 'dd-mm-yyyy'), null, 'Benjamin Rogers', 571201255, null, 832);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (734, 'Ruby', 'Martinez', to_date('01-02-2019', 'dd-mm-yyyy'), 'Dairy', 'Eliza Martinez', 596851840, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (735, 'Brianna', 'Diaz', to_date('10-12-2018', 'dd-mm-yyyy'), 'Dairy', 'Eliana Diaz', 516628526, null, 834);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (736, 'Evelyn', 'Lopez', to_date('16-09-2023', 'dd-mm-yyyy'), null, 'Willow Lopez', 548957130, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (737, 'Joseph', 'Garcia', to_date('26-06-2022', 'dd-mm-yyyy'), 'Gluten', 'Leonardo Garcia', 597341129, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (738, 'Everly', 'Rogers', to_date('16-09-2021', 'dd-mm-yyyy'), null, 'Juliet Rogers', 589578943, null, 837);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (739, 'Kaylee', 'Moore', to_date('05-06-2018', 'dd-mm-yyyy'), 'Peanuts', 'Gianna Moore', 546811506, null, 838);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (740, 'Ivy', 'Nguyen', to_date('19-11-2019', 'dd-mm-yyyy'), 'Gluten', 'Teagan Nguyen', 518396629, null, 839);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (741, 'Keira', 'Lee', to_date('12-04-2019', 'dd-mm-yyyy'), null, 'Taylor Lee', 537390208, null, 840);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (742, 'Callie', 'Cruz', to_date('08-06-2021', 'dd-mm-yyyy'), 'Peanuts', 'Luna Cruz', 516188935, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (743, 'Aubrey', 'Moore', to_date('31-05-2022', 'dd-mm-yyyy'), 'Peanuts', 'Cole Moore', 573180758, null, 842);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (744, 'Diego', 'Rogers', to_date('19-11-2023', 'dd-mm-yyyy'), null, 'Juliet Rogers', 542575530, null, 843);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (745, 'Brianna', 'Walker', to_date('16-01-2023', 'dd-mm-yyyy'), null, 'Adeline Walker', 555276489, null, 844);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (746, 'Delilah', 'Lopez', to_date('23-10-2022', 'dd-mm-yyyy'), 'Dairy', 'Layla Lopez', 586283874, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (747, 'Teagan', 'Moore', to_date('19-09-2018', 'dd-mm-yyyy'), 'Dairy', 'Keith Moore', 542036540, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (748, 'Adam', 'Hall', to_date('01-01-2019', 'dd-mm-yyyy'), 'Peanuts', 'Ruby Hall', 517421636, null, 847);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (749, 'Reagan', 'Adams', to_date('30-07-2018', 'dd-mm-yyyy'), 'Dairy', 'Peyton Adams', 571972845, null, 848);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (750, 'Elena', 'Nelson', to_date('26-03-2018', 'dd-mm-yyyy'), null, 'Ellie Nelson', 562877351, null, 849);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (751, 'Layla', 'Scott', to_date('15-10-2020', 'dd-mm-yyyy'), 'Gluten', 'Nicole Scott', 575200242, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (752, 'Alan', 'Anderson', to_date('07-10-2022', 'dd-mm-yyyy'), 'Peanuts', 'Millie Anderson', 578905527, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (753, 'Madison', 'Young', to_date('17-09-2022', 'dd-mm-yyyy'), 'Gluten', 'Isabelle Young', 535149526, null, 852);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (754, 'Taylor', 'Allen', to_date('01-12-2021', 'dd-mm-yyyy'), 'Gluten', 'Harold Allen', 553633251, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (755, 'Genevieve', 'Wilson', to_date('06-07-2022', 'dd-mm-yyyy'), 'Peanuts', 'Willow Wilson', 546491800, null, 854);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (756, 'Hazel', 'Lewis', to_date('06-04-2018', 'dd-mm-yyyy'), 'Dairy', 'Jasmine Lewis', 578190592, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (757, 'Dustin', 'Allen', to_date('01-06-2023', 'dd-mm-yyyy'), 'Peanuts', 'Autumn Allen', 569005730, null, 856);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (758, 'Eric', 'Moore', to_date('14-09-2021', 'dd-mm-yyyy'), 'Peanuts', 'Julia Moore', 526821995, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (759, 'Diego', 'Robinson', to_date('18-08-2022', 'dd-mm-yyyy'), 'Gluten', 'Stella Robinson', 587013183, null, 858);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (760, 'Evelyn', 'Nguyen', to_date('27-07-2021', 'dd-mm-yyyy'), null, 'Douglas Nguyen', 539640058, null, 859);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (761, 'Harper', 'Wright', to_date('21-06-2020', 'dd-mm-yyyy'), null, 'Ava Wright', 563301783, null, 860);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (762, 'Stella', 'Phillips', to_date('23-06-2020', 'dd-mm-yyyy'), 'Peanuts', 'Leah Phillips', 592387919, null, 861);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (763, 'Avery', 'Moore', to_date('07-08-2018', 'dd-mm-yyyy'), null, 'Nicole Moore', 599549260, null, 862);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (764, 'Gianna', 'Thompson', to_date('21-12-2023', 'dd-mm-yyyy'), null, 'Ezekiel Thompson', 520085268, null, 863);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (765, 'Sophie', 'Taylor', to_date('01-09-2021', 'dd-mm-yyyy'), 'Peanuts', 'Valentina Taylor', 591390039, null, 864);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (766, 'Avery', 'Anderson', to_date('09-12-2020', 'dd-mm-yyyy'), null, 'Gracie Anderson', 540910488, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (767, 'Clara', 'Mitchell', to_date('27-04-2019', 'dd-mm-yyyy'), 'Dairy', 'Julia Mitchell', 545751050, null, 866);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (768, 'Addison', 'Mitchell', to_date('09-05-2019', 'dd-mm-yyyy'), null, 'Rose Mitchell', 528079427, null, 867);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (769, 'Brooklyn', 'Rodriguez', to_date('21-07-2018', 'dd-mm-yyyy'), null, 'Madilyn Rodriguez', 561897400, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (770, 'Ava', 'Miller', to_date('07-02-2020', 'dd-mm-yyyy'), null, 'Sarah Miller', 575067043, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (771, 'Adalyn', 'Brown', to_date('08-02-2018', 'dd-mm-yyyy'), null, 'Jade Brown', 591270389, null, 870);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (772, 'Luna', 'Garcia', to_date('26-04-2021', 'dd-mm-yyyy'), 'Gluten', 'Allison Garcia', 522691087, null, 871);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (773, 'Amaya', 'Young', to_date('25-07-2020', 'dd-mm-yyyy'), null, 'Lillian Young', 592058733, null, 872);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (774, 'Luke', 'Walker', to_date('16-04-2019', 'dd-mm-yyyy'), null, 'Joshua Walker', 570646001, null, 873);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (775, 'Valentina', 'Robinson', to_date('27-11-2022', 'dd-mm-yyyy'), 'Peanuts', 'Isaac Robinson', 549161211, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (776, 'Brian', 'Jones', to_date('03-06-2021', 'dd-mm-yyyy'), 'Gluten', 'Claire Jones', 560467335, null, 875);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (777, 'Addison', 'Cruz', to_date('13-07-2019', 'dd-mm-yyyy'), 'Gluten', 'Vivian Cruz', 515067737, null, 876);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (778, 'Gregory', 'Wright', to_date('17-07-2022', 'dd-mm-yyyy'), 'Peanuts', 'Douglas Wright', 539239445, null, 877);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (779, 'Justin', 'Davis', to_date('28-03-2019', 'dd-mm-yyyy'), 'Peanuts', 'Stella Davis', 511187879, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (780, 'Eliana', 'Scott', to_date('23-01-2022', 'dd-mm-yyyy'), null, 'Athena Scott', 580605324, null, 879);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (781, 'Rosalie', 'Rogers', to_date('25-11-2019', 'dd-mm-yyyy'), null, 'Cora Rogers', 583535602, null, 880);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (782, 'Alice', 'Allen', to_date('14-01-2022', 'dd-mm-yyyy'), null, 'Eliza Allen', 561877915, null, 881);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (783, 'Daisy', 'Mitchell', to_date('21-12-2019', 'dd-mm-yyyy'), 'Gluten', 'Lillian Mitchell', 576382554, null, 882);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (784, 'Kyle', 'Nelson', to_date('08-06-2019', 'dd-mm-yyyy'), null, 'Chad Nelson', 546445295, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (785, 'Ellie', 'Rodriguez', to_date('26-11-2020', 'dd-mm-yyyy'), 'Dairy', 'Lila Rodriguez', 588839878, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (786, 'Aubrey', 'Rodriguez', to_date('08-02-2023', 'dd-mm-yyyy'), 'Peanuts', 'Alexis Rodriguez', 569423896, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (787, 'Caroline', 'Wright', to_date('23-08-2019', 'dd-mm-yyyy'), 'Dairy', 'Willow Wright', 523409258, null, 886);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (788, 'Brooklyn', 'Allen', to_date('06-03-2023', 'dd-mm-yyyy'), null, 'Ellie Allen', 523126520, null, 887);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (789, 'Alice', 'Allen', to_date('07-01-2022', 'dd-mm-yyyy'), 'Dairy', 'Andrew Allen', 530876686, null, 888);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (790, 'Adrian', 'Wright', to_date('03-11-2023', 'dd-mm-yyyy'), null, 'Peyton Wright', 559403965, null, 889);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (791, 'Aurora', 'Harris', to_date('07-05-2019', 'dd-mm-yyyy'), 'Gluten', 'Paisley Harris', 581055223, null, 890);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (792, 'Isaiah', 'Garcia', to_date('30-01-2021', 'dd-mm-yyyy'), 'Peanuts', 'Teagan Garcia', 569307774, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (793, 'Evelyn', 'Lopez', to_date('22-10-2018', 'dd-mm-yyyy'), 'Peanuts', 'Javier Lopez', 567472364, null, 892);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (794, 'Lola', 'Young', to_date('13-12-2019', 'dd-mm-yyyy'), 'Gluten', 'Kevin Young', 534402994, null, null);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (795, 'Paisley', 'Allen', to_date('07-10-2018', 'dd-mm-yyyy'), 'Gluten', 'Keith Allen', 529883841, null, 894);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (796, 'Gianna', 'Miller', to_date('18-01-2019', 'dd-mm-yyyy'), null, 'Miguel Miller', 551828863, null, 895);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (797, 'Lily', 'Lopez', to_date('11-04-2018', 'dd-mm-yyyy'), null, 'Caroline Lopez', 596264733, null, 896);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (798, 'Hazel', 'Garcia', to_date('03-07-2019', 'dd-mm-yyyy'), 'Gluten', 'Juliet Garcia', 564156636, null, 897);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (799, 'Juan', 'Green', to_date('20-09-2020', 'dd-mm-yyyy'), 'Peanuts', 'Gianna Green', 557281659, null, 898);
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (800, 'Luna', 'Ramirez', to_date('25-08-2022', 'dd-mm-yyyy'), null, 'Daniel Ramirez', 515162918, null, 899);
commit;
prompt 800 records committed...
insert into CHILD (childid, first_name, last_name, dateofbirth, allergies, emergencycontactname, emergencycontactphone, medicalconditions, registrationid_)
values (900, 'John', 'Doe', to_date('20-05-2018', 'dd-mm-yyyy'), 'None', 'Jane Doe', 1234567890, 'None', 1);
commit;
prompt 801 records loaded
prompt Loading MATERIAL...
insert into MATERIAL (material_id, name, type, expirydate)
values (6932, 'Cumin', 'plant', to_date('01-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9035, 'Salmon', 'meat', to_date('05-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7040, 'Cocoa Powder', 'dried food', to_date('25-05-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3013, 'Coconut Milk', 'dried food', to_date('01-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2659, 'Coriander', 'plant', to_date('17-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7485, 'Polenta', 'meat', to_date('29-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4155, 'Figs', 'dairy', to_date('26-05-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5204, 'Milk', 'plant', to_date('26-09-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6053, 'Vanilla Beans', 'meat', to_date('01-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7547, 'Sorbet', 'dried food', to_date('05-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9275, 'Eggs', 'dairy', to_date('04-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (781, 'Peppers', 'dried food', to_date('22-10-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7969, 'Stock', 'plant', to_date('10-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6271, 'Shrimp', 'dried food', to_date('21-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2363, 'Quinoa', 'dried food', to_date('18-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1502, 'Turmeric', 'meat', to_date('24-09-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9188, 'Lard', 'dairy', to_date('19-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5796, 'Baking Soda', 'meat', to_date('28-06-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8316, 'Mayonnaise', 'meat', to_date('14-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5905, 'Hazelnuts', 'plant', to_date('16-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2694, 'Orange Juice', 'dairy', to_date('10-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1682, 'Eggplant', 'meat', to_date('16-11-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1233, 'Lemons', 'plant', to_date('02-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9542, 'Jam', 'dairy', to_date('20-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6464, 'Plums', 'meat', to_date('21-06-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9992, 'Chutney', 'meat', to_date('19-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5253, 'Chard', 'dried food', to_date('27-06-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6033, 'Gelatin', 'plant', to_date('20-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1784, 'Chocolate', 'dairy', to_date('15-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6223, 'Cilantro', 'meat', to_date('10-10-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4596, 'Grapes', 'plant', to_date('24-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (992, 'Chia Seeds', 'plant', to_date('29-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (836, 'Scallops', 'plant', to_date('27-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9103, 'Pheasant', 'dried food', to_date('14-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8961, 'Gelatin', 'meat', to_date('12-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5315, 'Chives', 'dried food', to_date('09-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6790, 'Mango', 'dairy', to_date('10-05-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2168, 'Rabbit', 'meat', to_date('20-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1345, 'Coconut', 'dried food', to_date('21-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1604, 'Cumin', 'dairy', to_date('19-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7076, 'Cherries', 'dried food', to_date('19-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6286, 'Pork', 'plant', to_date('03-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1359, 'Peppers', 'dairy', to_date('27-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8477, 'Shrimp', 'meat', to_date('03-09-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (660, 'Sesame Seeds', 'dairy', to_date('18-05-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1580, 'Vanilla', 'meat', to_date('18-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2555, 'Cinnamon', 'dried food', to_date('30-09-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4548, 'Evaporated Milk', 'dried food', to_date('10-11-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9219, 'Condensed Milk', 'dairy', to_date('02-11-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1144, 'Pineapple', 'plant', to_date('30-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4967, 'Seitan', 'dairy', to_date('14-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9674, 'Sage', 'meat', to_date('25-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5474, 'Vanilla', 'dairy', to_date('20-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8779, 'Chickpeas', 'plant', to_date('04-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2242, 'Mango', 'dairy', to_date('17-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3486, 'Cumin', 'meat', to_date('19-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8138, 'Macadamia Nuts', 'meat', to_date('01-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6130, 'Cabbage', 'meat', to_date('24-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7987, 'Cashews', 'meat', to_date('27-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (728, 'Beef', 'plant', to_date('21-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (440, 'Bananas', 'dairy', to_date('16-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8426, 'Tapioca', 'plant', to_date('31-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3694, 'Tomato Sauce', 'dried food', to_date('06-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8997, 'Hummus', 'dried food', to_date('21-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5475, 'Strawberries', 'dried food', to_date('18-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2614, 'Cauliflower', 'dried food', to_date('15-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4288, 'Milk', 'dried food', to_date('13-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6076, 'Tabasco', 'meat', to_date('07-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4731, 'Grapefruit', 'dried food', to_date('10-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3100, 'Peas', 'dairy', to_date('11-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6061, 'Cornstarch', 'plant', to_date('14-10-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5476, 'Chili Powder', 'dried food', to_date('14-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3634, 'Mussels', 'meat', to_date('02-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9483, 'Raspberries', 'meat', to_date('14-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3205, 'Nectarines', 'dried food', to_date('18-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4369, 'Ketchup', 'meat', to_date('15-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8884, 'Peanut Butter', 'meat', to_date('24-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3494, 'Quail', 'dairy', to_date('29-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4360, 'Honeydew', 'meat', to_date('31-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9932, 'Rice', 'meat', to_date('02-05-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5789, 'Pectin', 'plant', to_date('13-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4737, 'Oysters', 'meat', to_date('16-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9940, 'Coriander', 'meat', to_date('09-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6876, 'Tomato Paste', 'meat', to_date('25-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4205, 'Buttermilk', 'dried food', to_date('26-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8819, 'Marmalade', 'meat', to_date('14-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9076, 'Raisins', 'dairy', to_date('28-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3391, 'Kale', 'dairy', to_date('30-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6075, 'Kiwi', 'dried food', to_date('25-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3894, 'Tahini', 'dried food', to_date('21-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5955, 'Zucchini', 'meat', to_date('24-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8481, 'Miso', 'dairy', to_date('24-10-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6798, 'Jam', 'dairy', to_date('11-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6956, 'Honeydew', 'dried food', to_date('21-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9296, 'Honeydew', 'meat', to_date('02-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9195, 'Avocado', 'dried food', to_date('27-05-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1186, 'Sriracha', 'plant', to_date('15-06-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7785, 'Peppers', 'meat', to_date('25-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7280, 'Cashews', 'meat', to_date('20-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5993, 'Tofu', 'dried food', to_date('26-06-2025', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into MATERIAL (material_id, name, type, expirydate)
values (3072, 'Cocoa Powder', 'plant', to_date('07-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (215, 'Broccoli', 'plant', to_date('07-05-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5302, 'Chocolate', 'dairy', to_date('21-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1016, 'Relish', 'meat', to_date('13-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8764, 'Duck', 'dairy', to_date('23-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8226, 'Guacamole', 'dairy', to_date('10-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4591, 'Baking Powder', 'dried food', to_date('22-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8697, 'Macadamia Nuts', 'plant', to_date('21-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1598, 'Tuna', 'meat', to_date('10-05-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6534, 'Yogurt', 'dairy', to_date('20-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1681, 'Rabbit', 'meat', to_date('17-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7375, 'Arugula', 'meat', to_date('25-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7688, 'Salsa', 'dairy', to_date('28-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5739, 'Butterscotch', 'plant', to_date('26-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4943, 'Tomato Paste', 'dried food', to_date('30-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4840, 'Cauliflower', 'plant', to_date('26-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4647, 'Beans', 'dairy', to_date('27-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (256, 'TVP', 'plant', to_date('20-11-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2123, 'Molasses', 'plant', to_date('17-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5869, 'Red Wine Vinega', 'dried food', to_date('27-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6739, 'Peas', 'dairy', to_date('10-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4455, 'Cheese', 'dried food', to_date('04-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6282, 'Honeydew', 'meat', to_date('17-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9157, 'Tortillas', 'dried food', to_date('15-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3006, 'Arrowroot', 'meat', to_date('22-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (595, 'Limes', 'plant', to_date('08-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3731, 'Soy Sauce', 'meat', to_date('05-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4263, 'Pickles', 'meat', to_date('17-06-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3212, 'Pineapple', 'dairy', to_date('07-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4368, 'Ketchup', 'meat', to_date('10-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9771, 'Chives', 'dairy', to_date('04-10-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7744, 'Guacamole', 'meat', to_date('20-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5379, 'Garlic', 'plant', to_date('04-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3027, 'Shrimp', 'dried food', to_date('21-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6825, 'Peas', 'meat', to_date('04-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1289, 'Cheese', 'meat', to_date('11-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2520, 'Rice', 'dairy', to_date('25-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1335, 'Broccoli', 'plant', to_date('30-06-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9984, 'Potatoes', 'dairy', to_date('17-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7065, 'Tapioca', 'dried food', to_date('31-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8984, 'Raisins', 'dried food', to_date('19-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8694, 'Turmeric', 'meat', to_date('22-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5138, 'Agar', 'meat', to_date('18-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6684, 'Pumpkin Seeds', 'meat', to_date('31-10-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4716, 'Plums', 'dried food', to_date('08-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4549, 'Tahini', 'meat', to_date('20-05-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9355, 'Tomato Paste', 'plant', to_date('05-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4804, 'Chutney', 'meat', to_date('17-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5423, 'Coconut', 'plant', to_date('04-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9588, 'Sunflower Seeds', 'meat', to_date('28-10-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3255, 'Paprika', 'plant', to_date('20-05-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8005, 'Cantaloupe', 'meat', to_date('23-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4776, 'Pomegranate', 'dried food', to_date('27-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8191, 'Meat', 'plant', to_date('26-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (341, 'Agar', 'dried food', to_date('29-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3831, 'Beans', 'meat', to_date('19-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7846, 'Lobster', 'meat', to_date('19-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2549, 'Gelato', 'dairy', to_date('15-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7084, 'Nutmeg', 'dairy', to_date('13-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8354, 'Flour', 'dairy', to_date('24-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4588, 'Lamb', 'dried food', to_date('19-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7151, 'White Wine Vine', 'dairy', to_date('16-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3511, 'Sriracha', 'dried food', to_date('24-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5987, 'Limes', 'plant', to_date('14-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6521, 'Ranch Dressing', 'dried food', to_date('22-10-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8745, 'Rabbit', 'dairy', to_date('09-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6653, 'Kiwi', 'dried food', to_date('07-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1790, 'Mushrooms', 'dried food', to_date('26-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1155, 'Salsa', 'meat', to_date('20-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9343, 'Sour Cream', 'meat', to_date('21-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (657, 'Jam', 'dried food', to_date('06-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6445, 'Pesto', 'meat', to_date('01-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4462, 'Cauliflower', 'meat', to_date('27-11-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5228, 'Buffalo', 'dried food', to_date('10-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7491, 'Sorbet', 'meat', to_date('17-10-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7039, 'Oats', 'meat', to_date('13-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6634, 'Almond Butter', 'plant', to_date('03-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2734, 'Cherries', 'dairy', to_date('16-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9234, 'Condensed Milk', 'dairy', to_date('19-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9498, 'Yogurt', 'dairy', to_date('25-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1637, 'Honey', 'dried food', to_date('09-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1520, 'Cumin', 'meat', to_date('12-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4805, 'Apple Cider Vin', 'plant', to_date('18-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6431, 'Miso', 'plant', to_date('30-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2097, 'Raspberries', 'meat', to_date('24-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6478, 'Chard', 'dairy', to_date('22-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7781, 'Miso', 'dairy', to_date('18-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6118, 'Dates', 'dairy', to_date('14-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1392, 'Chili Powder', 'meat', to_date('03-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4661, 'Dates', 'plant', to_date('04-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2375, 'Anchovies', 'plant', to_date('28-06-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1381, 'Figs', 'meat', to_date('07-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (760, 'Bread', 'meat', to_date('01-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3691, 'Watermelon', 'plant', to_date('07-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8531, 'Paprika', 'dairy', to_date('17-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8978, 'Pheasant', 'plant', to_date('09-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6231, 'Cocoa Powder', 'dairy', to_date('04-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9096, 'Pheasant', 'dried food', to_date('01-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (451, 'Cornmeal', 'dried food', to_date('10-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7737, 'Prunes', 'dried food', to_date('11-11-2024', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into MATERIAL (material_id, name, type, expirydate)
values (5967, 'Hemp Seeds', 'dried food', to_date('08-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1642, 'Chili Powder', 'meat', to_date('19-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1543, 'Buttermilk', 'plant', to_date('23-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4098, 'Chocolate', 'dairy', to_date('07-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6403, 'Pectin', 'plant', to_date('03-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2877, 'Chutney', 'dairy', to_date('09-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9451, 'Sorbet', 'plant', to_date('10-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9578, 'Spinach', 'plant', to_date('17-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3464, 'Salsa', 'meat', to_date('06-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9497, 'Mustard', 'plant', to_date('24-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7668, 'Bouillon', 'dairy', to_date('10-10-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (275, 'Scallops', 'dairy', to_date('06-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9120, 'Gelato', 'dairy', to_date('01-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7210, 'Broth', 'plant', to_date('12-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1044, 'Mayonnaise', 'dried food', to_date('16-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1764, 'Tortillas', 'dairy', to_date('02-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8154, 'Shortening', 'meat', to_date('08-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9279, 'Oranges', 'plant', to_date('16-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7238, 'Pineapple', 'dried food', to_date('10-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7605, 'Milk', 'meat', to_date('30-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3975, 'Sour Cream', 'dairy', to_date('24-10-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7202, 'Flaxseeds', 'dairy', to_date('21-11-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (420, 'Parsley', 'meat', to_date('20-05-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (777, 'Limes', 'meat', to_date('26-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (597, 'Sesame Oil', 'dairy', to_date('07-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (926, 'Beans', 'plant', to_date('29-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3169, 'Red Wine Vinega', 'dairy', to_date('02-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3381, 'Relish', 'plant', to_date('04-09-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6811, 'Pistachios', 'dried food', to_date('29-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4374, 'Agar', 'dairy', to_date('01-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2150, 'Quail', 'meat', to_date('07-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1465, 'Carrots', 'dairy', to_date('31-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5977, 'Avocado', 'meat', to_date('17-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7219, 'Lime Juice', 'dried food', to_date('24-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (503, 'Tomato Paste', 'meat', to_date('29-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7160, 'Rice Vinegar', 'dried food', to_date('31-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3098, 'Allspice', 'dried food', to_date('20-10-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8980, 'Peas', 'meat', to_date('28-09-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1876, 'Ginger', 'plant', to_date('09-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6611, 'Eggs', 'plant', to_date('15-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2153, 'Prunes', 'meat', to_date('14-11-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6163, 'Honey', 'plant', to_date('10-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7363, 'Pesto', 'dried food', to_date('05-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5920, 'Quinoa', 'plant', to_date('08-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3034, 'Garlic', 'dairy', to_date('05-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8799, 'Cabbage', 'meat', to_date('12-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2636, 'Molasses', 'meat', to_date('18-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8282, 'Guacamole', 'dried food', to_date('14-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7975, 'Yeast', 'dairy', to_date('23-09-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3892, 'Olive Oil', 'plant', to_date('21-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2104, 'Marmalade', 'dairy', to_date('07-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (428, 'Soy Sauce', 'dried food', to_date('01-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2180, 'Oats', 'plant', to_date('20-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5783, 'Onions', 'meat', to_date('14-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4990, 'Coriander', 'dairy', to_date('15-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7531, 'Tahini', 'dairy', to_date('09-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4035, 'Eggs', 'meat', to_date('15-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7754, 'Bison', 'plant', to_date('28-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3825, 'Oregano', 'dried food', to_date('08-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2109, 'Rabbit', 'plant', to_date('10-09-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7837, 'Lard', 'dairy', to_date('11-06-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1183, 'Seitan', 'meat', to_date('11-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9543, 'Cloves', 'plant', to_date('03-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5886, 'Paprika', 'dried food', to_date('04-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6091, 'Gelatin', 'dairy', to_date('13-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5522, 'Lobster', 'dairy', to_date('20-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5255, 'Figs', 'plant', to_date('16-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8321, 'Vanilla Beans', 'dried food', to_date('09-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6049, 'Honey', 'meat', to_date('15-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6425, 'Chutney', 'meat', to_date('04-09-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1992, 'Mushrooms', 'meat', to_date('05-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2748, 'Tahini', 'meat', to_date('13-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7052, 'Olive Oil', 'meat', to_date('18-11-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1691, 'Rabbit', 'plant', to_date('28-10-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6237, 'Tuna', 'dried food', to_date('01-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2919, 'Broccoli', 'plant', to_date('21-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7261, 'Oysters', 'meat', to_date('13-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7064, 'Salsa', 'meat', to_date('05-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (732, 'Papaya', 'dairy', to_date('04-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8868, 'Bison', 'dairy', to_date('08-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2476, 'Polenta', 'dried food', to_date('22-06-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2379, 'Pesto', 'meat', to_date('18-10-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3083, 'Agar', 'dried food', to_date('29-11-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (539, 'Tomato Paste', 'meat', to_date('11-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6145, 'Lard', 'dried food', to_date('28-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5672, 'Rabbit', 'dairy', to_date('17-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (771, 'Raisins', 'dairy', to_date('23-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8575, 'Shrimp', 'meat', to_date('17-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5145, 'Cornstarch', 'dairy', to_date('13-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6791, 'Prunes', 'dairy', to_date('14-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5491, 'Lard', 'plant', to_date('09-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6360, 'Worcestershire ', 'meat', to_date('14-05-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5893, 'Quinoa', 'dairy', to_date('20-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7014, 'Ranch Dressing', 'meat', to_date('10-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2781, 'Spinach', 'plant', to_date('27-11-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (251, 'Plums', 'plant', to_date('01-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9660, 'Grapes', 'dairy', to_date('03-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7627, 'Almond Butter', 'dried food', to_date('22-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6913, 'Pheasant', 'dried food', to_date('29-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8826, 'Olives', 'dried food', to_date('03-10-2025', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into MATERIAL (material_id, name, type, expirydate)
values (7222, 'Evaporated Milk', 'dried food', to_date('15-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2601, 'Rice Vinegar', 'dairy', to_date('30-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1252, 'Lobster', 'dried food', to_date('10-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4790, 'Cilantro', 'dried food', to_date('05-11-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7707, 'Tortillas', 'dried food', to_date('26-10-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3398, 'Turkey', 'meat', to_date('13-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1561, 'Buttermilk', 'meat', to_date('24-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3531, 'Raisins', 'dried food', to_date('02-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2173, 'Edamame', 'dried food', to_date('10-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6773, 'Cocoa Powder', 'meat', to_date('31-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7649, 'Cornmeal', 'dried food', to_date('15-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3437, 'Yogurt', 'dried food', to_date('05-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (868, 'Polenta', 'dried food', to_date('06-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7078, 'Nectarines', 'plant', to_date('13-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7583, 'Olive Oil', 'dairy', to_date('31-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3861, 'Chutney', 'dairy', to_date('01-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (763, 'Bouillon', 'dried food', to_date('26-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3001, 'Mayonnaise', 'plant', to_date('14-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4025, 'Cumin', 'dairy', to_date('24-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2096, 'Plums', 'dried food', to_date('02-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4304, 'Coconut', 'meat', to_date('16-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1370, 'Broth', 'plant', to_date('08-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9733, 'Apples', 'dried food', to_date('19-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5303, 'Natto', 'plant', to_date('02-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9158, 'Duck', 'dairy', to_date('02-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (956, 'Lard', 'dried food', to_date('07-10-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7959, 'Apples', 'plant', to_date('27-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1080, 'Baking Powder', 'dairy', to_date('17-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7128, 'Chocolate', 'dairy', to_date('01-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1716, 'Anchovies', 'plant', to_date('13-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4679, 'Oregano', 'meat', to_date('06-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4440, 'Tahini', 'dairy', to_date('08-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6095, 'Carrots', 'meat', to_date('14-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8440, 'Lemons', 'meat', to_date('12-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4178, 'Shrimp', 'plant', to_date('03-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6199, 'Lettuce', 'plant', to_date('31-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7297, 'Worcestershire ', 'dairy', to_date('22-06-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8546, 'Canola Oil', 'dairy', to_date('30-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8968, 'Edamame', 'dried food', to_date('12-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8429, 'Milk', 'plant', to_date('04-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9505, 'Cocoa Powder', 'dairy', to_date('17-09-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6538, 'Hemp Seeds', 'meat', to_date('18-06-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1532, 'Pectin', 'dried food', to_date('26-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (804, 'Onions', 'plant', to_date('12-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7554, 'Chickpeas', 'dried food', to_date('16-10-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8348, 'Soy Sauce', 'dairy', to_date('29-10-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2992, 'Cornmeal', 'dried food', to_date('15-05-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2296, 'Almonds', 'dried food', to_date('11-10-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8885, 'Buttermilk', 'dried food', to_date('19-10-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8468, 'Caramel', 'plant', to_date('29-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1442, 'Couscous', 'meat', to_date('28-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9108, 'Cream', 'plant', to_date('24-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1078, 'Milk', 'plant', to_date('23-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6495, 'Grapes', 'meat', to_date('31-08-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7687, 'Gelatin', 'plant', to_date('26-10-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1409, 'Ranch Dressing', 'plant', to_date('09-06-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7597, 'Mayonnaise', 'dairy', to_date('01-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4060, 'Ginger', 'meat', to_date('12-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3177, 'Ice Cream', 'dairy', to_date('24-03-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8880, 'Cilantro', 'plant', to_date('19-10-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6316, 'Guacamole', 'dried food', to_date('27-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1774, 'Chard', 'meat', to_date('05-07-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5551, 'Tapioca', 'dairy', to_date('06-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9645, 'Worcestershire ', 'plant', to_date('16-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4869, 'Rabbit', 'dried food', to_date('21-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5961, 'Jelly', 'dairy', to_date('05-03-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6768, 'Sage', 'dried food', to_date('13-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5609, 'Peanuts', 'meat', to_date('21-01-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8178, 'Hemp Seeds', 'dairy', to_date('27-02-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5992, 'Sage', 'dairy', to_date('24-09-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9249, 'Honey', 'dairy', to_date('20-04-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9599, 'Peanut Butter', 'dairy', to_date('30-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5596, 'Pineapple', 'dairy', to_date('18-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (631, 'Bananas', 'dairy', to_date('21-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3097, 'Mussels', 'dairy', to_date('07-10-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7042, 'Caramel', 'dairy', to_date('09-11-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (4766, 'Bison', 'dried food', to_date('22-09-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (2812, 'Agar', 'dried food', to_date('19-07-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (1782, 'Salmon', 'dried food', to_date('03-02-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (737, 'Pineapple', 'meat', to_date('11-12-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7149, 'Mayonnaise', 'dried food', to_date('01-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (3874, 'Peaches', 'plant', to_date('07-01-2026', 'dd-mm-yyyy'));
commit;
prompt 382 records loaded
prompt Loading CONTAIN...
insert into CONTAIN (quantity, dishs_id, material_id)
values (913488, 664, 1335);
insert into CONTAIN (quantity, dishs_id, material_id)
values (316707, 810, 5379);
insert into CONTAIN (quantity, dishs_id, material_id)
values (926431, 368, 2168);
insert into CONTAIN (quantity, dishs_id, material_id)
values (378892, 668, 8961);
insert into CONTAIN (quantity, dishs_id, material_id)
values (845592, 788, 8826);
insert into CONTAIN (quantity, dishs_id, material_id)
values (398866, 270, 8978);
insert into CONTAIN (quantity, dishs_id, material_id)
values (240874, 154, 5379);
insert into CONTAIN (quantity, dishs_id, material_id)
values (396530, 574, 8826);
insert into CONTAIN (quantity, dishs_id, material_id)
values (943105, 736, 4304);
insert into CONTAIN (quantity, dishs_id, material_id)
values (918062, 402, 836);
insert into CONTAIN (quantity, dishs_id, material_id)
values (624248, 1244, 7076);
insert into CONTAIN (quantity, dishs_id, material_id)
values (45007, 800, 4374);
insert into CONTAIN (quantity, dishs_id, material_id)
values (729467, 626, 2104);
insert into CONTAIN (quantity, dishs_id, material_id)
values (248588, 1320, 7076);
insert into CONTAIN (quantity, dishs_id, material_id)
values (358298, 50, 4360);
insert into CONTAIN (quantity, dishs_id, material_id)
values (193416, 364, 9588);
insert into CONTAIN (quantity, dishs_id, material_id)
values (178104, 328, 3381);
insert into CONTAIN (quantity, dishs_id, material_id)
values (59148, 916, 3098);
insert into CONTAIN (quantity, dishs_id, material_id)
values (172813, 1258, 868);
insert into CONTAIN (quantity, dishs_id, material_id)
values (431044, 1194, 8546);
insert into CONTAIN (quantity, dishs_id, material_id)
values (719773, 234, 428);
insert into CONTAIN (quantity, dishs_id, material_id)
values (355655, 1200, 3097);
insert into CONTAIN (quantity, dishs_id, material_id)
values (970532, 606, 9451);
insert into CONTAIN (quantity, dishs_id, material_id)
values (338546, 1348, 9219);
insert into CONTAIN (quantity, dishs_id, material_id)
values (93238, 994, 7202);
insert into CONTAIN (quantity, dishs_id, material_id)
values (938417, 736, 6876);
insert into CONTAIN (quantity, dishs_id, material_id)
values (432028, 392, 7084);
insert into CONTAIN (quantity, dishs_id, material_id)
values (2, 5, 251);
insert into CONTAIN (quantity, dishs_id, material_id)
values (363570, 228, 956);
insert into CONTAIN (quantity, dishs_id, material_id)
values (977681, 504, 4840);
insert into CONTAIN (quantity, dishs_id, material_id)
values (390035, 994, 4766);
insert into CONTAIN (quantity, dishs_id, material_id)
values (295746, 764, 5303);
insert into CONTAIN (quantity, dishs_id, material_id)
values (126601, 356, 6956);
insert into CONTAIN (quantity, dishs_id, material_id)
values (660262, 474, 9542);
insert into CONTAIN (quantity, dishs_id, material_id)
values (116316, 152, 5423);
insert into CONTAIN (quantity, dishs_id, material_id)
values (918832, 72, 4549);
insert into CONTAIN (quantity, dishs_id, material_id)
values (162230, 1344, 992);
insert into CONTAIN (quantity, dishs_id, material_id)
values (110848, 880, 737);
insert into CONTAIN (quantity, dishs_id, material_id)
values (909152, 1380, 7375);
insert into CONTAIN (quantity, dishs_id, material_id)
values (1996, 1362, 7785);
insert into CONTAIN (quantity, dishs_id, material_id)
values (54447, 244, 8429);
insert into CONTAIN (quantity, dishs_id, material_id)
values (40683, 212, 4025);
insert into CONTAIN (quantity, dishs_id, material_id)
values (624223, 966, 5869);
insert into CONTAIN (quantity, dishs_id, material_id)
values (373603, 1096, 8426);
insert into CONTAIN (quantity, dishs_id, material_id)
values (542239, 28, 9940);
insert into CONTAIN (quantity, dishs_id, material_id)
values (827062, 396, 5476);
insert into CONTAIN (quantity, dishs_id, material_id)
values (37318, 390, 3177);
insert into CONTAIN (quantity, dishs_id, material_id)
values (408398, 1172, 503);
insert into CONTAIN (quantity, dishs_id, material_id)
values (618082, 1276, 1155);
insert into CONTAIN (quantity, dishs_id, material_id)
values (976685, 688, 7065);
insert into CONTAIN (quantity, dishs_id, material_id)
values (181574, 392, 7222);
insert into CONTAIN (quantity, dishs_id, material_id)
values (836209, 342, 4731);
insert into CONTAIN (quantity, dishs_id, material_id)
values (638529, 926, 6431);
insert into CONTAIN (quantity, dishs_id, material_id)
values (175457, 1246, 2549);
insert into CONTAIN (quantity, dishs_id, material_id)
values (48936, 344, 8138);
insert into CONTAIN (quantity, dishs_id, material_id)
values (84029, 536, 4588);
insert into CONTAIN (quantity, dishs_id, material_id)
values (963573, 344, 6118);
insert into CONTAIN (quantity, dishs_id, material_id)
values (378530, 16, 7597);
insert into CONTAIN (quantity, dishs_id, material_id)
values (2, 5, 256);
insert into CONTAIN (quantity, dishs_id, material_id)
values (227384, 660, 5869);
insert into CONTAIN (quantity, dishs_id, material_id)
values (889916, 42, 5145);
insert into CONTAIN (quantity, dishs_id, material_id)
values (644134, 388, 3381);
insert into CONTAIN (quantity, dishs_id, material_id)
values (845416, 682, 7649);
insert into CONTAIN (quantity, dishs_id, material_id)
values (881389, 1170, 8980);
insert into CONTAIN (quantity, dishs_id, material_id)
values (893480, 770, 9542);
insert into CONTAIN (quantity, dishs_id, material_id)
values (662825, 1348, 6521);
insert into CONTAIN (quantity, dishs_id, material_id)
values (524590, 640, 3825);
insert into CONTAIN (quantity, dishs_id, material_id)
values (607647, 1064, 6076);
insert into CONTAIN (quantity, dishs_id, material_id)
values (447563, 214, 215);
insert into CONTAIN (quantity, dishs_id, material_id)
values (186557, 920, 660);
insert into CONTAIN (quantity, dishs_id, material_id)
values (128986, 590, 7959);
insert into CONTAIN (quantity, dishs_id, material_id)
values (665646, 68, 3975);
insert into CONTAIN (quantity, dishs_id, material_id)
values (931295, 162, 1155);
insert into CONTAIN (quantity, dishs_id, material_id)
values (810059, 666, 1252);
insert into CONTAIN (quantity, dishs_id, material_id)
values (554660, 818, 595);
insert into CONTAIN (quantity, dishs_id, material_id)
values (187863, 1008, 4374);
insert into CONTAIN (quantity, dishs_id, material_id)
values (395364, 38, 1381);
insert into CONTAIN (quantity, dishs_id, material_id)
values (808575, 796, 6876);
insert into CONTAIN (quantity, dishs_id, material_id)
values (888269, 1002, 8426);
insert into CONTAIN (quantity, dishs_id, material_id)
values (104970, 626, 4205);
insert into CONTAIN (quantity, dishs_id, material_id)
values (198615, 754, 8546);
insert into CONTAIN (quantity, dishs_id, material_id)
values (983280, 920, 1764);
insert into CONTAIN (quantity, dishs_id, material_id)
values (400807, 892, 597);
insert into CONTAIN (quantity, dishs_id, material_id)
values (783441, 1118, 9984);
insert into CONTAIN (quantity, dishs_id, material_id)
values (719606, 886, 1637);
insert into CONTAIN (quantity, dishs_id, material_id)
values (198238, 386, 1078);
insert into CONTAIN (quantity, dishs_id, material_id)
values (524267, 432, 6223);
insert into CONTAIN (quantity, dishs_id, material_id)
values (104220, 224, 5145);
insert into CONTAIN (quantity, dishs_id, material_id)
values (709920, 692, 5920);
insert into CONTAIN (quantity, dishs_id, material_id)
values (83480, 776, 7969);
insert into CONTAIN (quantity, dishs_id, material_id)
values (36511, 198, 631);
insert into CONTAIN (quantity, dishs_id, material_id)
values (473863, 1370, 2601);
insert into CONTAIN (quantity, dishs_id, material_id)
values (44952, 152, 9542);
insert into CONTAIN (quantity, dishs_id, material_id)
values (330425, 1130, 7781);
insert into CONTAIN (quantity, dishs_id, material_id)
values (821498, 470, 6061);
insert into CONTAIN (quantity, dishs_id, material_id)
values (846381, 818, 9940);
insert into CONTAIN (quantity, dishs_id, material_id)
values (625759, 822, 2992);
insert into CONTAIN (quantity, dishs_id, material_id)
values (700348, 252, 7531);
insert into CONTAIN (quantity, dishs_id, material_id)
values (439011, 276, 4869);
insert into CONTAIN (quantity, dishs_id, material_id)
values (798484, 1048, 3391);
commit;
prompt 100 records committed...
insert into CONTAIN (quantity, dishs_id, material_id)
values (101264, 392, 251);
insert into CONTAIN (quantity, dishs_id, material_id)
values (177614, 1300, 8468);
insert into CONTAIN (quantity, dishs_id, material_id)
values (445901, 770, 3072);
insert into CONTAIN (quantity, dishs_id, material_id)
values (727378, 342, 2549);
insert into CONTAIN (quantity, dishs_id, material_id)
values (781733, 930, 4679);
insert into CONTAIN (quantity, dishs_id, material_id)
values (766589, 564, 3177);
insert into CONTAIN (quantity, dishs_id, material_id)
values (30200, 418, 3861);
insert into CONTAIN (quantity, dishs_id, material_id)
values (234746, 888, 5783);
insert into CONTAIN (quantity, dishs_id, material_id)
values (438901, 694, 1784);
insert into CONTAIN (quantity, dishs_id, material_id)
values (280042, 58, 8697);
insert into CONTAIN (quantity, dishs_id, material_id)
values (513095, 1326, 7959);
insert into CONTAIN (quantity, dishs_id, material_id)
values (564855, 582, 6653);
insert into CONTAIN (quantity, dishs_id, material_id)
values (313806, 842, 6611);
insert into CONTAIN (quantity, dishs_id, material_id)
values (665421, 362, 1876);
insert into CONTAIN (quantity, dishs_id, material_id)
values (221311, 1224, 1442);
insert into CONTAIN (quantity, dishs_id, material_id)
values (422563, 940, 1465);
insert into CONTAIN (quantity, dishs_id, material_id)
values (537913, 1064, 6825);
insert into CONTAIN (quantity, dishs_id, material_id)
values (207414, 58, 9483);
insert into CONTAIN (quantity, dishs_id, material_id)
values (870804, 406, 7064);
insert into CONTAIN (quantity, dishs_id, material_id)
values (933418, 974, 3013);
insert into CONTAIN (quantity, dishs_id, material_id)
values (896024, 1120, 1774);
insert into CONTAIN (quantity, dishs_id, material_id)
values (520667, 226, 7649);
insert into CONTAIN (quantity, dishs_id, material_id)
values (229467, 1020, 8968);
insert into CONTAIN (quantity, dishs_id, material_id)
values (899665, 96, 1409);
insert into CONTAIN (quantity, dishs_id, material_id)
values (342247, 1124, 4178);
insert into CONTAIN (quantity, dishs_id, material_id)
values (134825, 322, 7554);
insert into CONTAIN (quantity, dishs_id, material_id)
values (616072, 236, 7987);
insert into CONTAIN (quantity, dishs_id, material_id)
values (895640, 928, 2748);
insert into CONTAIN (quantity, dishs_id, material_id)
values (297336, 576, 4679);
insert into CONTAIN (quantity, dishs_id, material_id)
values (639978, 1396, 8961);
insert into CONTAIN (quantity, dishs_id, material_id)
values (345765, 806, 4869);
insert into CONTAIN (quantity, dishs_id, material_id)
values (285705, 1098, 8978);
insert into CONTAIN (quantity, dishs_id, material_id)
values (541495, 138, 7846);
insert into CONTAIN (quantity, dishs_id, material_id)
values (174188, 478, 7846);
insert into CONTAIN (quantity, dishs_id, material_id)
values (776546, 626, 1289);
insert into CONTAIN (quantity, dishs_id, material_id)
values (558935, 1286, 9035);
insert into CONTAIN (quantity, dishs_id, material_id)
values (779470, 1128, 5920);
insert into CONTAIN (quantity, dishs_id, material_id)
values (16149, 1132, 1782);
insert into CONTAIN (quantity, dishs_id, material_id)
values (872599, 700, 9542);
insert into CONTAIN (quantity, dishs_id, material_id)
values (206818, 824, 6145);
insert into CONTAIN (quantity, dishs_id, material_id)
values (301016, 1036, 3531);
insert into CONTAIN (quantity, dishs_id, material_id)
values (765838, 1380, 8468);
insert into CONTAIN (quantity, dishs_id, material_id)
values (943527, 618, 5609);
insert into CONTAIN (quantity, dishs_id, material_id)
values (654909, 224, 5379);
insert into CONTAIN (quantity, dishs_id, material_id)
values (123476, 506, 4360);
insert into CONTAIN (quantity, dishs_id, material_id)
values (929004, 676, 6464);
insert into CONTAIN (quantity, dishs_id, material_id)
values (679072, 480, 1381);
insert into CONTAIN (quantity, dishs_id, material_id)
values (144130, 638, 4288);
insert into CONTAIN (quantity, dishs_id, material_id)
values (543859, 514, 781);
insert into CONTAIN (quantity, dishs_id, material_id)
values (64996, 60, 6223);
insert into CONTAIN (quantity, dishs_id, material_id)
values (187909, 858, 4588);
insert into CONTAIN (quantity, dishs_id, material_id)
values (920982, 902, 631);
insert into CONTAIN (quantity, dishs_id, material_id)
values (263925, 1216, 1637);
insert into CONTAIN (quantity, dishs_id, material_id)
values (762788, 818, 5255);
insert into CONTAIN (quantity, dishs_id, material_id)
values (61321, 1312, 7202);
insert into CONTAIN (quantity, dishs_id, material_id)
values (310371, 274, 2812);
insert into CONTAIN (quantity, dishs_id, material_id)
values (986251, 1052, 2097);
insert into CONTAIN (quantity, dishs_id, material_id)
values (466424, 694, 3205);
insert into CONTAIN (quantity, dishs_id, material_id)
values (65771, 1126, 9932);
insert into CONTAIN (quantity, dishs_id, material_id)
values (957568, 1264, 1392);
insert into CONTAIN (quantity, dishs_id, material_id)
values (725021, 1102, 8154);
insert into CONTAIN (quantity, dishs_id, material_id)
values (426580, 984, 3212);
insert into CONTAIN (quantity, dishs_id, material_id)
values (636955, 46, 7959);
insert into CONTAIN (quantity, dishs_id, material_id)
values (291970, 22, 6464);
insert into CONTAIN (quantity, dishs_id, material_id)
values (581287, 114, 7707);
insert into CONTAIN (quantity, dishs_id, material_id)
values (881036, 1232, 5992);
insert into CONTAIN (quantity, dishs_id, material_id)
values (816593, 738, 4060);
insert into CONTAIN (quantity, dishs_id, material_id)
values (286681, 1192, 8531);
insert into CONTAIN (quantity, dishs_id, material_id)
values (750754, 934, 7707);
insert into CONTAIN (quantity, dishs_id, material_id)
values (165423, 452, 8429);
insert into CONTAIN (quantity, dishs_id, material_id)
values (521795, 948, 9343);
insert into CONTAIN (quantity, dishs_id, material_id)
values (845712, 754, 7668);
insert into CONTAIN (quantity, dishs_id, material_id)
values (778210, 478, 4661);
insert into CONTAIN (quantity, dishs_id, material_id)
values (707066, 316, 7042);
insert into CONTAIN (quantity, dishs_id, material_id)
values (288310, 204, 275);
insert into CONTAIN (quantity, dishs_id, material_id)
values (394556, 1106, 1080);
insert into CONTAIN (quantity, dishs_id, material_id)
values (324602, 94, 777);
insert into CONTAIN (quantity, dishs_id, material_id)
values (107242, 568, 5522);
insert into CONTAIN (quantity, dishs_id, material_id)
values (878049, 1352, 781);
insert into CONTAIN (quantity, dishs_id, material_id)
values (502593, 1148, 9645);
insert into CONTAIN (quantity, dishs_id, material_id)
values (962323, 710, 2694);
insert into CONTAIN (quantity, dishs_id, material_id)
values (761610, 1010, 2109);
insert into CONTAIN (quantity, dishs_id, material_id)
values (391742, 220, 1078);
insert into CONTAIN (quantity, dishs_id, material_id)
values (616826, 1162, 5893);
insert into CONTAIN (quantity, dishs_id, material_id)
values (765176, 750, 1784);
insert into CONTAIN (quantity, dishs_id, material_id)
values (725693, 990, 9599);
insert into CONTAIN (quantity, dishs_id, material_id)
values (776156, 482, 8531);
insert into CONTAIN (quantity, dishs_id, material_id)
values (233364, 946, 1637);
insert into CONTAIN (quantity, dishs_id, material_id)
values (706714, 1122, 2109);
insert into CONTAIN (quantity, dishs_id, material_id)
values (775021, 262, 9588);
insert into CONTAIN (quantity, dishs_id, material_id)
values (868800, 30, 6798);
insert into CONTAIN (quantity, dishs_id, material_id)
values (85590, 874, 4591);
insert into CONTAIN (quantity, dishs_id, material_id)
values (134881, 914, 3892);
insert into CONTAIN (quantity, dishs_id, material_id)
values (865751, 1254, 8694);
insert into CONTAIN (quantity, dishs_id, material_id)
values (368293, 676, 2296);
insert into CONTAIN (quantity, dishs_id, material_id)
values (177381, 458, 451);
insert into CONTAIN (quantity, dishs_id, material_id)
values (836604, 40, 6464);
insert into CONTAIN (quantity, dishs_id, material_id)
values (447442, 490, 8191);
insert into CONTAIN (quantity, dishs_id, material_id)
values (372453, 796, 7084);
insert into CONTAIN (quantity, dishs_id, material_id)
values (738881, 588, 7707);
commit;
prompt 200 records committed...
insert into CONTAIN (quantity, dishs_id, material_id)
values (459900, 182, 777);
insert into CONTAIN (quantity, dishs_id, material_id)
values (331338, 704, 3874);
insert into CONTAIN (quantity, dishs_id, material_id)
values (374757, 988, 3894);
insert into CONTAIN (quantity, dishs_id, material_id)
values (433534, 502, 9275);
insert into CONTAIN (quantity, dishs_id, material_id)
values (67887, 1326, 8697);
insert into CONTAIN (quantity, dishs_id, material_id)
values (858866, 1336, 8968);
insert into CONTAIN (quantity, dishs_id, material_id)
values (764089, 1370, 8154);
insert into CONTAIN (quantity, dishs_id, material_id)
values (35703, 934, 251);
insert into CONTAIN (quantity, dishs_id, material_id)
values (882914, 1374, 7846);
insert into CONTAIN (quantity, dishs_id, material_id)
values (889745, 1006, 4804);
insert into CONTAIN (quantity, dishs_id, material_id)
values (695858, 882, 1543);
insert into CONTAIN (quantity, dishs_id, material_id)
values (293211, 274, 2659);
insert into CONTAIN (quantity, dishs_id, material_id)
values (879585, 644, 3177);
insert into CONTAIN (quantity, dishs_id, material_id)
values (914302, 1032, 3531);
insert into CONTAIN (quantity, dishs_id, material_id)
values (714438, 982, 6033);
insert into CONTAIN (quantity, dishs_id, material_id)
values (458613, 676, 1520);
insert into CONTAIN (quantity, dishs_id, material_id)
values (259284, 852, 9992);
insert into CONTAIN (quantity, dishs_id, material_id)
values (679987, 598, 6425);
insert into CONTAIN (quantity, dishs_id, material_id)
values (905819, 960, 1682);
insert into CONTAIN (quantity, dishs_id, material_id)
values (666441, 348, 6053);
insert into CONTAIN (quantity, dishs_id, material_id)
values (237422, 1372, 5303);
insert into CONTAIN (quantity, dishs_id, material_id)
values (278720, 1070, 9992);
insert into CONTAIN (quantity, dishs_id, material_id)
values (201144, 658, 8154);
insert into CONTAIN (quantity, dishs_id, material_id)
values (569574, 994, 6739);
insert into CONTAIN (quantity, dishs_id, material_id)
values (818394, 1068, 7583);
insert into CONTAIN (quantity, dishs_id, material_id)
values (406135, 892, 2549);
insert into CONTAIN (quantity, dishs_id, material_id)
values (93500, 800, 6286);
insert into CONTAIN (quantity, dishs_id, material_id)
values (326135, 932, 6798);
insert into CONTAIN (quantity, dishs_id, material_id)
values (977619, 482, 6237);
insert into CONTAIN (quantity, dishs_id, material_id)
values (197315, 826, 6425);
insert into CONTAIN (quantity, dishs_id, material_id)
values (264635, 808, 6316);
insert into CONTAIN (quantity, dishs_id, material_id)
values (322242, 230, 7084);
insert into CONTAIN (quantity, dishs_id, material_id)
values (688497, 374, 3205);
insert into CONTAIN (quantity, dishs_id, material_id)
values (559032, 60, 9234);
insert into CONTAIN (quantity, dishs_id, material_id)
values (344853, 362, 595);
insert into CONTAIN (quantity, dishs_id, material_id)
values (618412, 1128, 5423);
insert into CONTAIN (quantity, dishs_id, material_id)
values (403724, 612, 9096);
insert into CONTAIN (quantity, dishs_id, material_id)
values (265420, 470, 5379);
insert into CONTAIN (quantity, dishs_id, material_id)
values (9990, 518, 7668);
insert into CONTAIN (quantity, dishs_id, material_id)
values (510211, 838, 9660);
insert into CONTAIN (quantity, dishs_id, material_id)
values (818803, 1074, 4098);
insert into CONTAIN (quantity, dishs_id, material_id)
values (331129, 216, 451);
insert into CONTAIN (quantity, dishs_id, material_id)
values (868249, 550, 7040);
insert into CONTAIN (quantity, dishs_id, material_id)
values (843516, 850, 9188);
insert into CONTAIN (quantity, dishs_id, material_id)
values (996074, 832, 7649);
insert into CONTAIN (quantity, dishs_id, material_id)
values (429226, 258, 8282);
insert into CONTAIN (quantity, dishs_id, material_id)
values (840949, 1054, 2812);
insert into CONTAIN (quantity, dishs_id, material_id)
values (975814, 1144, 5423);
insert into CONTAIN (quantity, dishs_id, material_id)
values (176848, 788, 7687);
insert into CONTAIN (quantity, dishs_id, material_id)
values (368160, 84, 2694);
insert into CONTAIN (quantity, dishs_id, material_id)
values (988321, 368, 3874);
insert into CONTAIN (quantity, dishs_id, material_id)
values (523163, 1304, 5977);
insert into CONTAIN (quantity, dishs_id, material_id)
values (860017, 1166, 7238);
insert into CONTAIN (quantity, dishs_id, material_id)
values (893989, 1306, 4716);
insert into CONTAIN (quantity, dishs_id, material_id)
values (283985, 76, 4679);
insert into CONTAIN (quantity, dishs_id, material_id)
values (976484, 1054, 1381);
insert into CONTAIN (quantity, dishs_id, material_id)
values (333843, 354, 9451);
insert into CONTAIN (quantity, dishs_id, material_id)
values (702543, 818, 2601);
insert into CONTAIN (quantity, dishs_id, material_id)
values (980466, 644, 804);
insert into CONTAIN (quantity, dishs_id, material_id)
values (235025, 574, 3874);
insert into CONTAIN (quantity, dishs_id, material_id)
values (844868, 816, 7297);
insert into CONTAIN (quantity, dishs_id, material_id)
values (585001, 372, 3731);
insert into CONTAIN (quantity, dishs_id, material_id)
values (708089, 1260, 8477);
insert into CONTAIN (quantity, dishs_id, material_id)
values (969672, 952, 1016);
insert into CONTAIN (quantity, dishs_id, material_id)
values (286690, 718, 4840);
insert into CONTAIN (quantity, dishs_id, material_id)
values (800369, 136, 9992);
insert into CONTAIN (quantity, dishs_id, material_id)
values (233019, 218, 7052);
insert into CONTAIN (quantity, dishs_id, material_id)
values (67103, 944, 5302);
insert into CONTAIN (quantity, dishs_id, material_id)
values (979868, 30, 1381);
insert into CONTAIN (quantity, dishs_id, material_id)
values (341230, 972, 8354);
insert into CONTAIN (quantity, dishs_id, material_id)
values (529519, 1106, 1345);
insert into CONTAIN (quantity, dishs_id, material_id)
values (799254, 998, 2520);
insert into CONTAIN (quantity, dishs_id, material_id)
values (869446, 1194, 8005);
insert into CONTAIN (quantity, dishs_id, material_id)
values (545094, 1356, 7531);
insert into CONTAIN (quantity, dishs_id, material_id)
values (197259, 408, 2614);
insert into CONTAIN (quantity, dishs_id, material_id)
values (643693, 340, 1370);
insert into CONTAIN (quantity, dishs_id, material_id)
values (855814, 1030, 5987);
insert into CONTAIN (quantity, dishs_id, material_id)
values (732828, 874, 595);
insert into CONTAIN (quantity, dishs_id, material_id)
values (648363, 102, 1876);
insert into CONTAIN (quantity, dishs_id, material_id)
values (415334, 436, 4943);
insert into CONTAIN (quantity, dishs_id, material_id)
values (311340, 740, 8694);
insert into CONTAIN (quantity, dishs_id, material_id)
values (917678, 30, 1790);
insert into CONTAIN (quantity, dishs_id, material_id)
values (206690, 50, 781);
insert into CONTAIN (quantity, dishs_id, material_id)
values (291067, 692, 8481);
insert into CONTAIN (quantity, dishs_id, material_id)
values (46436, 856, 5967);
insert into CONTAIN (quantity, dishs_id, material_id)
values (789076, 562, 6538);
insert into CONTAIN (quantity, dishs_id, material_id)
values (507643, 872, 7084);
insert into CONTAIN (quantity, dishs_id, material_id)
values (553641, 606, 8984);
insert into CONTAIN (quantity, dishs_id, material_id)
values (241957, 156, 6237);
insert into CONTAIN (quantity, dishs_id, material_id)
values (423806, 1066, 7078);
insert into CONTAIN (quantity, dishs_id, material_id)
values (841576, 846, 8005);
insert into CONTAIN (quantity, dishs_id, material_id)
values (133618, 496, 8764);
insert into CONTAIN (quantity, dishs_id, material_id)
values (112872, 1098, 4731);
insert into CONTAIN (quantity, dishs_id, material_id)
values (427901, 1224, 2123);
insert into CONTAIN (quantity, dishs_id, material_id)
values (329414, 26, 9451);
insert into CONTAIN (quantity, dishs_id, material_id)
values (276794, 316, 5672);
insert into CONTAIN (quantity, dishs_id, material_id)
values (318726, 878, 7959);
insert into CONTAIN (quantity, dishs_id, material_id)
values (462485, 316, 7202);
insert into CONTAIN (quantity, dishs_id, material_id)
values (71912, 1366, 9940);
insert into CONTAIN (quantity, dishs_id, material_id)
values (916446, 588, 5423);
commit;
prompt 300 records committed...
insert into CONTAIN (quantity, dishs_id, material_id)
values (387300, 784, 9355);
insert into CONTAIN (quantity, dishs_id, material_id)
values (356271, 1258, 6360);
insert into CONTAIN (quantity, dishs_id, material_id)
values (663642, 412, 5551);
insert into CONTAIN (quantity, dishs_id, material_id)
values (577456, 76, 1335);
insert into CONTAIN (quantity, dishs_id, material_id)
values (666135, 1044, 1078);
insert into CONTAIN (quantity, dishs_id, material_id)
values (258198, 896, 8745);
insert into CONTAIN (quantity, dishs_id, material_id)
values (711749, 222, 4155);
insert into CONTAIN (quantity, dishs_id, material_id)
values (890328, 524, 3098);
insert into CONTAIN (quantity, dishs_id, material_id)
values (568376, 538, 1345);
insert into CONTAIN (quantity, dishs_id, material_id)
values (533247, 920, 7064);
insert into CONTAIN (quantity, dishs_id, material_id)
values (249742, 342, 7846);
insert into CONTAIN (quantity, dishs_id, material_id)
values (44781, 1158, 728);
insert into CONTAIN (quantity, dishs_id, material_id)
values (127852, 66, 1604);
insert into CONTAIN (quantity, dishs_id, material_id)
values (354693, 1244, 4455);
insert into CONTAIN (quantity, dishs_id, material_id)
values (187798, 52, 1465);
insert into CONTAIN (quantity, dishs_id, material_id)
values (758498, 1020, 7975);
insert into CONTAIN (quantity, dishs_id, material_id)
values (129496, 1250, 4647);
insert into CONTAIN (quantity, dishs_id, material_id)
values (195365, 1088, 8440);
insert into CONTAIN (quantity, dishs_id, material_id)
values (189993, 400, 5204);
insert into CONTAIN (quantity, dishs_id, material_id)
values (592361, 896, 4647);
insert into CONTAIN (quantity, dishs_id, material_id)
values (330775, 476, 4462);
insert into CONTAIN (quantity, dishs_id, material_id)
values (671819, 1120, 6431);
insert into CONTAIN (quantity, dishs_id, material_id)
values (618502, 1080, 8764);
insert into CONTAIN (quantity, dishs_id, material_id)
values (686704, 1218, 7238);
insert into CONTAIN (quantity, dishs_id, material_id)
values (539281, 14, 4455);
insert into CONTAIN (quantity, dishs_id, material_id)
values (444268, 392, 7052);
insert into CONTAIN (quantity, dishs_id, material_id)
values (436215, 1258, 5893);
insert into CONTAIN (quantity, dishs_id, material_id)
values (249958, 1016, 8546);
insert into CONTAIN (quantity, dishs_id, material_id)
values (562501, 66, 9096);
insert into CONTAIN (quantity, dishs_id, material_id)
values (124701, 336, 3013);
insert into CONTAIN (quantity, dishs_id, material_id)
values (207473, 1054, 4805);
insert into CONTAIN (quantity, dishs_id, material_id)
values (375471, 584, 7737);
insert into CONTAIN (quantity, dishs_id, material_id)
values (295274, 160, 4647);
insert into CONTAIN (quantity, dishs_id, material_id)
values (397487, 450, 9035);
insert into CONTAIN (quantity, dishs_id, material_id)
values (588516, 866, 3255);
insert into CONTAIN (quantity, dishs_id, material_id)
values (16337, 1024, 8282);
insert into CONTAIN (quantity, dishs_id, material_id)
values (460502, 918, 6199);
insert into CONTAIN (quantity, dishs_id, material_id)
values (804967, 30, 2520);
insert into CONTAIN (quantity, dishs_id, material_id)
values (194752, 1264, 428);
insert into CONTAIN (quantity, dishs_id, material_id)
values (769060, 376, 8178);
insert into CONTAIN (quantity, dishs_id, material_id)
values (900956, 1078, 9599);
insert into CONTAIN (quantity, dishs_id, material_id)
values (6612, 822, 2748);
insert into CONTAIN (quantity, dishs_id, material_id)
values (775590, 406, 6049);
insert into CONTAIN (quantity, dishs_id, material_id)
values (514036, 314, 7688);
insert into CONTAIN (quantity, dishs_id, material_id)
values (725613, 872, 9343);
insert into CONTAIN (quantity, dishs_id, material_id)
values (640422, 1308, 3831);
insert into CONTAIN (quantity, dishs_id, material_id)
values (381272, 1060, 7969);
insert into CONTAIN (quantity, dishs_id, material_id)
values (864999, 718, 4060);
insert into CONTAIN (quantity, dishs_id, material_id)
values (804773, 798, 1465);
insert into CONTAIN (quantity, dishs_id, material_id)
values (233411, 952, 5886);
insert into CONTAIN (quantity, dishs_id, material_id)
values (275954, 1282, 5672);
insert into CONTAIN (quantity, dishs_id, material_id)
values (378763, 1336, 1345);
insert into CONTAIN (quantity, dishs_id, material_id)
values (127011, 1018, 2476);
insert into CONTAIN (quantity, dishs_id, material_id)
values (223483, 904, 3205);
insert into CONTAIN (quantity, dishs_id, material_id)
values (298371, 840, 3034);
insert into CONTAIN (quantity, dishs_id, material_id)
values (490591, 302, 804);
insert into CONTAIN (quantity, dishs_id, material_id)
values (800713, 1318, 2734);
insert into CONTAIN (quantity, dishs_id, material_id)
values (731768, 252, 4440);
insert into CONTAIN (quantity, dishs_id, material_id)
values (170118, 298, 4288);
insert into CONTAIN (quantity, dishs_id, material_id)
values (346165, 782, 9076);
insert into CONTAIN (quantity, dishs_id, material_id)
values (415235, 686, 7052);
insert into CONTAIN (quantity, dishs_id, material_id)
values (758035, 1206, 4840);
insert into CONTAIN (quantity, dishs_id, material_id)
values (822875, 528, 9195);
insert into CONTAIN (quantity, dishs_id, material_id)
values (933107, 40, 5491);
insert into CONTAIN (quantity, dishs_id, material_id)
values (119337, 542, 7151);
insert into CONTAIN (quantity, dishs_id, material_id)
values (570020, 414, 5491);
insert into CONTAIN (quantity, dishs_id, material_id)
values (248706, 72, 6798);
insert into CONTAIN (quantity, dishs_id, material_id)
values (406022, 984, 7649);
insert into CONTAIN (quantity, dishs_id, material_id)
values (10574, 642, 5315);
insert into CONTAIN (quantity, dishs_id, material_id)
values (598716, 878, 7969);
insert into CONTAIN (quantity, dishs_id, material_id)
values (959123, 110, 440);
insert into CONTAIN (quantity, dishs_id, material_id)
values (244552, 82, 3892);
insert into CONTAIN (quantity, dishs_id, material_id)
values (222637, 1132, 8531);
insert into CONTAIN (quantity, dishs_id, material_id)
values (441749, 330, 8961);
insert into CONTAIN (quantity, dishs_id, material_id)
values (168689, 350, 3531);
insert into CONTAIN (quantity, dishs_id, material_id)
values (303068, 1184, 8799);
insert into CONTAIN (quantity, dishs_id, material_id)
values (233385, 674, 1520);
insert into CONTAIN (quantity, dishs_id, material_id)
values (493503, 294, 5789);
insert into CONTAIN (quantity, dishs_id, material_id)
values (928140, 708, 5739);
insert into CONTAIN (quantity, dishs_id, material_id)
values (742450, 1208, 8697);
insert into CONTAIN (quantity, dishs_id, material_id)
values (735113, 1254, 4790);
insert into CONTAIN (quantity, dishs_id, material_id)
values (762997, 200, 6611);
insert into CONTAIN (quantity, dishs_id, material_id)
values (161241, 700, 5796);
insert into CONTAIN (quantity, dishs_id, material_id)
values (179619, 1254, 1876);
insert into CONTAIN (quantity, dishs_id, material_id)
values (372530, 1080, 7280);
insert into CONTAIN (quantity, dishs_id, material_id)
values (958693, 1286, 4304);
insert into CONTAIN (quantity, dishs_id, material_id)
values (2, 1, 1233);
insert into CONTAIN (quantity, dishs_id, material_id)
values (3, 1, 8191);
insert into CONTAIN (quantity, dishs_id, material_id)
values (1, 1, 7363);
insert into CONTAIN (quantity, dishs_id, material_id)
values (2, 5, 215);
commit;
prompt 390 records loaded
prompt Loading MENU...
prompt Table is empty
prompt Loading INCLUDES...
prompt Table is empty
prompt Loading ISHAVING...
prompt Table is empty
prompt Loading TEACHER...
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (1, 'Alivia Garcia', 596067674, to_date('09-03-2005', 'dd-mm-yyyy'), 'assistant', 71);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (2, 'Penelope Thomas', 594356767, to_date('29-11-2021', 'dd-mm-yyyy'), 'assistant', 39);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (3, 'Makenna Garcia', 526764730, to_date('15-08-2012', 'dd-mm-yyyy'), 'teacher', 2);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (4, 'Eliza Allen', 554519829, to_date('08-10-2004', 'dd-mm-yyyy'), 'teacher', 26);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (5, 'Everly Young', 539957204, to_date('06-07-1997', 'dd-mm-yyyy'), 'assistant', 95);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (6, 'Talia Scott', 529739436, to_date('06-09-2020', 'dd-mm-yyyy'), 'teacher', 146);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (7, 'Rose Moore', 587377289, to_date('12-03-1997', 'dd-mm-yyyy'), 'assistant', 134);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (8, 'Claire Campbell', 562401307, to_date('25-01-2004', 'dd-mm-yyyy'), 'teacher', 57);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (9, 'Makayla Rogers', 550791006, to_date('06-07-1990', 'dd-mm-yyyy'), 'teacher', 122);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (10, 'Ada Scott', 565879282, to_date('13-10-2013', 'dd-mm-yyyy'), 'assistant', 137);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (11, 'Julianna Hernandez', 598373592, to_date('26-06-1994', 'dd-mm-yyyy'), 'teacher', 120);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (12, 'Maggie Hernandez', 539670068, to_date('05-12-2013', 'dd-mm-yyyy'), 'assistant', 149);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (13, 'Eliza Jones', 591113401, to_date('12-01-2020', 'dd-mm-yyyy'), 'assistant', 103);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (14, 'Ruby Rodriguez', 558270340, to_date('08-06-2001', 'dd-mm-yyyy'), 'teacher', 103);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (15, 'Eva Campbell', 599462517, to_date('03-04-2013', 'dd-mm-yyyy'), 'assistant', 41);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (16, 'Maya Rogers', 534754102, to_date('26-10-2009', 'dd-mm-yyyy'), 'teacher', 108);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (17, 'Arianna Clark', 516928889, to_date('09-04-2003', 'dd-mm-yyyy'), 'assistant', 110);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (18, 'Talia Wright', 585594591, to_date('05-08-2013', 'dd-mm-yyyy'), 'assistant', 31);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (19, 'Stella Clark', 531938568, to_date('07-10-2012', 'dd-mm-yyyy'), 'assistant', 134);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (20, 'Anastasia Brown', 514606940, to_date('06-04-2006', 'dd-mm-yyyy'), 'assistant', 134);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (21, 'Grace Lewis', 590323284, to_date('12-02-2005', 'dd-mm-yyyy'), 'teacher', 58);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (22, 'Serena Lopez', 552285379, to_date('01-05-2002', 'dd-mm-yyyy'), 'assistant', 29);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (23, 'Vivian Allen', 561264061, to_date('06-09-1990', 'dd-mm-yyyy'), 'teacher', 9);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (24, 'Sloane Scott', 515703779, to_date('11-07-2011', 'dd-mm-yyyy'), 'teacher', 117);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (25, 'Daisy Roy', 555526073, to_date('05-04-2007', 'dd-mm-yyyy'), 'assistant', 28);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (26, 'Aniyah Allen', 554712737, to_date('01-10-2000', 'dd-mm-yyyy'), 'assistant', 67);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (27, 'Abigail Hall', 544864441, to_date('23-03-1994', 'dd-mm-yyyy'), 'teacher', 49);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (28, 'Alyssa Garcia', 585099846, to_date('06-10-1999', 'dd-mm-yyyy'), 'assistant', 105);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (29, 'Brooklyn Phillips', 577808822, to_date('22-07-2003', 'dd-mm-yyyy'), 'teacher', 31);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (30, 'Sawyer Sanchez', 515400052, to_date('28-04-2021', 'dd-mm-yyyy'), 'assistant', 19);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (31, 'Sloane Lopez', 522797199, to_date('07-08-2022', 'dd-mm-yyyy'), 'teacher', 116);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (32, 'Miriam Phillips', 556861987, to_date('06-12-2014', 'dd-mm-yyyy'), 'teacher', 82);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (33, 'Savannah Allen', 598459617, to_date('13-09-1992', 'dd-mm-yyyy'), 'teacher', 36);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (34, 'Zara Nelson', 592142585, to_date('24-10-1998', 'dd-mm-yyyy'), 'assistant', 107);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (35, 'Katherine Garcia', 577194176, to_date('21-10-2004', 'dd-mm-yyyy'), 'assistant', 124);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (36, 'Serena Hernandez', 532076891, to_date('14-03-2017', 'dd-mm-yyyy'), 'assistant', 134);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (37, 'Malia Taylor', 536049279, to_date('19-06-2014', 'dd-mm-yyyy'), 'assistant', 95);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (38, 'Sienna Garcia', 536713342, to_date('04-03-2015', 'dd-mm-yyyy'), 'assistant', 78);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (39, 'Miriam Nguyen', 583601491, to_date('26-12-2017', 'dd-mm-yyyy'), 'teacher', 15);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (40, 'Mia Cruz', 521038798, to_date('01-12-1996', 'dd-mm-yyyy'), 'teacher', 150);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (41, 'Gracie Smith', 524239156, to_date('25-04-2015', 'dd-mm-yyyy'), 'assistant', 114);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (42, 'Jade Hernandez', 596121749, to_date('24-10-2010', 'dd-mm-yyyy'), 'assistant', 88);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (43, 'Cora Mitchell', 560895217, to_date('30-10-1993', 'dd-mm-yyyy'), 'assistant', 2);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (44, 'Madelyn Wilson', 571772649, to_date('26-10-2011', 'dd-mm-yyyy'), 'assistant', 33);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (45, 'Vivian Walker', 547355132, to_date('01-10-1999', 'dd-mm-yyyy'), 'teacher', 65);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (46, 'Scarlett Johnson', 530401114, to_date('11-06-2003', 'dd-mm-yyyy'), 'assistant', 133);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (47, 'Isla Williams', 588373351, to_date('31-03-2022', 'dd-mm-yyyy'), 'assistant', 58);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (48, 'Violet Jones', 567326530, to_date('13-08-2006', 'dd-mm-yyyy'), 'teacher', 31);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (49, 'Julia Miller', 523692886, to_date('03-09-2003', 'dd-mm-yyyy'), 'teacher', 120);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (50, 'Lena Campbell', 516544644, to_date('29-05-2023', 'dd-mm-yyyy'), 'assistant', 111);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (51, 'Mia Hernandez', 555273445, to_date('07-10-1990', 'dd-mm-yyyy'), 'assistant', 67);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (52, 'Aurora Miller', 534365237, to_date('19-06-1994', 'dd-mm-yyyy'), 'assistant', 43);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (53, 'Camilla Hernandez', 583802305, to_date('03-01-2016', 'dd-mm-yyyy'), 'teacher', 97);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (54, 'Josephine Lopez', 559331953, to_date('14-08-1999', 'dd-mm-yyyy'), 'teacher', 41);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (55, 'Skyler Young', 512884700, to_date('08-10-2017', 'dd-mm-yyyy'), 'teacher', 118);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (56, 'Penelope Moore', 548886183, to_date('27-12-2020', 'dd-mm-yyyy'), 'assistant', 40);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (57, 'Nora Davis', 595309529, to_date('09-07-2001', 'dd-mm-yyyy'), 'teacher', 79);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (58, 'Talia Moore', 514467152, to_date('09-07-2001', 'dd-mm-yyyy'), 'teacher', 61);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (59, 'Maggie Garcia', 586671091, to_date('24-04-2017', 'dd-mm-yyyy'), 'teacher', 23);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (60, 'Lilliana Mitchell', 593788753, to_date('27-01-2000', 'dd-mm-yyyy'), 'assistant', 78);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (61, 'Selena Thomas', 557763962, to_date('20-04-1998', 'dd-mm-yyyy'), 'assistant', 100);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (62, 'Hazel Miller', 582276729, to_date('08-05-2000', 'dd-mm-yyyy'), 'assistant', 118);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (63, 'Sawyer Miller', 555724918, to_date('30-11-2007', 'dd-mm-yyyy'), 'teacher', 46);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (64, 'Violet Harris', 591448621, to_date('05-02-2014', 'dd-mm-yyyy'), 'teacher', 129);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (65, 'Hazel Scott', 523974272, to_date('20-07-1993', 'dd-mm-yyyy'), 'teacher', 36);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (66, 'Millie Wright', 546888309, to_date('31-07-2019', 'dd-mm-yyyy'), 'teacher', 110);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (67, 'Alaina Lee', 530063567, to_date('04-04-1991', 'dd-mm-yyyy'), 'teacher', 55);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (68, 'Ariana Roy', 586600500, to_date('10-05-2017', 'dd-mm-yyyy'), 'teacher', 140);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (69, 'Genevieve Hernandez', 573109245, to_date('23-02-2017', 'dd-mm-yyyy'), 'assistant', 33);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (70, 'Emerson Moore', 559120582, to_date('18-12-2016', 'dd-mm-yyyy'), 'assistant', 67);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (71, 'Violet Lee', 546956794, to_date('12-11-2001', 'dd-mm-yyyy'), 'teacher', 25);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (72, 'Natalie Jones', 587638551, to_date('05-04-2018', 'dd-mm-yyyy'), 'teacher', 40);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (73, 'Claire Campbell', 593928773, to_date('23-04-2014', 'dd-mm-yyyy'), 'teacher', 67);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (74, 'Penelope Allen', 570750444, to_date('25-04-2018', 'dd-mm-yyyy'), 'teacher', 127);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (75, 'Miriam Miller', 548872523, to_date('20-11-2008', 'dd-mm-yyyy'), 'assistant', 94);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (76, 'Aria Moore', 535063477, to_date('13-06-2013', 'dd-mm-yyyy'), 'teacher', 44);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (77, 'Brooklynn Nelson', 596362269, to_date('18-11-1996', 'dd-mm-yyyy'), 'assistant', 133);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (78, 'Delilah Wright', 576549925, to_date('11-03-2008', 'dd-mm-yyyy'), 'assistant', 97);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (79, 'Jasmine Robinson', 591142217, to_date('08-06-2014', 'dd-mm-yyyy'), 'assistant', 38);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (80, 'Daphne Roy', 590340512, to_date('20-11-2003', 'dd-mm-yyyy'), 'teacher', 13);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (81, 'Jasmine Allen', 545212036, to_date('12-05-2011', 'dd-mm-yyyy'), 'teacher', 55);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (82, 'Athena Wilson', 541648313, to_date('15-08-2014', 'dd-mm-yyyy'), 'teacher', 77);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (83, 'Piper Clark', 555126578, to_date('18-07-2007', 'dd-mm-yyyy'), 'teacher', 32);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (84, 'Phoebe Wright', 554845295, to_date('22-04-2013', 'dd-mm-yyyy'), 'teacher', 89);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (85, 'Delilah Ramirez', 531269300, to_date('15-09-1997', 'dd-mm-yyyy'), 'teacher', 33);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (86, 'Violet Allen', 565097633, to_date('04-05-2018', 'dd-mm-yyyy'), 'assistant', 92);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (87, 'Sarah Nguyen', 517466286, to_date('31-07-2018', 'dd-mm-yyyy'), 'teacher', 24);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (88, 'Adeline Miller', 549129193, to_date('07-10-1993', 'dd-mm-yyyy'), 'teacher', 28);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (89, 'Vivian Nguyen', 587384384, to_date('16-06-2005', 'dd-mm-yyyy'), 'teacher', 60);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (90, 'Natalie Anderson', 532788759, to_date('25-06-2008', 'dd-mm-yyyy'), 'teacher', 103);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (91, 'Mila Lopez', 580996068, to_date('26-08-2008', 'dd-mm-yyyy'), 'assistant', 57);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (92, 'Alana Lee', 568461008, to_date('10-05-2011', 'dd-mm-yyyy'), 'teacher', 57);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (93, 'Emilia Lewis', 529391202, to_date('14-09-1994', 'dd-mm-yyyy'), 'teacher', 103);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (94, 'Lydia Garcia', 554991306, to_date('15-05-2022', 'dd-mm-yyyy'), 'teacher', 54);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (95, 'Blakely Moore', 578305024, to_date('22-06-2001', 'dd-mm-yyyy'), 'teacher', 111);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (96, 'Josie Wright', 522392538, to_date('25-11-2014', 'dd-mm-yyyy'), 'assistant', 55);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (97, 'Savannah Wright', 559697505, to_date('27-02-2018', 'dd-mm-yyyy'), 'assistant', 9);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (98, 'Abigail Wilson', 514109601, to_date('02-08-2021', 'dd-mm-yyyy'), 'assistant', 132);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (99, 'Savannah Phillips', 553901499, to_date('10-05-1996', 'dd-mm-yyyy'), 'assistant', 92);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (100, 'Nylah King', 562225270, to_date('15-08-2022', 'dd-mm-yyyy'), 'assistant', 45);
commit;
prompt 100 records committed...
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (101, 'Layla Hernandez', 530801036, to_date('28-12-2021', 'dd-mm-yyyy'), 'teacher', 56);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (102, 'Zoey Allen', 590520335, to_date('16-01-1995', 'dd-mm-yyyy'), 'assistant', 97);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (103, 'Avery Garcia', 524512967, to_date('11-03-1997', 'dd-mm-yyyy'), 'teacher', 24);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (104, 'Zoey Harris', 521040954, to_date('13-11-2007', 'dd-mm-yyyy'), 'teacher', 93);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (105, 'Zara Taylor', 589031145, to_date('17-09-2014', 'dd-mm-yyyy'), 'assistant', 106);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (106, 'Kaitlyn Allen', 514060720, to_date('02-11-2020', 'dd-mm-yyyy'), 'teacher', 135);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (107, 'Sloane Campbell', 523375742, to_date('11-01-2017', 'dd-mm-yyyy'), 'teacher', 112);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (108, 'Alaina Walker', 513473183, to_date('26-05-2007', 'dd-mm-yyyy'), 'teacher', 120);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (109, 'Aubree Garcia', 577050637, to_date('14-02-2020', 'dd-mm-yyyy'), 'assistant', 108);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (110, 'Mia Wright', 581274281, to_date('29-04-2002', 'dd-mm-yyyy'), 'assistant', 13);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (111, 'Addison Diaz', 572772792, to_date('05-03-2021', 'dd-mm-yyyy'), 'teacher', 131);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (112, 'Allison Rodriguez', 599135910, to_date('12-01-2011', 'dd-mm-yyyy'), 'assistant', 115);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (113, 'Juliana Moore', 573494740, to_date('13-01-2008', 'dd-mm-yyyy'), 'teacher', 121);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (114, 'Kaylee Moore', 557649784, to_date('26-02-2013', 'dd-mm-yyyy'), 'assistant', 141);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (115, 'Callie Brown', 562555704, to_date('09-01-1991', 'dd-mm-yyyy'), 'assistant', 99);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (116, 'Sloane Rodriguez', 543266314, to_date('08-02-1995', 'dd-mm-yyyy'), 'teacher', 119);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (117, 'Eliza Moore', 578761940, to_date('26-12-2006', 'dd-mm-yyyy'), 'teacher', 124);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (118, 'Quinn Martinez', 591504246, to_date('26-01-2023', 'dd-mm-yyyy'), 'assistant', 1);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (119, 'Eva Allen', 552566044, to_date('12-03-2018', 'dd-mm-yyyy'), 'teacher', 14);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (120, 'Catalina Nguyen', 540775929, to_date('20-07-2004', 'dd-mm-yyyy'), 'teacher', 50);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (121, 'Taylor Lopez', 547760714, to_date('29-05-1996', 'dd-mm-yyyy'), 'assistant', 109);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (122, 'Mariana Hernandez', 591556989, to_date('06-02-2019', 'dd-mm-yyyy'), 'assistant', 138);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (123, 'Avery Cruz', 572592717, to_date('14-06-2023', 'dd-mm-yyyy'), 'assistant', 58);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (124, 'Sophia Hall', 551845376, to_date('09-05-2007', 'dd-mm-yyyy'), 'assistant', 136);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (125, 'Delilah Thomas', 593251746, to_date('13-04-1993', 'dd-mm-yyyy'), 'assistant', 63);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (126, 'Hazel Rogers', 554118081, to_date('28-01-2019', 'dd-mm-yyyy'), 'assistant', 137);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (127, 'Ava Rodriguez', 560241936, to_date('07-06-2002', 'dd-mm-yyyy'), 'assistant', 64);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (128, 'Nylah Clark', 560679934, to_date('18-09-2009', 'dd-mm-yyyy'), 'teacher', 92);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (129, 'Elena Walker', 551614916, to_date('18-02-2010', 'dd-mm-yyyy'), 'assistant', 68);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (130, 'Rylee Clark', 510490343, to_date('05-06-2001', 'dd-mm-yyyy'), 'teacher', 6);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (131, 'Adrianna Lopez', 581974122, to_date('26-12-2001', 'dd-mm-yyyy'), 'teacher', 65);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (132, 'Brianna Garcia', 574826165, to_date('10-09-2022', 'dd-mm-yyyy'), 'assistant', 50);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (133, 'Annalise Wilson', 519386857, to_date('31-12-2013', 'dd-mm-yyyy'), 'teacher', 81);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (134, 'Zara Scott', 595129311, to_date('27-06-2020', 'dd-mm-yyyy'), 'teacher', 75);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (135, 'Lola Garcia', 594334031, to_date('17-06-1998', 'dd-mm-yyyy'), 'assistant', 122);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (136, 'Eva Garcia', 560294535, to_date('09-07-2021', 'dd-mm-yyyy'), 'assistant', 79);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (137, 'Mackenzie Rodriguez', 568161259, to_date('23-03-2021', 'dd-mm-yyyy'), 'assistant', 65);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (138, 'Daisy Hernandez', 517484827, to_date('09-09-1993', 'dd-mm-yyyy'), 'assistant', 146);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (139, 'Amaya Thomas', 511709345, to_date('12-04-2017', 'dd-mm-yyyy'), 'assistant', 34);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (140, 'Claire Rodriguez', 582758282, to_date('16-12-2000', 'dd-mm-yyyy'), 'assistant', 121);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (141, 'Fiona Hall', 579580741, to_date('02-11-2001', 'dd-mm-yyyy'), 'teacher', 50);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (142, 'Nina Campbell', 597424287, to_date('26-09-2009', 'dd-mm-yyyy'), 'assistant', 127);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (143, 'Emerson Lee', 554290169, to_date('21-04-2023', 'dd-mm-yyyy'), 'assistant', 10);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (144, 'Madelyn Garcia', 544141190, to_date('29-11-1996', 'dd-mm-yyyy'), 'assistant', 136);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (145, 'Eva Allen', 537922804, to_date('03-08-1996', 'dd-mm-yyyy'), 'assistant', 47);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (146, 'Andrea Rodriguez', 555699664, to_date('26-10-1996', 'dd-mm-yyyy'), 'assistant', 46);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (147, 'Brooke Sanchez', 520541654, to_date('04-11-1998', 'dd-mm-yyyy'), 'assistant', 149);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (148, 'Nora Nelson', 578303817, to_date('18-12-2011', 'dd-mm-yyyy'), 'teacher', 145);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (149, 'Anastasia Campbell', 582613178, to_date('26-07-2023', 'dd-mm-yyyy'), 'teacher', 25);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (150, 'Haley Anderson', 516200163, to_date('23-01-1991', 'dd-mm-yyyy'), 'assistant', 109);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (151, 'Makenna Campbell', 516676321, to_date('05-11-2023', 'dd-mm-yyyy'), 'assistant', 16);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (152, 'Paisley Rodriguez', 541194741, to_date('29-09-2014', 'dd-mm-yyyy'), 'assistant', 57);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (153, 'Chloe Hernandez', 579167340, to_date('12-04-2005', 'dd-mm-yyyy'), 'assistant', 69);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (154, 'Mila Lewis', 590195523, to_date('25-11-2007', 'dd-mm-yyyy'), 'assistant', 148);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (155, 'Peyton Clark', 570590567, to_date('09-08-1994', 'dd-mm-yyyy'), 'teacher', 63);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (156, 'Lila Rogers', 564569157, to_date('29-07-2017', 'dd-mm-yyyy'), 'assistant', 52);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (157, 'Lena Hernandez', 512095937, to_date('16-03-1991', 'dd-mm-yyyy'), 'teacher', 30);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (158, 'Molly Martinez', 586228041, to_date('28-04-1999', 'dd-mm-yyyy'), 'assistant', 39);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (159, 'Madilyn Moore', 533634467, to_date('08-12-1997', 'dd-mm-yyyy'), 'teacher', 98);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (160, 'Olivia Hernandez', 528761122, to_date('08-08-2018', 'dd-mm-yyyy'), 'assistant', 8);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (161, 'Ellie Phillips', 551112306, to_date('19-12-1990', 'dd-mm-yyyy'), 'assistant', 31);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (162, 'Sawyer Miller', 511869604, to_date('13-05-1998', 'dd-mm-yyyy'), 'teacher', 25);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (163, 'Freya Hernandez', 593246578, to_date('25-04-2019', 'dd-mm-yyyy'), 'assistant', 107);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (164, 'Ada Nguyen', 573010956, to_date('30-03-2007', 'dd-mm-yyyy'), 'teacher', 40);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (165, 'Hayden Thomas', 529953879, to_date('29-11-2009', 'dd-mm-yyyy'), 'teacher', 116);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (166, 'Evelyn Hernandez', 546339752, to_date('24-12-2007', 'dd-mm-yyyy'), 'assistant', 56);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (167, 'Naomi Hernandez', 542373858, to_date('29-06-1994', 'dd-mm-yyyy'), 'teacher', 94);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (168, 'Brielle Moore', 546429819, to_date('14-06-1991', 'dd-mm-yyyy'), 'teacher', 57);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (169, 'Aubrey Roberts', 531926540, to_date('12-10-2010', 'dd-mm-yyyy'), 'assistant', 94);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (170, 'Allison Allen', 586064099, to_date('06-02-2004', 'dd-mm-yyyy'), 'teacher', 67);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (171, 'Lila Green', 571775564, to_date('04-11-1995', 'dd-mm-yyyy'), 'teacher', 55);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (172, 'Josephine Cruz', 520066307, to_date('01-10-2014', 'dd-mm-yyyy'), 'teacher', 55);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (173, 'Julianna Lee', 561924270, to_date('16-06-2018', 'dd-mm-yyyy'), 'assistant', 131);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (174, 'Aubrie Young', 534933464, to_date('09-02-2000', 'dd-mm-yyyy'), 'assistant', 126);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (175, 'Makenna Thomas', 561340235, to_date('09-02-2019', 'dd-mm-yyyy'), 'assistant', 7);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (176, 'Lydia Lee', 513558022, to_date('12-11-1992', 'dd-mm-yyyy'), 'teacher', 22);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (177, 'Aubrey Allen', 532918862, to_date('09-05-1994', 'dd-mm-yyyy'), 'teacher', 67);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (178, 'Riley Carter', 581857601, to_date('28-08-2014', 'dd-mm-yyyy'), 'teacher', 28);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (179, 'Eva Mitchell', 568042030, to_date('10-01-2010', 'dd-mm-yyyy'), 'teacher', 40);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (180, 'Aaliyah Hernandez', 554021567, to_date('16-01-2010', 'dd-mm-yyyy'), 'assistant', 91);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (181, 'Emilia Mitchell', 532160916, to_date('05-05-2003', 'dd-mm-yyyy'), 'teacher', 64);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (182, 'Elsie Harris', 559026750, to_date('28-02-2014', 'dd-mm-yyyy'), 'assistant', 117);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (183, 'Charlotte Thomas', 547748064, to_date('15-06-2022', 'dd-mm-yyyy'), 'teacher', 55);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (184, 'Zoey Allen', 531701774, to_date('19-02-2005', 'dd-mm-yyyy'), 'assistant', 108);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (185, 'Daisy Campbell', 547968171, to_date('30-10-2007', 'dd-mm-yyyy'), 'assistant', 23);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (186, 'Isabella Garcia', 535454620, to_date('26-07-2009', 'dd-mm-yyyy'), 'assistant', 74);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (187, 'Blake Hernandez', 541156017, to_date('23-08-2016', 'dd-mm-yyyy'), 'assistant', 51);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (188, 'Athena Clark', 589793709, to_date('08-04-2007', 'dd-mm-yyyy'), 'teacher', 79);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (189, 'Skyler Lee', 590830777, to_date('14-02-2006', 'dd-mm-yyyy'), 'assistant', 110);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (190, 'Ashley Garcia', 531146548, to_date('15-08-1993', 'dd-mm-yyyy'), 'assistant', 58);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (191, 'Alaina Jones', 531310003, to_date('23-01-2010', 'dd-mm-yyyy'), 'assistant', 97);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (192, 'Autumn Williams', 576569729, to_date('05-10-2001', 'dd-mm-yyyy'), 'assistant', 87);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (193, 'Skylar Nguyen', 599221869, to_date('29-04-2023', 'dd-mm-yyyy'), 'teacher', 6);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (194, 'Sophia Jones', 549252221, to_date('05-08-2008', 'dd-mm-yyyy'), 'assistant', 10);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (195, 'Ella Miller', 570440138, to_date('17-12-2007', 'dd-mm-yyyy'), 'teacher', 148);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (196, 'Julia Green', 568757838, to_date('10-06-2008', 'dd-mm-yyyy'), 'assistant', 18);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (197, 'Makayla Evans', 534924911, to_date('28-07-2018', 'dd-mm-yyyy'), 'assistant', 49);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (198, 'Eden Evans', 590608988, to_date('26-07-2003', 'dd-mm-yyyy'), 'teacher', 107);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (199, 'Ella Moore', 569369928, to_date('23-09-1994', 'dd-mm-yyyy'), 'teacher', 74);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (200, 'Sadie Clark', 539337623, to_date('17-09-2005', 'dd-mm-yyyy'), 'teacher', 12);
commit;
prompt 200 records committed...
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (201, 'Serenity Wilson', 565731979, to_date('11-01-1997', 'dd-mm-yyyy'), 'teacher', 130);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (202, 'Emilia Roy', 544373991, to_date('31-01-2022', 'dd-mm-yyyy'), 'assistant', 119);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (203, 'Alivia Young', 569234980, to_date('16-05-1998', 'dd-mm-yyyy'), 'assistant', 125);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (204, 'Leilani Scott', 568101982, to_date('18-03-2012', 'dd-mm-yyyy'), 'assistant', 116);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (205, 'Adelaide Campbell', 580164942, to_date('11-03-1998', 'dd-mm-yyyy'), 'teacher', 44);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (206, 'Aaliyah Rodriguez', 591079081, to_date('06-03-2012', 'dd-mm-yyyy'), 'assistant', 16);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (207, 'Jordyn Robinson', 583599209, to_date('02-02-2010', 'dd-mm-yyyy'), 'assistant', 11);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (208, 'Alivia Hernandez', 580046048, to_date('23-09-2012', 'dd-mm-yyyy'), 'teacher', 21);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (209, 'Lydia Moore', 564288592, to_date('19-08-2020', 'dd-mm-yyyy'), 'teacher', 34);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (210, 'Ellie Diaz', 561673045, to_date('14-07-1998', 'dd-mm-yyyy'), 'assistant', 92);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (211, 'Reagan Johnson', 591837290, to_date('19-04-1998', 'dd-mm-yyyy'), 'assistant', 19);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (212, 'Piper Anderson', 536465024, to_date('26-07-2000', 'dd-mm-yyyy'), 'teacher', 50);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (213, 'Avery Anderson', 522714679, to_date('29-03-1992', 'dd-mm-yyyy'), 'assistant', 66);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (214, 'Elise Davis', 591687266, to_date('05-10-2023', 'dd-mm-yyyy'), 'assistant', 33);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (215, 'Athena Anderson', 562618327, to_date('09-12-2011', 'dd-mm-yyyy'), 'teacher', 67);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (216, 'Catherine Garcia', 559136733, to_date('24-11-2023', 'dd-mm-yyyy'), 'teacher', 128);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (217, 'Emersyn Johnson', 581061108, to_date('24-07-2019', 'dd-mm-yyyy'), 'assistant', 51);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (218, 'Alyssa Thomas', 522321947, to_date('15-08-2022', 'dd-mm-yyyy'), 'teacher', 93);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (219, 'Caroline Campbell', 563567828, to_date('27-11-2008', 'dd-mm-yyyy'), 'assistant', 70);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (220, 'Nora Robinson', 576233766, to_date('10-08-2001', 'dd-mm-yyyy'), 'assistant', 5);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (221, 'Brielle Moore', 547733466, to_date('11-01-2002', 'dd-mm-yyyy'), 'teacher', 79);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (222, 'Natalie Moore', 538453237, to_date('13-04-2011', 'dd-mm-yyyy'), 'teacher', 28);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (223, 'Marley Walker', 574238518, to_date('26-10-2001', 'dd-mm-yyyy'), 'assistant', 140);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (224, 'Isabella Campbell', 536796216, to_date('11-07-1998', 'dd-mm-yyyy'), 'teacher', 73);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (225, 'Sloane Lopez', 595429935, to_date('15-04-2007', 'dd-mm-yyyy'), 'teacher', 83);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (226, 'Alana Allen', 579736918, to_date('14-11-2016', 'dd-mm-yyyy'), 'teacher', 40);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (227, 'Selena Rogers', 553017676, to_date('19-10-1994', 'dd-mm-yyyy'), 'teacher', 11);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (228, 'Andrea Nguyen', 522321471, to_date('13-03-2011', 'dd-mm-yyyy'), 'teacher', 108);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (229, 'Layla Davis', 574164188, to_date('27-01-2005', 'dd-mm-yyyy'), 'teacher', 88);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (230, 'Logan Rogers', 599901166, to_date('13-06-2006', 'dd-mm-yyyy'), 'assistant', 11);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (231, 'Kaylee Lee', 568891984, to_date('09-04-2010', 'dd-mm-yyyy'), 'assistant', 53);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (232, 'Andrea Garcia', 590271312, to_date('05-04-2016', 'dd-mm-yyyy'), 'teacher', 34);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (233, 'Blake Harris', 591062442, to_date('16-05-2004', 'dd-mm-yyyy'), 'teacher', 73);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (234, 'Kaitlyn Wright', 557787164, to_date('27-06-2020', 'dd-mm-yyyy'), 'assistant', 41);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (235, 'Isabelle Mitchell', 573313785, to_date('05-08-2022', 'dd-mm-yyyy'), 'teacher', 62);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (236, 'Valentina King', 535185895, to_date('01-06-2016', 'dd-mm-yyyy'), 'teacher', 67);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (237, 'Alice Allen', 570080854, to_date('27-04-1994', 'dd-mm-yyyy'), 'assistant', 45);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (238, 'Blake Hernandez', 589139999, to_date('26-05-2002', 'dd-mm-yyyy'), 'assistant', 148);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (239, 'Amira Johnson', 519680845, to_date('27-12-2017', 'dd-mm-yyyy'), 'assistant', 44);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (240, 'Elsie Carter', 517313202, to_date('25-02-1995', 'dd-mm-yyyy'), 'assistant', 5);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (241, 'Kendall Lopez', 559161350, to_date('28-02-2013', 'dd-mm-yyyy'), 'assistant', 81);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (242, 'Sophia Jones', 544951866, to_date('11-06-1991', 'dd-mm-yyyy'), 'teacher', 146);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (243, 'Nina Scott', 537556058, to_date('25-09-1993', 'dd-mm-yyyy'), 'teacher', 90);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (244, 'Madison Rogers', 582215205, to_date('07-06-1998', 'dd-mm-yyyy'), 'assistant', 19);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (245, 'Arianna Wright', 511624749, to_date('23-01-2023', 'dd-mm-yyyy'), 'assistant', 43);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (246, 'Maya Lewis', 594443965, to_date('04-07-2003', 'dd-mm-yyyy'), 'assistant', 69);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (247, 'Talia Williams', 576077820, to_date('06-09-2002', 'dd-mm-yyyy'), 'teacher', 49);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (248, 'Nylah Allen', 570107233, to_date('07-07-2017', 'dd-mm-yyyy'), 'assistant', 146);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (249, 'Naomi Lewis', 520316884, to_date('09-06-2011', 'dd-mm-yyyy'), 'teacher', 79);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (250, 'Delilah Hernandez', 585702398, to_date('09-07-2018', 'dd-mm-yyyy'), 'teacher', 56);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (251, 'Naomi Moore', 546410028, to_date('16-04-1995', 'dd-mm-yyyy'), 'assistant', 86);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (252, 'Fiona Moore', 586800137, to_date('01-11-1997', 'dd-mm-yyyy'), 'teacher', 26);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (253, 'Cora Young', 551313035, to_date('09-12-1992', 'dd-mm-yyyy'), 'assistant', 2);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (254, 'Aurora Hernandez', 510278005, to_date('17-01-2016', 'dd-mm-yyyy'), 'teacher', 145);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (255, 'Amira Hernandez', 539256167, to_date('24-03-1994', 'dd-mm-yyyy'), 'teacher', 10);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (256, 'Savannah Green', 589527074, to_date('29-11-2009', 'dd-mm-yyyy'), 'assistant', 42);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (257, 'Blake Mitchell', 579512148, to_date('22-09-2022', 'dd-mm-yyyy'), 'assistant', 145);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (258, 'Zoey Wright', 527636312, to_date('16-01-1999', 'dd-mm-yyyy'), 'assistant', 149);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (259, 'Emerson Jones', 568502525, to_date('13-10-1993', 'dd-mm-yyyy'), 'teacher', 100);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (260, 'Piper Lewis', 587230075, to_date('06-05-2006', 'dd-mm-yyyy'), 'teacher', 3);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (261, 'Emerson Lewis', 514161743, to_date('26-07-2005', 'dd-mm-yyyy'), 'teacher', 141);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (262, 'Gracie Garcia', 587379973, to_date('09-08-2003', 'dd-mm-yyyy'), 'assistant', 106);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (263, 'Hazel Garcia', 541794674, to_date('14-02-2009', 'dd-mm-yyyy'), 'assistant', 58);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (264, 'Faith Wilson', 540509709, to_date('23-03-2010', 'dd-mm-yyyy'), 'assistant', 108);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (265, 'Nicole Lopez', 522859659, to_date('24-07-1994', 'dd-mm-yyyy'), 'teacher', 69);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (266, 'Eliana Rodriguez', 510214031, to_date('21-02-2005', 'dd-mm-yyyy'), 'teacher', 51);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (267, 'Blake Brown', 572209406, to_date('27-06-2021', 'dd-mm-yyyy'), 'teacher', 82);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (268, 'Jocelyn Allen', 554134857, to_date('30-10-2013', 'dd-mm-yyyy'), 'teacher', 55);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (269, 'Alexandra Nelson', 576719002, to_date('01-01-2005', 'dd-mm-yyyy'), 'assistant', 118);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (270, 'Lucy Nelson', 511820777, to_date('27-04-2003', 'dd-mm-yyyy'), 'teacher', 26);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (271, 'Josephine Wright', 533189458, to_date('16-12-1997', 'dd-mm-yyyy'), 'teacher', 100);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (272, 'Sadie Harris', 564125455, to_date('04-06-1997', 'dd-mm-yyyy'), 'assistant', 50);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (273, 'Brianna Allen', 550612618, to_date('19-10-2001', 'dd-mm-yyyy'), 'assistant', 133);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (274, 'Catherine Mitchell', 516495861, to_date('10-07-2007', 'dd-mm-yyyy'), 'assistant', 94);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (275, 'Andrea Wright', 526758948, to_date('02-10-2014', 'dd-mm-yyyy'), 'teacher', 91);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (276, 'Julianna Nelson', 537186924, to_date('27-04-2001', 'dd-mm-yyyy'), 'teacher', 112);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (277, 'Maggie Garcia', 538189537, to_date('11-02-2020', 'dd-mm-yyyy'), 'assistant', 108);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (278, 'Mila Young', 597677645, to_date('26-05-1998', 'dd-mm-yyyy'), 'assistant', 33);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (279, 'Josephine Young', 587303912, to_date('22-02-1993', 'dd-mm-yyyy'), 'assistant', 44);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (280, 'Parker Lopez', 590007634, to_date('18-12-2008', 'dd-mm-yyyy'), 'assistant', 81);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (281, 'Daisy Williams', 533584388, to_date('21-12-2015', 'dd-mm-yyyy'), 'teacher', 69);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (282, 'Brooke Moore', 595558113, to_date('24-11-1995', 'dd-mm-yyyy'), 'teacher', 146);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (283, 'Daphne Lee', 557830226, to_date('30-10-2011', 'dd-mm-yyyy'), 'assistant', 29);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (284, 'Natalie Thomas', 568881677, to_date('27-08-1998', 'dd-mm-yyyy'), 'assistant', 147);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (285, 'Matilda Green', 513340894, to_date('19-08-1990', 'dd-mm-yyyy'), 'assistant', 84);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (286, 'Nora Young', 557898932, to_date('13-03-2018', 'dd-mm-yyyy'), 'assistant', 3);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (287, 'Claire Walker', 547263109, to_date('19-01-2018', 'dd-mm-yyyy'), 'teacher', 41);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (288, 'Sophie Lewis', 556233926, to_date('21-09-1992', 'dd-mm-yyyy'), 'teacher', 29);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (289, 'Serena Miller', 516341780, to_date('16-03-2009', 'dd-mm-yyyy'), 'teacher', 63);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (290, 'Logan Roberts', 556493065, to_date('02-01-2011', 'dd-mm-yyyy'), 'assistant', 137);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (291, 'Ashley Roberts', 511007705, to_date('15-12-2022', 'dd-mm-yyyy'), 'teacher', 53);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (292, 'Parker Wilson', 570031265, to_date('17-12-1996', 'dd-mm-yyyy'), 'assistant', 7);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (293, 'Skyler Lopez', 568361594, to_date('19-04-2021', 'dd-mm-yyyy'), 'teacher', 27);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (294, 'Aria Moore', 557161078, to_date('04-05-2004', 'dd-mm-yyyy'), 'teacher', 52);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (295, 'Addison Diaz', 568037081, to_date('13-11-2006', 'dd-mm-yyyy'), 'assistant', 66);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (296, 'Brielle Nguyen', 557420785, to_date('29-09-2005', 'dd-mm-yyyy'), 'assistant', 101);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (297, 'Jayla Clark', 563624223, to_date('02-03-2004', 'dd-mm-yyyy'), 'teacher', 128);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (298, 'Kinsley Allen', 519942224, to_date('04-01-2012', 'dd-mm-yyyy'), 'assistant', 58);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (299, 'Gabriella Wilson', 520530258, to_date('02-04-2013', 'dd-mm-yyyy'), 'assistant', 109);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (300, 'Jordyn Wright', 569899204, to_date('14-05-2016', 'dd-mm-yyyy'), 'teacher', 43);
commit;
prompt 300 records committed...
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (301, 'Leah Phillips', 549198904, to_date('25-01-2003', 'dd-mm-yyyy'), 'teacher', 92);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (302, 'Ada Clark', 596447587, to_date('30-07-2001', 'dd-mm-yyyy'), 'teacher', 71);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (303, 'Eden Robinson', 572917000, to_date('19-11-2002', 'dd-mm-yyyy'), 'assistant', 114);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (304, 'Brooklynn Scott', 574455772, to_date('31-07-2008', 'dd-mm-yyyy'), 'assistant', 149);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (305, 'Alexis Lewis', 584784282, to_date('09-03-2012', 'dd-mm-yyyy'), 'assistant', 113);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (306, 'Blake Wilson', 541386483, to_date('27-04-1997', 'dd-mm-yyyy'), 'assistant', 66);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (307, 'Anna Wright', 573246722, to_date('16-07-2018', 'dd-mm-yyyy'), 'teacher', 104);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (308, 'Anna Mitchell', 574448386, to_date('19-06-2009', 'dd-mm-yyyy'), 'teacher', 94);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (309, 'Valentina Lopez', 515881720, to_date('12-06-2011', 'dd-mm-yyyy'), 'teacher', 90);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (310, 'Olivia Moore', 543743390, to_date('31-08-1998', 'dd-mm-yyyy'), 'teacher', 8);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (311, 'Vivienne Lopez', 589207204, to_date('12-08-2023', 'dd-mm-yyyy'), 'assistant', 54);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (312, 'Natalie Scott', 530036564, to_date('01-02-1996', 'dd-mm-yyyy'), 'teacher', 116);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (313, 'Eliana Martinez', 528791754, to_date('30-08-2004', 'dd-mm-yyyy'), 'teacher', 56);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (314, 'Ellie Moore', 582395515, to_date('14-10-1991', 'dd-mm-yyyy'), 'teacher', 67);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (315, 'Emersyn Young', 525289817, to_date('05-06-2011', 'dd-mm-yyyy'), 'assistant', 102);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (316, 'Juliet Scott', 512613517, to_date('12-01-1997', 'dd-mm-yyyy'), 'teacher', 2);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (317, 'Chloe Green', 512056715, to_date('23-08-2008', 'dd-mm-yyyy'), 'assistant', 115);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (318, 'Riley Lewis', 548765854, to_date('19-04-1990', 'dd-mm-yyyy'), 'teacher', 38);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (319, 'Freya Martinez', 552462901, to_date('20-12-2014', 'dd-mm-yyyy'), 'assistant', 10);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (320, 'Ashley Clark', 538285842, to_date('29-08-2015', 'dd-mm-yyyy'), 'teacher', 22);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (321, 'Amelia Miller', 545041763, to_date('12-11-1999', 'dd-mm-yyyy'), 'teacher', 14);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (322, 'Gabriella Johnson', 550347671, to_date('05-11-2009', 'dd-mm-yyyy'), 'assistant', 140);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (323, 'Isla Thompson', 546937973, to_date('26-07-2017', 'dd-mm-yyyy'), 'teacher', 139);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (324, 'Miriam Clark', 533234521, to_date('27-04-1990', 'dd-mm-yyyy'), 'assistant', 58);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (325, 'Haley Mitchell', 572189822, to_date('07-04-2015', 'dd-mm-yyyy'), 'assistant', 96);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (326, 'Lilliana Wilson', 581310441, to_date('12-03-2019', 'dd-mm-yyyy'), 'teacher', 148);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (327, 'Lillian Anderson', 533905701, to_date('26-02-2014', 'dd-mm-yyyy'), 'teacher', 75);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (328, 'Arabella Jones', 554649221, to_date('01-12-2014', 'dd-mm-yyyy'), 'teacher', 65);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (329, 'Ariana Davis', 520345447, to_date('16-10-2022', 'dd-mm-yyyy'), 'teacher', 20);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (330, 'Sadie Rogers', 521042168, to_date('09-04-2019', 'dd-mm-yyyy'), 'assistant', 139);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (331, 'Myla Jones', 533770829, to_date('20-07-2010', 'dd-mm-yyyy'), 'assistant', 2);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (332, 'Adelaide Moore', 528630247, to_date('13-03-2017', 'dd-mm-yyyy'), 'teacher', 38);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (333, 'Sloane Hernandez', 520562416, to_date('01-06-2011', 'dd-mm-yyyy'), 'assistant', 88);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (334, 'Noelle Davis', 554689712, to_date('01-08-1990', 'dd-mm-yyyy'), 'teacher', 38);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (335, 'Ashley Hernandez', 561709456, to_date('22-01-2005', 'dd-mm-yyyy'), 'assistant', 103);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (336, 'Sadie Hall', 569689206, to_date('19-04-1992', 'dd-mm-yyyy'), 'teacher', 117);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (337, 'Claire Nelson', 566937695, to_date('20-12-2009', 'dd-mm-yyyy'), 'teacher', 43);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (338, 'Elsie Thompson', 575748061, to_date('17-12-2019', 'dd-mm-yyyy'), 'teacher', 47);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (339, 'Josephine Lee', 553069055, to_date('30-12-2019', 'dd-mm-yyyy'), 'teacher', 133);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (340, 'Kendall Hernandez', 554410256, to_date('17-08-2018', 'dd-mm-yyyy'), 'assistant', 136);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (341, 'Grace Lopez', 561501976, to_date('18-03-2012', 'dd-mm-yyyy'), 'teacher', 126);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (342, 'Elena Hernandez', 559656704, to_date('15-11-2005', 'dd-mm-yyyy'), 'teacher', 117);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (343, 'Jocelyn Wright', 560664746, to_date('18-08-1995', 'dd-mm-yyyy'), 'teacher', 23);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (344, 'Lilliana Moore', 591126368, to_date('27-04-1999', 'dd-mm-yyyy'), 'assistant', 3);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (345, 'Emma Roy', 598425461, to_date('15-09-2012', 'dd-mm-yyyy'), 'teacher', 123);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (346, 'Fiona Johnson', 557786783, to_date('23-11-2015', 'dd-mm-yyyy'), 'assistant', 90);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (347, 'Kennedy Phillips', 557796403, to_date('24-01-2005', 'dd-mm-yyyy'), 'teacher', 21);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (348, 'Millie Hernandez', 551626394, to_date('06-05-2013', 'dd-mm-yyyy'), 'assistant', 51);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (349, 'Amira Young', 582172314, to_date('05-03-1998', 'dd-mm-yyyy'), 'assistant', 41);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (350, 'Adalyn Campbell', 543683296, to_date('12-10-2000', 'dd-mm-yyyy'), 'assistant', 18);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (351, 'Alaina Clark', 562135035, to_date('27-04-2022', 'dd-mm-yyyy'), 'assistant', 134);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (352, 'Miriam Lewis', 545081914, to_date('11-03-2017', 'dd-mm-yyyy'), 'assistant', 31);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (353, 'Ava Mitchell', 542122706, to_date('03-11-2019', 'dd-mm-yyyy'), 'teacher', 65);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (354, 'Bianca Nguyen', 523405384, to_date('23-11-1991', 'dd-mm-yyyy'), 'teacher', 14);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (355, 'Everly Nguyen', 596198385, to_date('11-09-1992', 'dd-mm-yyyy'), 'assistant', 5);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (356, 'Mackenzie Campbell', 587082098, to_date('07-02-2009', 'dd-mm-yyyy'), 'teacher', 92);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (357, 'Lena Lee', 535050304, to_date('06-04-2003', 'dd-mm-yyyy'), 'teacher', 123);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (358, 'Natalia Scott', 574802702, to_date('24-07-2019', 'dd-mm-yyyy'), 'assistant', 60);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (359, 'Aspen Thomas', 532486498, to_date('15-12-2019', 'dd-mm-yyyy'), 'teacher', 141);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (360, 'Nora Nelson', 586567967, to_date('31-10-2009', 'dd-mm-yyyy'), 'assistant', 95);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (361, 'Adeline Mitchell', 555312696, to_date('03-01-2012', 'dd-mm-yyyy'), 'teacher', 11);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (362, 'Lucy Hernandez', 579294648, to_date('17-06-2015', 'dd-mm-yyyy'), 'teacher', 86);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (363, 'Makenna Allen', 520963107, to_date('06-05-2017', 'dd-mm-yyyy'), 'assistant', 82);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (364, 'Anna Moore', 557041626, to_date('10-05-2005', 'dd-mm-yyyy'), 'teacher', 118);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (365, 'Hazel Diaz', 530174017, to_date('06-10-1997', 'dd-mm-yyyy'), 'teacher', 51);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (366, 'Millie Cruz', 513103252, to_date('04-11-2023', 'dd-mm-yyyy'), 'assistant', 85);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (367, 'Juliana Anderson', 585401819, to_date('27-11-2008', 'dd-mm-yyyy'), 'teacher', 47);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (368, 'Eva Garcia', 582271081, to_date('06-10-2009', 'dd-mm-yyyy'), 'assistant', 109);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (369, 'Sadie Hernandez', 569059496, to_date('16-06-2004', 'dd-mm-yyyy'), 'assistant', 106);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (370, 'Catalina Allen', 576020270, to_date('25-08-2003', 'dd-mm-yyyy'), 'assistant', 145);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (371, 'Elsie Hernandez', 525104319, to_date('10-10-2012', 'dd-mm-yyyy'), 'assistant', 143);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (372, 'Elise Anderson', 548094526, to_date('07-12-2013', 'dd-mm-yyyy'), 'assistant', 90);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (373, 'Harley Sanchez', 588082039, to_date('04-08-2015', 'dd-mm-yyyy'), 'assistant', 24);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (374, 'Maggie Lee', 554673780, to_date('24-06-2019', 'dd-mm-yyyy'), 'teacher', 104);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (375, 'Madilyn Lopez', 528037946, to_date('08-11-2014', 'dd-mm-yyyy'), 'teacher', 4);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (376, 'Aubree Wilson', 538126406, to_date('02-10-2016', 'dd-mm-yyyy'), 'teacher', 91);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (377, 'Hayden Lewis', 567550031, to_date('13-09-2005', 'dd-mm-yyyy'), 'assistant', 5);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (378, 'Katherine Nelson', 581348047, to_date('17-10-1994', 'dd-mm-yyyy'), 'teacher', 7);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (379, 'Layla Moore', 596127779, to_date('24-03-2015', 'dd-mm-yyyy'), 'assistant', 69);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (380, 'Mila Hall', 518551004, to_date('01-10-2005', 'dd-mm-yyyy'), 'assistant', 134);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (381, 'Maggie Lee', 550909852, to_date('03-06-2013', 'dd-mm-yyyy'), 'assistant', 18);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (382, 'Kinsley Harris', 573172273, to_date('16-02-2001', 'dd-mm-yyyy'), 'assistant', 35);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (383, 'Violet Carter', 549757709, to_date('13-01-2017', 'dd-mm-yyyy'), 'assistant', 13);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (384, 'Stella Martinez', 549256719, to_date('29-12-1998', 'dd-mm-yyyy'), 'assistant', 150);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (385, 'Aubrie Garcia', 592555456, to_date('13-01-2010', 'dd-mm-yyyy'), 'assistant', 105);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (386, 'Ava Rogers', 569924318, to_date('09-12-2019', 'dd-mm-yyyy'), 'assistant', 26);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (387, 'Reagan Moore', 528784136, to_date('28-06-1991', 'dd-mm-yyyy'), 'teacher', 125);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (388, 'Jocelyn Garcia', 574792453, to_date('01-09-2019', 'dd-mm-yyyy'), 'teacher', 118);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (389, 'Cora Wright', 554427055, to_date('07-09-2013', 'dd-mm-yyyy'), 'teacher', 105);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (390, 'Makayla Ramirez', 514031106, to_date('14-12-1993', 'dd-mm-yyyy'), 'teacher', 126);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (391, 'Emma Davis', 585106658, to_date('25-03-1994', 'dd-mm-yyyy'), 'teacher', 7);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (392, 'Sarah Diaz', 561975424, to_date('21-05-2000', 'dd-mm-yyyy'), 'assistant', 76);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (393, 'Daphne Scott', 558675934, to_date('17-10-2002', 'dd-mm-yyyy'), 'assistant', 97);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (394, 'Claire Harris', 574967600, to_date('26-04-1992', 'dd-mm-yyyy'), 'assistant', 146);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (395, 'Valentina Lewis', 557964646, to_date('19-08-2020', 'dd-mm-yyyy'), 'teacher', 78);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (396, 'Ruth Diaz', 547579069, to_date('20-11-2022', 'dd-mm-yyyy'), 'assistant', 107);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (397, 'Natalia Nguyen', 527637725, to_date('17-09-2016', 'dd-mm-yyyy'), 'teacher', 56);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (398, 'Taylor Clark', 556415651, to_date('05-09-1992', 'dd-mm-yyyy'), 'assistant', 16);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (399, 'Claire Roberts', 592067687, to_date('03-03-1998', 'dd-mm-yyyy'), 'teacher', 103);
insert into TEACHER (teacher_id, t_name, phone, experience_date, t_role, kindergartenid)
values (400, 'Mackenzie Thomas', 590435624, to_date('26-09-2009', 'dd-mm-yyyy'), 'teacher', 63);
commit;
prompt 400 records loaded
prompt Loading WORKER...
insert into WORKER (worker_id, workhoures, name, salary)
values (4830, 9, 'Rory Furtado', 11884);
insert into WORKER (worker_id, workhoures, name, salary)
values (4840, 10, 'Pierce Hudson', 6360);
insert into WORKER (worker_id, workhoures, name, salary)
values (4850, 6, 'Gordie Ammons', 14169);
insert into WORKER (worker_id, workhoures, name, salary)
values (4860, 10, 'Natasha Michael', 19068);
insert into WORKER (worker_id, workhoures, name, salary)
values (4870, 12, 'Lupe Nicks', 22051);
insert into WORKER (worker_id, workhoures, name, salary)
values (4880, 12, 'Crystal Loeb', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (4890, 10, 'Teena Barnett', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4900, 9, 'Amanda Penders', 10588);
insert into WORKER (worker_id, workhoures, name, salary)
values (4910, 5, 'Daniel Pastore', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4920, 10, 'Lauren Peniston', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4930, 12, 'Benjamin Navarr', 11666);
insert into WORKER (worker_id, workhoures, name, salary)
values (4940, 4, 'Natasha Beals', 15577);
insert into WORKER (worker_id, workhoures, name, salary)
values (4950, 5, 'Beth Sellers', 4708);
insert into WORKER (worker_id, workhoures, name, salary)
values (4960, 8, 'Aaron Gooding', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (4970, 11, 'Andy Ledger', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4980, 10, 'Neve Presley', 20023);
insert into WORKER (worker_id, workhoures, name, salary)
values (4990, 6, 'Isabella Dunn', 10013);
insert into WORKER (worker_id, workhoures, name, salary)
values (5000, 9, 'Shirley Mazzell', 5768);
insert into WORKER (worker_id, workhoures, name, salary)
values (5010, 8, 'Pablo Bean', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (5020, 4, 'Michael Preston', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5030, 4, 'Brittany Rippy', 11453);
insert into WORKER (worker_id, workhoures, name, salary)
values (5040, 4, 'Kylie Reeves', 6421);
insert into WORKER (worker_id, workhoures, name, salary)
values (5050, 9, 'Rade Armatradin', 17191);
insert into WORKER (worker_id, workhoures, name, salary)
values (5060, 11, 'Natascha Pullma', 8177);
insert into WORKER (worker_id, workhoures, name, salary)
values (5070, 10, 'Nicky Eat World', 9114);
insert into WORKER (worker_id, workhoures, name, salary)
values (5080, 8, 'Heather Dourif', 9578);
insert into WORKER (worker_id, workhoures, name, salary)
values (5090, 5, 'Glenn Delta', 4919);
insert into WORKER (worker_id, workhoures, name, salary)
values (5100, 12, 'Janice Rickles', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (5110, 11, 'Gavin Morales', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (5120, 8, 'Oliver Connery', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (5130, 6, 'Doug Deejay', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5140, 11, 'Shannyn Suvari', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (5150, 7, 'Mark Donelly', 7632);
insert into WORKER (worker_id, workhoures, name, salary)
values (5160, 9, 'Powers Wine', 12854);
insert into WORKER (worker_id, workhoures, name, salary)
values (5170, 12, 'Oliver Woodward', 18014);
insert into WORKER (worker_id, workhoures, name, salary)
values (5180, 10, 'Hank Streep', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (5190, 12, 'Mindy Smith', 12861);
insert into WORKER (worker_id, workhoures, name, salary)
values (5200, 12, 'Julie Costner', 7317);
insert into WORKER (worker_id, workhoures, name, salary)
values (5210, 7, 'Jann McPherson', 18142);
insert into WORKER (worker_id, workhoures, name, salary)
values (5220, 8, 'Lorraine Venora', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (5230, 10, 'Vendetta Berkof', 7051);
insert into WORKER (worker_id, workhoures, name, salary)
values (5240, 8, 'Natalie Borgnin', 9683);
insert into WORKER (worker_id, workhoures, name, salary)
values (5250, 12, 'Hope Weston', 6731);
insert into WORKER (worker_id, workhoures, name, salary)
values (5260, 5, 'Hazel Goodman', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5270, 6, 'Faye Dafoe', 18489);
insert into WORKER (worker_id, workhoures, name, salary)
values (5280, 9, 'Rickie Hawthorn', 8602);
insert into WORKER (worker_id, workhoures, name, salary)
values (5290, 12, 'Vickie Jenkins', 19015);
insert into WORKER (worker_id, workhoures, name, salary)
values (5300, 12, 'Praga Dafoe', 10729);
insert into WORKER (worker_id, workhoures, name, salary)
values (5310, 11, 'Rebecca Tucci', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (5320, 10, 'Steve Wilkinson', 14756);
insert into WORKER (worker_id, workhoures, name, salary)
values (5330, 5, 'Nastassja Monk', 14366);
insert into WORKER (worker_id, workhoures, name, salary)
values (5340, 9, 'Salma Bentley', 12603);
insert into WORKER (worker_id, workhoures, name, salary)
values (5350, 6, 'Miranda Simpson', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5360, 4, 'Lynn Landau', 4214);
insert into WORKER (worker_id, workhoures, name, salary)
values (5370, 7, 'Freda Thomas', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (5380, 6, 'Red Molina', 17278);
insert into WORKER (worker_id, workhoures, name, salary)
values (5390, 12, 'Jackie Gandolfi', 14268);
insert into WORKER (worker_id, workhoures, name, salary)
values (5400, 6, 'Ben Cazale', 18443);
insert into WORKER (worker_id, workhoures, name, salary)
values (5410, 7, 'Nancy Douglas', 10462);
insert into WORKER (worker_id, workhoures, name, salary)
values (5420, 5, 'Murray James', 18538);
insert into WORKER (worker_id, workhoures, name, salary)
values (5430, 11, 'Kate Chinlund', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (5440, 4, 'Sophie Eckhart', 12292);
insert into WORKER (worker_id, workhoures, name, salary)
values (5450, 10, 'Nicholas Tinsle', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (5460, 5, 'Lindsey Neill', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5470, 12, 'Jody Child', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (5480, 5, 'Walter Chapman', 12507);
insert into WORKER (worker_id, workhoures, name, salary)
values (5490, 10, 'Derrick Wong', 10315);
insert into WORKER (worker_id, workhoures, name, salary)
values (5500, 9, 'Gailard Liu', 7392);
insert into WORKER (worker_id, workhoures, name, salary)
values (5510, 6, 'Rachid Vega', 10106);
insert into WORKER (worker_id, workhoures, name, salary)
values (5520, 8, 'Maury Mazar', 11223);
insert into WORKER (worker_id, workhoures, name, salary)
values (5530, 5, 'Bridget Dreyfus', 19015);
insert into WORKER (worker_id, workhoures, name, salary)
values (5540, 4, 'Lisa Gere', 5007);
insert into WORKER (worker_id, workhoures, name, salary)
values (5550, 5, 'Rebeka Marx', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5560, 9, 'Grant Nash', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (5570, 12, 'Vertical Robert', 13470);
insert into WORKER (worker_id, workhoures, name, salary)
values (5580, 9, 'Nik Tolkan', 17245);
insert into WORKER (worker_id, workhoures, name, salary)
values (5590, 7, 'Nick Eder', 18749);
insert into WORKER (worker_id, workhoures, name, salary)
values (5600, 8, 'Sissy Gibbons', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (5610, 10, 'Eileen Marx', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (5620, 4, 'Peabo Gooding', 4339);
insert into WORKER (worker_id, workhoures, name, salary)
values (5630, 7, 'Juliette Braugh', 11030);
insert into WORKER (worker_id, workhoures, name, salary)
values (5640, 5, 'Yaphet Gaynor', 11577);
insert into WORKER (worker_id, workhoures, name, salary)
values (5650, 11, 'Denis Harnes', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (5660, 5, 'Forest Rivers', 4419);
insert into WORKER (worker_id, workhoures, name, salary)
values (5670, 7, 'Rose McFerrin', 13663);
insert into WORKER (worker_id, workhoures, name, salary)
values (5680, 8, 'Mary Beth McCon', 6452);
insert into WORKER (worker_id, workhoures, name, salary)
values (5690, 8, 'Nikki Evanswood', 18786);
insert into WORKER (worker_id, workhoures, name, salary)
values (5700, 12, 'Larry Ticotin', 14502);
insert into WORKER (worker_id, workhoures, name, salary)
values (5710, 10, 'Adrien MacPhers', 12980);
insert into WORKER (worker_id, workhoures, name, salary)
values (5720, 8, 'Miko Baranski', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (5730, 4, 'Crystal Hubbard', 17116);
insert into WORKER (worker_id, workhoures, name, salary)
values (5740, 7, 'Bo Stamp', 23394);
insert into WORKER (worker_id, workhoures, name, salary)
values (5750, 12, 'Teena Nelligan', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (5760, 11, 'Tony Harrison', 8277);
insert into WORKER (worker_id, workhoures, name, salary)
values (5770, 7, 'Nikki Palmer', 12027);
insert into WORKER (worker_id, workhoures, name, salary)
values (5780, 5, 'Vertical Rowlan', 19196);
insert into WORKER (worker_id, workhoures, name, salary)
values (5790, 11, 'Vickie Caine', 10706);
insert into WORKER (worker_id, workhoures, name, salary)
values (5800, 8, 'Chris Napolitan', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (5810, 8, 'Rascal Giamatti', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (5820, 10, 'Larenz Liotta', 6000);
commit;
prompt 100 records committed...
insert into WORKER (worker_id, workhoures, name, salary)
values (5830, 5, 'Adrien Lavigne', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5840, 7, 'Selma Travolta', 6010);
insert into WORKER (worker_id, workhoures, name, salary)
values (5850, 6, 'Freda Skaggs', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5860, 5, 'Julia Griggs', 12371);
insert into WORKER (worker_id, workhoures, name, salary)
values (5870, 12, 'Ethan Esposito', 19693);
insert into WORKER (worker_id, workhoures, name, salary)
values (5880, 6, 'Frank Blades', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5890, 9, 'Maureen Hawkins', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (5900, 10, 'Mos Pacino', 8396);
insert into WORKER (worker_id, workhoures, name, salary)
values (5910, 9, 'Humberto McCrea', 4361);
insert into WORKER (worker_id, workhoures, name, salary)
values (5920, 4, 'Jonathan Holly', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5930, 6, 'Gary Pitney', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5940, 10, 'Charlton Metcal', 11730);
insert into WORKER (worker_id, workhoures, name, salary)
values (5950, 8, 'Cole Stiles', 12671);
insert into WORKER (worker_id, workhoures, name, salary)
values (5960, 4, 'Toshiro Harriso', 9608);
insert into WORKER (worker_id, workhoures, name, salary)
values (5970, 6, 'Debi O''Neill', 14347);
insert into WORKER (worker_id, workhoures, name, salary)
values (5980, 5, 'Amy Santana', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5990, 8, 'Murray Monk', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (6000, 4, 'Shannon Davies', 14008);
insert into WORKER (worker_id, workhoures, name, salary)
values (2420, 5, 'Laura Westerber', 10434);
insert into WORKER (worker_id, workhoures, name, salary)
values (2430, 8, 'Angela Hutch', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2440, 7, 'Todd Aniston', 8282);
insert into WORKER (worker_id, workhoures, name, salary)
values (2450, 8, 'Azucar Worrell', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2460, 5, 'Remy Stigers', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2470, 5, 'Kiefer Moody', 17517);
insert into WORKER (worker_id, workhoures, name, salary)
values (2480, 10, 'Nicky Perlman', 16541);
insert into WORKER (worker_id, workhoures, name, salary)
values (2490, 8, 'Steven Cherry', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2500, 7, 'Dennis Hingle', 18374);
insert into WORKER (worker_id, workhoures, name, salary)
values (2510, 6, 'Merle Krumholtz', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2520, 11, 'Domingo Patton', 9075);
insert into WORKER (worker_id, workhoures, name, salary)
values (2530, 7, 'Ving Biel', 7594);
insert into WORKER (worker_id, workhoures, name, salary)
values (2540, 12, 'Jeffery Feore', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (2550, 4, 'Jonatha Martin', 7418);
insert into WORKER (worker_id, workhoures, name, salary)
values (2560, 11, 'Rosanna Reno', 6233);
insert into WORKER (worker_id, workhoures, name, salary)
values (2570, 7, 'Al Winter', 11016);
insert into WORKER (worker_id, workhoures, name, salary)
values (2580, 8, 'Glenn Eldard', 11609);
insert into WORKER (worker_id, workhoures, name, salary)
values (2590, 5, 'Lily Wilkinson', 19361);
insert into WORKER (worker_id, workhoures, name, salary)
values (2600, 4, 'Leo Barrymore', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2610, 8, 'Corey Maguire', 18498);
insert into WORKER (worker_id, workhoures, name, salary)
values (2620, 7, 'Elisabeth Senio', 16907);
insert into WORKER (worker_id, workhoures, name, salary)
values (2630, 10, 'Vondie Bragg', 12259);
insert into WORKER (worker_id, workhoures, name, salary)
values (2640, 4, 'Ice Rubinek', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2650, 7, 'Carolyn Marin', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2660, 10, 'Rebeka Scaggs', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (2670, 12, 'Brittany Dooley', 13760);
insert into WORKER (worker_id, workhoures, name, salary)
values (2680, 12, 'Armin Vanian', 6093);
insert into WORKER (worker_id, workhoures, name, salary)
values (2690, 8, 'Remy McElhone', 21103);
insert into WORKER (worker_id, workhoures, name, salary)
values (2700, 11, 'Mira Davis', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (2710, 9, 'Nile Jonze', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2720, 6, 'Suzy Tinsley', 6842);
insert into WORKER (worker_id, workhoures, name, salary)
values (2730, 6, 'Jason Phillippe', 18516);
insert into WORKER (worker_id, workhoures, name, salary)
values (2740, 12, 'Tara Sherman', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (2750, 5, 'Rolando Armstro', 12353);
insert into WORKER (worker_id, workhoures, name, salary)
values (2760, 9, 'Tramaine Dillan', 7215);
insert into WORKER (worker_id, workhoures, name, salary)
values (2770, 10, 'Lesley Cetera', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (2780, 12, 'Kurt Strathairn', 17070);
insert into WORKER (worker_id, workhoures, name, salary)
values (2790, 10, 'Max Fariq', 7942);
insert into WORKER (worker_id, workhoures, name, salary)
values (2800, 7, 'Radney Francis', 8785);
insert into WORKER (worker_id, workhoures, name, salary)
values (2810, 12, 'Seth Arjona', 8011);
insert into WORKER (worker_id, workhoures, name, salary)
values (2820, 8, 'Meg Rhymes', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2830, 10, 'Kurtwood Fogert', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (2840, 8, 'Jessica Winwood', 7515);
insert into WORKER (worker_id, workhoures, name, salary)
values (2850, 10, 'Buddy Zevon', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (2860, 9, 'Elias Pride', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2870, 7, 'Val Lipnicki', 6748);
insert into WORKER (worker_id, workhoures, name, salary)
values (2880, 11, 'Juliet Field', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (2890, 11, 'Chalee Winger', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (2900, 9, 'Hope Mars', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2910, 11, 'Goldie Keitel', 17805);
insert into WORKER (worker_id, workhoures, name, salary)
values (2920, 5, 'Rita Crystal', 16256);
insert into WORKER (worker_id, workhoures, name, salary)
values (2930, 11, 'Red Ryan', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (2940, 12, 'Roger Farrow', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (2950, 7, 'Chant׳™ Hurt', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2960, 11, 'Lindsey Cruz', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (2970, 10, 'Quentin Stevens', 19345);
insert into WORKER (worker_id, workhoures, name, salary)
values (2980, 6, 'Cameron Shandli', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2990, 8, 'Maxine Conlee', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (3000, 7, 'Edie Belle', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (3010, 8, 'Nancy Weiss', 11432);
insert into WORKER (worker_id, workhoures, name, salary)
values (3020, 4, 'Malcolm Palmer', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3030, 4, 'Vern McLachlan', 5077);
insert into WORKER (worker_id, workhoures, name, salary)
values (3040, 4, 'Kid Keaton', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3050, 4, 'Vendetta Santan', 6273);
insert into WORKER (worker_id, workhoures, name, salary)
values (3060, 5, 'Doug Olyphant', 13779);
insert into WORKER (worker_id, workhoures, name, salary)
values (3070, 10, 'Al Jackman', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (3080, 4, 'Brooke Richards', 7363);
insert into WORKER (worker_id, workhoures, name, salary)
values (3090, 11, 'Nicole Salonga', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (3100, 9, 'Marie Mandrell', 13530);
insert into WORKER (worker_id, workhoures, name, salary)
values (3110, 5, 'Horace Weiland', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3120, 7, 'Sean McFerrin', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (3130, 7, 'Pelvic Polley', 10851);
insert into WORKER (worker_id, workhoures, name, salary)
values (3140, 8, 'Red Schock', 19164);
insert into WORKER (worker_id, workhoures, name, salary)
values (3150, 7, 'Greg Meyer', 8381);
insert into WORKER (worker_id, workhoures, name, salary)
values (3160, 7, 'Maggie Milsap', 11508);
insert into WORKER (worker_id, workhoures, name, salary)
values (3170, 6, 'Juliana Hawkins', 10006);
insert into WORKER (worker_id, workhoures, name, salary)
values (3180, 4, 'Frank Cross', 19353);
insert into WORKER (worker_id, workhoures, name, salary)
values (3190, 10, 'Patrick Reubens', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (3200, 11, 'Carrie Conlee', 13943);
insert into WORKER (worker_id, workhoures, name, salary)
values (3210, 6, 'Taye Haslam', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3220, 6, 'Claude Magnuson', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3230, 10, 'Selma Gayle', 6000);
commit;
prompt 200 records committed...
insert into WORKER (worker_id, workhoures, name, salary)
values (3240, 12, 'Ben Abraham', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (3250, 12, 'Jet Peet', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (3260, 8, 'Nanci Howard', 9719);
insert into WORKER (worker_id, workhoures, name, salary)
values (3270, 7, 'Kimberly Martin', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (3280, 9, 'Suzanne Sutherl', 7383);
insert into WORKER (worker_id, workhoures, name, salary)
values (3290, 5, 'Will Holden', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3300, 6, 'Jeffery Rollins', 6164);
insert into WORKER (worker_id, workhoures, name, salary)
values (3310, 4, 'Terri Monk', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3320, 4, 'Roddy Hagar', 10298);
insert into WORKER (worker_id, workhoures, name, salary)
values (3330, 4, 'Quentin Judd', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3340, 11, 'Dom Oakenfold', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (3350, 7, 'Lesley Fogerty', 12361);
insert into WORKER (worker_id, workhoures, name, salary)
values (3360, 6, 'Oro Kadison', 18433);
insert into WORKER (worker_id, workhoures, name, salary)
values (3370, 7, 'Famke Day', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (3380, 11, 'Bob Tyson', 11433);
insert into WORKER (worker_id, workhoures, name, salary)
values (3390, 10, 'Dennis Rubinek', 16012);
insert into WORKER (worker_id, workhoures, name, salary)
values (3400, 9, 'Christina Dusch', 16220);
insert into WORKER (worker_id, workhoures, name, salary)
values (3410, 9, 'Guy English', 11849);
insert into WORKER (worker_id, workhoures, name, salary)
values (3420, 8, 'Ali Swank', 14243);
insert into WORKER (worker_id, workhoures, name, salary)
values (3430, 6, 'Terry Dafoe', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3440, 6, 'Davis Pullman', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3450, 6, 'Taylor Blackmor', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3460, 6, 'Chazz Assante', 16400);
insert into WORKER (worker_id, workhoures, name, salary)
values (3470, 5, 'Phoebe Kier', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3480, 10, 'Jose Favreau', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (3490, 10, 'Wally McCabe', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (3500, 10, 'Laura Paige', 18057);
insert into WORKER (worker_id, workhoures, name, salary)
values (3510, 11, 'Tracy Sisto', 17441);
insert into WORKER (worker_id, workhoures, name, salary)
values (3520, 9, 'Vincent McGill', 14667);
insert into WORKER (worker_id, workhoures, name, salary)
values (3530, 5, 'Mindy Balaban', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3540, 6, 'Clive Perrineau', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3550, 5, 'Nicolas Orton', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3560, 8, 'Brooke Chao', 12188);
insert into WORKER (worker_id, workhoures, name, salary)
values (3570, 8, 'Barbara McLachl', 18839);
insert into WORKER (worker_id, workhoures, name, salary)
values (3580, 8, 'Solomon Conroy', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (3590, 10, 'Debra Bracco', 14035);
insert into WORKER (worker_id, workhoures, name, salary)
values (3600, 5, 'Madeline Avital', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3610, 5, 'Clint Baldwin', 4499);
insert into WORKER (worker_id, workhoures, name, salary)
values (3620, 7, 'Denzel Camp', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (3630, 8, 'Lin Pacino', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (3640, 6, 'Jeffery McDowel', 19011);
insert into WORKER (worker_id, workhoures, name, salary)
values (3650, 11, 'Sissy Hopper', 12176);
insert into WORKER (worker_id, workhoures, name, salary)
values (3660, 8, 'Lizzy Campbell', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (3670, 10, 'Melba Cohn', 14373);
insert into WORKER (worker_id, workhoures, name, salary)
values (3680, 8, 'Quentin Browne', 13504);
insert into WORKER (worker_id, workhoures, name, salary)
values (3690, 10, 'Ron Schwimmer', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (3700, 12, 'Stockard Berkle', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (3710, 10, 'Bridgette Carlt', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (3720, 10, 'Shannon Kingsle', 12161);
insert into WORKER (worker_id, workhoures, name, salary)
values (3730, 10, 'Irene Waits', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (3740, 12, 'Pelvic Schiff', 15728);
insert into WORKER (worker_id, workhoures, name, salary)
values (3750, 5, 'Gary Myles', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3760, 10, 'Bobby von Sydow', 11682);
insert into WORKER (worker_id, workhoures, name, salary)
values (3770, 10, 'Norm Unger', 7289);
insert into WORKER (worker_id, workhoures, name, salary)
values (3780, 10, 'Dom Stigers', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (3790, 6, 'Gaby Wong', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3800, 9, 'Rhys Pryce', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (3810, 12, 'Jeff Thurman', 18365);
insert into WORKER (worker_id, workhoures, name, salary)
values (3820, 12, 'Vondie Caine', 14242);
insert into WORKER (worker_id, workhoures, name, salary)
values (3830, 12, 'Morgan Guest', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (3840, 10, 'Drew Rickles', 7802);
insert into WORKER (worker_id, workhoures, name, salary)
values (3850, 8, 'Rhys Robinson', 14869);
insert into WORKER (worker_id, workhoures, name, salary)
values (3860, 9, 'Taye Jordan', 6477);
insert into WORKER (worker_id, workhoures, name, salary)
values (3870, 12, 'Katie Lyonne', 8291);
insert into WORKER (worker_id, workhoures, name, salary)
values (3880, 12, 'Meryl Glenn', 20750);
insert into WORKER (worker_id, workhoures, name, salary)
values (3890, 7, 'Junior Spacek', 5613);
insert into WORKER (worker_id, workhoures, name, salary)
values (3900, 6, 'Heath Leoni', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3910, 6, 'Guy Marie', 8730);
insert into WORKER (worker_id, workhoures, name, salary)
values (3920, 5, 'Ty Springfield', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3930, 12, 'Neve McAnally', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (3940, 10, 'Aaron Gallant', 14101);
insert into WORKER (worker_id, workhoures, name, salary)
values (3950, 12, 'Dar Hopper', 13700);
insert into WORKER (worker_id, workhoures, name, salary)
values (3960, 4, 'Spencer Holy', 5964);
insert into WORKER (worker_id, workhoures, name, salary)
values (3970, 11, 'Suzi Costa', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (3980, 7, 'Lynn Bacharach', 4039);
insert into WORKER (worker_id, workhoures, name, salary)
values (3990, 11, 'Freddy Richter', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4000, 6, 'Shannyn McLachl', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4010, 5, 'Stellan Heather', 9497);
insert into WORKER (worker_id, workhoures, name, salary)
values (4020, 6, 'Christina Mahoo', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4030, 4, 'Devon Mann', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4040, 5, 'Toshiro Brown', 15562);
insert into WORKER (worker_id, workhoures, name, salary)
values (4050, 12, 'Nelly Cage', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (4060, 7, 'Rebecca Favreau', 13725);
insert into WORKER (worker_id, workhoures, name, salary)
values (4070, 11, 'Ozzy Serbedzija', 24445);
insert into WORKER (worker_id, workhoures, name, salary)
values (4080, 7, 'Nils Ifans', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (4090, 5, 'Lari Burmester', 17637);
insert into WORKER (worker_id, workhoures, name, salary)
values (4100, 11, 'Lennie Satriani', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4110, 7, 'Murray DeVita', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (4120, 5, 'Famke Mould', 8555);
insert into WORKER (worker_id, workhoures, name, salary)
values (4130, 9, 'Pat Pearce', 14211);
insert into WORKER (worker_id, workhoures, name, salary)
values (4140, 6, 'Lois Kretschman', 19286);
insert into WORKER (worker_id, workhoures, name, salary)
values (4150, 12, 'Belinda Unger', 7983);
insert into WORKER (worker_id, workhoures, name, salary)
values (4160, 10, 'Denny Teng', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4170, 10, 'Mena Hong', 10634);
insert into WORKER (worker_id, workhoures, name, salary)
values (4180, 5, 'Samuel Fender', 4158);
insert into WORKER (worker_id, workhoures, name, salary)
values (4190, 7, 'Spike Belles', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (4200, 9, 'Jesse Furtado', 16208);
insert into WORKER (worker_id, workhoures, name, salary)
values (4210, 6, 'Marc Roundtree', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4220, 7, 'Colm Hauser', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (4230, 5, 'Avenged McGover', 3500);
commit;
prompt 300 records committed...
insert into WORKER (worker_id, workhoures, name, salary)
values (4240, 5, 'Christmas Mazar', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4250, 11, 'Terrence Stewar', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4260, 4, 'Debra Solido', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4270, 6, 'Jesus Warburton', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4280, 9, 'Stephanie Mathe', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (4290, 9, 'Natascha Bracco', 11058);
insert into WORKER (worker_id, workhoures, name, salary)
values (4300, 4, 'Fairuza Goldber', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4310, 12, 'Nickel Palin', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (4320, 8, 'Elizabeth Colem', 7318);
insert into WORKER (worker_id, workhoures, name, salary)
values (4330, 6, 'Sharon Sevenfol', 12139);
insert into WORKER (worker_id, workhoures, name, salary)
values (4340, 10, 'Hope Spears', 20324);
insert into WORKER (worker_id, workhoures, name, salary)
values (4350, 8, 'Dwight Collie', 10618);
insert into WORKER (worker_id, workhoures, name, salary)
values (4360, 8, 'CeCe Spacey', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (4370, 5, 'Bridgette Cartl', 4152);
insert into WORKER (worker_id, workhoures, name, salary)
values (4380, 7, 'Burt Field', 8736);
insert into WORKER (worker_id, workhoures, name, salary)
values (4390, 7, 'Donal Giannini', 14534);
insert into WORKER (worker_id, workhoures, name, salary)
values (4400, 11, 'Geoffrey Hunter', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4410, 10, 'Penelope Katt', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4420, 8, 'Linda England', 19016);
insert into WORKER (worker_id, workhoures, name, salary)
values (4430, 12, 'Joanna Fonda', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (4440, 8, 'Pat Plummer', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (4450, 8, 'Peabo Estevez', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (4460, 11, 'Greg Rea', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4470, 12, 'Denis Briscoe', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (4480, 8, 'Chad Crow', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (4490, 5, 'Luis Shandling', 4871);
insert into WORKER (worker_id, workhoures, name, salary)
values (4500, 10, 'Julianna O''Sull', 15682);
insert into WORKER (worker_id, workhoures, name, salary)
values (4510, 4, 'Jesus Evett', 19661);
insert into WORKER (worker_id, workhoures, name, salary)
values (4520, 8, 'Denny Roth', 13438);
insert into WORKER (worker_id, workhoures, name, salary)
values (4530, 12, 'Elle Potter', 10403);
insert into WORKER (worker_id, workhoures, name, salary)
values (4540, 12, 'Fairuza Rizzo', 11895);
insert into WORKER (worker_id, workhoures, name, salary)
values (4550, 7, 'Jean-Luc Richar', 11776);
insert into WORKER (worker_id, workhoures, name, salary)
values (4560, 11, 'Kasey Heatherly', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4570, 12, 'Curtis Redford', 21966);
insert into WORKER (worker_id, workhoures, name, salary)
values (4580, 7, 'Ike Chestnut', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (4590, 11, 'Taye Gertner', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4600, 5, 'Cornell Richard', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4610, 4, 'Carolyn Jovovic', 15401);
insert into WORKER (worker_id, workhoures, name, salary)
values (4620, 11, 'Miles Baez', 11311);
insert into WORKER (worker_id, workhoures, name, salary)
values (4630, 4, 'Teri Lapointe', 10531);
insert into WORKER (worker_id, workhoures, name, salary)
values (4640, 10, 'Devon Aniston', 13813);
insert into WORKER (worker_id, workhoures, name, salary)
values (4650, 4, 'Caroline Torino', 9689);
insert into WORKER (worker_id, workhoures, name, salary)
values (4660, 5, 'Bernie Horton', 12845);
insert into WORKER (worker_id, workhoures, name, salary)
values (4670, 7, 'Ray Banderas', 15463);
insert into WORKER (worker_id, workhoures, name, salary)
values (4680, 8, 'Curtis Irons', 12240);
insert into WORKER (worker_id, workhoures, name, salary)
values (4690, 4, 'Julianne Gary', 15956);
insert into WORKER (worker_id, workhoures, name, salary)
values (4700, 4, 'Patti Rydell', 11636);
insert into WORKER (worker_id, workhoures, name, salary)
values (4710, 11, 'Adina Sandoval', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4720, 12, 'Crispin Carrack', 14196);
insert into WORKER (worker_id, workhoures, name, salary)
values (4730, 11, 'Neneh Shand', 5962);
insert into WORKER (worker_id, workhoures, name, salary)
values (4740, 8, 'Renee Roberts', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (4750, 8, 'Drew Feliciano', 6641);
insert into WORKER (worker_id, workhoures, name, salary)
values (4760, 12, 'Sandra Parsons', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (4770, 7, 'Gary Arjona', 5613);
insert into WORKER (worker_id, workhoures, name, salary)
values (4780, 6, 'Freda Soda', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4790, 11, 'Ellen Keener', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4800, 8, 'Deborah Taranti', 6434);
insert into WORKER (worker_id, workhoures, name, salary)
values (4810, 11, 'Aimee Seagal', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (4820, 7, 'Gena Barrymore', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (990, 9, 'Sona Candy', 11149);
insert into WORKER (worker_id, workhoures, name, salary)
values (1000, 8, 'Ossie Wagner', 6979);
insert into WORKER (worker_id, workhoures, name, salary)
values (1010, 9, 'Burt Palin', 16035);
insert into WORKER (worker_id, workhoures, name, salary)
values (1020, 5, 'Radney Payton', 6539);
insert into WORKER (worker_id, workhoures, name, salary)
values (1030, 12, 'Bonnie Randal', 17334);
insert into WORKER (worker_id, workhoures, name, salary)
values (1040, 12, 'Famke Clooney', 10310);
insert into WORKER (worker_id, workhoures, name, salary)
values (1050, 11, 'Anna Iglesias', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (1060, 11, 'Mary Mirren', 8010);
insert into WORKER (worker_id, workhoures, name, salary)
values (1070, 8, 'Burt Jeter', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (1080, 10, 'Anjelica El-Sah', 20040);
insert into WORKER (worker_id, workhoures, name, salary)
values (1090, 9, 'Keith Tucci', 15557);
insert into WORKER (worker_id, workhoures, name, salary)
values (1100, 4, 'Rene Coleman', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1110, 10, 'Rene Parm', 11683);
insert into WORKER (worker_id, workhoures, name, salary)
values (1120, 5, 'Avril Dreyfuss', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1130, 7, 'Candice Squier', 21874);
insert into WORKER (worker_id, workhoures, name, salary)
values (1140, 4, 'Chris Tucker', 15100);
insert into WORKER (worker_id, workhoures, name, salary)
values (1150, 5, 'Nigel Parker', 11812);
insert into WORKER (worker_id, workhoures, name, salary)
values (1160, 4, 'Lloyd Pesci', 18491);
insert into WORKER (worker_id, workhoures, name, salary)
values (1170, 6, 'Cyndi Peebles', 10974);
insert into WORKER (worker_id, workhoures, name, salary)
values (1180, 6, 'Edward Himmelma', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1190, 9, 'Colm Davis', 8288);
insert into WORKER (worker_id, workhoures, name, salary)
values (1200, 9, 'Spike Levert', 12997);
insert into WORKER (worker_id, workhoures, name, salary)
values (1210, 7, 'Rascal Crudup', 17092);
insert into WORKER (worker_id, workhoures, name, salary)
values (1220, 4, 'Charles Sorvino', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1230, 7, 'Clint Elwes', 16696);
insert into WORKER (worker_id, workhoures, name, salary)
values (1240, 11, 'Donna Moss', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (1250, 12, 'Jimmy Dempsey', 20610);
insert into WORKER (worker_id, workhoures, name, salary)
values (1260, 6, 'Freddy Sanchez', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1270, 9, 'Dan Pullman', 13758);
insert into WORKER (worker_id, workhoures, name, salary)
values (1280, 7, 'Terri Nolte', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (1290, 7, 'Jack Grier', 8698);
insert into WORKER (worker_id, workhoures, name, salary)
values (1300, 5, 'Nathan Simpson', 12342);
insert into WORKER (worker_id, workhoures, name, salary)
values (1310, 7, 'Franco Austin', 8208);
insert into WORKER (worker_id, workhoures, name, salary)
values (1320, 8, 'Wayne Matthau', 7039);
insert into WORKER (worker_id, workhoures, name, salary)
values (1330, 12, 'Forest McKellen', 20000);
insert into WORKER (worker_id, workhoures, name, salary)
values (1340, 8, 'Lauren Estevez', 12747);
insert into WORKER (worker_id, workhoures, name, salary)
values (1350, 10, 'Winona Tomlin', 10449);
insert into WORKER (worker_id, workhoures, name, salary)
values (1360, 12, 'Gordon Jovovich', 17603);
insert into WORKER (worker_id, workhoures, name, salary)
values (1370, 4, 'Danny Berkley', 8967);
insert into WORKER (worker_id, workhoures, name, salary)
values (1380, 5, 'Jared Stiller', 13313);
insert into WORKER (worker_id, workhoures, name, salary)
values (1400, 10, 'Nile Byrd', 16283);
commit;
prompt 400 records committed...
insert into WORKER (worker_id, workhoures, name, salary)
values (1410, 8, 'Leo Parish', 12190);
insert into WORKER (worker_id, workhoures, name, salary)
values (1420, 10, 'Brenda Holm', 16261);
insert into WORKER (worker_id, workhoures, name, salary)
values (1430, 5, 'Will Santa Rosa', 18469);
insert into WORKER (worker_id, workhoures, name, salary)
values (1440, 11, 'Hugh Sawa', 16858);
insert into WORKER (worker_id, workhoures, name, salary)
values (1450, 11, 'Brad Stampley', 5567);
insert into WORKER (worker_id, workhoures, name, salary)
values (1460, 8, 'Jude Loveless', 20042);
insert into WORKER (worker_id, workhoures, name, salary)
values (1470, 8, 'Aida Satriani', 15094);
insert into WORKER (worker_id, workhoures, name, salary)
values (1480, 8, 'Hugo Tomei', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (1490, 12, 'Regina Craven', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (1500, 10, 'Malcolm Fonda', 6000);
insert into WORKER (worker_id, workhoures, name, salary)
values (1510, 8, 'Steven Remar', 13174);
insert into WORKER (worker_id, workhoures, name, salary)
values (1520, 10, 'Dustin Napolita', 13462);
insert into WORKER (worker_id, workhoures, name, salary)
values (1530, 5, 'Randall Carrere', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1540, 8, 'Kim Wood', 8959);
insert into WORKER (worker_id, workhoures, name, salary)
values (1550, 7, 'Johnny Bancroft', 17902);
insert into WORKER (worker_id, workhoures, name, salary)
values (1560, 12, 'Alec Perlman', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (1570, 7, 'Frank Pantolian', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (1580, 10, 'Domingo O''Donne', 9451);
insert into WORKER (worker_id, workhoures, name, salary)
values (1590, 11, 'Mickey Karyo', 9208);
insert into WORKER (worker_id, workhoures, name, salary)
values (1600, 9, 'Chris Wong', 23864);
insert into WORKER (worker_id, workhoures, name, salary)
values (1610, 8, 'Nicky Boyle', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (1620, 6, 'Nina Weber', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1630, 10, 'Harvey Supernaw', 12932);
insert into WORKER (worker_id, workhoures, name, salary)
values (1640, 7, 'Lea Farrell', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (1650, 4, 'Diamond Leoni', 17754);
insert into WORKER (worker_id, workhoures, name, salary)
values (1660, 12, 'Nelly Rains', 6600);
insert into WORKER (worker_id, workhoures, name, salary)
values (1670, 10, 'Kenny Wakeling', 6324);
insert into WORKER (worker_id, workhoures, name, salary)
values (1680, 11, 'Gordie Webb', 13752);
insert into WORKER (worker_id, workhoures, name, salary)
values (1690, 5, 'Carrie-Anne Rey', 13813);
insert into WORKER (worker_id, workhoures, name, salary)
values (1700, 6, 'Pete Rhymes', 9136);
insert into WORKER (worker_id, workhoures, name, salary)
values (1710, 5, 'Samantha Reinho', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1720, 6, 'Aidan McDonnell', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1730, 4, 'Jeremy Tennison', 4590);
insert into WORKER (worker_id, workhoures, name, salary)
values (1740, 4, 'Charlie Hatfiel', 4450);
insert into WORKER (worker_id, workhoures, name, salary)
values (1750, 6, 'Vin Lyonne', 10733);
insert into WORKER (worker_id, workhoures, name, salary)
values (1760, 9, 'Bryan Purefoy', 7454);
insert into WORKER (worker_id, workhoures, name, salary)
values (1770, 8, 'Ann Allen', 6942);
insert into WORKER (worker_id, workhoures, name, salary)
values (1780, 12, 'Rose Ellis', 18250);
insert into WORKER (worker_id, workhoures, name, salary)
values (1790, 10, 'Domingo Hidalgo', 9857);
insert into WORKER (worker_id, workhoures, name, salary)
values (1800, 7, 'Ian Malkovich', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (1810, 6, 'Larenz Spader', 11867);
insert into WORKER (worker_id, workhoures, name, salary)
values (1820, 8, 'Freda Bassett', 4036);
insert into WORKER (worker_id, workhoures, name, salary)
values (1830, 4, 'Rade Vinton', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1840, 8, 'Natascha Marsde', 16382);
insert into WORKER (worker_id, workhoures, name, salary)
values (1850, 12, 'Darius Luongo', 9502);
insert into WORKER (worker_id, workhoures, name, salary)
values (1860, 6, 'Mindy Womack', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1870, 10, 'Denis Wagner', 4800);
insert into WORKER (worker_id, workhoures, name, salary)
values (1880, 10, 'Ray Doucette', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (1890, 12, 'Tony Diffie', 18629);
insert into WORKER (worker_id, workhoures, name, salary)
values (1900, 7, 'James Preston', 13866);
insert into WORKER (worker_id, workhoures, name, salary)
values (1910, 10, 'Tori Campbell', 6005);
insert into WORKER (worker_id, workhoures, name, salary)
values (1920, 7, 'Howie Schneider', 8173);
insert into WORKER (worker_id, workhoures, name, salary)
values (1930, 8, 'Cheryl Stigers', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (1940, 6, 'Kathleen Vance', 6574);
insert into WORKER (worker_id, workhoures, name, salary)
values (1950, 5, 'Neneh Rispoli', 15800);
insert into WORKER (worker_id, workhoures, name, salary)
values (1960, 6, 'Clay Satriani', 12207);
insert into WORKER (worker_id, workhoures, name, salary)
values (1970, 12, 'Rhys Reno', 4671);
insert into WORKER (worker_id, workhoures, name, salary)
values (1980, 11, 'Danni Zevon', 8118);
insert into WORKER (worker_id, workhoures, name, salary)
values (1990, 11, 'Ray Humphrey', 17835);
insert into WORKER (worker_id, workhoures, name, salary)
values (2000, 5, 'Kyra Stigers', 6216);
insert into WORKER (worker_id, workhoures, name, salary)
values (2010, 7, 'Clint Gill', 15849);
insert into WORKER (worker_id, workhoures, name, salary)
values (2020, 5, 'Bobby Rain', 13520);
insert into WORKER (worker_id, workhoures, name, salary)
values (2030, 7, 'Roscoe Moreno', 8005);
insert into WORKER (worker_id, workhoures, name, salary)
values (2040, 9, 'Millie Hewitt', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2050, 4, 'Amy Tempest', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2060, 5, 'Tommy Baker', 17810);
insert into WORKER (worker_id, workhoures, name, salary)
values (2070, 6, 'Russell Lerner', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2080, 5, 'Jean-Luc Dolenz', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2090, 11, 'Gerald Chandler', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2100, 5, 'Mykelti McKean', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2110, 5, 'Armand McElhone', 9547);
insert into WORKER (worker_id, workhoures, name, salary)
values (2120, 12, 'Gene Gough', 14048);
insert into WORKER (worker_id, workhoures, name, salary)
values (2130, 6, 'Gina Alda', 10027);
insert into WORKER (worker_id, workhoures, name, salary)
values (2140, 11, 'Harrison McCann', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2150, 6, 'Tori Gryner', 10913);
insert into WORKER (worker_id, workhoures, name, salary)
values (2160, 9, 'Jared Levin', 17865);
insert into WORKER (worker_id, workhoures, name, salary)
values (2390, 4, 'Nikka Fariq', 6698);
insert into WORKER (worker_id, workhoures, name, salary)
values (2400, 5, 'Marie Martinez', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2410, 4, 'Gilberto Brisco', 11291);
insert into WORKER (worker_id, workhoures, name, salary)
values (10, 5, 'Karen Hoffman', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (20, 4, 'Jeff Navarro', 6483);
insert into WORKER (worker_id, workhoures, name, salary)
values (30, 6, 'Deborah Daniels', 8730);
insert into WORKER (worker_id, workhoures, name, salary)
values (40, 9, 'Janeane Hurt', 20336);
insert into WORKER (worker_id, workhoures, name, salary)
values (50, 4, 'Geoffrey Krabbe', 18122);
insert into WORKER (worker_id, workhoures, name, salary)
values (60, 5, 'Nicole Holmes', 4627);
insert into WORKER (worker_id, workhoures, name, salary)
values (70, 12, 'Thin Loring', 11798);
insert into WORKER (worker_id, workhoures, name, salary)
values (80, 7, 'Freda Harrison', 4648);
insert into WORKER (worker_id, workhoures, name, salary)
values (90, 8, 'Jena Mazzello', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (100, 6, 'Jennifer Arthur', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (110, 11, 'Rufus Garr', 9609);
insert into WORKER (worker_id, workhoures, name, salary)
values (120, 11, 'Goran Kidman', 7072);
insert into WORKER (worker_id, workhoures, name, salary)
values (130, 6, 'Oded Weber', 9580);
insert into WORKER (worker_id, workhoures, name, salary)
values (140, 11, 'Harriet Capshaw', 19206);
insert into WORKER (worker_id, workhoures, name, salary)
values (150, 12, 'Mena Esposito', 12949);
insert into WORKER (worker_id, workhoures, name, salary)
values (160, 8, 'Simon Sandoval', 19473);
insert into WORKER (worker_id, workhoures, name, salary)
values (170, 5, 'Heath Hannah', 6156);
insert into WORKER (worker_id, workhoures, name, salary)
values (180, 8, 'Howie Coltrane', 10971);
insert into WORKER (worker_id, workhoures, name, salary)
values (190, 9, 'Frank Heatherly', 7245);
insert into WORKER (worker_id, workhoures, name, salary)
values (200, 6, 'Rod McDormand', 6566);
insert into WORKER (worker_id, workhoures, name, salary)
values (210, 4, 'Seann Romijn-St', 3500);
commit;
prompt 500 records committed...
insert into WORKER (worker_id, workhoures, name, salary)
values (220, 5, 'Kathy Brothers', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (230, 8, 'Willem Pierce', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (240, 10, 'Nancy Tennison', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (250, 7, 'Ramsey Waite', 18867);
insert into WORKER (worker_id, workhoures, name, salary)
values (260, 9, 'Nile Yorn', 15465);
insert into WORKER (worker_id, workhoures, name, salary)
values (270, 12, 'Wendy Vince', 4800);
insert into WORKER (worker_id, workhoures, name, salary)
values (280, 12, 'Kazem Easton', 4800);
insert into WORKER (worker_id, workhoures, name, salary)
values (290, 4, 'Rufus Dench', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (300, 6, 'Alessandro Ryde', 11868);
insert into WORKER (worker_id, workhoures, name, salary)
values (310, 9, 'Mira DeLuise', 12259);
insert into WORKER (worker_id, workhoures, name, salary)
values (320, 11, 'Parker Jonze', 11613);
insert into WORKER (worker_id, workhoures, name, salary)
values (330, 5, 'Rosario Dempsey', 8780);
insert into WORKER (worker_id, workhoures, name, salary)
values (340, 8, 'Frankie Whitake', 12310);
insert into WORKER (worker_id, workhoures, name, salary)
values (350, 9, 'Jim Savage', 18970);
insert into WORKER (worker_id, workhoures, name, salary)
values (360, 10, 'Colm Borden', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (370, 7, 'Juliette Jolie', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (380, 11, 'Gerald Darren', 7355);
insert into WORKER (worker_id, workhoures, name, salary)
values (390, 9, 'Mint Myles', 8860);
insert into WORKER (worker_id, workhoures, name, salary)
values (400, 10, 'Alessandro Gatl', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (410, 11, 'Kirsten Avital', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (420, 7, 'Marty Chinlund', 12458);
insert into WORKER (worker_id, workhoures, name, salary)
values (430, 12, 'Lindsay Conley', 4800);
insert into WORKER (worker_id, workhoures, name, salary)
values (440, 12, 'Mae Orlando', 4800);
insert into WORKER (worker_id, workhoures, name, salary)
values (450, 11, 'Jody Hawke', 14534);
insert into WORKER (worker_id, workhoures, name, salary)
values (460, 8, 'Jackson Winwood', 10964);
insert into WORKER (worker_id, workhoures, name, salary)
values (470, 5, 'Denis Almond', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (480, 9, 'Lari Keen', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (490, 7, 'Mary-Louise Wat', 6146);
insert into WORKER (worker_id, workhoures, name, salary)
values (500, 8, 'Manu Cronin', 9109);
insert into WORKER (worker_id, workhoures, name, salary)
values (510, 10, 'Joseph Mars', 6762);
insert into WORKER (worker_id, workhoures, name, salary)
values (520, 5, 'Kitty Reid', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (530, 4, 'Brothers Serbed', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (540, 7, 'Nigel Durning', 11021);
insert into WORKER (worker_id, workhoures, name, salary)
values (550, 9, 'Sean Rubinek', 8109);
insert into WORKER (worker_id, workhoures, name, salary)
values (560, 10, 'Gerald Spears', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (570, 10, 'Mekhi Jackson', 14189);
insert into WORKER (worker_id, workhoures, name, salary)
values (580, 8, 'Parker Forster', 9716);
insert into WORKER (worker_id, workhoures, name, salary)
values (590, 5, 'Lena Schwimmer', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (600, 12, 'Patty Carlyle', 4800);
insert into WORKER (worker_id, workhoures, name, salary)
values (610, 4, 'Lois Gill', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (620, 8, 'Corey Shalhoub', 10102);
insert into WORKER (worker_id, workhoures, name, salary)
values (630, 9, 'Geena Peterson', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (640, 9, 'Jesus McIntosh', 4500);
insert into WORKER (worker_id, workhoures, name, salary)
values (650, 4, 'Ryan Rodgers', 16615);
insert into WORKER (worker_id, workhoures, name, salary)
values (660, 5, 'Wendy Fiennes', 19979);
insert into WORKER (worker_id, workhoures, name, salary)
values (670, 11, 'Joey Bloch', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (680, 6, 'Anna Paquin', 15113);
insert into WORKER (worker_id, workhoures, name, salary)
values (690, 7, 'Ricky Heston', 10983);
insert into WORKER (worker_id, workhoures, name, salary)
values (700, 7, 'Graham Wood', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (710, 5, 'Nastassja Skars', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (720, 4, 'Timothy Spiner', 9146);
insert into WORKER (worker_id, workhoures, name, salary)
values (730, 5, 'Eliza Baldwin', 11344);
insert into WORKER (worker_id, workhoures, name, salary)
values (740, 9, 'Scott Lofgren', 11849);
insert into WORKER (worker_id, workhoures, name, salary)
values (750, 12, 'Carolyn Spader', 6430);
insert into WORKER (worker_id, workhoures, name, salary)
values (760, 5, 'Doug Griggs', 12250);
insert into WORKER (worker_id, workhoures, name, salary)
values (770, 9, 'Jeanne Durning', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (780, 7, 'Debby Palmer', 8270);
insert into WORKER (worker_id, workhoures, name, salary)
values (790, 4, 'Derrick Mirren', 19001);
insert into WORKER (worker_id, workhoures, name, salary)
values (800, 12, 'Seann Supernaw', 7158);
insert into WORKER (worker_id, workhoures, name, salary)
values (810, 12, 'Phil Colin Youn', 4800);
insert into WORKER (worker_id, workhoures, name, salary)
values (820, 9, 'Gwyneth Weiland', 19528);
insert into WORKER (worker_id, workhoures, name, salary)
values (830, 4, 'Patricia White', 5993);
insert into WORKER (worker_id, workhoures, name, salary)
values (840, 4, 'Daniel Danes', 12223);
insert into WORKER (worker_id, workhoures, name, salary)
values (850, 9, 'Todd Almond', 22190);
insert into WORKER (worker_id, workhoures, name, salary)
values (860, 9, 'Fats Harnes', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (870, 6, 'Lea Richards', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (880, 8, 'Garland Yankovi', 9345);
insert into WORKER (worker_id, workhoures, name, salary)
values (890, 7, 'Sara Turturro', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (900, 4, 'Anthony Busey', 11465);
insert into WORKER (worker_id, workhoures, name, salary)
values (910, 5, 'Penelope Margul', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (920, 5, 'Patty Gibbons', 14045);
insert into WORKER (worker_id, workhoures, name, salary)
values (930, 10, 'Karen Mars', 13893);
insert into WORKER (worker_id, workhoures, name, salary)
values (940, 10, 'Mary-Louise Col', 18945);
insert into WORKER (worker_id, workhoures, name, salary)
values (950, 6, 'Johnny Gayle', 13884);
insert into WORKER (worker_id, workhoures, name, salary)
values (960, 12, 'Javon McGill', 4800);
insert into WORKER (worker_id, workhoures, name, salary)
values (970, 4, 'Teena Stiller', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (980, 5, 'Ty Broza', 18365);
insert into WORKER (worker_id, workhoures, name, salary)
values (2170, 12, 'Jody Dzundza', 4800);
insert into WORKER (worker_id, workhoures, name, salary)
values (2180, 6, 'Benjamin Flanag', 14946);
insert into WORKER (worker_id, workhoures, name, salary)
values (2190, 11, 'Blair Bentley', 10407);
insert into WORKER (worker_id, workhoures, name, salary)
values (2200, 6, 'Elisabeth Ammon', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2210, 7, 'Cyndi Duncan', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2220, 10, 'Ron Ward', 21467);
insert into WORKER (worker_id, workhoures, name, salary)
values (2230, 8, 'Claire Ferrell', 12129);
insert into WORKER (worker_id, workhoures, name, salary)
values (2240, 5, 'Sigourney Galla', 13497);
insert into WORKER (worker_id, workhoures, name, salary)
values (2250, 10, 'Cathy Makowicz', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2260, 4, 'Lee Danger', 16578);
insert into WORKER (worker_id, workhoures, name, salary)
values (2270, 4, 'Stewart Rizzo', 10817);
insert into WORKER (worker_id, workhoures, name, salary)
values (2280, 8, 'Lupe Sellers', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2290, 5, 'Ronnie Numan', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2300, 8, 'Barry Bale', 4326);
insert into WORKER (worker_id, workhoures, name, salary)
values (2310, 5, 'Stevie Walsh', 14854);
insert into WORKER (worker_id, workhoures, name, salary)
values (2320, 10, 'Ceili Hiatt', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2330, 4, 'Oliver Osbourne', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2340, 9, 'Tommy Dunn', 15340);
insert into WORKER (worker_id, workhoures, name, salary)
values (2350, 4, 'Nigel Rifkin', 5260);
insert into WORKER (worker_id, workhoures, name, salary)
values (2360, 10, 'Jeanne Estevez', 4200);
insert into WORKER (worker_id, workhoures, name, salary)
values (2370, 6, 'Colleen Amos', 12413);
insert into WORKER (worker_id, workhoures, name, salary)
values (2380, 9, 'Jerry Gandolfin', 19715);
commit;
prompt 599 records loaded
prompt Loading WORKINGIN...
insert into WORKINGIN (worker_id, catering_id)
values (10, 2);
insert into WORKINGIN (worker_id, catering_id)
values (10, 432);
insert into WORKINGIN (worker_id, catering_id)
values (10, 469);
insert into WORKINGIN (worker_id, catering_id)
values (10, 755);
insert into WORKINGIN (worker_id, catering_id)
values (30, 226);
insert into WORKINGIN (worker_id, catering_id)
values (40, 86);
insert into WORKINGIN (worker_id, catering_id)
values (40, 482);
insert into WORKINGIN (worker_id, catering_id)
values (50, 754);
insert into WORKINGIN (worker_id, catering_id)
values (90, 49);
insert into WORKINGIN (worker_id, catering_id)
values (90, 121);
insert into WORKINGIN (worker_id, catering_id)
values (90, 368);
insert into WORKINGIN (worker_id, catering_id)
values (100, 377);
insert into WORKINGIN (worker_id, catering_id)
values (100, 526);
insert into WORKINGIN (worker_id, catering_id)
values (100, 656);
insert into WORKINGIN (worker_id, catering_id)
values (120, 97);
insert into WORKINGIN (worker_id, catering_id)
values (130, 354);
insert into WORKINGIN (worker_id, catering_id)
values (170, 598);
insert into WORKINGIN (worker_id, catering_id)
values (210, 519);
insert into WORKINGIN (worker_id, catering_id)
values (220, 72);
insert into WORKINGIN (worker_id, catering_id)
values (230, 33);
insert into WORKINGIN (worker_id, catering_id)
values (240, 208);
insert into WORKINGIN (worker_id, catering_id)
values (250, 46);
insert into WORKINGIN (worker_id, catering_id)
values (270, 785);
insert into WORKINGIN (worker_id, catering_id)
values (280, 469);
insert into WORKINGIN (worker_id, catering_id)
values (290, 191);
insert into WORKINGIN (worker_id, catering_id)
values (290, 245);
insert into WORKINGIN (worker_id, catering_id)
values (290, 527);
insert into WORKINGIN (worker_id, catering_id)
values (320, 291);
insert into WORKINGIN (worker_id, catering_id)
values (360, 619);
insert into WORKINGIN (worker_id, catering_id)
values (360, 631);
insert into WORKINGIN (worker_id, catering_id)
values (370, 46);
insert into WORKINGIN (worker_id, catering_id)
values (370, 656);
insert into WORKINGIN (worker_id, catering_id)
values (390, 200);
insert into WORKINGIN (worker_id, catering_id)
values (400, 111);
insert into WORKINGIN (worker_id, catering_id)
values (410, 344);
insert into WORKINGIN (worker_id, catering_id)
values (430, 743);
insert into WORKINGIN (worker_id, catering_id)
values (430, 787);
insert into WORKINGIN (worker_id, catering_id)
values (440, 135);
insert into WORKINGIN (worker_id, catering_id)
values (470, 55);
insert into WORKINGIN (worker_id, catering_id)
values (480, 149);
insert into WORKINGIN (worker_id, catering_id)
values (480, 743);
insert into WORKINGIN (worker_id, catering_id)
values (520, 140);
insert into WORKINGIN (worker_id, catering_id)
values (530, 451);
insert into WORKINGIN (worker_id, catering_id)
values (560, 198);
insert into WORKINGIN (worker_id, catering_id)
values (590, 144);
insert into WORKINGIN (worker_id, catering_id)
values (590, 247);
insert into WORKINGIN (worker_id, catering_id)
values (600, 258);
insert into WORKINGIN (worker_id, catering_id)
values (610, 377);
insert into WORKINGIN (worker_id, catering_id)
values (610, 394);
insert into WORKINGIN (worker_id, catering_id)
values (630, 2);
insert into WORKINGIN (worker_id, catering_id)
values (630, 316);
insert into WORKINGIN (worker_id, catering_id)
values (670, 230);
insert into WORKINGIN (worker_id, catering_id)
values (690, 263);
insert into WORKINGIN (worker_id, catering_id)
values (700, 534);
insert into WORKINGIN (worker_id, catering_id)
values (710, 54);
insert into WORKINGIN (worker_id, catering_id)
values (710, 431);
insert into WORKINGIN (worker_id, catering_id)
values (770, 467);
insert into WORKINGIN (worker_id, catering_id)
values (780, 282);
insert into WORKINGIN (worker_id, catering_id)
values (800, 547);
insert into WORKINGIN (worker_id, catering_id)
values (810, 519);
insert into WORKINGIN (worker_id, catering_id)
values (820, 550);
insert into WORKINGIN (worker_id, catering_id)
values (850, 450);
insert into WORKINGIN (worker_id, catering_id)
values (860, 47);
insert into WORKINGIN (worker_id, catering_id)
values (870, 157);
insert into WORKINGIN (worker_id, catering_id)
values (890, 240);
insert into WORKINGIN (worker_id, catering_id)
values (890, 281);
insert into WORKINGIN (worker_id, catering_id)
values (910, 175);
insert into WORKINGIN (worker_id, catering_id)
values (920, 46);
insert into WORKINGIN (worker_id, catering_id)
values (920, 103);
insert into WORKINGIN (worker_id, catering_id)
values (950, 426);
insert into WORKINGIN (worker_id, catering_id)
values (960, 213);
insert into WORKINGIN (worker_id, catering_id)
values (960, 594);
insert into WORKINGIN (worker_id, catering_id)
values (970, 243);
insert into WORKINGIN (worker_id, catering_id)
values (970, 571);
insert into WORKINGIN (worker_id, catering_id)
values (1010, 799);
insert into WORKINGIN (worker_id, catering_id)
values (1040, 282);
insert into WORKINGIN (worker_id, catering_id)
values (1050, 129);
insert into WORKINGIN (worker_id, catering_id)
values (1050, 671);
insert into WORKINGIN (worker_id, catering_id)
values (1060, 337);
insert into WORKINGIN (worker_id, catering_id)
values (1070, 545);
insert into WORKINGIN (worker_id, catering_id)
values (1090, 30);
insert into WORKINGIN (worker_id, catering_id)
values (1090, 423);
insert into WORKINGIN (worker_id, catering_id)
values (1100, 534);
insert into WORKINGIN (worker_id, catering_id)
values (1100, 679);
insert into WORKINGIN (worker_id, catering_id)
values (1110, 538);
insert into WORKINGIN (worker_id, catering_id)
values (1120, 451);
insert into WORKINGIN (worker_id, catering_id)
values (1120, 769);
insert into WORKINGIN (worker_id, catering_id)
values (1130, 631);
insert into WORKINGIN (worker_id, catering_id)
values (1180, 264);
insert into WORKINGIN (worker_id, catering_id)
values (1220, 379);
insert into WORKINGIN (worker_id, catering_id)
values (1240, 65);
insert into WORKINGIN (worker_id, catering_id)
values (1260, 343);
insert into WORKINGIN (worker_id, catering_id)
values (1260, 559);
insert into WORKINGIN (worker_id, catering_id)
values (1280, 179);
insert into WORKINGIN (worker_id, catering_id)
values (1310, 161);
insert into WORKINGIN (worker_id, catering_id)
values (1320, 334);
insert into WORKINGIN (worker_id, catering_id)
values (1330, 194);
insert into WORKINGIN (worker_id, catering_id)
values (1330, 214);
insert into WORKINGIN (worker_id, catering_id)
values (1340, 329);
insert into WORKINGIN (worker_id, catering_id)
values (1350, 530);
commit;
prompt 100 records committed...
insert into WORKINGIN (worker_id, catering_id)
values (1350, 723);
insert into WORKINGIN (worker_id, catering_id)
values (1360, 239);
insert into WORKINGIN (worker_id, catering_id)
values (1370, 23);
insert into WORKINGIN (worker_id, catering_id)
values (1400, 441);
insert into WORKINGIN (worker_id, catering_id)
values (1460, 324);
insert into WORKINGIN (worker_id, catering_id)
values (1480, 140);
insert into WORKINGIN (worker_id, catering_id)
values (1480, 723);
insert into WORKINGIN (worker_id, catering_id)
values (1490, 323);
insert into WORKINGIN (worker_id, catering_id)
values (1500, 473);
insert into WORKINGIN (worker_id, catering_id)
values (1500, 591);
insert into WORKINGIN (worker_id, catering_id)
values (1520, 290);
insert into WORKINGIN (worker_id, catering_id)
values (1530, 49);
insert into WORKINGIN (worker_id, catering_id)
values (1530, 555);
insert into WORKINGIN (worker_id, catering_id)
values (1550, 151);
insert into WORKINGIN (worker_id, catering_id)
values (1560, 300);
insert into WORKINGIN (worker_id, catering_id)
values (1560, 572);
insert into WORKINGIN (worker_id, catering_id)
values (1570, 99);
insert into WORKINGIN (worker_id, catering_id)
values (1570, 590);
insert into WORKINGIN (worker_id, catering_id)
values (1590, 638);
insert into WORKINGIN (worker_id, catering_id)
values (1600, 347);
insert into WORKINGIN (worker_id, catering_id)
values (1610, 699);
insert into WORKINGIN (worker_id, catering_id)
values (1620, 76);
insert into WORKINGIN (worker_id, catering_id)
values (1620, 206);
insert into WORKINGIN (worker_id, catering_id)
values (1620, 599);
insert into WORKINGIN (worker_id, catering_id)
values (1640, 70);
insert into WORKINGIN (worker_id, catering_id)
values (1660, 619);
insert into WORKINGIN (worker_id, catering_id)
values (1710, 647);
insert into WORKINGIN (worker_id, catering_id)
values (1720, 699);
insert into WORKINGIN (worker_id, catering_id)
values (1740, 19);
insert into WORKINGIN (worker_id, catering_id)
values (1740, 193);
insert into WORKINGIN (worker_id, catering_id)
values (1750, 522);
insert into WORKINGIN (worker_id, catering_id)
values (1780, 160);
insert into WORKINGIN (worker_id, catering_id)
values (1790, 90);
insert into WORKINGIN (worker_id, catering_id)
values (1790, 547);
insert into WORKINGIN (worker_id, catering_id)
values (1800, 756);
insert into WORKINGIN (worker_id, catering_id)
values (1810, 267);
insert into WORKINGIN (worker_id, catering_id)
values (1820, 193);
insert into WORKINGIN (worker_id, catering_id)
values (1830, 54);
insert into WORKINGIN (worker_id, catering_id)
values (1830, 68);
insert into WORKINGIN (worker_id, catering_id)
values (1830, 198);
insert into WORKINGIN (worker_id, catering_id)
values (1860, 332);
insert into WORKINGIN (worker_id, catering_id)
values (1860, 542);
insert into WORKINGIN (worker_id, catering_id)
values (1870, 40);
insert into WORKINGIN (worker_id, catering_id)
values (1870, 367);
insert into WORKINGIN (worker_id, catering_id)
values (1880, 161);
insert into WORKINGIN (worker_id, catering_id)
values (1880, 566);
insert into WORKINGIN (worker_id, catering_id)
values (1930, 2);
insert into WORKINGIN (worker_id, catering_id)
values (1950, 458);
insert into WORKINGIN (worker_id, catering_id)
values (1950, 733);
insert into WORKINGIN (worker_id, catering_id)
values (1950, 741);
insert into WORKINGIN (worker_id, catering_id)
values (1980, 624);
insert into WORKINGIN (worker_id, catering_id)
values (2040, 379);
insert into WORKINGIN (worker_id, catering_id)
values (2050, 213);
insert into WORKINGIN (worker_id, catering_id)
values (2050, 229);
insert into WORKINGIN (worker_id, catering_id)
values (2070, 9);
insert into WORKINGIN (worker_id, catering_id)
values (2070, 400);
insert into WORKINGIN (worker_id, catering_id)
values (2070, 677);
insert into WORKINGIN (worker_id, catering_id)
values (2080, 16);
insert into WORKINGIN (worker_id, catering_id)
values (2080, 463);
insert into WORKINGIN (worker_id, catering_id)
values (2090, 679);
insert into WORKINGIN (worker_id, catering_id)
values (2100, 224);
insert into WORKINGIN (worker_id, catering_id)
values (2100, 490);
insert into WORKINGIN (worker_id, catering_id)
values (2140, 401);
insert into WORKINGIN (worker_id, catering_id)
values (2170, 647);
insert into WORKINGIN (worker_id, catering_id)
values (2170, 791);
insert into WORKINGIN (worker_id, catering_id)
values (2200, 305);
insert into WORKINGIN (worker_id, catering_id)
values (2210, 4);
insert into WORKINGIN (worker_id, catering_id)
values (2210, 82);
insert into WORKINGIN (worker_id, catering_id)
values (2210, 538);
insert into WORKINGIN (worker_id, catering_id)
values (2210, 619);
insert into WORKINGIN (worker_id, catering_id)
values (2220, 788);
insert into WORKINGIN (worker_id, catering_id)
values (2240, 538);
insert into WORKINGIN (worker_id, catering_id)
values (2250, 402);
insert into WORKINGIN (worker_id, catering_id)
values (2280, 432);
insert into WORKINGIN (worker_id, catering_id)
values (2290, 99);
insert into WORKINGIN (worker_id, catering_id)
values (2290, 255);
insert into WORKINGIN (worker_id, catering_id)
values (2320, 251);
insert into WORKINGIN (worker_id, catering_id)
values (2330, 690);
insert into WORKINGIN (worker_id, catering_id)
values (2340, 46);
insert into WORKINGIN (worker_id, catering_id)
values (2360, 579);
insert into WORKINGIN (worker_id, catering_id)
values (2400, 561);
insert into WORKINGIN (worker_id, catering_id)
values (2430, 790);
insert into WORKINGIN (worker_id, catering_id)
values (2440, 547);
insert into WORKINGIN (worker_id, catering_id)
values (2450, 751);
insert into WORKINGIN (worker_id, catering_id)
values (2460, 325);
insert into WORKINGIN (worker_id, catering_id)
values (2490, 4);
insert into WORKINGIN (worker_id, catering_id)
values (2490, 665);
insert into WORKINGIN (worker_id, catering_id)
values (2500, 160);
insert into WORKINGIN (worker_id, catering_id)
values (2510, 336);
insert into WORKINGIN (worker_id, catering_id)
values (2540, 599);
insert into WORKINGIN (worker_id, catering_id)
values (2580, 771);
insert into WORKINGIN (worker_id, catering_id)
values (2600, 111);
insert into WORKINGIN (worker_id, catering_id)
values (2600, 565);
insert into WORKINGIN (worker_id, catering_id)
values (2610, 645);
insert into WORKINGIN (worker_id, catering_id)
values (2620, 30);
insert into WORKINGIN (worker_id, catering_id)
values (2640, 404);
insert into WORKINGIN (worker_id, catering_id)
values (2650, 351);
insert into WORKINGIN (worker_id, catering_id)
values (2660, 560);
insert into WORKINGIN (worker_id, catering_id)
values (2660, 762);
insert into WORKINGIN (worker_id, catering_id)
values (2690, 30);
commit;
prompt 200 records committed...
insert into WORKINGIN (worker_id, catering_id)
values (2700, 408);
insert into WORKINGIN (worker_id, catering_id)
values (2700, 520);
insert into WORKINGIN (worker_id, catering_id)
values (2710, 397);
insert into WORKINGIN (worker_id, catering_id)
values (2710, 430);
insert into WORKINGIN (worker_id, catering_id)
values (2730, 23);
insert into WORKINGIN (worker_id, catering_id)
values (2730, 322);
insert into WORKINGIN (worker_id, catering_id)
values (2740, 65);
insert into WORKINGIN (worker_id, catering_id)
values (2770, 243);
insert into WORKINGIN (worker_id, catering_id)
values (2780, 267);
insert into WORKINGIN (worker_id, catering_id)
values (2820, 164);
insert into WORKINGIN (worker_id, catering_id)
values (2820, 355);
insert into WORKINGIN (worker_id, catering_id)
values (2820, 548);
insert into WORKINGIN (worker_id, catering_id)
values (2830, 312);
insert into WORKINGIN (worker_id, catering_id)
values (2850, 549);
insert into WORKINGIN (worker_id, catering_id)
values (2860, 227);
insert into WORKINGIN (worker_id, catering_id)
values (2860, 445);
insert into WORKINGIN (worker_id, catering_id)
values (2860, 647);
insert into WORKINGIN (worker_id, catering_id)
values (2860, 786);
insert into WORKINGIN (worker_id, catering_id)
values (2880, 588);
insert into WORKINGIN (worker_id, catering_id)
values (2890, 751);
insert into WORKINGIN (worker_id, catering_id)
values (2900, 549);
insert into WORKINGIN (worker_id, catering_id)
values (2930, 229);
insert into WORKINGIN (worker_id, catering_id)
values (2930, 464);
insert into WORKINGIN (worker_id, catering_id)
values (2940, 65);
insert into WORKINGIN (worker_id, catering_id)
values (2940, 559);
insert into WORKINGIN (worker_id, catering_id)
values (2950, 770);
insert into WORKINGIN (worker_id, catering_id)
values (2960, 300);
insert into WORKINGIN (worker_id, catering_id)
values (2980, 63);
insert into WORKINGIN (worker_id, catering_id)
values (2980, 135);
insert into WORKINGIN (worker_id, catering_id)
values (2980, 503);
insert into WORKINGIN (worker_id, catering_id)
values (2990, 211);
insert into WORKINGIN (worker_id, catering_id)
values (2990, 379);
insert into WORKINGIN (worker_id, catering_id)
values (3000, 19);
insert into WORKINGIN (worker_id, catering_id)
values (3000, 229);
insert into WORKINGIN (worker_id, catering_id)
values (3020, 574);
insert into WORKINGIN (worker_id, catering_id)
values (3040, 213);
insert into WORKINGIN (worker_id, catering_id)
values (3050, 754);
insert into WORKINGIN (worker_id, catering_id)
values (3070, 215);
insert into WORKINGIN (worker_id, catering_id)
values (3080, 723);
insert into WORKINGIN (worker_id, catering_id)
values (3090, 758);
insert into WORKINGIN (worker_id, catering_id)
values (3090, 761);
insert into WORKINGIN (worker_id, catering_id)
values (3100, 638);
insert into WORKINGIN (worker_id, catering_id)
values (3110, 99);
insert into WORKINGIN (worker_id, catering_id)
values (3120, 111);
insert into WORKINGIN (worker_id, catering_id)
values (3170, 784);
insert into WORKINGIN (worker_id, catering_id)
values (3190, 758);
insert into WORKINGIN (worker_id, catering_id)
values (3200, 106);
insert into WORKINGIN (worker_id, catering_id)
values (3210, 415);
insert into WORKINGIN (worker_id, catering_id)
values (3220, 33);
insert into WORKINGIN (worker_id, catering_id)
values (3220, 200);
insert into WORKINGIN (worker_id, catering_id)
values (3230, 790);
insert into WORKINGIN (worker_id, catering_id)
values (3240, 367);
insert into WORKINGIN (worker_id, catering_id)
values (3240, 679);
insert into WORKINGIN (worker_id, catering_id)
values (3250, 731);
insert into WORKINGIN (worker_id, catering_id)
values (3250, 744);
insert into WORKINGIN (worker_id, catering_id)
values (3270, 58);
insert into WORKINGIN (worker_id, catering_id)
values (3290, 305);
insert into WORKINGIN (worker_id, catering_id)
values (3290, 679);
insert into WORKINGIN (worker_id, catering_id)
values (3300, 382);
insert into WORKINGIN (worker_id, catering_id)
values (3310, 55);
insert into WORKINGIN (worker_id, catering_id)
values (3310, 468);
insert into WORKINGIN (worker_id, catering_id)
values (3330, 249);
insert into WORKINGIN (worker_id, catering_id)
values (3340, 197);
insert into WORKINGIN (worker_id, catering_id)
values (3340, 297);
insert into WORKINGIN (worker_id, catering_id)
values (3370, 247);
insert into WORKINGIN (worker_id, catering_id)
values (3370, 300);
insert into WORKINGIN (worker_id, catering_id)
values (3420, 271);
insert into WORKINGIN (worker_id, catering_id)
values (3430, 94);
insert into WORKINGIN (worker_id, catering_id)
values (3440, 129);
insert into WORKINGIN (worker_id, catering_id)
values (3450, 367);
insert into WORKINGIN (worker_id, catering_id)
values (3470, 669);
insert into WORKINGIN (worker_id, catering_id)
values (3480, 75);
insert into WORKINGIN (worker_id, catering_id)
values (3480, 336);
insert into WORKINGIN (worker_id, catering_id)
values (3490, 690);
insert into WORKINGIN (worker_id, catering_id)
values (3510, 155);
insert into WORKINGIN (worker_id, catering_id)
values (3510, 226);
insert into WORKINGIN (worker_id, catering_id)
values (3510, 426);
insert into WORKINGIN (worker_id, catering_id)
values (3530, 284);
insert into WORKINGIN (worker_id, catering_id)
values (3530, 695);
insert into WORKINGIN (worker_id, catering_id)
values (3540, 68);
insert into WORKINGIN (worker_id, catering_id)
values (3540, 619);
insert into WORKINGIN (worker_id, catering_id)
values (3550, 469);
insert into WORKINGIN (worker_id, catering_id)
values (3560, 46);
insert into WORKINGIN (worker_id, catering_id)
values (3580, 332);
insert into WORKINGIN (worker_id, catering_id)
values (3600, 194);
insert into WORKINGIN (worker_id, catering_id)
values (3600, 227);
insert into WORKINGIN (worker_id, catering_id)
values (3600, 694);
insert into WORKINGIN (worker_id, catering_id)
values (3600, 756);
insert into WORKINGIN (worker_id, catering_id)
values (3610, 362);
insert into WORKINGIN (worker_id, catering_id)
values (3620, 312);
insert into WORKINGIN (worker_id, catering_id)
values (3630, 78);
insert into WORKINGIN (worker_id, catering_id)
values (3630, 390);
insert into WORKINGIN (worker_id, catering_id)
values (3630, 511);
insert into WORKINGIN (worker_id, catering_id)
values (3650, 226);
insert into WORKINGIN (worker_id, catering_id)
values (3650, 733);
insert into WORKINGIN (worker_id, catering_id)
values (3660, 480);
insert into WORKINGIN (worker_id, catering_id)
values (3660, 756);
insert into WORKINGIN (worker_id, catering_id)
values (3680, 282);
insert into WORKINGIN (worker_id, catering_id)
values (3690, 16);
insert into WORKINGIN (worker_id, catering_id)
values (3700, 118);
commit;
prompt 300 records committed...
insert into WORKINGIN (worker_id, catering_id)
values (3700, 128);
insert into WORKINGIN (worker_id, catering_id)
values (3710, 198);
insert into WORKINGIN (worker_id, catering_id)
values (3710, 706);
insert into WORKINGIN (worker_id, catering_id)
values (3730, 8);
insert into WORKINGIN (worker_id, catering_id)
values (3750, 751);
insert into WORKINGIN (worker_id, catering_id)
values (3780, 193);
insert into WORKINGIN (worker_id, catering_id)
values (3780, 770);
insert into WORKINGIN (worker_id, catering_id)
values (3790, 400);
insert into WORKINGIN (worker_id, catering_id)
values (3800, 300);
insert into WORKINGIN (worker_id, catering_id)
values (3810, 675);
insert into WORKINGIN (worker_id, catering_id)
values (3830, 392);
insert into WORKINGIN (worker_id, catering_id)
values (3900, 212);
insert into WORKINGIN (worker_id, catering_id)
values (3920, 677);
insert into WORKINGIN (worker_id, catering_id)
values (3930, 21);
insert into WORKINGIN (worker_id, catering_id)
values (3960, 631);
insert into WORKINGIN (worker_id, catering_id)
values (3970, 790);
insert into WORKINGIN (worker_id, catering_id)
values (3990, 656);
insert into WORKINGIN (worker_id, catering_id)
values (4000, 536);
insert into WORKINGIN (worker_id, catering_id)
values (4010, 104);
insert into WORKINGIN (worker_id, catering_id)
values (4020, 570);
insert into WORKINGIN (worker_id, catering_id)
values (4030, 202);
insert into WORKINGIN (worker_id, catering_id)
values (4030, 639);
insert into WORKINGIN (worker_id, catering_id)
values (4040, 754);
insert into WORKINGIN (worker_id, catering_id)
values (4050, 548);
insert into WORKINGIN (worker_id, catering_id)
values (4070, 624);
insert into WORKINGIN (worker_id, catering_id)
values (4080, 202);
insert into WORKINGIN (worker_id, catering_id)
values (4080, 502);
insert into WORKINGIN (worker_id, catering_id)
values (4090, 711);
insert into WORKINGIN (worker_id, catering_id)
values (4090, 747);
insert into WORKINGIN (worker_id, catering_id)
values (4100, 129);
insert into WORKINGIN (worker_id, catering_id)
values (4110, 368);
insert into WORKINGIN (worker_id, catering_id)
values (4110, 533);
insert into WORKINGIN (worker_id, catering_id)
values (4160, 19);
insert into WORKINGIN (worker_id, catering_id)
values (4160, 39);
insert into WORKINGIN (worker_id, catering_id)
values (4160, 574);
insert into WORKINGIN (worker_id, catering_id)
values (4190, 714);
insert into WORKINGIN (worker_id, catering_id)
values (4210, 224);
insert into WORKINGIN (worker_id, catering_id)
values (4210, 793);
insert into WORKINGIN (worker_id, catering_id)
values (4220, 324);
insert into WORKINGIN (worker_id, catering_id)
values (4220, 781);
insert into WORKINGIN (worker_id, catering_id)
values (4230, 121);
insert into WORKINGIN (worker_id, catering_id)
values (4230, 431);
insert into WORKINGIN (worker_id, catering_id)
values (4240, 78);
insert into WORKINGIN (worker_id, catering_id)
values (4240, 194);
insert into WORKINGIN (worker_id, catering_id)
values (4240, 473);
insert into WORKINGIN (worker_id, catering_id)
values (4250, 588);
insert into WORKINGIN (worker_id, catering_id)
values (4250, 791);
insert into WORKINGIN (worker_id, catering_id)
values (4260, 473);
insert into WORKINGIN (worker_id, catering_id)
values (4260, 744);
insert into WORKINGIN (worker_id, catering_id)
values (4270, 528);
insert into WORKINGIN (worker_id, catering_id)
values (4280, 184);
insert into WORKINGIN (worker_id, catering_id)
values (4280, 625);
insert into WORKINGIN (worker_id, catering_id)
values (4300, 570);
insert into WORKINGIN (worker_id, catering_id)
values (4310, 464);
insert into WORKINGIN (worker_id, catering_id)
values (4350, 186);
insert into WORKINGIN (worker_id, catering_id)
values (4360, 99);
insert into WORKINGIN (worker_id, catering_id)
values (4360, 690);
insert into WORKINGIN (worker_id, catering_id)
values (4370, 784);
insert into WORKINGIN (worker_id, catering_id)
values (4400, 93);
insert into WORKINGIN (worker_id, catering_id)
values (4400, 267);
insert into WORKINGIN (worker_id, catering_id)
values (4400, 647);
insert into WORKINGIN (worker_id, catering_id)
values (4410, 184);
insert into WORKINGIN (worker_id, catering_id)
values (4410, 469);
insert into WORKINGIN (worker_id, catering_id)
values (4420, 547);
insert into WORKINGIN (worker_id, catering_id)
values (4430, 206);
insert into WORKINGIN (worker_id, catering_id)
values (4430, 652);
insert into WORKINGIN (worker_id, catering_id)
values (4430, 786);
insert into WORKINGIN (worker_id, catering_id)
values (4440, 97);
insert into WORKINGIN (worker_id, catering_id)
values (4440, 490);
insert into WORKINGIN (worker_id, catering_id)
values (4450, 23);
insert into WORKINGIN (worker_id, catering_id)
values (4450, 73);
insert into WORKINGIN (worker_id, catering_id)
values (4460, 2);
insert into WORKINGIN (worker_id, catering_id)
values (4460, 349);
insert into WORKINGIN (worker_id, catering_id)
values (4470, 250);
insert into WORKINGIN (worker_id, catering_id)
values (4470, 434);
insert into WORKINGIN (worker_id, catering_id)
values (4470, 591);
insert into WORKINGIN (worker_id, catering_id)
values (4480, 451);
insert into WORKINGIN (worker_id, catering_id)
values (4480, 457);
insert into WORKINGIN (worker_id, catering_id)
values (4480, 548);
insert into WORKINGIN (worker_id, catering_id)
values (4530, 329);
insert into WORKINGIN (worker_id, catering_id)
values (4560, 9);
insert into WORKINGIN (worker_id, catering_id)
values (4580, 4);
insert into WORKINGIN (worker_id, catering_id)
values (4580, 794);
insert into WORKINGIN (worker_id, catering_id)
values (4590, 60);
insert into WORKINGIN (worker_id, catering_id)
values (4590, 762);
insert into WORKINGIN (worker_id, catering_id)
values (4600, 178);
insert into WORKINGIN (worker_id, catering_id)
values (4600, 680);
insert into WORKINGIN (worker_id, catering_id)
values (4610, 334);
insert into WORKINGIN (worker_id, catering_id)
values (4670, 459);
insert into WORKINGIN (worker_id, catering_id)
values (4670, 477);
insert into WORKINGIN (worker_id, catering_id)
values (4690, 151);
insert into WORKINGIN (worker_id, catering_id)
values (4690, 190);
insert into WORKINGIN (worker_id, catering_id)
values (4700, 382);
insert into WORKINGIN (worker_id, catering_id)
values (4710, 533);
insert into WORKINGIN (worker_id, catering_id)
values (4710, 790);
insert into WORKINGIN (worker_id, catering_id)
values (4720, 500);
insert into WORKINGIN (worker_id, catering_id)
values (4740, 39);
insert into WORKINGIN (worker_id, catering_id)
values (4740, 367);
insert into WORKINGIN (worker_id, catering_id)
values (4740, 675);
insert into WORKINGIN (worker_id, catering_id)
values (4760, 463);
commit;
prompt 400 records committed...
insert into WORKINGIN (worker_id, catering_id)
values (4780, 190);
insert into WORKINGIN (worker_id, catering_id)
values (4780, 624);
insert into WORKINGIN (worker_id, catering_id)
values (4780, 669);
insert into WORKINGIN (worker_id, catering_id)
values (4790, 127);
insert into WORKINGIN (worker_id, catering_id)
values (4790, 530);
insert into WORKINGIN (worker_id, catering_id)
values (4810, 599);
insert into WORKINGIN (worker_id, catering_id)
values (4820, 490);
insert into WORKINGIN (worker_id, catering_id)
values (4820, 788);
insert into WORKINGIN (worker_id, catering_id)
values (4840, 40);
insert into WORKINGIN (worker_id, catering_id)
values (4840, 344);
insert into WORKINGIN (worker_id, catering_id)
values (4850, 572);
insert into WORKINGIN (worker_id, catering_id)
values (4870, 161);
insert into WORKINGIN (worker_id, catering_id)
values (4880, 265);
insert into WORKINGIN (worker_id, catering_id)
values (4890, 413);
insert into WORKINGIN (worker_id, catering_id)
values (4890, 467);
insert into WORKINGIN (worker_id, catering_id)
values (4910, 647);
insert into WORKINGIN (worker_id, catering_id)
values (4910, 695);
insert into WORKINGIN (worker_id, catering_id)
values (4920, 218);
insert into WORKINGIN (worker_id, catering_id)
values (4920, 451);
insert into WORKINGIN (worker_id, catering_id)
values (4960, 519);
insert into WORKINGIN (worker_id, catering_id)
values (4970, 432);
insert into WORKINGIN (worker_id, catering_id)
values (4990, 63);
insert into WORKINGIN (worker_id, catering_id)
values (4990, 347);
insert into WORKINGIN (worker_id, catering_id)
values (5010, 93);
insert into WORKINGIN (worker_id, catering_id)
values (5010, 362);
insert into WORKINGIN (worker_id, catering_id)
values (5010, 402);
insert into WORKINGIN (worker_id, catering_id)
values (5020, 54);
insert into WORKINGIN (worker_id, catering_id)
values (5030, 218);
insert into WORKINGIN (worker_id, catering_id)
values (5040, 165);
insert into WORKINGIN (worker_id, catering_id)
values (5100, 180);
insert into WORKINGIN (worker_id, catering_id)
values (5100, 390);
insert into WORKINGIN (worker_id, catering_id)
values (5110, 76);
insert into WORKINGIN (worker_id, catering_id)
values (5110, 465);
insert into WORKINGIN (worker_id, catering_id)
values (5110, 718);
insert into WORKINGIN (worker_id, catering_id)
values (5120, 372);
insert into WORKINGIN (worker_id, catering_id)
values (5130, 678);
insert into WORKINGIN (worker_id, catering_id)
values (5140, 80);
insert into WORKINGIN (worker_id, catering_id)
values (5140, 247);
insert into WORKINGIN (worker_id, catering_id)
values (5140, 264);
insert into WORKINGIN (worker_id, catering_id)
values (5140, 445);
insert into WORKINGIN (worker_id, catering_id)
values (5160, 631);
insert into WORKINGIN (worker_id, catering_id)
values (5170, 723);
insert into WORKINGIN (worker_id, catering_id)
values (5180, 145);
insert into WORKINGIN (worker_id, catering_id)
values (5180, 669);
insert into WORKINGIN (worker_id, catering_id)
values (5190, 723);
insert into WORKINGIN (worker_id, catering_id)
values (5200, 753);
insert into WORKINGIN (worker_id, catering_id)
values (5220, 149);
insert into WORKINGIN (worker_id, catering_id)
values (5220, 239);
insert into WORKINGIN (worker_id, catering_id)
values (5220, 709);
insert into WORKINGIN (worker_id, catering_id)
values (5260, 230);
insert into WORKINGIN (worker_id, catering_id)
values (5260, 390);
insert into WORKINGIN (worker_id, catering_id)
values (5290, 522);
insert into WORKINGIN (worker_id, catering_id)
values (5310, 8);
insert into WORKINGIN (worker_id, catering_id)
values (5310, 502);
insert into WORKINGIN (worker_id, catering_id)
values (5340, 629);
insert into WORKINGIN (worker_id, catering_id)
values (5350, 706);
insert into WORKINGIN (worker_id, catering_id)
values (5360, 18);
insert into WORKINGIN (worker_id, catering_id)
values (5370, 99);
insert into WORKINGIN (worker_id, catering_id)
values (5370, 118);
insert into WORKINGIN (worker_id, catering_id)
values (5370, 153);
insert into WORKINGIN (worker_id, catering_id)
values (5390, 718);
insert into WORKINGIN (worker_id, catering_id)
values (5430, 277);
insert into WORKINGIN (worker_id, catering_id)
values (5450, 135);
insert into WORKINGIN (worker_id, catering_id)
values (5450, 795);
insert into WORKINGIN (worker_id, catering_id)
values (5460, 141);
insert into WORKINGIN (worker_id, catering_id)
values (5470, 99);
insert into WORKINGIN (worker_id, catering_id)
values (5480, 754);
insert into WORKINGIN (worker_id, catering_id)
values (5510, 500);
insert into WORKINGIN (worker_id, catering_id)
values (5550, 297);
insert into WORKINGIN (worker_id, catering_id)
values (5560, 520);
insert into WORKINGIN (worker_id, catering_id)
values (5560, 678);
insert into WORKINGIN (worker_id, catering_id)
values (5600, 224);
insert into WORKINGIN (worker_id, catering_id)
values (5610, 367);
insert into WORKINGIN (worker_id, catering_id)
values (5650, 280);
insert into WORKINGIN (worker_id, catering_id)
values (5650, 542);
insert into WORKINGIN (worker_id, catering_id)
values (5690, 313);
insert into WORKINGIN (worker_id, catering_id)
values (5700, 718);
insert into WORKINGIN (worker_id, catering_id)
values (5720, 323);
insert into WORKINGIN (worker_id, catering_id)
values (5740, 547);
insert into WORKINGIN (worker_id, catering_id)
values (5750, 343);
insert into WORKINGIN (worker_id, catering_id)
values (5800, 526);
insert into WORKINGIN (worker_id, catering_id)
values (5810, 404);
insert into WORKINGIN (worker_id, catering_id)
values (5820, 561);
insert into WORKINGIN (worker_id, catering_id)
values (5820, 656);
insert into WORKINGIN (worker_id, catering_id)
values (5830, 336);
insert into WORKINGIN (worker_id, catering_id)
values (5830, 480);
insert into WORKINGIN (worker_id, catering_id)
values (5840, 291);
insert into WORKINGIN (worker_id, catering_id)
values (5850, 549);
insert into WORKINGIN (worker_id, catering_id)
values (5860, 218);
insert into WORKINGIN (worker_id, catering_id)
values (5880, 419);
insert into WORKINGIN (worker_id, catering_id)
values (5890, 321);
insert into WORKINGIN (worker_id, catering_id)
values (5890, 536);
insert into WORKINGIN (worker_id, catering_id)
values (5900, 309);
insert into WORKINGIN (worker_id, catering_id)
values (5920, 83);
insert into WORKINGIN (worker_id, catering_id)
values (5920, 707);
insert into WORKINGIN (worker_id, catering_id)
values (5930, 681);
insert into WORKINGIN (worker_id, catering_id)
values (5980, 160);
insert into WORKINGIN (worker_id, catering_id)
values (5980, 669);
insert into WORKINGIN (worker_id, catering_id)
values (5990, 180);
commit;
prompt 499 records loaded
prompt Enabling foreign key constraints for KINDERGARTEN...
alter table KINDERGARTEN enable constraint FK_KINDERGARTEN_CUSTOMER;
alter table KINDERGARTEN enable constraint SYS_C007684;
alter table KINDERGARTEN enable constraint SYS_C007685;
prompt Enabling foreign key constraints for ACTIVITYSCHEDULE...
alter table ACTIVITYSCHEDULE enable constraint SYS_C007690;
alter table ACTIVITYSCHEDULE enable constraint SYS_C007691;
prompt Enabling foreign key constraints for DISHS...
alter table DISHS enable constraint SYS_C007473;
prompt Enabling foreign key constraints for AFFECTS...
alter table AFFECTS enable constraint SYS_C007724;
alter table AFFECTS enable constraint SYS_C007725;
prompt Enabling foreign key constraints for THE_ORDER...
alter table THE_ORDER enable constraint SYS_C007489;
prompt Enabling foreign key constraints for BELONG...
alter table BELONG enable constraint SYS_C007494;
alter table BELONG enable constraint SYS_C007495;
prompt Enabling foreign key constraints for REGISTRATION...
alter table REGISTRATION enable constraint FK_REGISTRATION_KINDERGARTEN;
alter table REGISTRATION enable constraint SYS_C007696;
prompt Enabling foreign key constraints for CHILD...
alter table CHILD enable constraint FK_CHILD_REGISTRATION;
prompt Enabling foreign key constraints for CONTAIN...
alter table CONTAIN enable constraint SYS_C007505;
alter table CONTAIN enable constraint SYS_C007506;
prompt Enabling foreign key constraints for MENU...
alter table MENU enable constraint SYS_C007715;
prompt Enabling foreign key constraints for INCLUDES...
alter table INCLUDES enable constraint SYS_C007721;
alter table INCLUDES enable constraint SYS_C007722;
prompt Enabling foreign key constraints for ISHAVING...
alter table ISHAVING enable constraint SYS_C007718;
alter table ISHAVING enable constraint SYS_C007719;
prompt Enabling foreign key constraints for TEACHER...
alter table TEACHER enable constraint SYS_C007705;
prompt Enabling foreign key constraints for WORKINGIN...
alter table WORKINGIN enable constraint SYS_C007515;
alter table WORKINGIN enable constraint SYS_C007516;
prompt Enabling triggers for ACTIVITY...
alter table ACTIVITY enable all triggers;
prompt Enabling triggers for K_TYPE...
alter table K_TYPE enable all triggers;
prompt Enabling triggers for BUILDINGS...
alter table BUILDINGS enable all triggers;
prompt Enabling triggers for CUSTOMER...
alter table CUSTOMER enable all triggers;
prompt Enabling triggers for KINDERGARTEN...
alter table KINDERGARTEN enable all triggers;
prompt Enabling triggers for ACTIVITYSCHEDULE...
alter table ACTIVITYSCHEDULE enable all triggers;
prompt Enabling triggers for DIETARYRESTRICTIONS...
alter table DIETARYRESTRICTIONS enable all triggers;
prompt Enabling triggers for CATERING...
alter table CATERING enable all triggers;
prompt Enabling triggers for DISHS...
alter table DISHS enable all triggers;
prompt Enabling triggers for AFFECTS...
alter table AFFECTS enable all triggers;
prompt Enabling triggers for THE_ORDER...
alter table THE_ORDER enable all triggers;
prompt Enabling triggers for BELONG...
alter table BELONG enable all triggers;
prompt Enabling triggers for REGISTRATION...
alter table REGISTRATION enable all triggers;
prompt Enabling triggers for CHILD...
alter table CHILD enable all triggers;
prompt Enabling triggers for MATERIAL...
alter table MATERIAL enable all triggers;
prompt Enabling triggers for CONTAIN...
alter table CONTAIN enable all triggers;
prompt Enabling triggers for MENU...
alter table MENU enable all triggers;
prompt Enabling triggers for INCLUDES...
alter table INCLUDES enable all triggers;
prompt Enabling triggers for ISHAVING...
alter table ISHAVING enable all triggers;
prompt Enabling triggers for TEACHER...
alter table TEACHER enable all triggers;
prompt Enabling triggers for WORKER...
alter table WORKER enable all triggers;
prompt Enabling triggers for WORKINGIN...
alter table WORKINGIN enable all triggers;
set feedback on
set define on
prompt Done.
