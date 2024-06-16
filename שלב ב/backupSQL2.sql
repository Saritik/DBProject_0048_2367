prompt PL/SQL Developer import file
prompt Created on יום ראשון 16 יוני 2024 by משתמש
set feedback off
set define off
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
  catering_id NUMBER(5) not null
)
;
alter table DISHS
  add primary key (DISHS_ID);
alter table DISHS
  add foreign key (CATERING_ID)
  references CATERING (CATERING_ID);
alter table DISHS
  add check (cosherType='Dairy' or cosherType='Meat' or cosherType='None');

prompt Creating CUSTOMER...
create table CUSTOMER
(
  customer_id    NUMBER(5) not null,
  name           VARCHAR2(15) not null,
  email          VARCHAR2(20) not null,
  address        VARCHAR2(20) not null,
  phonenumber    VARCHAR2(11) not null,
  paymentdetails VARCHAR2(10) not null
)
;
alter table CUSTOMER
  add primary key (CUSTOMER_ID);

prompt Creating THE_ORDER...
create table THE_ORDER
(
  order_id    NUMBER(5) not null,
  totalprice  NUMBER(7) not null,
  order_date  DATE not null,
  address     VARCHAR2(20) not null,
  phonenumber VARCHAR2(11) not null,
  customer_id NUMBER(5) not null
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

prompt Disabling triggers for CATERING...
alter table CATERING disable all triggers;
prompt Disabling triggers for DISHS...
alter table DISHS disable all triggers;
prompt Disabling triggers for CUSTOMER...
alter table CUSTOMER disable all triggers;
prompt Disabling triggers for THE_ORDER...
alter table THE_ORDER disable all triggers;
prompt Disabling triggers for BELONG...
alter table BELONG disable all triggers;
prompt Disabling triggers for MATERIAL...
alter table MATERIAL disable all triggers;
prompt Disabling triggers for CONTAIN...
alter table CONTAIN disable all triggers;
prompt Disabling triggers for WORKER...
alter table WORKER disable all triggers;
prompt Disabling triggers for WORKINGIN...
alter table WORKINGIN disable all triggers;
prompt Disabling foreign key constraints for DISHS...
alter table DISHS disable constraint SYS_C007473;
prompt Disabling foreign key constraints for THE_ORDER...
alter table THE_ORDER disable constraint SYS_C007489;
prompt Disabling foreign key constraints for BELONG...
alter table BELONG disable constraint SYS_C007494;
alter table BELONG disable constraint SYS_C007495;
prompt Disabling foreign key constraints for CONTAIN...
alter table CONTAIN disable constraint SYS_C007505;
alter table CONTAIN disable constraint SYS_C007506;
prompt Disabling foreign key constraints for WORKINGIN...
alter table WORKINGIN disable constraint SYS_C007515;
alter table WORKINGIN disable constraint SYS_C007516;
prompt Deleting WORKINGIN...
delete from WORKINGIN;
commit;
prompt Deleting WORKER...
delete from WORKER;
commit;
prompt Deleting CONTAIN...
delete from CONTAIN;
commit;
prompt Deleting MATERIAL...
delete from MATERIAL;
commit;
prompt Deleting BELONG...
delete from BELONG;
commit;
prompt Deleting THE_ORDER...
delete from THE_ORDER;
commit;
prompt Deleting CUSTOMER...
delete from CUSTOMER;
commit;
prompt Deleting DISHS...
delete from DISHS;
commit;
prompt Deleting CATERING...
delete from CATERING;
commit;
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
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (2, 218, 'Kerak Telor', 'Meat', 79);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (4, 197, 'Sate Padang Pad', 'Meat', 16);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (6, 66, 'Dim Sum', 'Meat', 769);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (8, 39, 'Fajitas', 'None', 121);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (10, 229, 'Sate Padang Saw', 'None', 2);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (12, 141, 'Sate Taoco', 'Dairy', 143);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (14, 114, 'Sate Padang Buk', 'Dairy', 23);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (16, 116, 'Bruschetta', 'Dairy', 286);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (18, 227, 'Sate Ayam Kampu', 'None', 474);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (20, 53, 'Bihun', 'None', 640);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (22, 138, 'Shawarma', 'Dairy', 666);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (24, 192, 'Sate Lilit', 'None', 198);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (26, 94, 'Pad Thai', 'None', 52);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (28, 207, 'Sate Padang Buk', 'Dairy', 379);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (30, 167, 'Sate Padang Sol', 'Dairy', 689);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (32, 178, 'Risotto', 'None', 59);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (34, 164, 'Sate Padang Tan', 'None', 611);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (36, 246, 'Sate Padang Pes', 'Meat', 661);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (38, 71, 'Schnitzel', 'Dairy', 284);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (40, 120, 'Sate Padang Saw', 'None', 706);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (42, 111, 'Sate Lilit', 'Dairy', 223);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (44, 29, 'Sate Kikil', 'None', 80);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (46, 177, 'Sambal', 'None', 213);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (48, 134, 'Crepe', 'None', 379);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (50, 33, 'Sate Padang Pad', 'Dairy', 284);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (52, 20, 'Risotto', 'Dairy', 349);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (54, 46, 'Soto Medan', 'None', 72);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (56, 96, 'Lo Mie', 'Dairy', 368);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (58, 147, 'Sate Burung', 'None', 599);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (60, 69, 'Sate Padang Sol', 'Dairy', 459);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (62, 246, 'Kroket', 'Meat', 656);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (64, 35, 'Sate Padang Lim', 'Meat', 12);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (66, 27, 'Sate Daging Sap', 'Dairy', 158);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (68, 22, 'Soto Ayam', 'Dairy', 690);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (70, 202, 'Soto Kudus', 'Meat', 761);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (72, 63, 'Sate Lilit', 'Dairy', 694);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (74, 145, 'Bakpao', 'None', 355);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (76, 118, 'Sate Padang Aga', 'None', 131);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (78, 205, 'Sate Tempe', 'Meat', 290);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (80, 65, 'Sate Padang Men', 'None', 218);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (82, 184, 'Baklava', 'None', 65);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (84, 222, 'Sate Padang Saw', 'Dairy', 762);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (86, 179, 'Sate Padang Sij', 'Meat', 313);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (88, 98, 'Sate Padang Lim', 'Dairy', 58);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (90, 122, 'Sate Padang Lub', 'Dairy', 373);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (92, 215, 'Sate Usus', 'Dairy', 770);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (94, 77, 'Sate Tomat', 'Dairy', 413);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (96, 79, 'Sate Padang Lim', 'None', 209);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (98, 157, 'Sate Usus', 'Meat', 640);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (100, 150, 'Sate Padang Pas', 'Meat', 286);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (102, 37, 'Sate Padang Pas', 'None', 396);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (104, 182, 'Asinan', 'None', 316);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (106, 173, 'Kimchi', 'Meat', 709);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (108, 185, 'Sate Padang Sol', 'Dairy', 555);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (110, 77, 'Sate Padang Dha', 'Dairy', 183);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (112, 67, 'Sate Gulai', 'None', 108);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (114, 134, 'Sate Padang Par', 'None', 131);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (116, 44, 'Sate Padang Pas', 'Meat', 490);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (118, 28, 'Sate Padang Par', 'Dairy', 590);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (120, 197, 'Mie Goreng', 'Dairy', 349);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (122, 238, 'Sate Jeroan', 'Dairy', 588);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (124, 103, 'Soto Kudus', 'None', 17);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (126, 148, 'Sate Padang Pay', 'Meat', 53);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (128, 150, 'Sate Padang Par', 'None', 265);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (130, 152, 'Sate Padang Pas', 'Dairy', 72);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (132, 161, 'Sate Tegal', 'Dairy', 707);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (134, 133, 'Sate Vegetarian', 'None', 140);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (136, 160, 'Lemper', 'Dairy', 30);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (138, 99, 'Sate Daging Sap', 'Dairy', 143);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (140, 61, 'Enchilada', 'Dairy', 164);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (142, 194, 'Kroket', 'Meat', 39);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (144, 123, 'Sate Padang Pes', 'None', 490);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (146, 89, 'Sate Ikan', 'Meat', 297);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (148, 83, 'Sate Padang Pes', 'None', 76);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (150, 63, 'Schnitzel', 'None', 282);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (152, 219, 'Sate Padang Sol', 'Dairy', 191);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (154, 79, 'Sate Padang Pad', 'None', 251);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (156, 172, 'Sate Padang Tan', 'Meat', 343);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (158, 78, 'Sate Padang Dha', 'None', 579);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (160, 145, 'Sate Meranggi', 'Dairy', 755);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (162, 131, 'Sate Padang Lim', 'Dairy', 777);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (164, 103, 'Sate Padang Saw', 'Meat', 49);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (166, 183, 'Sate Padang Buk', 'None', 284);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (168, 197, 'Lasagna', 'None', 380);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (170, 112, 'Sate Padang Sij', 'Dairy', 243);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (172, 101, 'Sate Padang Sol', 'Dairy', 427);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (174, 88, 'Sate Padang Tan', 'Meat', 164);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (176, 45, 'Paella', 'Meat', 422);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (178, 78, 'Sate Keong', 'Dairy', 545);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (180, 71, 'Sate Kambing', 'Dairy', 180);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (182, 122, 'Sate Padang Pas', 'None', 631);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (184, 47, 'Sate Padang Lim', 'Meat', 280);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (186, 209, 'Sate Padang Men', 'None', 224);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (188, 226, 'Sate Padang Aga', 'None', 111);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (190, 238, 'Sate Daging Sap', 'Dairy', 76);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (192, 250, 'Sate Padang Buk', 'Meat', 770);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (194, 38, 'Sate Kikil', 'None', 377);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (196, 85, 'Sup Buntut', 'Dairy', 751);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (198, 167, 'Lemper', 'Dairy', 549);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (200, 90, 'Sate Padang Tan', 'None', 647);
commit;
prompt 100 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (202, 228, 'Soto Ayam', 'None', 336);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (204, 20, 'Laksa', 'Dairy', 550);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (206, 43, 'Sate Burung', 'Dairy', 373);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (208, 164, 'Sate Padang Sol', 'None', 781);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (210, 192, 'Sate Padang Saw', 'Dairy', 200);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (212, 29, 'Sate Ambal', 'Dairy', 99);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (214, 99, 'Crepe', 'None', 570);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (216, 85, 'Maki', 'None', 761);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (218, 99, 'Sate Padang Par', 'None', 743);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (220, 127, 'Sate Padang Sol', 'None', 240);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (222, 131, 'Sate Maranggi', 'Dairy', 787);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (224, 249, 'Empanada', 'Dairy', 486);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (226, 107, 'Sate Padang Sol', 'Meat', 9);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (228, 39, 'Sate Padang Aga', 'Meat', 551);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (230, 123, 'Sate Padang Par', 'Dairy', 8);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (232, 156, 'Sate Padang Men', 'Meat', 165);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (234, 61, 'Sate Padang Sol', 'Meat', 750);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (236, 56, 'Rendang', 'None', 794);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (238, 170, 'Sate Usus', 'Meat', 579);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (240, 176, 'Sate Padang Pay', 'Meat', 183);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (242, 115, 'Sate Padang Pas', 'Meat', 503);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (244, 35, 'Ketoprak', 'None', 116);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (246, 175, 'Sate Padang Sij', 'None', 137);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (248, 99, 'Pad Thai', 'Dairy', 258);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (250, 197, 'Ceviche', 'Dairy', 544);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (252, 25, 'Sate Burung', 'Dairy', 281);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (254, 245, 'Sate Padang Dha', 'Dairy', 322);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (256, 212, 'Soto Betawi', 'Dairy', 305);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (258, 166, 'Sate Lilit', 'Meat', 89);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (260, 189, 'Sate Padang Par', 'Dairy', 709);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (262, 149, 'Tempura', 'None', 337);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (264, 75, 'Kue Lapis', 'Meat', 208);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (266, 205, 'Sate Padang Aga', 'Dairy', 332);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (268, 41, 'Kue Lapis', 'Meat', 777);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (270, 175, 'Focaccia', 'None', 137);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (272, 65, 'Sate Padang Sij', 'Dairy', 761);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (274, 52, 'Sate Padang Pas', 'None', 367);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (276, 226, 'Bibimbap', 'None', 751);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (278, 131, 'Sate Ayam', 'Dairy', 334);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (280, 147, 'Sate Padang Aga', 'Dairy', 186);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (282, 88, 'Sate', 'None', 318);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (284, 129, 'Lumpia', 'Meat', 786);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (286, 199, 'Sate Padang Men', 'Dairy', 580);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (288, 37, 'Sate Padang Pay', 'None', 790);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (290, 104, 'Nasi Uduk', 'Dairy', 540);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (292, 122, 'Sate Padang Tan', 'Dairy', 128);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (294, 168, 'Fajitas', 'None', 280);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (296, 50, 'Sate Padang Pas', 'None', 580);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (298, 157, 'Sate Ayam Kampu', 'None', 714);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (300, 99, 'Tacos', 'Dairy', 316);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (302, 55, 'Sate Blora', 'None', 197);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (304, 104, 'Capcay', 'Meat', 726);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (306, 34, 'Sate Padang Dha', 'Meat', 603);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (308, 101, 'Sate Padang Men', 'None', 198);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (310, 34, 'Batagor', 'Meat', 777);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (312, 113, 'Karedok', 'None', 401);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (314, 105, 'Sate Krecek', 'Dairy', 86);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (316, 242, 'Sate Padang Lim', 'Dairy', 33);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (318, 133, 'Sushi', 'Meat', 394);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (320, 142, 'Tumpeng', 'None', 230);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (322, 95, 'Sate Padang Saw', 'None', 599);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (324, 175, 'Bakpao', 'Dairy', 468);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (326, 159, 'Sate Padang Pes', 'Meat', 325);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (328, 107, 'Sate Padang Pas', 'None', 473);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (330, 165, 'Sate Daging Sap', 'Dairy', 323);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (332, 176, 'Lumpia', 'Meat', 286);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (334, 92, 'Sate Klatak', 'None', 534);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (336, 162, 'Sate Padang Buk', 'None', 121);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (338, 150, 'Sate Padang Aga', 'Dairy', 568);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (340, 144, 'Tiramisu', 'None', 229);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (342, 240, 'Sate Padang Buk', 'Dairy', 400);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (344, 167, 'Sate Padang Aga', 'Dairy', 212);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (346, 180, 'Sate Padang Dha', 'Dairy', 70);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (348, 227, 'Sate Ayam', 'Meat', 585);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (350, 244, 'Sate Padang Sol', 'Dairy', 402);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (352, 78, 'Risotto', 'None', 484);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (354, 142, 'Sate Blora', 'None', 565);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (356, 53, 'Sate Padang Dha', 'Dairy', 265);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (358, 163, 'Sate Padang Sol', 'Dairy', 367);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (360, 101, 'Sate Daging', 'Dairy', 99);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (362, 72, 'Kroket', 'None', 352);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (364, 48, 'Kroket', 'None', 127);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (366, 167, 'Sate Padang Pas', 'None', 229);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (368, 166, 'Sate Padang Buk', 'None', 76);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (370, 86, 'Sate Padang Pas', 'Dairy', 666);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (372, 201, 'Sate Padang Buk', 'None', 323);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (374, 238, 'Sate Padang Sol', 'Dairy', 65);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (376, 79, 'Sate Padang Pas', 'Dairy', 785);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (378, 69, 'Tagine', 'Dairy', 689);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (380, 233, 'Bruschetta', 'Meat', 398);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (382, 94, 'Sushi', 'Dairy', 681);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (384, 146, 'Sate Padang Lub', 'Meat', 243);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (386, 74, 'Sate Padang Pas', 'None', 93);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (388, 209, 'Sate Blora', 'None', 775);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (390, 43, 'Soto Medan', 'Dairy', 510);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (392, 176, 'Sate Padang Tan', 'Dairy', 699);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (394, 243, 'Sate Padang Sol', 'Dairy', 520);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (396, 240, 'Sate Klatak', 'Meat', 243);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (398, 217, 'Sate Padang Sol', 'None', 312);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (400, 100, 'Sate Padang Saw', 'None', 198);
commit;
prompt 200 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (402, 45, 'Nasi Kuning', 'None', 618);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (404, 178, 'Karedok', 'None', 140);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (406, 39, 'Sate Padang Sij', 'Dairy', 758);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (408, 136, 'Sate Padang Pad', 'None', 137);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (410, 49, 'Sushi', 'Meat', 143);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (412, 238, 'Bihun', 'Dairy', 8);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (414, 227, 'Fajitas', 'None', 651);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (416, 245, 'Sashimi', 'Meat', 111);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (418, 241, 'Sate Padang Buk', 'Dairy', 690);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (420, 229, 'Sate Padang Sij', 'Meat', 82);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (422, 185, 'Siomay', 'Dairy', 214);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (424, 69, 'Sate Sosis', 'Dairy', 432);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (426, 174, 'Sate Padang Lim', 'None', 726);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (428, 182, 'Ketoprak', 'Meat', 526);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (430, 237, 'Bubur', 'None', 271);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (432, 238, 'Sate Padang Lub', 'Meat', 392);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (434, 59, 'Sate Ayam', 'Meat', 430);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (436, 38, 'Sate Tempe', 'None', 377);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (438, 172, 'Sate Padang Pas', 'None', 437);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (440, 220, 'Pizza', 'Dairy', 678);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (442, 224, 'Sate Padang Buk', 'Meat', 97);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (444, 46, 'Sate Padang Dha', 'Dairy', 108);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (446, 90, 'Pierogi', 'None', 762);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (448, 100, 'Kolak', 'Dairy', 48);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (450, 125, 'Sate Padang Par', 'None', 793);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (452, 222, 'Sate Padang Saw', 'None', 669);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (454, 109, 'Kimchi', 'None', 58);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (456, 41, 'Sate Padang Aga', 'Dairy', 144);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (458, 113, 'Pecel', 'None', 255);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (460, 52, 'Sate Padang Pas', 'Meat', 128);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (462, 50, 'Sate Padang Saw', 'None', 729);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (464, 217, 'Sate Padang Pas', 'Dairy', 690);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (466, 217, 'Sate Vegetarian', 'None', 264);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (468, 32, 'Lumpia', 'Meat', 318);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (470, 68, 'Sate Padang Pes', 'None', 555);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (472, 43, 'Sate Padang Pay', 'None', 49);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (474, 62, 'Lumpia', 'Dairy', 779);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (476, 211, 'Tacos', 'None', 91);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (478, 112, 'Soto Ayam', 'None', 68);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (480, 185, 'Karedok', 'Dairy', 157);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (482, 190, 'Sate Padang Par', 'Dairy', 689);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (484, 121, 'Bibimbap', 'None', 224);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (486, 83, 'Sate Taoco', 'None', 678);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (488, 177, 'Sate Padang Pay', 'Dairy', 65);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (490, 136, 'Soto Medan', 'None', 325);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (492, 88, 'Sate Padang Pad', 'Meat', 149);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (494, 228, 'Sate Klatak', 'Meat', 748);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (496, 195, 'Fajitas', 'Dairy', 544);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (498, 204, 'Sate Ayam Kampu', 'None', 542);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (500, 238, 'Sate Padang Pes', 'None', 239);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (502, 143, 'Bibimbap', 'Dairy', 280);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (504, 65, 'Sate Padang Aga', 'None', 178);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (506, 244, 'Sate Padang Lub', 'Meat', 145);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (508, 191, 'Sate Padang Saw', 'None', 256);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (510, 84, 'Sate Kikil', 'Meat', 211);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (512, 110, 'Pad Thai', 'Dairy', 73);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (514, 35, 'Burger', 'Dairy', 52);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (516, 149, 'Sate Padang Pan', 'None', 50);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (518, 203, 'Sate Padang Lim', 'Dairy', 568);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (520, 157, 'Sate Padang Pas', 'Dairy', 566);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (522, 142, 'Enchilada', 'Dairy', 619);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (524, 123, 'Sashimi', 'None', 206);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (526, 247, 'Biryani', 'Dairy', 490);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (528, 157, 'Sate Padang Lub', 'Dairy', 432);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (530, 225, 'Empanada', 'Meat', 175);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (532, 99, 'Sate Maranggi', 'Dairy', 681);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (534, 175, 'Lemper', 'None', 656);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (536, 112, 'Sate Padang Tan', 'Dairy', 12);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (538, 122, 'Sate Kuda', 'Dairy', 505);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (540, 195, 'Sate Padang', 'None', 377);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (542, 90, 'Lasagna', 'Dairy', 695);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (544, 235, 'Ceviche', 'None', 312);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (546, 240, 'Sate Banjar', 'Meat', 343);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (548, 123, 'Bihun', 'Dairy', 652);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (550, 163, 'Pad Thai', 'Meat', 69);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (552, 183, 'Sate Gulai', 'None', 694);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (554, 92, 'Sate Daging', 'Dairy', 215);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (556, 46, 'Churros', 'Meat', 149);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (558, 102, 'Sate Lilit', 'Meat', 351);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (560, 144, 'Kroket', 'Dairy', 208);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (562, 80, 'Sate Padang Pad', 'Dairy', 786);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (564, 41, 'Sate Padang Pay', 'Dairy', 666);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (566, 231, 'Bibimbap', 'Meat', 403);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (568, 67, 'Sayur Lodeh', 'Dairy', 202);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (570, 32, 'Panna Cotta', 'None', 213);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (572, 26, 'Cannoli', 'Meat', 351);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (574, 38, 'Ketoprak', 'None', 280);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (576, 52, 'Sate Kikil', 'Dairy', 65);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (578, 56, 'Sate Padang Lim', 'None', 73);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (580, 152, 'Sate Padang Aga', 'Dairy', 419);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (582, 173, 'Goulash', 'None', 451);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (584, 52, 'Sate Padang Saw', 'Dairy', 422);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (586, 233, 'Bratwurst', 'Dairy', 111);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (588, 39, 'Sate Padang Pad', 'None', 17);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (590, 76, 'Sate Padang Sol', 'None', 70);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (592, 26, 'Pempek', 'Dairy', 781);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (594, 89, 'Martabak', 'None', 89);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (596, 83, 'Siomay', 'Meat', 264);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (598, 206, 'Pho', 'Dairy', 184);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (600, 102, 'Sate Padang Aga', 'None', 126);
commit;
prompt 300 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (602, 135, 'Sate Usus', 'Dairy', 352);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (604, 239, 'Sate Padang Dha', 'Dairy', 332);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (606, 124, 'Lumpia', 'None', 490);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (608, 38, 'Sate Babi', 'Dairy', 251);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (610, 179, 'Sate Padang Lim', 'Meat', 277);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (612, 170, 'Kue Lapis', 'None', 372);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (614, 42, 'Sate Vegetarian', 'None', 39);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (616, 80, 'Sate', 'Meat', 2);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (618, 178, 'Lumpia', 'None', 599);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (620, 105, 'Baklava', 'Meat', 17);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (622, 50, 'Sate Ambal', 'Dairy', 372);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (624, 192, 'Sate Padang Pas', 'None', 748);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (626, 168, 'Hummus', 'Dairy', 111);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (628, 73, 'Sate Padang Par', 'Meat', 670);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (630, 50, 'Sate Daging', 'None', 794);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (632, 216, 'Sate Padang Pay', 'Meat', 65);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (634, 187, 'Cannoli', 'Dairy', 528);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (636, 60, 'Sate Taoco', 'None', 679);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (638, 144, 'Sate Padang Pay', 'Meat', 544);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (640, 33, 'Sate Padang Saw', 'Meat', 505);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (642, 207, 'Sate Padang Sol', 'None', 680);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (644, 167, 'Sate Padang Sol', 'Dairy', 82);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (646, 96, 'Sate Padang Pad', 'Meat', 490);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (648, 179, 'Sate Padang Pay', 'Dairy', 618);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (650, 60, 'Focaccia', 'Dairy', 591);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (652, 80, 'Sate Padang Sij', 'Dairy', 588);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (654, 193, 'Borscht', 'Meat', 638);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (656, 163, 'Sate Padang Pay', 'None', 566);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (658, 59, 'Sate Padang Pes', 'None', 632);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (660, 148, 'Sate Oncom', 'Meat', 669);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (662, 237, 'Sate Taichan', 'None', 4);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (664, 235, 'Sate Banjar', 'None', 528);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (666, 235, 'Gelato', 'Meat', 536);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (668, 160, 'Sushi', 'None', 251);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (670, 177, 'Ketupat', 'None', 694);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (672, 164, 'Bibimbap', 'Meat', 527);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (674, 27, 'Sate Padang Pay', 'None', 277);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (676, 193, 'Otak-Otak', 'None', 135);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (678, 29, 'Sate Padang Lub', 'None', 548);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (680, 89, 'Karedok', 'Dairy', 480);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (682, 68, 'Sate Padang Men', 'None', 40);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (684, 83, 'Goulash', 'Dairy', 9);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (686, 37, 'Sate Vegetarian', 'None', 367);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (688, 213, 'Sate Padang Pay', 'Meat', 143);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (690, 26, 'Sate Padang', 'None', 790);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (692, 38, 'Soto Banjar', 'Dairy', 153);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (694, 141, 'Klepon', 'Dairy', 625);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (696, 42, 'Sate Padang Sol', 'Meat', 619);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (698, 150, 'Sate Padang Sol', 'Dairy', 415);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (700, 111, 'Sate Padang Pay', 'Dairy', 706);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (702, 134, 'Sushi', 'Meat', 566);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (704, 157, 'Rawon', 'None', 264);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (706, 47, 'Karedok', 'Meat', 33);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (708, 125, 'Ceviche', 'None', 536);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (710, 50, 'Lemper', 'Dairy', 699);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (712, 67, 'Pad Thai', 'Dairy', 427);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (714, 220, 'Kerak Telor', 'Meat', 639);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (716, 63, 'Sushi', 'Meat', 679);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (718, 97, 'Borscht', 'None', 151);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (720, 211, 'Mie Goreng', 'None', 326);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (722, 156, 'Sate Oncom', 'None', 777);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (724, 226, 'Sate Padang Pes', 'None', 73);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (726, 117, 'Sate Padang Par', 'Meat', 55);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (728, 40, 'Martabak', 'Meat', 458);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (730, 95, 'Sate Babi', 'Meat', 402);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (732, 238, 'Sate', 'Meat', 464);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (734, 210, 'Cannoli', 'Dairy', 54);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (736, 26, 'Sate Padang Lub', 'Dairy', 769);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (738, 36, 'Soto Betawi', 'None', 137);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (740, 127, 'Sate Padang Pas', 'None', 651);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (742, 200, 'Carbonara', 'Dairy', 21);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (744, 200, 'Sate Padang Pay', 'Meat', 669);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (746, 128, 'Sate Gulai', 'Dairy', 305);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (748, 27, 'Sate Padang Lim', 'Dairy', 430);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (750, 23, 'Sate Padang Pay', 'Dairy', 756);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (752, 83, 'Sate Padang Pes', 'Meat', 585);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (754, 136, 'Kebab', 'Dairy', 135);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (756, 98, 'Sate Padang Saw', 'None', 681);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (758, 118, 'Sate Padang Dha', 'None', 709);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (760, 228, 'Serabi', 'Dairy', 355);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (762, 57, 'Biryani', 'Dairy', 108);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (764, 228, 'Pepes', 'None', 747);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (766, 200, 'Kue Lapis', 'Dairy', 781);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (768, 72, 'Tahu Gejrot', 'Meat', 714);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (770, 56, 'Kerak Telor', 'Dairy', 323);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (772, 192, 'Tahu Sumedang', 'Dairy', 54);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (774, 112, 'Sate Jeroan', 'None', 211);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (776, 169, 'Sate Padang Sol', 'None', 781);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (778, 156, 'Karedok', 'Meat', 404);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (780, 38, 'Sate Padang Aga', 'None', 533);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (782, 213, 'Sate Padang Tan', 'Dairy', 677);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (784, 46, 'Sate Padang', 'None', 561);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (786, 168, 'Sate Banjar', 'None', 284);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (788, 20, 'Dim Sum', 'None', 52);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (790, 153, 'Sate Padang Pay', 'Dairy', 343);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (792, 201, 'Sate Padang Buk', 'Dairy', 52);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (794, 83, 'Sate Tegal', 'Dairy', 179);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (796, 59, 'Sate Lilit', 'Dairy', 413);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (798, 186, 'Kimchi', 'Dairy', 574);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (800, 192, 'Sate Madura', 'Dairy', 682);
commit;
prompt 400 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (802, 225, 'Sate Padang Lub', 'None', 450);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (804, 136, 'Sate Padang Par', 'None', 141);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (806, 172, 'Sate Padang Tan', 'Meat', 31);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (808, 175, 'Sate Blora', 'Dairy', 580);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (810, 32, 'Sate Padang Pas', 'None', 53);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (812, 218, 'Sate Padang', 'None', 797);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (814, 202, 'Sate Padang Pes', 'Meat', 258);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (816, 140, 'Sate Padang Aga', 'Dairy', 118);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (818, 55, 'Tongseng', 'Dairy', 400);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (820, 187, 'Sate Ayam Kampu', 'None', 469);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (822, 59, 'Sate Padang Pas', 'Dairy', 199);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (824, 73, 'Sate Tahu', 'None', 195);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (826, 44, 'Sate Padang Sij', 'Dairy', 629);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (828, 229, 'Sate Padang Buk', 'None', 249);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (830, 75, 'Sate Padang Dha', 'Meat', 750);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (832, 113, 'Rendang', 'Meat', 656);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (834, 25, 'Carbonara', 'None', 579);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (836, 68, 'Biryani', 'None', 121);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (838, 129, 'Lasagna', 'Dairy', 720);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (840, 245, 'Croissant', 'Dairy', 111);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (842, 234, 'Bihun', 'None', 129);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (844, 53, 'Sate Padang Pad', 'Dairy', 463);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (846, 41, 'Sate Padang Sij', 'None', 121);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (848, 236, 'Sambal', 'Dairy', 135);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (850, 116, 'Sate Padang Pas', 'Dairy', 640);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (852, 157, 'Sate Padang Par', 'Dairy', 446);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (854, 193, 'Rendang', 'Meat', 82);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (856, 248, 'Jambalaya', 'None', 157);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (858, 102, 'Sate Padang Buk', 'None', 58);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (860, 136, 'Sate Padang Par', 'None', 415);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (862, 66, 'Sate Lilit', 'Dairy', 255);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (864, 77, 'Sate Padang Pad', 'None', 781);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (866, 152, 'Sate Padang Par', 'None', 192);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (868, 153, 'Tabbouleh', 'Dairy', 164);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (870, 22, 'Sate Padang Dha', 'Meat', 566);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (872, 234, 'Sate Padang Sol', 'Dairy', 379);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (874, 145, 'Sate Jamur', 'None', 202);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (876, 243, 'Pizza', 'Dairy', 572);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (878, 74, 'Sate Keong', 'None', 161);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (880, 28, 'Sate Padang Lub', 'Dairy', 70);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (882, 35, 'Sate Padang Pas', 'None', 553);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (884, 239, 'Bibimbap', 'Meat', 243);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (886, 43, 'Capcay', 'Dairy', 781);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (888, 30, 'Mie Goreng', 'Dairy', 215);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (890, 244, 'Focaccia', 'Meat', 519);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (892, 162, 'Quiche', 'Dairy', 400);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (894, 182, 'Sate Telur Puyu', 'None', 59);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (896, 156, 'Baklava', 'Dairy', 611);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (898, 204, 'Perkedel', 'Dairy', 571);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (900, 151, 'Sate Padang Lim', 'Dairy', 682);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (902, 178, 'Sate Padang Sij', 'Dairy', 526);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (904, 55, 'Sate Padang Saw', 'Meat', 180);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (906, 127, 'Rendang', 'None', 17);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (908, 158, 'Soto Mie', 'None', 785);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (910, 236, 'Tumpeng', 'None', 551);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (912, 195, 'Klepon', 'None', 366);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (914, 249, 'Sate Padang Lub', 'None', 763);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (916, 107, 'Sate Padang Sol', 'None', 392);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (918, 82, 'Sate Padang Sol', 'None', 59);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (920, 170, 'Sate Padang Saw', 'Dairy', 111);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (922, 56, 'Sate Padang Par', 'None', 197);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (924, 53, 'Serabi', 'Meat', 779);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (926, 43, 'Sate Padang Sol', 'None', 318);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (928, 247, 'Sate Padang Sol', 'None', 751);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (930, 67, 'Sate Padang Sij', 'Meat', 794);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (932, 111, 'Empanada', 'Dairy', 611);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (934, 59, 'Rawon', 'None', 52);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (936, 139, 'Clafoutis', 'None', 129);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (938, 141, 'Sate Ayam', 'Meat', 212);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (940, 150, 'Sate Padang Buk', 'Dairy', 79);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (942, 63, 'Sate Padang Pas', 'Dairy', 33);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (944, 85, 'Kebab', 'Dairy', 94);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (946, 95, 'Sate Padang Pad', 'None', 392);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (948, 186, 'Sate Padang Buk', 'None', 748);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (950, 146, 'Sate Padang Par', 'Dairy', 762);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (952, 89, 'Sate Banjar', 'Meat', 545);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (954, 102, 'Sate Padang Pas', 'Dairy', 791);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (956, 76, 'Sate Padang Pay', 'Dairy', 647);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (958, 21, 'Sate Padang Pas', 'None', 750);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (960, 76, 'Sate Padang Sij', 'Dairy', 281);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (962, 150, 'Mie Goreng', 'Meat', 94);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (964, 141, 'Tiramisu', 'Meat', 784);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (966, 107, 'Bratwurst', 'Meat', 451);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (968, 52, 'Sate Daging Sap', 'Meat', 237);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (970, 202, 'Sate Padang Pad', 'None', 195);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (972, 168, 'Sate Padang Buk', 'Dairy', 137);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (974, 67, 'Sate Padang Tan', 'None', 750);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (976, 29, 'Sate Ayam Kampu', 'None', 126);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (978, 126, 'Sate Tegal', 'Meat', 451);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (980, 34, 'Sate Padang Par', 'None', 559);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (982, 129, 'Sate Padang Saw', 'None', 230);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (984, 191, 'Sate Banjar', 'Dairy', 17);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (986, 82, 'Sate Padang Pes', 'None', 55);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (988, 91, 'Sate Padang Saw', 'None', 141);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (990, 81, 'Otak-Otak', 'Dairy', 318);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (992, 118, 'Pierogi', 'Meat', 243);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (994, 223, 'Sate Padang Sol', 'Dairy', 398);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (996, 174, 'Sate Padang Men', 'Meat', 544);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (998, 129, 'Sate Padang Saw', 'Dairy', 52);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1000, 110, 'Sate Padang Aga', 'Dairy', 758);
commit;
prompt 500 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1002, 155, 'Sate Padang Dha', 'None', 249);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1004, 219, 'Capcay', 'Dairy', 397);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1006, 131, 'Sate Sapi', 'Dairy', 208);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1008, 186, 'Baklava', 'Dairy', 744);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1010, 25, 'Sate Padang Saw', 'None', 519);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1012, 193, 'Sate Ponorogo', 'Dairy', 160);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1014, 215, 'Sate Gulai', 'Dairy', 144);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1016, 242, 'Sate Padang Par', 'Dairy', 423);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1018, 215, 'Sate Padang Pad', 'Meat', 47);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1020, 250, 'Sate Padang Pas', 'Dairy', 446);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1022, 247, 'Sate Padang Saw', 'None', 763);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1024, 212, 'Sate Padang Aga', 'None', 183);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1026, 115, 'Sate Padang Tan', 'Dairy', 553);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1028, 203, 'Sate Padang Sij', 'Meat', 305);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1030, 223, 'Sate Padang Par', 'None', 520);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1032, 226, 'Dodol', 'Dairy', 419);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1034, 132, 'Jambalaya', 'Meat', 127);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1036, 134, 'Lo Mie', 'Meat', 474);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1038, 190, 'Sroto', 'Meat', 230);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1040, 77, 'Sate Padang Pan', 'Meat', 751);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1042, 228, 'Sate Padang Pas', 'Meat', 324);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1044, 104, 'Sate Padang Sij', 'None', 55);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1046, 181, 'Sate Padang Sol', 'Meat', 677);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1048, 69, 'Es Teler', 'Dairy', 729);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1050, 84, 'Sate Sapi', 'Dairy', 560);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1052, 68, 'Sate Padang Pas', 'Dairy', 467);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1054, 140, 'Rawon', 'None', 679);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1056, 26, 'Kroket', 'None', 656);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1058, 176, 'Otak-Otak', 'None', 437);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1060, 45, 'Sate Padang Par', 'None', 680);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1062, 79, 'Bakso', 'None', 559);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1064, 139, 'Sate Padang Lim', 'None', 707);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1066, 92, 'Risotto', 'None', 536);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1068, 37, 'Otak-Otak', 'Dairy', 208);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1070, 240, 'Es Teler', 'Dairy', 354);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1072, 206, 'Sate Padang Sij', 'Dairy', 33);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1074, 74, 'Tahu Sumedang', 'Dairy', 711);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1076, 193, 'Sate Sapi', 'None', 79);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1078, 96, 'Sate Padang Buk', 'Dairy', 570);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1080, 248, 'Sate Padang Par', 'Dairy', 786);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1082, 23, 'Pho', 'Dairy', 61);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1084, 42, 'Sate Padang Buk', 'Meat', 137);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1086, 130, 'Sate Padang Sij', 'Dairy', 526);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1088, 207, 'Sate Padang Pas', 'Dairy', 795);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1090, 118, 'Sate Kuda', 'Dairy', 121);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1092, 39, 'Sate Padang Par', 'None', 8);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1094, 142, 'Sate Padang Pas', 'None', 695);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1096, 108, 'Sate Padang Lim', 'None', 787);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1098, 52, 'Sate Padang Pay', 'None', 791);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1100, 105, 'Sate Padang Aga', 'Dairy', 464);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1102, 103, 'Sate Telur Puyu', 'None', 297);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1104, 213, 'Sate Ayam Kampu', 'None', 243);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1106, 114, 'Sate Padang Tan', 'Dairy', 175);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1108, 248, 'Sate Padang Pay', 'Dairy', 344);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1110, 85, 'Sate Lilit', 'Dairy', 482);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1112, 27, 'Sate Padang Pay', 'None', 748);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1114, 196, 'Martabak', 'Dairy', 336);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1116, 33, 'Ceviche', 'Dairy', 408);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1118, 183, 'Bakpao', 'Dairy', 140);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1120, 77, 'Sate Padang Tan', 'None', 790);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1122, 177, 'Sate Ayam', 'None', 714);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1124, 118, 'Sate Padang Pas', 'None', 82);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1126, 218, 'Sate Padang Pas', 'Dairy', 795);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1128, 217, 'Bakso', 'None', 78);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1130, 87, 'Sate Kikil', 'Dairy', 404);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1132, 114, 'Ketupat', 'Dairy', 656);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1134, 122, 'Tongseng', 'Meat', 49);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1136, 22, 'Sate Padang Lim', 'Dairy', 93);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1138, 33, 'Sate Padang Tan', 'Meat', 763);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1140, 119, 'Sate Gulai', 'Dairy', 344);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1142, 99, 'Sate Padang Pas', 'Dairy', 401);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1144, 99, 'Sate Meranggi', 'None', 80);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1146, 126, 'Sate Padang Lim', 'Dairy', 229);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1148, 191, 'Sate Telur Puyu', 'None', 21);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1150, 93, 'Sate Padang Pad', 'Dairy', 404);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1152, 169, 'Sate Susu', 'Meat', 179);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1154, 180, 'Sate Sapi', 'None', 206);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1156, 44, 'Soto', 'Dairy', 527);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1158, 173, 'Falooda', 'None', 157);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1160, 149, 'Sate Padang Par', 'None', 624);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1162, 98, 'Soto Mie', 'Dairy', 758);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1164, 128, 'Pizza', 'Meat', 396);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1166, 232, 'Sate Padang Men', 'None', 503);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1168, 81, 'Sate Padang Pas', 'None', 17);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1170, 35, 'Sate Padang Pas', 'Meat', 586);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1172, 170, 'Perkedel', 'None', 561);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1174, 149, 'Kebab', 'Meat', 528);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1176, 57, 'Biryani', 'None', 144);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1178, 92, 'Panna Cotta', 'None', 390);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1180, 33, 'Sate Padang Sol', 'None', 263);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1182, 173, 'Sate Krecek', 'None', 771);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1184, 148, 'Sate Padang Par', 'Dairy', 352);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1186, 246, 'Bratwurst', 'Meat', 158);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1188, 97, 'Sate Padang Aga', 'None', 265);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1190, 161, 'Sate Padang Saw', 'None', 743);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1192, 104, 'Kroket', 'Dairy', 591);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1194, 44, 'Sate Padang Pas', 'Dairy', 93);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1196, 37, 'Sate Padang Pay', 'Meat', 352);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1198, 200, 'Kimchi', 'None', 441);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1200, 201, 'Sate Padang Sol', 'Dairy', 656);
commit;
prompt 600 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1202, 151, 'Bubur', 'None', 467);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1204, 135, 'Tempura', 'Dairy', 78);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1206, 70, 'Sate Padang Lub', 'None', 433);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1208, 247, 'Sate Padang Sij', 'None', 55);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1210, 197, 'Gado-Gado', 'None', 4);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1212, 55, 'Karedok', 'Dairy', 343);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1214, 99, 'Sate Padang Par', 'Meat', 48);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1216, 203, 'Sate Padang Sij', 'Dairy', 469);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1218, 89, 'Samosa', 'Dairy', 625);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1220, 153, 'Sate Maranggi', 'Meat', 157);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1222, 162, 'Crepe', 'None', 549);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1224, 111, 'Sate Padang Pas', 'None', 47);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1226, 174, 'Tahu Sumedang', 'None', 198);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1228, 21, 'Sate Padang Tan', 'Dairy', 568);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1230, 77, 'Sate Padang Sij', 'Dairy', 419);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1232, 20, 'Sate Padang Aga', 'Dairy', 468);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1234, 241, 'Sate Padang Pes', 'Meat', 555);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1236, 34, 'Soto Banjar', 'Dairy', 574);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1238, 220, 'Sashimi', 'Dairy', 769);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1240, 148, 'Sate Padang Pas', 'Dairy', 690);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1242, 139, 'Baklava', 'Dairy', 87);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1244, 119, 'Sate Padang Sol', 'Meat', 351);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1246, 70, 'Tapenade', 'Dairy', 490);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1248, 114, 'Sate Pentol', 'Dairy', 689);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1250, 172, 'Sate Padang', 'Dairy', 226);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1252, 145, 'Sate Lilit', 'Meat', 349);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1254, 216, 'Pecel', 'None', 347);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1256, 22, 'Kolak', 'Meat', 755);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1258, 99, 'Rawon', 'Dairy', 591);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1260, 86, 'Laksa', 'Dairy', 463);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1262, 206, 'Sate Padang Par', 'Dairy', 368);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1264, 157, 'Shawarma', 'None', 549);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1266, 218, 'Sate Taoco', 'Dairy', 433);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1268, 176, 'Sate Padang Pes', 'Meat', 769);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1270, 87, 'Sate Padang Pay', 'Meat', 680);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1272, 221, 'Sate Buah', 'Dairy', 779);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1274, 139, 'Sate Padang Sol', 'None', 284);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1276, 143, 'Sate Padang Sol', 'None', 661);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1278, 110, 'Sate Padang Aga', 'Dairy', 575);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1280, 185, 'Sate Padang Sol', 'Meat', 547);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1282, 95, 'Sate Pentol', 'Dairy', 312);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1284, 66, 'Paella', 'Meat', 434);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1286, 188, 'Serabi', 'Dairy', 213);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1288, 214, 'Sate Padang', 'Dairy', 744);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1290, 184, 'Sate Padang Pes', 'Dairy', 178);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1292, 65, 'Sate Padang Saw', 'Dairy', 474);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1294, 61, 'Sate Padang Men', 'None', 457);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1296, 136, 'Sate Lada Hitam', 'Meat', 545);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1298, 58, 'Bratwurst', 'None', 688);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1300, 234, 'Tahu Sumedang', 'None', 277);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1302, 144, 'Kwetiau', 'None', 377);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1304, 61, 'Sate Daging Sap', 'None', 16);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1306, 241, 'Satay', 'Meat', 440);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1308, 106, 'Hummus', 'Dairy', 137);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1310, 69, 'Tabbouleh', 'Dairy', 548);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1312, 81, 'Siomay', 'Dairy', 640);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1314, 207, 'Sate Padang Pas', 'Dairy', 740);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1316, 195, 'Sate Padang Pad', 'Dairy', 192);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1318, 231, 'Perkedel', 'Dairy', 476);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1320, 193, 'Sate Padang Saw', 'Meat', 598);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1322, 157, 'Sate Tahu', 'Meat', 484);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1324, 79, 'Tiramisu', 'None', 445);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1326, 101, 'Pizza', 'None', 202);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1328, 228, 'Sate Padang Par', 'Meat', 300);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1330, 23, 'Tacos', 'Dairy', 451);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1332, 173, 'Pho', 'None', 682);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1334, 227, 'Sate Padang Buk', 'Dairy', 277);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1336, 244, 'Sroto', 'Meat', 741);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1338, 88, 'Sate Pentol', 'Dairy', 548);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1340, 43, 'Sate Padang Pan', 'Dairy', 396);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1342, 87, 'Sate Padang Saw', 'None', 52);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1344, 221, 'Croissant', 'None', 91);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1346, 220, 'Lumpia', 'Meat', 733);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1348, 179, 'Sate Udang', 'Dairy', 426);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1350, 96, 'Pho', 'Meat', 8);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1352, 218, 'Sate Padang Pad', 'Meat', 377);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1354, 34, 'Perkedel', 'Meat', 54);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1356, 77, 'Soto Kudus', 'Dairy', 408);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1358, 147, 'Sate Padang Sol', 'Dairy', 197);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1360, 72, 'Sate Taoco', 'Dairy', 740);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1362, 201, 'Martabak', 'None', 756);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1364, 243, 'Sate Padang Pas', 'Dairy', 390);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1366, 230, 'Sate Ambal', 'Meat', 190);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1368, 250, 'Sate Klatak', 'Meat', 625);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1370, 71, 'Croissant', 'Dairy', 49);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1372, 46, 'Schnitzel', 'None', 751);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1374, 131, 'Sate Padang Pay', 'Meat', 526);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1376, 156, 'Sate Padang Lub', 'Meat', 729);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1378, 138, 'Sate Padang Pay', 'None', 580);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1380, 182, 'Cannoli', 'None', 510);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1382, 52, 'Sate Ayam', 'Meat', 277);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1384, 145, 'Sate Kambing', 'Meat', 256);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1386, 121, 'Sate Padang Sol', 'Dairy', 788);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1388, 64, 'Sate Meranggi', 'None', 608);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1390, 79, 'Sate Vegetarian', 'Dairy', 372);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1392, 58, 'Sate Padang Dha', 'Dairy', 422);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1394, 47, 'Goulash', 'Dairy', 300);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1396, 61, 'Sate Padang Pes', 'Dairy', 534);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1398, 105, 'Sate Padang', 'Dairy', 91);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1400, 76, 'Ramen', 'Meat', 21);
commit;
prompt 700 records loaded
prompt Loading CUSTOMER...
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (76784, 'Chris Miller', 'chris.mi@hotmail.com', '680 High Riverside N', '628-3754265', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (56477, 'Alex Davis', 'alex.dav@example.com', '237 Maple Greenfield', '413-9079902', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (65687, 'Chris Jones', 'chris.jone@yahoo.com', '187 Broadway Bristol', '703-2911076', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (59374, 'Laura Brown', 'laura.br@outlook.com', '462 Main Springfield', '418-2185103', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (37149, 'Michael Davis', 'michael.@outlook.com', '616 2nd Madison FL', '464-7254100', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (79696, 'Sarah Jones', 'sarah.jo@example.com', '230 Oak Fairview MI', '749-5773304', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (17352, 'Emily Moore', 'emily.mo@example.com', '536 2nd Madison GA', '213-6238357', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91393, 'Sarah Davis', 'sarah.davi@gmail.com', '940 3rd Bristol GA', '925-8928440', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (56199, 'Katie Wilson', 'katie.wi@outlook.com', '117 2nd Fairview CA', '499-3533741', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (68339, 'Chris Davis', 'chris.davi@gmail.com', '948 3rd Springfield ', '773-2229995', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (37588, 'Jane Jones', 'jane.jon@hotmail.com', '577 Cedar Bristol MI', '467-9936932', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (10744, 'Emily Taylor', 'emily.tayl@yahoo.com', '821 Oak Clinton FL', '973-4339439', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (89204, 'John Brown', 'john.bro@outlook.com', '318 Main Georgetown ', '157-5465081', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (1808, 'Michael Wilson', 'michael.@outlook.com', '969 High Greenville ', '184-4587140', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (32075, 'Alex Jones', 'alex.jon@example.com', '626 2nd Springfield ', '393-5183207', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (69827, 'David Miller', 'david.mi@example.com', '729 Oak Bristol TX', '559-3214137', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (22818, 'Laura Moore', 'laura.mo@hotmail.com', '722 Elm Greenville F', '107-7699389', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (30106, 'Laura Smith', 'laura.sm@example.com', '328 2nd Greenville F', '667-7284259', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (43410, 'Chris Wilson', 'chris.wi@hotmail.com', '671 2nd Madison TX', '504-1245948', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (65489, 'Emily Brown', 'emily.br@hotmail.com', '325 Main Bristol NY', '897-5529802', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (689, 'David Miller', 'david.mill@gmail.com', '925 Pine Madison TX', '641-4297856', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (7961, 'David Moore', 'david.moor@gmail.com', '974 Oak Clinton FL', '972-4931089', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (78711, 'Sarah Miller', 'sarah.mill@gmail.com', '926 Elm Greenville O', '773-1767196', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (69306, 'Laura Williams', 'laura.wi@hotmail.com', '312 3rd Riverside GA', '735-3148708', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (92207, 'John Miller', 'john.mil@hotmail.com', '140 Cedar Riverside ', '200-4955673', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (19682, 'Katie Moore', 'katie.moor@yahoo.com', '743 Maple Greenville', '837-7784397', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (21008, 'Sarah Johnson', 'sarah.john@gmail.com', '958 Pine Franklin NC', '202-2814612', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (44605, 'Katie Miller', 'katie.mill@gmail.com', '632 High Bristol GA', '493-9427433', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (33796, 'Alex Johnson', 'alex.joh@example.com', '683 3rd Fairview TX', '899-4834016', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (72636, 'Laura Williams', 'laura.wi@outlook.com', '229 3rd Clinton IL', '853-4227521', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (27070, 'Sarah Brown', 'sarah.brow@yahoo.com', '552 3rd Fairview NC', '864-3377763', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (27971, 'Sarah Taylor', 'sarah.ta@example.com', '543 Elm Georgetown N', '805-8386908', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (96613, 'David Moore', 'david.mo@example.com', '782 Main Fairview IL', '951-5316785', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (64137, 'Katie Brown', 'katie.br@hotmail.com', '377 Oak Georgetown I', '266-1551215', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (17421, 'Chris Jones', 'chris.jo@example.com', '521 Oak Riverside FL', '986-5161204', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (15424, 'Laura Moore', 'laura.moor@gmail.com', '396 Cedar Georgetown', '882-2237103', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (61528, 'Laura Davis', 'laura.da@hotmail.com', '360 High Madison IL', '406-1283019', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (94944, 'Sarah Taylor', 'sarah.tayl@yahoo.com', '458 Cedar Fairview G', '973-2777486', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (93334, 'Chris Miller', 'chris.mi@outlook.com', '278 3rd Greenfield O', '383-3673109', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (21318, 'Emily Williams', 'emily.wi@outlook.com', '188 Oak Madison IL', '852-7594221', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (66276, 'Chris Johnson', 'chris.john@gmail.com', '360 Oak Springfield ', '950-7678486', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (61363, 'Laura Moore', 'laura.moor@gmail.com', '132 High Greenfield ', '348-4438180', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (4304, 'David Smith', 'david.sm@hotmail.com', '290 Elm Madison GA', '401-3923552', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (57300, 'Sarah Wilson', 'sarah.wils@yahoo.com', '660 Oak Georgetown N', '270-3372375', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (3131, 'John Wilson', 'john.wil@outlook.com', '408 3rd Bristol NY', '840-4338673', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (95704, 'Katie Wilson', 'katie.wi@example.com', '337 High Greenville ', '450-1683456', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42102, 'Chris Moore', 'chris.mo@hotmail.com', '619 Elm Greenfield N', '850-8827373', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (38753, 'Sarah Davis', 'sarah.da@example.com', '849 High Greenville ', '978-6385337', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (21210, 'Katie Jones', 'katie.jo@outlook.com', '181 High Madison PA', '458-7673277', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (25113, 'Michael Miller', 'michael.@hotmail.com', '568 2nd Greenville I', '524-6066247', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (94272, 'Chris Moore', 'chris.mo@outlook.com', '381 Broadway Riversi', '529-7171379', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (37101, 'Michael Davis', 'michael.da@gmail.com', '561 2nd Greenville P', '772-2579343', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (84726, 'Laura Davis', 'laura.davi@yahoo.com', '282 Maple Franklin C', '976-5444144', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (75891, 'Emily Jones', 'emily.jone@yahoo.com', '606 Oak Clinton PA', '958-1898720', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (44678, 'Chris Smith', 'chris.sm@example.com', '253 Oak Springfield ', '927-2564046', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (63084, 'Jane Williams', 'jane.wil@outlook.com', '455 Cedar Fairview C', '807-1027049', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (41976, 'Katie Williams', 'katie.will@gmail.com', '115 Main Springfield', '831-9575658', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (34839, 'Emily Smith', 'emily.sm@example.com', '829 Oak Greenville P', '816-8735213', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (76036, 'John Brown', 'john.brown@gmail.com', '495 Pine Madison TX', '544-1093082', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42201, 'Laura Davis', 'laura.davi@yahoo.com', '918 Oak Springfield ', '628-8901427', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (92025, 'Alex Miller', 'alex.mil@example.com', '448 Maple Georgetown', '497-1283398', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (95197, 'Emily Williams', 'emily.wi@hotmail.com', '103 2nd Greenville M', '705-7992508', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (19683, 'Chris Miller', 'chris.mi@hotmail.com', '103 Pine Springfield', '551-9825490', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (8778, 'Michael Brown', 'michael.br@yahoo.com', '133 Pine Springfield', '676-6266229', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (45593, 'Chris Davis', 'chris.da@outlook.com', '712 3rd Fairview TX', '261-2937270', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (24008, 'Sarah Taylor', 'sarah.ta@example.com', '589 Cedar Greenville', '816-3723627', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (82096, 'Chris Smith', 'chris.sm@example.com', '609 Pine Springfield', '889-7646629', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (88114, 'Michael Smith', 'michael.@example.com', '514 3rd Georgetown N', '971-5698084', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (39213, 'Emily Williams', 'emily.wi@example.com', '921 Pine Georgetown ', '347-1545258', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (26024, 'Alex Moore', 'alex.moo@example.com', '454 Pine Fairview OH', '296-2236961', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (36377, 'Emily Wilson', 'emily.wi@hotmail.com', '185 2nd Greenville F', '444-4303948', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (64909, 'Katie Johnson', 'katie.jo@example.com', '888 3rd Bristol MI', '280-3059689', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (78122, 'Michael Taylor', 'michael.@example.com', '824 Maple Springfiel', '639-2048976', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (65557, 'Alex Moore', 'alex.moore@gmail.com', '241 Elm Fairview TX', '304-8002578', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (32912, 'Jane Taylor', 'jane.taylo@gmail.com', '267 High Franklin NC', '334-7089852', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (63004, 'Laura Taylor', 'laura.ta@hotmail.com', '484 Broadway Georget', '857-9687288', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (59705, 'Chris Miller', 'chris.mill@gmail.com', '226 Maple Clinton PA', '118-2991768', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (61882, 'Alex Miller', 'alex.mil@example.com', '250 Main Greenfield ', '405-6282425', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97861, 'Alex Davis', 'alex.davis@gmail.com', '603 High Greenfield ', '756-8941882', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (92450, 'Jane Brown', 'jane.brown@yahoo.com', '166 Elm Clinton OH', '755-3477448', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (36098, 'Laura Taylor', 'laura.tayl@yahoo.com', '385 Broadway Bristol', '744-2035160', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (51737, 'Katie Moore', 'katie.mo@example.com', '589 2nd Bristol GA', '619-6692694', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (16425, 'Emily Brown', 'emily.br@example.com', '500 2nd Franklin TX', '352-9067451', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (19416, 'Emily Moore', 'emily.mo@hotmail.com', '971 Main Georgetown ', '191-9935580', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (11541, 'Chris Smith', 'chris.sm@hotmail.com', '933 Elm Franklin TX', '870-4296518', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (85019, 'David Williams', 'david.wi@example.com', '385 High Fairview MI', '147-4639829', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (14323, 'John Jones', 'john.jon@hotmail.com', '502 Maple Franklin T', '369-9516322', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (70323, 'Sarah Davis', 'sarah.davi@gmail.com', '766 Cedar Madison IL', '563-9112019', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (41634, 'Jane Smith', 'jane.smith@yahoo.com', '863 3rd Fairview OH', '898-7884126', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42636, 'Katie Williams', 'katie.wi@hotmail.com', '198 2nd Fairview MI', '535-6993688', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (62025, 'John Jones', 'john.jon@hotmail.com', '371 Oak Georgetown O', '939-5788288', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (29964, 'Katie Miller', 'katie.mi@hotmail.com', '801 Oak Bristol GA', '404-3009407', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (11050, 'Sarah Moore', 'sarah.mo@outlook.com', '737 Main Georgetown ', '454-5975413', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (14382, 'Katie Wilson', 'katie.wi@outlook.com', '725 Main Springfield', '702-5164666', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (54325, 'David Taylor', 'david.tayl@gmail.com', '794 Pine Greenville ', '198-6586291', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (22674, 'Sarah Miller', 'sarah.mi@outlook.com', '574 Main Fairview MI', '795-3477730', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (37772, 'Alex Brown', 'alex.brown@yahoo.com', '877 Cedar Greenville', '887-4315586', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (26035, 'John Davis', 'john.dav@outlook.com', '985 Cedar Madison PA', '623-1937204', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (28759, 'Jane Davis', 'jane.dav@outlook.com', '944 Elm Greenfield N', '117-1757880', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (26650, 'Emily Davis', 'emily.da@outlook.com', '778 Maple Springfiel', '109-3199555', 'Bit');
commit;
prompt 100 records committed...
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (30132, 'Laura Johnson', 'laura.jo@outlook.com', '886 Elm Clinton PA', '304-6206327', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97677, 'Emily Smith', 'emily.smit@gmail.com', '779 Cedar Franklin G', '394-5454992', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (15512, 'Chris Moore', 'chris.mo@example.com', '189 Pine Greenville ', '276-5936964', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (70360, 'Katie Johnson', 'katie.jo@outlook.com', '637 Elm Georgetown O', '584-8323027', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (57091, 'Jane Williams', 'jane.willi@yahoo.com', '545 3rd Fairview IL', '650-6803421', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (21621, 'Chris Miller', 'chris.mi@outlook.com', '130 Maple Greenville', '846-7197817', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (34822, 'Jane Jones', 'jane.jon@hotmail.com', '547 Pine Georgetown ', '405-2416525', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (98425, 'David Brown', 'david.brow@gmail.com', '857 Broadway Frankli', '212-2165218', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (69795, 'Laura Taylor', 'laura.ta@outlook.com', '341 Oak Madison CA', '861-9075734', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (5421, 'Jane Taylor', 'jane.taylo@gmail.com', '437 Cedar Georgetown', '331-4116953', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (54553, 'John Williams', 'john.willi@gmail.com', '126 Pine Franklin PA', '792-9002023', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (7915, 'Laura Smith', 'laura.sm@outlook.com', '926 Maple Georgetown', '466-8275181', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (40098, 'Michael Smith', 'michael.@example.com', '544 Maple Fairview N', '211-4268749', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (71464, 'Katie Davis', 'katie.davi@gmail.com', '520 Elm Riverside IL', '518-9174557', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (6990, 'Katie Brown', 'katie.br@example.com', '595 Main Clinton GA', '715-7504238', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (21876, 'Emily Taylor', 'emily.ta@example.com', '114 3rd Clinton CA', '538-6266611', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (73696, 'John Taylor', 'john.tay@hotmail.com', '398 Cedar Greenville', '316-4356077', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (60059, 'Michael Jones', 'michael.@example.com', '601 High Madison FL', '151-7005896', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (969, 'Chris Smith', 'chris.smit@gmail.com', '764 Elm Greenfield T', '712-1707642', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (65479, 'Emily Miller', 'emily.mi@hotmail.com', '142 Oak Clinton NC', '342-7295959', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (25581, 'David Moore', 'david.moor@gmail.com', '716 Oak Fairview OH', '547-6274084', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (61931, 'Chris Davis', 'chris.da@hotmail.com', '750 High Clinton GA', '643-3661921', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (73319, 'Katie Williams', 'katie.will@gmail.com', '893 High Greenfield ', '684-2966566', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (37976, 'Alex Moore', 'alex.moore@gmail.com', '525 Oak Madison TX', '766-3226203', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (93754, 'John Williams', 'john.willi@yahoo.com', '177 Pine Clinton OH', '959-6055972', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (9612, 'Emily Taylor', 'emily.tayl@gmail.com', '303 Elm Greenfield M', '319-6111245', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (39925, 'Chris Davis', 'chris.da@example.com', '165 Broadway Greenvi', '781-8884765', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (86783, 'David Miller', 'david.mi@example.com', '300 Pine Franklin GA', '799-5728771', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42806, 'Alex Williams', 'alex.willi@gmail.com', '328 Elm Clinton NY', '240-4004152', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (30174, 'David Taylor', 'david.ta@hotmail.com', '340 Cedar Springfiel', '862-6169102', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (78485, 'Michael Brown', 'michael.br@yahoo.com', '509 Oak Georgetown G', '711-5901997', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (62576, 'Michael Davis', 'michael.da@gmail.com', '443 2nd Georgetown O', '488-6574512', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (63036, 'Michael Jones', 'michael.@hotmail.com', '305 3rd Madison MI', '277-7004890', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (48677, 'Jane Smith', 'jane.smi@example.com', '286 Pine Springfield', '777-1394117', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (64901, 'Katie Moore', 'katie.mo@outlook.com', '259 Oak Franklin GA', '417-6068810', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (47026, 'Chris Davis', 'chris.davi@gmail.com', '798 Cedar Madison NY', '241-1552438', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (55688, 'Jane Brown', 'jane.bro@hotmail.com', '117 Pine Greenfield ', '572-6319127', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (86943, 'Emily Johnson', 'emily.jo@hotmail.com', '483 Elm Georgetown O', '252-2541542', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (63220, 'Laura Taylor', 'laura.ta@hotmail.com', '952 3rd Georgetown N', '774-1826438', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (69825, 'Jane Brown', 'jane.brown@gmail.com', '407 High Georgetown ', '101-5229522', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (61000, 'Emily Williams', 'emily.wi@hotmail.com', '895 Elm Georgetown O', '264-4624539', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (84191, 'Laura Jones', 'laura.jo@hotmail.com', '344 3rd Bristol PA', '486-7788483', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (96987, 'John Williams', 'john.wil@example.com', '769 3rd Georgetown P', '296-4855439', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (35942, 'John Johnson', 'john.joh@example.com', '230 Broadway Frankli', '166-5755318', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (66975, 'Michael Jones', 'michael.jo@gmail.com', '728 Maple Springfiel', '125-6479907', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (84609, 'John Brown', 'john.brown@yahoo.com', '911 Main Springfield', '181-8298878', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (68534, 'Emily Moore', 'emily.mo@example.com', '129 Broadway Greenfi', '901-2665646', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (66224, 'Emily Miller', 'emily.mi@example.com', '672 Main Springfield', '282-2688044', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (74286, 'Jane Williams', 'jane.willi@yahoo.com', '269 Broadway Frankli', '440-9098668', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (52324, 'David Brown', 'david.br@example.com', '384 3rd Clinton PA', '587-8604042', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (71391, 'Katie Moore', 'katie.mo@outlook.com', '315 High Georgetown ', '400-3815204', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91873, 'Alex Johnson', 'alex.joh@hotmail.com', '550 Main Greenfield ', '522-8081371', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (79361, 'Katie Williams', 'katie.wi@example.com', '213 Main Riverside P', '550-7511276', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (39945, 'John Brown', 'john.bro@outlook.com', '235 Pine Madison CA', '436-9264337', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (93298, 'Katie Jones', 'katie.jo@outlook.com', '933 Broadway Greenfi', '624-6472791', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (11706, 'Laura Brown', 'laura.br@outlook.com', '746 2nd Fairview NY', '382-4681095', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (1067, 'Katie Taylor', 'katie.ta@hotmail.com', '322 Pine Greenfield ', '252-7183804', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (69664, 'Alex Wilson', 'alex.wilso@yahoo.com', '918 Elm Georgetown T', '343-5918073', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (79861, 'John Brown', 'john.brown@gmail.com', '122 Oak Springfield ', '366-5374829', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (15681, 'Sarah Moore', 'sarah.moor@yahoo.com', '774 Cedar Greenville', '584-9525982', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (81596, 'Emily Brown', 'emily.br@hotmail.com', '673 Cedar Greenville', '561-8913519', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (8358, 'Chris Taylor', 'chris.ta@hotmail.com', '721 Main Franklin OH', '487-4362221', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (62454, 'Michael Jones', 'michael.jo@gmail.com', '795 Elm Madison NC', '854-1817479', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (47195, 'Jane Davis', 'jane.dav@outlook.com', '834 Broadway Clinton', '808-9288402', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (3305, 'John Johnson', 'john.johns@gmail.com', '839 Elm Greenville N', '272-7694227', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (20720, 'Jane Johnson', 'jane.joh@outlook.com', '578 Pine Fairview PA', '696-4353335', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (57611, 'Jane Moore', 'jane.moo@hotmail.com', '507 3rd Springfield ', '299-5322274', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (26189, 'Emily Jones', 'emily.jo@example.com', '244 Elm Bristol IL', '747-1244794', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (33040, 'Katie Miller', 'katie.mill@yahoo.com', '979 2nd Greenfield C', '299-2474396', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (49645, 'Sarah Smith', 'sarah.sm@example.com', '837 Pine Fairview CA', '859-2905573', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (55703, 'Alex Moore', 'alex.moore@gmail.com', '500 Elm Greenville T', '632-2388548', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (54590, 'Michael Wilson', 'michael.wi@yahoo.com', '282 Pine Bristol TX', '799-7762339', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (51101, 'Sarah Miller', 'sarah.mill@yahoo.com', '928 Pine Madison OH', '210-3775555', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97930, 'Jane Taylor', 'jane.taylo@yahoo.com', '541 Pine Springfield', '345-3082846', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (24115, 'Sarah Johnson', 'sarah.jo@hotmail.com', '904 Pine Clinton IL', '830-3369935', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (2526, 'Jane Jones', 'jane.jon@example.com', '531 Main Riverside M', '227-4001302', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (87841, 'Emily Moore', 'emily.moor@gmail.com', '312 3rd Franklin PA', '375-3139332', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (55531, 'Jane Wilson', 'jane.wilso@gmail.com', '397 Oak Greenville C', '380-5257069', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (21291, 'John Moore', 'john.moo@hotmail.com', '169 Main Bristol TX', '607-2974445', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (45017, 'Emily Moore', 'emily.mo@hotmail.com', '113 High Franklin MI', '172-3018264', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (44681, 'John Johnson', 'john.johns@gmail.com', '316 3rd Franklin TX', '927-1677900', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (22555, 'Michael Taylor', 'michael.ta@gmail.com', '126 Elm Springfield ', '255-5309341', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (4048, 'Katie Wilson', 'katie.wi@example.com', '844 Elm Riverside IL', '424-2818860', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (73599, 'Sarah Brown', 'sarah.brow@gmail.com', '790 3rd Georgetown F', '940-1307058', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97929, 'Chris Smith', 'chris.sm@hotmail.com', '920 Oak Greenfield O', '629-5141950', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (5324, 'Jane Smith', 'jane.smi@hotmail.com', '106 3rd Greenville T', '466-6626642', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (86659, 'Sarah Davis', 'sarah.da@hotmail.com', '870 Elm Madison NY', '440-6727736', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (93405, 'Chris Jones', 'chris.jone@gmail.com', '391 High Riverside N', '256-1139885', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (28182, 'John Davis', 'john.davis@yahoo.com', '985 2nd Springfield ', '959-9915687', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (88664, 'Katie Miller', 'katie.mill@gmail.com', '595 Cedar Madison PA', '885-9211107', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (83181, 'Emily Johnson', 'emily.jo@example.com', '257 Elm Greenville I', '142-4098209', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (90416, 'Michael Smith', 'michael.sm@gmail.com', '877 3rd Riverside FL', '326-1711824', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (22498, 'Laura Wilson', 'laura.wils@gmail.com', '162 Maple Springfiel', '111-4676734', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (98467, 'Katie Miller', 'katie.mi@hotmail.com', '463 Main Georgetown ', '813-6464142', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91694, 'Jane Miller', 'jane.mil@hotmail.com', '449 2nd Fairview NY', '364-8474032', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (57213, 'Katie Taylor', 'katie.tayl@yahoo.com', '152 3rd Greenville I', '707-5134390', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (82702, 'Emily Jones', 'emily.jo@outlook.com', '417 Pine Fairview PA', '396-5367149', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (79147, 'Jane Johnson', 'jane.joh@hotmail.com', '967 High Madison MI', '827-1985393', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (54956, 'Emily Taylor', 'emily.ta@hotmail.com', '736 Elm Springfield ', '329-8871782', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91928, 'John Brown', 'john.bro@outlook.com', '961 Oak Franklin MI', '645-9018307', 'Bit');
commit;
prompt 200 records committed...
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (31638, 'Chris Williams', 'chris.wi@hotmail.com', '666 Cedar Georgetown', '477-8939664', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91445, 'Chris Williams', 'chris.will@yahoo.com', '256 High Greenville ', '580-4328093', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (74187, 'Alex Johnson', 'alex.joh@outlook.com', '639 High Clinton GA', '889-4081060', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (71975, 'David Johnson', 'david.john@gmail.com', '481 2nd Franklin GA', '334-7597333', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (85098, 'Alex Smith', 'alex.smi@outlook.com', '500 Broadway Fairvie', '386-4234125', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (29702, 'David Moore', 'david.moor@gmail.com', '701 Broadway Fairvie', '673-8748860', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (18702, 'Sarah Taylor', 'sarah.ta@hotmail.com', '997 Main Clinton TX', '337-9995398', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (63489, 'Emily Miller', 'emily.mi@example.com', '880 Maple Springfiel', '158-7992149', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (11713, 'Michael Smith', 'michael.@example.com', '717 Elm Riverside TX', '518-3643990', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (25980, 'Katie Davis', 'katie.davi@yahoo.com', '131 Cedar Greenfield', '875-3419793', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (94578, 'David Taylor', 'david.tayl@gmail.com', '678 3rd Springfield ', '713-4104557', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (41762, 'Sarah Miller', 'sarah.mill@yahoo.com', '492 3rd Springfield ', '436-5929666', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (7029, 'Emily Williams', 'emily.will@yahoo.com', '778 Maple Greenfield', '397-4195544', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (96382, 'Alex Taylor', 'alex.tay@outlook.com', '957 Main Fairview PA', '163-5823845', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (33584, 'Katie Brown', 'katie.br@example.com', '331 3rd Madison IL', '743-8999983', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (16596, 'Katie Wilson', 'katie.wils@yahoo.com', '492 High Clinton NY', '600-6805545', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (67227, 'Alex Johnson', 'alex.joh@example.com', '556 Cedar Madison FL', '714-1332627', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (58806, 'Chris Miller', 'chris.mi@example.com', '218 Pine Franklin MI', '648-9071860', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (57243, 'Emily Wilson', 'emily.wi@hotmail.com', '728 Elm Fairview IL', '591-2307588', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (64193, 'David Miller', 'david.mill@gmail.com', '199 Oak Clinton TX', '163-1117571', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (19348, 'Chris Johnson', 'chris.john@gmail.com', '186 Pine Madison CA', '506-6388662', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (66299, 'Michael Smith', 'michael.@example.com', '510 Broadway Clinton', '308-5006077', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (77906, 'Alex Jones', 'alex.jones@yahoo.com', '409 Main Clinton TX', '988-6412426', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (16243, 'Michael Smith', 'michael.@example.com', '582 Elm Fairview PA', '309-2558871', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (19936, 'Emily Taylor', 'emily.ta@outlook.com', '965 Elm Clinton PA', '106-3945909', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (50786, 'Emily Moore', 'emily.mo@example.com', '585 Pine Springfield', '940-4561336', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (18952, 'Katie Miller', 'katie.mill@gmail.com', '111 2nd Greenfield O', '855-4844322', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (44652, 'Sarah Miller', 'sarah.mi@hotmail.com', '439 Oak Franklin IL', '536-4992829', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (29478, 'Jane Davis', 'jane.dav@example.com', '159 Cedar Madison MI', '484-8036281', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42377, 'Sarah Brown', 'sarah.brow@gmail.com', '688 High Clinton IL', '733-3289069', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (15217, 'David Davis', 'david.da@outlook.com', '699 Oak Clinton NC', '251-1565707', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (3877, 'Katie Miller', 'katie.mi@example.com', '180 Cedar Riverside ', '449-7618322', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (19080, 'Chris Johnson', 'chris.john@yahoo.com', '533 Pine Franklin NC', '463-2732977', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (82022, 'Chris Jones', 'chris.jo@hotmail.com', '388 Pine Springfield', '518-4197807', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (99958, 'Katie Wilson', 'katie.wi@example.com', '658 Maple Bristol CA', '919-3448806', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97712, 'Laura Brown', 'laura.br@example.com', '539 High Greenville ', '846-3929178', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (60528, 'Alex Johnson', 'alex.joh@outlook.com', '758 Maple Greenfield', '535-7563690', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (71890, 'Laura Williams', 'laura.will@gmail.com', '759 High Madison TX', '944-7698428', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (50747, 'Alex Wilson', 'alex.wilso@gmail.com', '996 Maple Fairview N', '406-7766161', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (64456, 'Alex Brown', 'alex.bro@outlook.com', '498 Maple Greenfield', '890-7139177', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (51223, 'David Smith', 'david.smit@yahoo.com', '760 Broadway Greenvi', '579-7939113', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (74937, 'Emily Taylor', 'emily.ta@outlook.com', '883 Maple Springfiel', '529-1534852', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42953, 'Katie Johnson', 'katie.jo@outlook.com', '382 Elm Greenfield I', '159-6005766', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (70755, 'David Jones', 'david.jone@yahoo.com', '867 Elm Madison NY', '276-3859674', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (3645, 'Chris Miller', 'chris.mi@hotmail.com', '276 Pine Bristol CA', '288-6473149', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (64893, 'Katie Wilson', 'katie.wi@example.com', '576 Cedar Madison NC', '901-2336453', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (41744, 'John Williams', 'john.willi@gmail.com', '618 Oak Fairview TX', '588-8529969', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (84145, 'Jane Williams', 'jane.wil@outlook.com', '241 3rd Greenfield P', '468-7186753', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (10215, 'Jane Smith', 'jane.smith@gmail.com', '555 Elm Greenfield I', '953-3719662', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (23284, 'Chris Taylor', 'chris.ta@example.com', '892 3rd Georgetown P', '218-1759549', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (5810, 'Sarah Miller', 'sarah.mill@gmail.com', '964 Maple Madison PA', '859-7539095', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (46454, 'Chris Davis', 'chris.da@hotmail.com', '946 2nd Greenfield T', '644-8928678', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (37844, 'Alex Miller', 'alex.mil@example.com', '402 Pine Riverside P', '315-2132540', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (46523, 'Sarah Taylor', 'sarah.ta@hotmail.com', '302 Cedar Madison GA', '172-4841790', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (62962, 'Jane Johnson', 'jane.joh@example.com', '254 Pine Franklin CA', '651-6138480', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (647, 'John Moore', 'john.moore@yahoo.com', '585 3rd Franklin NY', '140-2689837', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (86505, 'Chris Taylor', 'chris.ta@outlook.com', '904 Broadway Georget', '726-5338436', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (79427, 'Emily Miller', 'emily.mi@hotmail.com', '506 2nd Georgetown P', '989-5265854', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (11110, 'Katie Smith', 'katie.smit@yahoo.com', '493 Pine Bristol TX', '288-2565545', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91311, 'Michael Brown', 'michael.@hotmail.com', '199 Pine Madison PA', '583-5607592', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (70061, 'Katie Smith', 'katie.smit@yahoo.com', '588 Cedar Madison NC', '573-2783146', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (67425, 'Laura Moore', 'laura.mo@example.com', '889 Main Springfield', '445-8765859', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (38940, 'David Miller', 'david.mill@gmail.com', '105 Pine Greenville ', '753-8485671', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (82382, 'David Johnson', 'david.jo@example.com', '594 High Springfield', '119-5656340', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (6133, 'Michael Miller', 'michael.mi@gmail.com', '541 3rd Greenville I', '451-5065082', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (92239, 'Laura Smith', 'laura.sm@hotmail.com', '805 Broadway Greenvi', '774-7496277', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (38357, 'Jane Jones', 'jane.jon@outlook.com', '125 Main Fairview CA', '766-2168044', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (24658, 'Sarah Taylor', 'sarah.tayl@gmail.com', '239 3rd Georgetown T', '232-5771717', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (26544, 'Sarah Johnson', 'sarah.john@yahoo.com', '412 Elm Georgetown P', '274-9598147', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (86400, 'Alex Jones', 'alex.jon@outlook.com', '663 Cedar Georgetown', '750-5921122', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (4665, 'Jane Smith', 'jane.smi@hotmail.com', '234 Pine Fairview GA', '919-7097439', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (83675, 'Katie Moore', 'katie.mo@outlook.com', '164 Main Clinton PA', '851-1176416', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42158, 'Sarah Brown', 'sarah.brow@yahoo.com', '744 3rd Fairview NY', '443-2922937', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97144, 'Jane Johnson', 'jane.joh@outlook.com', '206 Cedar Georgetown', '225-9258296', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (27641, 'Chris Smith', 'chris.smit@yahoo.com', '471 High Greenville ', '955-5736933', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (74651, 'Katie Williams', 'katie.wi@outlook.com', '705 High Bristol PA', '119-5846937', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (55303, 'Michael Davis', 'michael.@example.com', '803 High Clinton TX', '772-9043487', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (14244, 'Chris Jones', 'chris.jone@yahoo.com', '711 3rd Greenfield G', '889-8043072', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (32409, 'Laura Moore', 'laura.mo@hotmail.com', '669 Elm Greenville F', '329-5891605', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (36176, 'Alex Taylor', 'alex.tay@example.com', '798 Broadway Riversi', '860-2124322', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (37209, 'Katie Brown', 'katie.br@hotmail.com', '477 Main Clinton NY', '659-2102763', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97912, 'Laura Smith', 'laura.sm@example.com', '685 Broadway Frankli', '717-6479085', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (72048, 'John Johnson', 'john.joh@outlook.com', '636 Elm Springfield ', '695-4635260', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (18219, 'Michael Moore', 'michael.mo@yahoo.com', '983 Maple Madison CA', '496-7241046', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (53393, 'Jane Jones', 'jane.jon@example.com', '996 Main Bristol IL', '869-9595358', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (71521, 'Sarah Moore', 'sarah.moor@gmail.com', '456 Cedar Springfiel', '485-9292141', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (60222, 'Alex Smith', 'alex.smi@hotmail.com', '945 2nd Franklin IL', '423-6402263', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (4820, 'Michael Johnson', 'michael.@outlook.com', '529 2nd Greenfield M', '960-9447014', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (1828, 'John Davis', 'john.dav@example.com', '640 3rd Springfield ', '445-1257717', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (10344, 'Alex Moore', 'alex.moo@outlook.com', '781 Elm Franklin NY', '400-6857959', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (87977, 'Alex Wilson', 'alex.wil@outlook.com', '549 Cedar Springfiel', '421-3678665', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (10721, 'Sarah Wilson', 'sarah.wi@outlook.com', '360 2nd Springfield ', '607-7729924', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (71500, 'Michael Johnson', 'michael.@hotmail.com', '910 Maple Clinton PA', '415-4434459', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (38391, 'Laura Wilson', 'laura.wi@outlook.com', '235 Maple Madison OH', '335-1767479', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (50594, 'Sarah Smith', 'sarah.sm@example.com', '102 2nd Georgetown N', '164-8706773', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (94309, 'Sarah Wilson', 'sarah.wi@hotmail.com', '263 Main Bristol CA', '247-3863078', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (52106, 'Chris Miller', 'chris.mi@hotmail.com', '866 3rd Georgetown M', '703-6301852', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (48566, 'Laura Miller', 'laura.mi@hotmail.com', '362 2nd Franklin TX', '987-8465870', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (49187, 'Michael Brown', 'michael.br@yahoo.com', '128 Oak Greenfield N', '121-2207751', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (92453, 'Emily Williams', 'emily.will@gmail.com', '897 Oak Clinton NC', '232-1634107', 'Bit');
commit;
prompt 300 records committed...
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (95931, 'Laura Miller', 'laura.mi@outlook.com', '608 High Greenville ', '742-6902562', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (84712, 'Laura Williams', 'laura.wi@hotmail.com', '843 Broadway Madison', '169-9063898', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (9437, 'Michael Taylor', 'michael.@example.com', '561 2nd Springfield ', '484-9183993', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (44275, 'Jane Johnson', 'jane.joh@example.com', '592 Oak Fairview GA', '102-1379332', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (68611, 'Chris Moore', 'chris.moor@yahoo.com', '130 2nd Springfield ', '897-9084615', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (80481, 'Sarah Davis', 'sarah.da@example.com', '991 Main Georgetown ', '129-2762380', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (86150, 'Katie Johnson', 'katie.john@yahoo.com', '844 Oak Greenfield N', '109-1937711', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (72700, 'David Taylor', 'david.tayl@yahoo.com', '774 Broadway Madison', '839-1637680', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (80219, 'Chris Jones', 'chris.jo@outlook.com', '781 3rd Franklin TX', '177-8787376', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (25370, 'Sarah Miller', 'sarah.mill@yahoo.com', '980 Cedar Bristol NY', '717-3767543', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (33470, 'Laura Taylor', 'laura.tayl@yahoo.com', '712 Elm Fairview OH', '972-4595434', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (11020, 'Jane Moore', 'jane.moo@example.com', '215 Elm Franklin TX', '914-3367868', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (27133, 'Emily Miller', 'emily.mi@example.com', '941 Oak Bristol NY', '439-4839567', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (49215, 'Katie Miller', 'katie.mill@gmail.com', '314 3rd Georgetown N', '485-2818773', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (77193, 'John Jones', 'john.jones@gmail.com', '499 Elm Springfield ', '401-1502488', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (72669, 'Laura Jones', 'laura.jo@outlook.com', '968 Pine Springfield', '600-2593051', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (80825, 'David Taylor', 'david.tayl@gmail.com', '104 Broadway Madison', '484-9649907', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (22904, 'Jane Taylor', 'jane.tay@outlook.com', '449 3rd Franklin TX', '804-5706725', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (45268, 'Jane Brown', 'jane.brown@gmail.com', '516 Main Madison PA', '461-3065078', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (55374, 'Chris Brown', 'chris.br@outlook.com', '765 Cedar Greenfield', '865-1196841', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (5630, 'Michael Jones', 'michael.@hotmail.com', '408 2nd Greenville N', '444-2858787', 'Bit');
commit;
prompt 321 records loaded
prompt Loading THE_ORDER...
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28283, 1000000, to_date('29-08-2023', 'dd-mm-yyyy'), '58 Rains Blvd', '995-4963084', 18219);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (82852, 5113651, to_date('07-03-2021', 'dd-mm-yyyy'), '31 Harris', '995-4889461', 73696);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (66529, 1000000, to_date('07-09-2022', 'dd-mm-yyyy'), '93rd Street', '762-3802611', 97712);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (80048, 774873, to_date('14-03-2022', 'dd-mm-yyyy'), '68 Sylvester Drive', '522-4865122', 91311);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (2114, 5271254, to_date('11-08-2020', 'dd-mm-yyyy'), '94 O''Connor Ave', '736-2919258', 92450);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81540, 1000000, to_date('16-07-2023', 'dd-mm-yyyy'), '81 DiFranco Street', '350-1071802', 58806);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (16969, 1000000, to_date('11-06-2023', 'dd-mm-yyyy'), '500 Katie Street', '610-4464147', 52106);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (2533, 1000000, to_date('21-04-2023', 'dd-mm-yyyy'), '65 New Hope Road', '907-3335966', 93405);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (66973, 1000000, to_date('28-02-2021', 'dd-mm-yyyy'), '315 Frederiksberg Ro', '633-6101038', 3645);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (33352, 6760835, to_date('21-03-2023', 'dd-mm-yyyy'), '441 Wolf Drive', '695-9932510', 86783);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (61383, 6128358, to_date('04-12-2022', 'dd-mm-yyyy'), '33 Vassar Road', '245-9850195', 63004);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (11223, 8198249, to_date('06-02-2021', 'dd-mm-yyyy'), '99 Mariano Comense A', '803-9540975', 59374);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (59136, 1000000, to_date('02-12-2023', 'dd-mm-yyyy'), '63rd Street', '933-4989917', 11713);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (87178, 1407192, to_date('08-09-2022', 'dd-mm-yyyy'), '50 Bad Oeynhausen St', '364-8032812', 84191);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (66539, 1000000, to_date('21-02-2022', 'dd-mm-yyyy'), '93rd Street', '152-6390629', 44605);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (2812, 1000000, to_date('03-03-2023', 'dd-mm-yyyy'), '72 Janeane Drive', '672-7207503', 23284);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10259, 7714557, to_date('16-07-2020', 'dd-mm-yyyy'), '66 Omaha Drive', '602-6796847', 16243);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (51130, 3793171, to_date('16-02-2024', 'dd-mm-yyyy'), '91 Burke Road', '132-5650871', 3131);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (14559, 1000000, to_date('13-12-2020', 'dd-mm-yyyy'), '6 Talvin Street', '257-1692772', 94944);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (67327, 1000000, to_date('20-09-2022', 'dd-mm-yyyy'), '96 Kier Drive', '895-2469230', 18702);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (90574, 1000000, to_date('27-10-2021', 'dd-mm-yyyy'), '33 Trevino Drive', '329-1616267', 63220);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (36202, 1000000, to_date('07-09-2020', 'dd-mm-yyyy'), '50 Lippetal Blvd', '978-9954373', 21318);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (49131, 1000000, to_date('05-08-2020', 'dd-mm-yyyy'), '50 Porto alegre Stre', '263-9279472', 61882);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (63965, 9464071, to_date('24-09-2020', 'dd-mm-yyyy'), '3 Elizabeth Street', '529-7520686', 71391);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (97566, 1000000, to_date('29-04-2023', 'dd-mm-yyyy'), '45 Winans Road', '888-1864310', 37209);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (21754, 1000000, to_date('27-10-2020', 'dd-mm-yyyy'), '9 Sugar Hill Street', '485-2075647', 74187);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (78900, 1000000, to_date('15-07-2023', 'dd-mm-yyyy'), '29 Uggams Blvd', '737-1742549', 27971);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (22197, 1843019, to_date('18-06-2022', 'dd-mm-yyyy'), '8 Tampa Blvd', '524-6235850', 39945);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (47843, 1984093, to_date('17-12-2023', 'dd-mm-yyyy'), '2 Fariq Road', '449-5333331', 4665);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10932, 1000000, to_date('10-08-2020', 'dd-mm-yyyy'), '19 Logue Street', '287-2048506', 32409);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (18177, 1000000, to_date('23-11-2020', 'dd-mm-yyyy'), '97 Shand Street', '258-2111295', 16596);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (91407, 1000000, to_date('11-05-2022', 'dd-mm-yyyy'), '85 Hjallerup', '879-4357808', 98467);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (43408, 1000000, to_date('15-02-2024', 'dd-mm-yyyy'), '72nd Street', '145-7741204', 21621);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10356, 3586990, to_date('13-07-2022', 'dd-mm-yyyy'), '28 Drew Drive', '619-8123958', 71521);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28183, 1000000, to_date('17-09-2020', 'dd-mm-yyyy'), '400 Lahr Drive', '413-8641609', 54590);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (34345, 74700, to_date('22-05-2023', 'dd-mm-yyyy'), '44 Ledger Street', '583-8865730', 99958);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (91588, 1000000, to_date('25-04-2022', 'dd-mm-yyyy'), '36 Macy Road', '664-1368715', 25581);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (24369, 1000000, to_date('02-12-2021', 'dd-mm-yyyy'), '347 Alessandria Road', '362-9093990', 88664);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (66102, 1000000, to_date('12-11-2021', 'dd-mm-yyyy'), '18 Kejae City Blvd', '826-7167565', 84726);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (60877, 1000000, to_date('29-08-2022', 'dd-mm-yyyy'), '62 Atlanta Road', '793-5783326', 46454);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (84015, 9755518, to_date('27-09-2021', 'dd-mm-yyyy'), '23 Pleasence', '610-7556358', 65687);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (13698, 1000000, to_date('06-02-2022', 'dd-mm-yyyy'), '92 Spacek Road', '176-7905876', 54956);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (39336, 706326, to_date('23-04-2023', 'dd-mm-yyyy'), '51 Crowe Drive', '963-1984772', 87977);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (57784, 4750077, to_date('04-03-2021', 'dd-mm-yyyy'), '92nd Street', '290-3616022', 15424);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81884, 1000000, to_date('18-07-2022', 'dd-mm-yyyy'), '81 Rita Road', '396-9099843', 55703);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (82274, 5472711, to_date('04-01-2024', 'dd-mm-yyyy'), '65 Li Blvd', '159-2098912', 54325);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (60128, 548851, to_date('19-02-2023', 'dd-mm-yyyy'), '588 Frankfurt am Mai', '990-2781942', 79427);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (34506, 1000000, to_date('06-06-2020', 'dd-mm-yyyy'), '96 Santa Cruz Street', '367-5974747', 9612);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (20547, 1000000, to_date('31-12-2021', 'dd-mm-yyyy'), '61st Street', '225-6452819', 30106);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (38522, 1000000, to_date('09-09-2020', 'dd-mm-yyyy'), '34 Albright Drive', '614-3918022', 64909);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (29984, 1000000, to_date('15-10-2022', 'dd-mm-yyyy'), '60 Haverhill Blvd', '582-7157389', 79147);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (96486, 1000000, to_date('27-11-2020', 'dd-mm-yyyy'), '63rd Street', '506-5041182', 70323);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (72589, 1000000, to_date('30-08-2020', 'dd-mm-yyyy'), '22 Gerald Street', '233-4293709', 7961);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (39025, 1000000, to_date('07-06-2020', 'dd-mm-yyyy'), '13 Frost', '360-1343833', 46523);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (97337, 3874947, to_date('15-09-2020', 'dd-mm-yyyy'), '96 Adkins', '988-9826430', 42953);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (85934, 9332730, to_date('10-06-2023', 'dd-mm-yyyy'), '33 Schlieren Drive', '546-5444306', 83181);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (53565, 1000000, to_date('24-11-2022', 'dd-mm-yyyy'), '20 Tallahassee Drive', '928-9116851', 55703);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (97948, 486562, to_date('07-05-2022', 'dd-mm-yyyy'), '80 Thorton Street', '442-4207896', 61931);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (36094, 1000000, to_date('23-01-2021', 'dd-mm-yyyy'), '88 Ruth Drive', '906-6097266', 38357);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (4421, 152469, to_date('22-01-2022', 'dd-mm-yyyy'), '43 Southampton Stree', '921-3121501', 65489);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (20764, 1000000, to_date('15-08-2021', 'dd-mm-yyyy'), '44 Lisa Blvd', '888-8874699', 63036);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (6926, 4396435, to_date('14-09-2020', 'dd-mm-yyyy'), '89 Macau Ave', '918-7574014', 22555);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (85394, 1000000, to_date('20-07-2020', 'dd-mm-yyyy'), '89 Dupree Ave', '675-1511117', 88114);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (19840, 2701156, to_date('21-12-2023', 'dd-mm-yyyy'), '52 Thurman', '624-5891693', 57243);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81066, 7253204, to_date('05-12-2021', 'dd-mm-yyyy'), '280 Colorado Springs', '738-5834244', 87841);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (38771, 1000000, to_date('10-12-2020', 'dd-mm-yyyy'), '81st Street', '879-9068006', 63036);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (78159, 1000000, to_date('15-09-2021', 'dd-mm-yyyy'), '84 Thurman Road', '951-9404370', 27070);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (91439, 1000000, to_date('03-01-2023', 'dd-mm-yyyy'), '49 Jamal Street', '807-5468148', 69306);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (48609, 255127, to_date('28-05-2022', 'dd-mm-yyyy'), '52nd Street', '668-3012634', 25980);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (85507, 1000000, to_date('23-02-2022', 'dd-mm-yyyy'), '91 Lawrence Drive', '412-5439762', 68611);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (61206, 1000000, to_date('08-07-2021', 'dd-mm-yyyy'), '53 Scaggs Street', '956-2102002', 91873);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (76900, 1376345, to_date('15-10-2021', 'dd-mm-yyyy'), '14 Lake worth Drive', '312-4846282', 74651);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (30593, 1000000, to_date('16-01-2022', 'dd-mm-yyyy'), '12 Horizon Blvd', '241-9448132', 86400);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (83726, 1000000, to_date('28-06-2020', 'dd-mm-yyyy'), '39 Long Island City ', '380-5220497', 60222);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (69316, 787505, to_date('03-02-2024', 'dd-mm-yyyy'), '45 Magnuson Street', '599-5190206', 69306);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (32932, 6548485, to_date('05-11-2023', 'dd-mm-yyyy'), '18 Tisdale Road', '449-5419777', 14382);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10575, 1000000, to_date('17-02-2021', 'dd-mm-yyyy'), '80 Arjona Street', '170-4944212', 55374);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (14188, 1000000, to_date('30-01-2022', 'dd-mm-yyyy'), '21 Lucinda Street', '250-8161309', 1828);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (50866, 1000000, to_date('26-04-2021', 'dd-mm-yyyy'), '81 Green bay Street', '950-8929837', 4304);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (57797, 1000000, to_date('22-01-2022', 'dd-mm-yyyy'), '77 Salt Road', '950-8577494', 97912);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (21459, 194912, to_date('04-07-2021', 'dd-mm-yyyy'), '63 Balaban Drive', '458-9543328', 37844);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (11265, 2085286, to_date('20-05-2021', 'dd-mm-yyyy'), '14 Leimen Drive', '681-1783415', 5421);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (25427, 1000000, to_date('03-08-2022', 'dd-mm-yyyy'), '3 Lennox Road', '675-6110158', 98425);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (57878, 7657944, to_date('01-05-2021', 'dd-mm-yyyy'), '23rd Street', '563-1613378', 56477);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (16942, 4088586, to_date('01-01-2021', 'dd-mm-yyyy'), '76 Leelee Road', '536-5280762', 11110);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (50415, 1749101, to_date('19-12-2021', 'dd-mm-yyyy'), '82 Noseworthy Blvd', '954-8051606', 57300);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (34856, 1000000, to_date('29-09-2022', 'dd-mm-yyyy'), '53rd Street', '652-2352627', 85019);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (86294, 1000000, to_date('01-08-2022', 'dd-mm-yyyy'), '4 Tillis', '965-9871539', 81596);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (24034, 1000000, to_date('09-08-2022', 'dd-mm-yyyy'), '358 Worrell Street', '666-9229049', 18952);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (40181, 9427058, to_date('02-12-2023', 'dd-mm-yyyy'), '68 Luzern Street', '112-8005594', 82702);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (26959, 1386143, to_date('04-09-2021', 'dd-mm-yyyy'), '12 Janice Road', '851-9484789', 44275);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (62607, 1000000, to_date('08-04-2021', 'dd-mm-yyyy'), '91st Street', '540-3634245', 69827);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (29501, 1000000, to_date('30-04-2023', 'dd-mm-yyyy'), '37 Monk Street', '876-1114364', 7029);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (93832, 1000000, to_date('22-11-2021', 'dd-mm-yyyy'), '36 Lisbon', '110-4896953', 80219);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (56170, 319051, to_date('24-07-2021', 'dd-mm-yyyy'), '36 Trejo Drive', '291-2974652', 30132);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (33702, 9231246, to_date('27-12-2020', 'dd-mm-yyyy'), '54 McAnally Drive', '738-3833362', 77193);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (27220, 841115, to_date('29-04-2022', 'dd-mm-yyyy'), '59 Davidson Road', '237-3788833', 86659);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (95415, 1000000, to_date('13-03-2022', 'dd-mm-yyyy'), '63rd Street', '398-4961685', 41762);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (84219, 1000000, to_date('14-11-2020', 'dd-mm-yyyy'), '26 Carlisle Drive', '377-5310447', 15217);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (59106, 1000000, to_date('24-06-2023', 'dd-mm-yyyy'), '86 Bo Drive', '171-4140884', 93298);
commit;
prompt 100 records committed...
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (39006, 1000000, to_date('03-10-2023', 'dd-mm-yyyy'), '56 Noumea Blvd', '279-2397753', 85019);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (89775, 5727267, to_date('20-03-2023', 'dd-mm-yyyy'), '65 Campbell Drive', '602-2797170', 61528);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (54338, 1000000, to_date('25-01-2022', 'dd-mm-yyyy'), '52 Frost Blvd', '780-1457522', 72636);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81115, 1000000, to_date('21-08-2023', 'dd-mm-yyyy'), '68 Karon Ave', '638-6849086', 91873);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10587, 7913289, to_date('10-08-2021', 'dd-mm-yyyy'), '25 Lemmon Ave', '123-2362777', 75891);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (90546, 1528304, to_date('23-11-2021', 'dd-mm-yyyy'), '48 DeGraw Road', '810-2133151', 3877);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (34515, 6843644, to_date('22-09-2020', 'dd-mm-yyyy'), '44 Torino Street', '501-9508643', 30174);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (76831, 7456757, to_date('08-11-2020', 'dd-mm-yyyy'), '23 Kirk', '269-9863474', 64193);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81549, 310961, to_date('28-06-2023', 'dd-mm-yyyy'), '87 Vern Ave', '753-3900576', 45268);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (40788, 1000000, to_date('06-06-2020', 'dd-mm-yyyy'), '61 Taylor Blvd', '408-8478724', 48566);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (67007, 9569081, to_date('18-04-2021', 'dd-mm-yyyy'), '17 Yucca Ave', '427-3032694', 22674);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (565, 1262981, to_date('04-10-2023', 'dd-mm-yyyy'), '64 McLean Road', '896-4720649', 79861);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (25303, 1000000, to_date('06-12-2022', 'dd-mm-yyyy'), '88 Grand-mere Drive', '511-4772023', 88114);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10691, 1000000, to_date('09-11-2020', 'dd-mm-yyyy'), '28 Garry Street', '488-1440045', 9437);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (18748, 10453, to_date('28-07-2023', 'dd-mm-yyyy'), '77 McGovern Drive', '368-3481572', 30106);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (96301, 8303666, to_date('12-11-2022', 'dd-mm-yyyy'), '86 Groton Blvd', '652-3099394', 42201);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (5929, 531498, to_date('02-11-2021', 'dd-mm-yyyy'), '31 Vanessa', '877-7701466', 34839);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (31980, 1000000, to_date('21-07-2021', 'dd-mm-yyyy'), '26 Carradine Ave', '791-3615273', 39213);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (15121, 8473898, to_date('21-09-2021', 'dd-mm-yyyy'), '790 Rickles Street', '941-9484552', 32075);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (60079, 9701636, to_date('06-06-2021', 'dd-mm-yyyy'), '48 Gavin Street', '611-3998270', 51223);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (69961, 1000000, to_date('17-01-2022', 'dd-mm-yyyy'), '30 McAnally Street', '144-4745282', 15217);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (13205, 2873083, to_date('14-11-2023', 'dd-mm-yyyy'), '50 Belles Drive', '371-7468214', 71500);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (14707, 1000000, to_date('16-01-2022', 'dd-mm-yyyy'), '66 Rip Road', '160-9555097', 70755);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (88163, 2451806, to_date('06-08-2023', 'dd-mm-yyyy'), '216 Condition Road', '582-6870571', 33796);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81550, 1000000, to_date('30-05-2021', 'dd-mm-yyyy'), '69 Caine Road', '623-3484993', 92025);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (94582, 1000000, to_date('10-06-2021', 'dd-mm-yyyy'), '4 Levy Street', '428-3753553', 70061);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (94770, 1000000, to_date('18-08-2020', 'dd-mm-yyyy'), '36 Merle Drive', '441-1683855', 27641);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81252, 1000000, to_date('16-04-2022', 'dd-mm-yyyy'), '19 Loring Drive', '424-6537491', 82382);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (86420, 3308944, to_date('16-12-2022', 'dd-mm-yyyy'), '54 Ani Drive', '997-4416153', 33584);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (84163, 1000000, to_date('19-09-2021', 'dd-mm-yyyy'), '98 Rhys-Davies Blvd', '927-6025805', 82022);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (70939, 1000000, to_date('06-07-2023', 'dd-mm-yyyy'), '43 Ludbreg Drive', '169-1019924', 39213);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (63297, 3936941, to_date('06-09-2023', 'dd-mm-yyyy'), '89 LeVar Road', '882-7053707', 21876);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28484, 1000000, to_date('18-03-2022', 'dd-mm-yyyy'), '62 Joli Ave', '760-9591898', 97912);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (20873, 6534852, to_date('02-04-2022', 'dd-mm-yyyy'), '20 Rapaport Street', '484-9340544', 66276);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (86619, 9306684, to_date('25-05-2023', 'dd-mm-yyyy'), '87 Koteas Road', '219-1541334', 59705);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (99877, 9982906, to_date('16-08-2022', 'dd-mm-yyyy'), '35 Stoltz Road', '523-7091364', 90416);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (6819, 3092466, to_date('16-06-2023', 'dd-mm-yyyy'), '44 Rock Blvd', '317-4711247', 2526);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (37096, 1000000, to_date('21-11-2020', 'dd-mm-yyyy'), '40 Jesus Drive', '926-6168456', 54553);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (77933, 1000000, to_date('30-11-2023', 'dd-mm-yyyy'), '614 Woodland Hills R', '675-3080528', 93754);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (17955, 6768899, to_date('23-12-2023', 'dd-mm-yyyy'), '24 McDowall Road', '280-4390796', 36098);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (39372, 9171278, to_date('20-07-2022', 'dd-mm-yyyy'), '642 Karlstad Drive', '428-4646701', 14323);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81604, 1000000, to_date('29-09-2023', 'dd-mm-yyyy'), '73 Helen Street', '854-8702752', 37588);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (40160, 1000000, to_date('21-08-2021', 'dd-mm-yyyy'), '56 Maintenon Ave', '304-3916873', 37209);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (31048, 3896664, to_date('03-08-2023', 'dd-mm-yyyy'), '88 Wong Drive', '602-6485932', 68339);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (76150, 1000000, to_date('23-04-2021', 'dd-mm-yyyy'), '15 Kloten Road', '163-4594794', 25581);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (80904, 1000000, to_date('27-10-2021', 'dd-mm-yyyy'), '20 Dartmouth Drive', '882-7840112', 11541);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10784, 7220444, to_date('22-10-2022', 'dd-mm-yyyy'), '90 St Leonards', '152-3524299', 91694);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (78280, 1000000, to_date('12-06-2022', 'dd-mm-yyyy'), '92 Evett Street', '579-8253952', 57091);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (93930, 1000000, to_date('12-12-2020', 'dd-mm-yyyy'), '348 Edison', '266-9442887', 34822);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (76176, 2480178, to_date('08-11-2020', 'dd-mm-yyyy'), '29 Rupert Drive', '834-3788316', 73319);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (25987, 7197697, to_date('26-02-2022', 'dd-mm-yyyy'), '73 Sorvino Road', '734-9127108', 4820);
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
insert into CONTAIN (quantity, dishs_id, material_id)
values (101264, 392, 251);
insert into CONTAIN (quantity, dishs_id, material_id)
values (177614, 1300, 8468);
commit;
prompt 100 records committed...
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
insert into CONTAIN (quantity, dishs_id, material_id)
values (459900, 182, 777);
insert into CONTAIN (quantity, dishs_id, material_id)
values (331338, 704, 3874);
commit;
prompt 200 records committed...
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
insert into CONTAIN (quantity, dishs_id, material_id)
values (387300, 784, 9355);
insert into CONTAIN (quantity, dishs_id, material_id)
values (356271, 1258, 6360);
commit;
prompt 300 records committed...
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
commit;
prompt 384 records loaded
prompt Loading WORKER...
insert into WORKER (worker_id, workhoures, name, salary)
values (4830, 9, 'Rory Furtado', 11384);
insert into WORKER (worker_id, workhoures, name, salary)
values (4840, 10, 'Pierce Hudson', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4850, 6, 'Gordie Ammons', 14169);
insert into WORKER (worker_id, workhoures, name, salary)
values (4860, 10, 'Natasha Michael', 17568);
insert into WORKER (worker_id, workhoures, name, salary)
values (4870, 12, 'Lupe Nicks', 16376);
insert into WORKER (worker_id, workhoures, name, salary)
values (4880, 12, 'Crystal Loeb', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4890, 10, 'Teena Barnett', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4900, 9, 'Amanda Penders', 10588);
insert into WORKER (worker_id, workhoures, name, salary)
values (4910, 5, 'Daniel Pastore', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4920, 10, 'Lauren Peniston', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4930, 12, 'Benjamin Navarr', 9666);
insert into WORKER (worker_id, workhoures, name, salary)
values (4940, 4, 'Natasha Beals', 15577);
insert into WORKER (worker_id, workhoures, name, salary)
values (4950, 5, 'Beth Sellers', 4708);
insert into WORKER (worker_id, workhoures, name, salary)
values (4960, 8, 'Aaron Gooding', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4970, 11, 'Andy Ledger', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4980, 10, 'Neve Presley', 18523);
insert into WORKER (worker_id, workhoures, name, salary)
values (4990, 6, 'Isabella Dunn', 10013);
insert into WORKER (worker_id, workhoures, name, salary)
values (5000, 9, 'Shirley Mazzell', 5768);
insert into WORKER (worker_id, workhoures, name, salary)
values (5010, 8, 'Pablo Bean', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5020, 4, 'Michael Preston', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5030, 4, 'Brittany Rippy', 11453);
insert into WORKER (worker_id, workhoures, name, salary)
values (5040, 4, 'Kylie Reeves', 6421);
insert into WORKER (worker_id, workhoures, name, salary)
values (5050, 9, 'Rade Armatradin', 17191);
insert into WORKER (worker_id, workhoures, name, salary)
values (5060, 11, 'Natascha Pullma', 6677);
insert into WORKER (worker_id, workhoures, name, salary)
values (5070, 10, 'Nicky Eat World', 7614);
insert into WORKER (worker_id, workhoures, name, salary)
values (5080, 8, 'Heather Dourif', 9578);
insert into WORKER (worker_id, workhoures, name, salary)
values (5090, 5, 'Glenn Delta', 4919);
insert into WORKER (worker_id, workhoures, name, salary)
values (5100, 12, 'Janice Rickles', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5110, 11, 'Gavin Morales', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5120, 8, 'Oliver Connery', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5130, 6, 'Doug Deejay', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5140, 11, 'Shannyn Suvari', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5150, 7, 'Mark Donelly', 7632);
insert into WORKER (worker_id, workhoures, name, salary)
values (5160, 9, 'Powers Wine', 10712);
insert into WORKER (worker_id, workhoures, name, salary)
values (5170, 12, 'Oliver Woodward', 16014);
insert into WORKER (worker_id, workhoures, name, salary)
values (5180, 10, 'Hank Streep', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5190, 12, 'Mindy Smith', 10861);
insert into WORKER (worker_id, workhoures, name, salary)
values (5200, 12, 'Julie Costner', 5317);
insert into WORKER (worker_id, workhoures, name, salary)
values (5210, 7, 'Jann McPherson', 18142);
insert into WORKER (worker_id, workhoures, name, salary)
values (5220, 8, 'Lorraine Venora', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5230, 10, 'Vendetta Berkof', 5551);
insert into WORKER (worker_id, workhoures, name, salary)
values (5240, 8, 'Natalie Borgnin', 9683);
insert into WORKER (worker_id, workhoures, name, salary)
values (5250, 12, 'Hope Weston', 4731);
insert into WORKER (worker_id, workhoures, name, salary)
values (5260, 5, 'Hazel Goodman', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5270, 6, 'Faye Dafoe', 18489);
insert into WORKER (worker_id, workhoures, name, salary)
values (5280, 9, 'Rickie Hawthorn', 8602);
insert into WORKER (worker_id, workhoures, name, salary)
values (5290, 12, 'Vickie Jenkins', 17015);
insert into WORKER (worker_id, workhoures, name, salary)
values (5300, 12, 'Praga Dafoe', 8729);
insert into WORKER (worker_id, workhoures, name, salary)
values (5310, 11, 'Rebecca Tucci', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5320, 10, 'Steve Wilkinson', 13256);
insert into WORKER (worker_id, workhoures, name, salary)
values (5330, 5, 'Nastassja Monk', 14366);
insert into WORKER (worker_id, workhoures, name, salary)
values (5340, 9, 'Salma Bentley', 12603);
insert into WORKER (worker_id, workhoures, name, salary)
values (5350, 6, 'Miranda Simpson', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5360, 4, 'Lynn Landau', 4214);
insert into WORKER (worker_id, workhoures, name, salary)
values (5370, 7, 'Freda Thomas', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5380, 6, 'Red Molina', 17278);
insert into WORKER (worker_id, workhoures, name, salary)
values (5390, 12, 'Jackie Gandolfi', 12268);
insert into WORKER (worker_id, workhoures, name, salary)
values (5400, 6, 'Ben Cazale', 18443);
insert into WORKER (worker_id, workhoures, name, salary)
values (5410, 7, 'Nancy Douglas', 10462);
insert into WORKER (worker_id, workhoures, name, salary)
values (5420, 5, 'Murray James', 18538);
insert into WORKER (worker_id, workhoures, name, salary)
values (5430, 11, 'Kate Chinlund', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5440, 4, 'Sophie Eckhart', 12292);
insert into WORKER (worker_id, workhoures, name, salary)
values (5450, 10, 'Nicholas Tinsle', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5460, 5, 'Lindsey Neill', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5470, 12, 'Jody Child', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5480, 5, 'Walter Chapman', 12507);
insert into WORKER (worker_id, workhoures, name, salary)
values (5490, 10, 'Derrick Wong', 8815);
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
values (5560, 9, 'Grant Nash', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5570, 12, 'Vertical Robert', 11470);
insert into WORKER (worker_id, workhoures, name, salary)
values (5580, 9, 'Nik Tolkan', 17245);
insert into WORKER (worker_id, workhoures, name, salary)
values (5590, 7, 'Nick Eder', 18749);
insert into WORKER (worker_id, workhoures, name, salary)
values (5600, 8, 'Sissy Gibbons', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5610, 10, 'Eileen Marx', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5620, 4, 'Peabo Gooding', 4339);
insert into WORKER (worker_id, workhoures, name, salary)
values (5630, 7, 'Juliette Braugh', 11030);
insert into WORKER (worker_id, workhoures, name, salary)
values (5640, 5, 'Yaphet Gaynor', 11577);
insert into WORKER (worker_id, workhoures, name, salary)
values (5650, 11, 'Denis Harnes', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5660, 5, 'Forest Rivers', 4419);
insert into WORKER (worker_id, workhoures, name, salary)
values (5670, 7, 'Rose McFerrin', 13663);
insert into WORKER (worker_id, workhoures, name, salary)
values (5680, 8, 'Mary Beth McCon', 6452);
insert into WORKER (worker_id, workhoures, name, salary)
values (5690, 8, 'Nikki Evanswood', 15655);
insert into WORKER (worker_id, workhoures, name, salary)
values (5700, 12, 'Larry Ticotin', 12502);
insert into WORKER (worker_id, workhoures, name, salary)
values (5710, 10, 'Adrien MacPhers', 11480);
insert into WORKER (worker_id, workhoures, name, salary)
values (5720, 8, 'Miko Baranski', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5730, 4, 'Crystal Hubbard', 17116);
insert into WORKER (worker_id, workhoures, name, salary)
values (5740, 7, 'Bo Stamp', 19495);
insert into WORKER (worker_id, workhoures, name, salary)
values (5750, 12, 'Teena Nelligan', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5760, 11, 'Tony Harrison', 6777);
insert into WORKER (worker_id, workhoures, name, salary)
values (5770, 7, 'Nikki Palmer', 12027);
insert into WORKER (worker_id, workhoures, name, salary)
values (5780, 5, 'Vertical Rowlan', 19196);
insert into WORKER (worker_id, workhoures, name, salary)
values (5790, 11, 'Vickie Caine', 9206);
insert into WORKER (worker_id, workhoures, name, salary)
values (5800, 8, 'Chris Napolitan', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5810, 8, 'Rascal Giamatti', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5820, 10, 'Larenz Liotta', 3500);
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
values (5870, 12, 'Ethan Esposito', 17693);
insert into WORKER (worker_id, workhoures, name, salary)
values (5880, 6, 'Frank Blades', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5890, 9, 'Maureen Hawkins', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5900, 10, 'Mos Pacino', 6896);
insert into WORKER (worker_id, workhoures, name, salary)
values (5910, 9, 'Humberto McCrea', 4361);
insert into WORKER (worker_id, workhoures, name, salary)
values (5920, 4, 'Jonathan Holly', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5930, 6, 'Gary Pitney', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5940, 10, 'Charlton Metcal', 10230);
insert into WORKER (worker_id, workhoures, name, salary)
values (5950, 8, 'Cole Stiles', 12671);
insert into WORKER (worker_id, workhoures, name, salary)
values (5960, 4, 'Toshiro Harriso', 9608);
insert into WORKER (worker_id, workhoures, name, salary)
values (5970, 6, 'Debi O''Neill', 14347);
insert into WORKER (worker_id, workhoures, name, salary)
values (5980, 5, 'Amy Santana', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (5990, 8, 'Murray Monk', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (6000, 4, 'Shannon Davies', 14008);
insert into WORKER (worker_id, workhoures, name, salary)
values (2420, 5, 'Laura Westerber', 10434);
insert into WORKER (worker_id, workhoures, name, salary)
values (2430, 8, 'Angela Hutch', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2440, 7, 'Todd Aniston', 6902);
insert into WORKER (worker_id, workhoures, name, salary)
values (2450, 8, 'Azucar Worrell', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2460, 5, 'Remy Stigers', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2470, 5, 'Kiefer Moody', 17517);
insert into WORKER (worker_id, workhoures, name, salary)
values (2480, 10, 'Nicky Perlman', 15041);
insert into WORKER (worker_id, workhoures, name, salary)
values (2490, 8, 'Steven Cherry', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2500, 7, 'Dennis Hingle', 15312);
insert into WORKER (worker_id, workhoures, name, salary)
values (2510, 6, 'Merle Krumholtz', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2520, 11, 'Domingo Patton', 7575);
insert into WORKER (worker_id, workhoures, name, salary)
values (2530, 7, 'Ving Biel', 7594);
insert into WORKER (worker_id, workhoures, name, salary)
values (2540, 12, 'Jeffery Feore', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2550, 4, 'Jonatha Martin', 7418);
insert into WORKER (worker_id, workhoures, name, salary)
values (2560, 11, 'Rosanna Reno', 4733);
insert into WORKER (worker_id, workhoures, name, salary)
values (2570, 7, 'Al Winter', 11016);
insert into WORKER (worker_id, workhoures, name, salary)
values (2580, 8, 'Glenn Eldard', 9674);
insert into WORKER (worker_id, workhoures, name, salary)
values (2590, 5, 'Lily Wilkinson', 19361);
insert into WORKER (worker_id, workhoures, name, salary)
values (2600, 4, 'Leo Barrymore', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2610, 8, 'Corey Maguire', 18498);
insert into WORKER (worker_id, workhoures, name, salary)
values (2620, 7, 'Elisabeth Senio', 14089);
insert into WORKER (worker_id, workhoures, name, salary)
values (2630, 10, 'Vondie Bragg', 10759);
insert into WORKER (worker_id, workhoures, name, salary)
values (2640, 4, 'Ice Rubinek', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2650, 7, 'Carolyn Marin', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2660, 10, 'Rebeka Scaggs', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2670, 12, 'Brittany Dooley', 11760);
insert into WORKER (worker_id, workhoures, name, salary)
values (2680, 12, 'Armin Vanian', 4093);
insert into WORKER (worker_id, workhoures, name, salary)
values (2690, 8, 'Remy McElhone', 17586);
insert into WORKER (worker_id, workhoures, name, salary)
values (2700, 11, 'Mira Davis', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2710, 9, 'Nile Jonze', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2720, 6, 'Suzy Tinsley', 6842);
insert into WORKER (worker_id, workhoures, name, salary)
values (2730, 6, 'Jason Phillippe', 18516);
insert into WORKER (worker_id, workhoures, name, salary)
values (2740, 12, 'Tara Sherman', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2750, 5, 'Rolando Armstro', 12353);
insert into WORKER (worker_id, workhoures, name, salary)
values (2760, 9, 'Tramaine Dillan', 7215);
insert into WORKER (worker_id, workhoures, name, salary)
values (2770, 10, 'Lesley Cetera', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2780, 12, 'Kurt Strathairn', 15070);
insert into WORKER (worker_id, workhoures, name, salary)
values (2790, 10, 'Max Fariq', 6442);
insert into WORKER (worker_id, workhoures, name, salary)
values (2800, 7, 'Radney Francis', 8785);
insert into WORKER (worker_id, workhoures, name, salary)
values (2810, 12, 'Seth Arjona', 6011);
insert into WORKER (worker_id, workhoures, name, salary)
values (2820, 8, 'Meg Rhymes', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2830, 10, 'Kurtwood Fogert', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2840, 8, 'Jessica Winwood', 7515);
insert into WORKER (worker_id, workhoures, name, salary)
values (2850, 10, 'Buddy Zevon', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2860, 9, 'Elias Pride', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2870, 7, 'Val Lipnicki', 6748);
insert into WORKER (worker_id, workhoures, name, salary)
values (2880, 11, 'Juliet Field', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2890, 11, 'Chalee Winger', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2900, 9, 'Hope Mars', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2910, 11, 'Goldie Keitel', 16305);
insert into WORKER (worker_id, workhoures, name, salary)
values (2920, 5, 'Rita Crystal', 16256);
insert into WORKER (worker_id, workhoures, name, salary)
values (2930, 11, 'Red Ryan', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2940, 12, 'Roger Farrow', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2950, 7, 'Chant׳™ Hurt', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2960, 11, 'Lindsey Cruz', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2970, 10, 'Quentin Stevens', 17845);
insert into WORKER (worker_id, workhoures, name, salary)
values (2980, 6, 'Cameron Shandli', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2990, 8, 'Maxine Conlee', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3000, 7, 'Edie Belle', 3500);
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
values (3070, 10, 'Al Jackman', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3080, 4, 'Brooke Richards', 7363);
insert into WORKER (worker_id, workhoures, name, salary)
values (3090, 11, 'Nicole Salonga', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3100, 9, 'Marie Mandrell', 11275);
insert into WORKER (worker_id, workhoures, name, salary)
values (3110, 5, 'Horace Weiland', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3120, 7, 'Sean McFerrin', 3500);
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
values (3190, 10, 'Patrick Reubens', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3200, 11, 'Carrie Conlee', 12443);
insert into WORKER (worker_id, workhoures, name, salary)
values (3210, 6, 'Taye Haslam', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3220, 6, 'Claude Magnuson', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3230, 10, 'Selma Gayle', 3500);
commit;
prompt 200 records committed...
insert into WORKER (worker_id, workhoures, name, salary)
values (3240, 12, 'Ben Abraham', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3250, 12, 'Jet Peet', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3260, 8, 'Nanci Howard', 9719);
insert into WORKER (worker_id, workhoures, name, salary)
values (3270, 7, 'Kimberly Martin', 3500);
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
values (3340, 11, 'Dom Oakenfold', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3350, 7, 'Lesley Fogerty', 12361);
insert into WORKER (worker_id, workhoures, name, salary)
values (3360, 6, 'Oro Kadison', 18433);
insert into WORKER (worker_id, workhoures, name, salary)
values (3370, 7, 'Famke Day', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3380, 11, 'Bob Tyson', 9933);
insert into WORKER (worker_id, workhoures, name, salary)
values (3390, 10, 'Dennis Rubinek', 14512);
insert into WORKER (worker_id, workhoures, name, salary)
values (3400, 9, 'Christina Dusch', 16220);
insert into WORKER (worker_id, workhoures, name, salary)
values (3410, 9, 'Guy English', 11849);
insert into WORKER (worker_id, workhoures, name, salary)
values (3420, 8, 'Ali Swank', 11869);
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
values (3480, 10, 'Jose Favreau', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3490, 10, 'Wally McCabe', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3500, 10, 'Laura Paige', 16557);
insert into WORKER (worker_id, workhoures, name, salary)
values (3510, 11, 'Tracy Sisto', 13034);
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
values (3580, 8, 'Solomon Conroy', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3590, 10, 'Debra Bracco', 12535);
insert into WORKER (worker_id, workhoures, name, salary)
values (3600, 5, 'Madeline Avital', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3610, 5, 'Clint Baldwin', 4499);
insert into WORKER (worker_id, workhoures, name, salary)
values (3620, 7, 'Denzel Camp', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3630, 8, 'Lin Pacino', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3640, 6, 'Jeffery McDowel', 19011);
insert into WORKER (worker_id, workhoures, name, salary)
values (3650, 11, 'Sissy Hopper', 8647);
insert into WORKER (worker_id, workhoures, name, salary)
values (3660, 8, 'Lizzy Campbell', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3670, 10, 'Melba Cohn', 12873);
insert into WORKER (worker_id, workhoures, name, salary)
values (3680, 8, 'Quentin Browne', 11253);
insert into WORKER (worker_id, workhoures, name, salary)
values (3690, 10, 'Ron Schwimmer', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3700, 12, 'Stockard Berkle', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3710, 10, 'Bridgette Carlt', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3720, 10, 'Shannon Kingsle', 10661);
insert into WORKER (worker_id, workhoures, name, salary)
values (3730, 10, 'Irene Waits', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3740, 12, 'Pelvic Schiff', 13728);
insert into WORKER (worker_id, workhoures, name, salary)
values (3750, 5, 'Gary Myles', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3760, 10, 'Bobby von Sydow', 10182);
insert into WORKER (worker_id, workhoures, name, salary)
values (3770, 10, 'Norm Unger', 5789);
insert into WORKER (worker_id, workhoures, name, salary)
values (3780, 10, 'Dom Stigers', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3790, 6, 'Gaby Wong', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3800, 9, 'Rhys Pryce', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3810, 12, 'Jeff Thurman', 16365);
insert into WORKER (worker_id, workhoures, name, salary)
values (3820, 12, 'Vondie Caine', 12242);
insert into WORKER (worker_id, workhoures, name, salary)
values (3830, 12, 'Morgan Guest', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3840, 10, 'Drew Rickles', 6302);
insert into WORKER (worker_id, workhoures, name, salary)
values (3850, 8, 'Rhys Robinson', 14869);
insert into WORKER (worker_id, workhoures, name, salary)
values (3860, 9, 'Taye Jordan', 6477);
insert into WORKER (worker_id, workhoures, name, salary)
values (3870, 12, 'Katie Lyonne', 6291);
insert into WORKER (worker_id, workhoures, name, salary)
values (3880, 12, 'Meryl Glenn', 18750);
insert into WORKER (worker_id, workhoures, name, salary)
values (3890, 7, 'Junior Spacek', 5613);
insert into WORKER (worker_id, workhoures, name, salary)
values (3900, 6, 'Heath Leoni', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3910, 6, 'Guy Marie', 8730);
insert into WORKER (worker_id, workhoures, name, salary)
values (3920, 5, 'Ty Springfield', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3930, 12, 'Neve McAnally', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3940, 10, 'Aaron Gallant', 12601);
insert into WORKER (worker_id, workhoures, name, salary)
values (3950, 12, 'Dar Hopper', 11700);
insert into WORKER (worker_id, workhoures, name, salary)
values (3960, 4, 'Spencer Holy', 5964);
insert into WORKER (worker_id, workhoures, name, salary)
values (3970, 11, 'Suzi Costa', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (3980, 7, 'Lynn Bacharach', 4039);
insert into WORKER (worker_id, workhoures, name, salary)
values (3990, 11, 'Freddy Richter', 3500);
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
values (4050, 12, 'Nelly Cage', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4060, 7, 'Rebecca Favreau', 13725);
insert into WORKER (worker_id, workhoures, name, salary)
values (4070, 11, 'Ozzy Serbedzija', 18871);
insert into WORKER (worker_id, workhoures, name, salary)
values (4080, 7, 'Nils Ifans', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4090, 5, 'Lari Burmester', 17637);
insert into WORKER (worker_id, workhoures, name, salary)
values (4100, 11, 'Lennie Satriani', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4110, 7, 'Murray DeVita', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4120, 5, 'Famke Mould', 8555);
insert into WORKER (worker_id, workhoures, name, salary)
values (4130, 9, 'Pat Pearce', 14211);
insert into WORKER (worker_id, workhoures, name, salary)
values (4140, 6, 'Lois Kretschman', 19286);
insert into WORKER (worker_id, workhoures, name, salary)
values (4150, 12, 'Belinda Unger', 5983);
insert into WORKER (worker_id, workhoures, name, salary)
values (4160, 10, 'Denny Teng', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4170, 10, 'Mena Hong', 9134);
insert into WORKER (worker_id, workhoures, name, salary)
values (4180, 5, 'Samuel Fender', 4158);
insert into WORKER (worker_id, workhoures, name, salary)
values (4190, 7, 'Spike Belles', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4200, 9, 'Jesse Furtado', 16208);
insert into WORKER (worker_id, workhoures, name, salary)
values (4210, 6, 'Marc Roundtree', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4220, 7, 'Colm Hauser', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4230, 5, 'Avenged McGover', 3500);
commit;
prompt 300 records committed...
insert into WORKER (worker_id, workhoures, name, salary)
values (4240, 5, 'Christmas Mazar', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4250, 11, 'Terrence Stewar', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4260, 4, 'Debra Solido', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4270, 6, 'Jesus Warburton', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4280, 9, 'Stephanie Mathe', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4290, 9, 'Natascha Bracco', 11058);
insert into WORKER (worker_id, workhoures, name, salary)
values (4300, 4, 'Fairuza Goldber', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4310, 12, 'Nickel Palin', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4320, 8, 'Elizabeth Colem', 7318);
insert into WORKER (worker_id, workhoures, name, salary)
values (4330, 6, 'Sharon Sevenfol', 12139);
insert into WORKER (worker_id, workhoures, name, salary)
values (4340, 10, 'Hope Spears', 18824);
insert into WORKER (worker_id, workhoures, name, salary)
values (4350, 8, 'Dwight Collie', 8848);
insert into WORKER (worker_id, workhoures, name, salary)
values (4360, 8, 'CeCe Spacey', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4370, 5, 'Bridgette Cartl', 4152);
insert into WORKER (worker_id, workhoures, name, salary)
values (4380, 7, 'Burt Field', 8736);
insert into WORKER (worker_id, workhoures, name, salary)
values (4390, 7, 'Donal Giannini', 14534);
insert into WORKER (worker_id, workhoures, name, salary)
values (4400, 11, 'Geoffrey Hunter', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4410, 10, 'Penelope Katt', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4420, 8, 'Linda England', 15847);
insert into WORKER (worker_id, workhoures, name, salary)
values (4430, 12, 'Joanna Fonda', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4440, 8, 'Pat Plummer', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4450, 8, 'Peabo Estevez', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4460, 11, 'Greg Rea', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4470, 12, 'Denis Briscoe', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4480, 8, 'Chad Crow', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4490, 5, 'Luis Shandling', 4871);
insert into WORKER (worker_id, workhoures, name, salary)
values (4500, 10, 'Julianna O''Sull', 14182);
insert into WORKER (worker_id, workhoures, name, salary)
values (4510, 4, 'Jesus Evett', 19661);
insert into WORKER (worker_id, workhoures, name, salary)
values (4520, 8, 'Denny Roth', 13438);
insert into WORKER (worker_id, workhoures, name, salary)
values (4530, 12, 'Elle Potter', 8403);
insert into WORKER (worker_id, workhoures, name, salary)
values (4540, 12, 'Fairuza Rizzo', 9895);
insert into WORKER (worker_id, workhoures, name, salary)
values (4550, 7, 'Jean-Luc Richar', 11776);
insert into WORKER (worker_id, workhoures, name, salary)
values (4560, 11, 'Kasey Heatherly', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4570, 12, 'Curtis Redford', 19966);
insert into WORKER (worker_id, workhoures, name, salary)
values (4580, 7, 'Ike Chestnut', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4590, 11, 'Taye Gertner', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4600, 5, 'Cornell Richard', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4610, 4, 'Carolyn Jovovic', 15401);
insert into WORKER (worker_id, workhoures, name, salary)
values (4620, 11, 'Miles Baez', 9811);
insert into WORKER (worker_id, workhoures, name, salary)
values (4630, 4, 'Teri Lapointe', 10531);
insert into WORKER (worker_id, workhoures, name, salary)
values (4640, 10, 'Devon Aniston', 12313);
insert into WORKER (worker_id, workhoures, name, salary)
values (4650, 4, 'Caroline Torino', 9689);
insert into WORKER (worker_id, workhoures, name, salary)
values (4660, 5, 'Bernie Horton', 12845);
insert into WORKER (worker_id, workhoures, name, salary)
values (4670, 7, 'Ray Banderas', 12886);
insert into WORKER (worker_id, workhoures, name, salary)
values (4680, 8, 'Curtis Irons', 12240);
insert into WORKER (worker_id, workhoures, name, salary)
values (4690, 4, 'Julianne Gary', 15956);
insert into WORKER (worker_id, workhoures, name, salary)
values (4700, 4, 'Patti Rydell', 11636);
insert into WORKER (worker_id, workhoures, name, salary)
values (4710, 11, 'Adina Sandoval', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4720, 12, 'Crispin Carrack', 12196);
insert into WORKER (worker_id, workhoures, name, salary)
values (4730, 11, 'Neneh Shand', 4462);
insert into WORKER (worker_id, workhoures, name, salary)
values (4740, 8, 'Renee Roberts', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4750, 8, 'Drew Feliciano', 6641);
insert into WORKER (worker_id, workhoures, name, salary)
values (4760, 12, 'Sandra Parsons', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4770, 7, 'Gary Arjona', 5613);
insert into WORKER (worker_id, workhoures, name, salary)
values (4780, 6, 'Freda Soda', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4790, 11, 'Ellen Keener', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4800, 8, 'Deborah Taranti', 6434);
insert into WORKER (worker_id, workhoures, name, salary)
values (4810, 11, 'Aimee Seagal', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (4820, 7, 'Gena Barrymore', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (990, 9, 'Sona Candy', 11149);
insert into WORKER (worker_id, workhoures, name, salary)
values (1000, 8, 'Ossie Wagner', 6979);
insert into WORKER (worker_id, workhoures, name, salary)
values (1010, 9, 'Burt Palin', 16035);
insert into WORKER (worker_id, workhoures, name, salary)
values (1020, 5, 'Radney Payton', 6539);
insert into WORKER (worker_id, workhoures, name, salary)
values (1030, 12, 'Bonnie Randal', 15334);
insert into WORKER (worker_id, workhoures, name, salary)
values (1040, 12, 'Famke Clooney', 6592);
insert into WORKER (worker_id, workhoures, name, salary)
values (1050, 11, 'Anna Iglesias', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1060, 11, 'Mary Mirren', 5175);
insert into WORKER (worker_id, workhoures, name, salary)
values (1070, 8, 'Burt Jeter', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1080, 10, 'Anjelica El-Sah', 18540);
insert into WORKER (worker_id, workhoures, name, salary)
values (1090, 9, 'Keith Tucci', 12964);
insert into WORKER (worker_id, workhoures, name, salary)
values (1100, 4, 'Rene Coleman', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1110, 10, 'Rene Parm', 10183);
insert into WORKER (worker_id, workhoures, name, salary)
values (1120, 5, 'Avril Dreyfuss', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1130, 7, 'Candice Squier', 18228);
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
values (1240, 11, 'Donna Moss', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1250, 12, 'Jimmy Dempsey', 18610);
insert into WORKER (worker_id, workhoures, name, salary)
values (1260, 6, 'Freddy Sanchez', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1270, 9, 'Dan Pullman', 13758);
insert into WORKER (worker_id, workhoures, name, salary)
values (1280, 7, 'Terri Nolte', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1290, 7, 'Jack Grier', 8698);
insert into WORKER (worker_id, workhoures, name, salary)
values (1300, 5, 'Nathan Simpson', 12342);
insert into WORKER (worker_id, workhoures, name, salary)
values (1310, 7, 'Franco Austin', 6840);
insert into WORKER (worker_id, workhoures, name, salary)
values (1320, 8, 'Wayne Matthau', 5866);
insert into WORKER (worker_id, workhoures, name, salary)
values (1330, 12, 'Forest McKellen', 14667);
insert into WORKER (worker_id, workhoures, name, salary)
values (1340, 8, 'Lauren Estevez', 12747);
insert into WORKER (worker_id, workhoures, name, salary)
values (1350, 10, 'Winona Tomlin', 8949);
insert into WORKER (worker_id, workhoures, name, salary)
values (1360, 12, 'Gordon Jovovich', 12669);
insert into WORKER (worker_id, workhoures, name, salary)
values (1370, 4, 'Danny Berkley', 8967);
insert into WORKER (worker_id, workhoures, name, salary)
values (1380, 5, 'Jared Stiller', 13313);
insert into WORKER (worker_id, workhoures, name, salary)
values (1400, 10, 'Nile Byrd', 12069);
commit;
prompt 400 records committed...
insert into WORKER (worker_id, workhoures, name, salary)
values (1410, 8, 'Leo Parish', 12190);
insert into WORKER (worker_id, workhoures, name, salary)
values (1420, 10, 'Brenda Holm', 14761);
insert into WORKER (worker_id, workhoures, name, salary)
values (1430, 5, 'Will Santa Rosa', 18469);
insert into WORKER (worker_id, workhoures, name, salary)
values (1440, 11, 'Hugh Sawa', 15358);
insert into WORKER (worker_id, workhoures, name, salary)
values (1450, 11, 'Brad Stampley', 4067);
insert into WORKER (worker_id, workhoures, name, salary)
values (1460, 8, 'Jude Loveless', 16702);
insert into WORKER (worker_id, workhoures, name, salary)
values (1470, 8, 'Aida Satriani', 15094);
insert into WORKER (worker_id, workhoures, name, salary)
values (1480, 8, 'Hugo Tomei', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1490, 12, 'Regina Craven', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1500, 10, 'Malcolm Fonda', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1510, 8, 'Steven Remar', 13174);
insert into WORKER (worker_id, workhoures, name, salary)
values (1520, 10, 'Dustin Napolita', 9718);
insert into WORKER (worker_id, workhoures, name, salary)
values (1530, 5, 'Randall Carrere', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1540, 8, 'Kim Wood', 8959);
insert into WORKER (worker_id, workhoures, name, salary)
values (1550, 7, 'Johnny Bancroft', 14918);
insert into WORKER (worker_id, workhoures, name, salary)
values (1560, 12, 'Alec Perlman', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1570, 7, 'Frank Pantolian', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1580, 10, 'Domingo O''Donne', 7951);
insert into WORKER (worker_id, workhoures, name, salary)
values (1590, 11, 'Mickey Karyo', 6173);
insert into WORKER (worker_id, workhoures, name, salary)
values (1600, 9, 'Chris Wong', 19887);
insert into WORKER (worker_id, workhoures, name, salary)
values (1610, 8, 'Nicky Boyle', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1620, 6, 'Nina Weber', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1630, 10, 'Harvey Supernaw', 11432);
insert into WORKER (worker_id, workhoures, name, salary)
values (1640, 7, 'Lea Farrell', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1650, 4, 'Diamond Leoni', 17754);
insert into WORKER (worker_id, workhoures, name, salary)
values (1660, 12, 'Nelly Rains', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1670, 10, 'Kenny Wakeling', 4824);
insert into WORKER (worker_id, workhoures, name, salary)
values (1680, 11, 'Gordie Webb', 12252);
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
values (1780, 12, 'Rose Ellis', 13208);
insert into WORKER (worker_id, workhoures, name, salary)
values (1790, 10, 'Domingo Hidalgo', 6714);
insert into WORKER (worker_id, workhoures, name, salary)
values (1800, 7, 'Ian Malkovich', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1810, 6, 'Larenz Spader', 11867);
insert into WORKER (worker_id, workhoures, name, salary)
values (1820, 8, 'Freda Bassett', 4036);
insert into WORKER (worker_id, workhoures, name, salary)
values (1830, 4, 'Rade Vinton', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1840, 8, 'Natascha Marsde', 16382);
insert into WORKER (worker_id, workhoures, name, salary)
values (1850, 12, 'Darius Luongo', 7502);
insert into WORKER (worker_id, workhoures, name, salary)
values (1860, 6, 'Mindy Womack', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1870, 10, 'Denis Wagner', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1880, 10, 'Ray Doucette', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1890, 12, 'Tony Diffie', 18129);
insert into WORKER (worker_id, workhoures, name, salary)
values (1900, 7, 'James Preston', 13866);
insert into WORKER (worker_id, workhoures, name, salary)
values (1910, 10, 'Tori Campbell', 6005);
insert into WORKER (worker_id, workhoures, name, salary)
values (1920, 7, 'Howie Schneider', 8173);
insert into WORKER (worker_id, workhoures, name, salary)
values (1930, 8, 'Cheryl Stigers', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (1940, 6, 'Kathleen Vance', 6574);
insert into WORKER (worker_id, workhoures, name, salary)
values (1950, 5, 'Neneh Rispoli', 15800);
insert into WORKER (worker_id, workhoures, name, salary)
values (1960, 6, 'Clay Satriani', 12207);
insert into WORKER (worker_id, workhoures, name, salary)
values (1970, 12, 'Rhys Reno', 4171);
insert into WORKER (worker_id, workhoures, name, salary)
values (1980, 11, 'Danni Zevon', 6765);
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
values (2040, 9, 'Millie Hewitt', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2050, 4, 'Amy Tempest', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2060, 5, 'Tommy Baker', 17810);
insert into WORKER (worker_id, workhoures, name, salary)
values (2070, 6, 'Russell Lerner', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2080, 5, 'Jean-Luc Dolenz', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2090, 11, 'Gerald Chandler', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2100, 5, 'Mykelti McKean', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2110, 5, 'Armand McElhone', 9547);
insert into WORKER (worker_id, workhoures, name, salary)
values (2120, 12, 'Gene Gough', 13548);
insert into WORKER (worker_id, workhoures, name, salary)
values (2130, 6, 'Gina Alda', 10027);
insert into WORKER (worker_id, workhoures, name, salary)
values (2140, 11, 'Harrison McCann', 3500);
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
values (40, 9, 'Janeane Hurt', 16947);
insert into WORKER (worker_id, workhoures, name, salary)
values (50, 4, 'Geoffrey Krabbe', 18122);
insert into WORKER (worker_id, workhoures, name, salary)
values (60, 5, 'Nicole Holmes', 4627);
insert into WORKER (worker_id, workhoures, name, salary)
values (70, 12, 'Thin Loring', 11298);
insert into WORKER (worker_id, workhoures, name, salary)
values (80, 7, 'Freda Harrison', 4648);
insert into WORKER (worker_id, workhoures, name, salary)
values (90, 8, 'Jena Mazzello', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (100, 6, 'Jennifer Arthur', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (110, 11, 'Rufus Garr', 9609);
insert into WORKER (worker_id, workhoures, name, salary)
values (120, 11, 'Goran Kidman', 5893);
insert into WORKER (worker_id, workhoures, name, salary)
values (130, 6, 'Oded Weber', 9580);
insert into WORKER (worker_id, workhoures, name, salary)
values (140, 11, 'Harriet Capshaw', 19206);
insert into WORKER (worker_id, workhoures, name, salary)
values (150, 12, 'Mena Esposito', 12449);
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
values (230, 8, 'Willem Pierce', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (240, 10, 'Nancy Tennison', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (250, 7, 'Ramsey Waite', 18867);
insert into WORKER (worker_id, workhoures, name, salary)
values (260, 9, 'Nile Yorn', 15465);
insert into WORKER (worker_id, workhoures, name, salary)
values (270, 12, 'Wendy Vince', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (280, 12, 'Kazem Easton', 3500);
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
values (360, 10, 'Colm Borden', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (370, 7, 'Juliette Jolie', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (380, 11, 'Gerald Darren', 7355);
insert into WORKER (worker_id, workhoures, name, salary)
values (390, 9, 'Mint Myles', 7383);
insert into WORKER (worker_id, workhoures, name, salary)
values (400, 10, 'Alessandro Gatl', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (410, 11, 'Kirsten Avital', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (420, 7, 'Marty Chinlund', 12458);
insert into WORKER (worker_id, workhoures, name, salary)
values (430, 12, 'Lindsay Conley', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (440, 12, 'Mae Orlando', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (450, 11, 'Jody Hawke', 14534);
insert into WORKER (worker_id, workhoures, name, salary)
values (460, 8, 'Jackson Winwood', 10964);
insert into WORKER (worker_id, workhoures, name, salary)
values (470, 5, 'Denis Almond', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (480, 9, 'Lari Keen', 3500);
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
values (560, 10, 'Gerald Spears', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (570, 10, 'Mekhi Jackson', 14189);
insert into WORKER (worker_id, workhoures, name, salary)
values (580, 8, 'Parker Forster', 9716);
insert into WORKER (worker_id, workhoures, name, salary)
values (590, 5, 'Lena Schwimmer', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (600, 12, 'Patty Carlyle', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (610, 4, 'Lois Gill', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (620, 8, 'Corey Shalhoub', 10102);
insert into WORKER (worker_id, workhoures, name, salary)
values (630, 9, 'Geena Peterson', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (640, 9, 'Jesus McIntosh', 4500);
insert into WORKER (worker_id, workhoures, name, salary)
values (650, 4, 'Ryan Rodgers', 16615);
insert into WORKER (worker_id, workhoures, name, salary)
values (660, 5, 'Wendy Fiennes', 19979);
insert into WORKER (worker_id, workhoures, name, salary)
values (670, 11, 'Joey Bloch', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (680, 6, 'Anna Paquin', 15113);
insert into WORKER (worker_id, workhoures, name, salary)
values (690, 7, 'Ricky Heston', 10983);
insert into WORKER (worker_id, workhoures, name, salary)
values (700, 7, 'Graham Wood', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (710, 5, 'Nastassja Skars', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (720, 4, 'Timothy Spiner', 9146);
insert into WORKER (worker_id, workhoures, name, salary)
values (730, 5, 'Eliza Baldwin', 11344);
insert into WORKER (worker_id, workhoures, name, salary)
values (740, 9, 'Scott Lofgren', 11849);
insert into WORKER (worker_id, workhoures, name, salary)
values (750, 12, 'Carolyn Spader', 5930);
insert into WORKER (worker_id, workhoures, name, salary)
values (760, 5, 'Doug Griggs', 12250);
insert into WORKER (worker_id, workhoures, name, salary)
values (770, 9, 'Jeanne Durning', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (780, 7, 'Debby Palmer', 6892);
insert into WORKER (worker_id, workhoures, name, salary)
values (790, 4, 'Derrick Mirren', 19001);
insert into WORKER (worker_id, workhoures, name, salary)
values (800, 12, 'Seann Supernaw', 5465);
insert into WORKER (worker_id, workhoures, name, salary)
values (810, 12, 'Phil Colin Youn', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (820, 9, 'Gwyneth Weiland', 19528);
insert into WORKER (worker_id, workhoures, name, salary)
values (830, 4, 'Patricia White', 5993);
insert into WORKER (worker_id, workhoures, name, salary)
values (840, 4, 'Daniel Danes', 12223);
insert into WORKER (worker_id, workhoures, name, salary)
values (850, 9, 'Todd Almond', 18492);
insert into WORKER (worker_id, workhoures, name, salary)
values (860, 9, 'Fats Harnes', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (870, 6, 'Lea Richards', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (880, 8, 'Garland Yankovi', 9345);
insert into WORKER (worker_id, workhoures, name, salary)
values (890, 7, 'Sara Turturro', 3500);
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
values (960, 12, 'Javon McGill', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (970, 4, 'Teena Stiller', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (980, 5, 'Ty Broza', 18365);
insert into WORKER (worker_id, workhoures, name, salary)
values (2170, 12, 'Jody Dzundza', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2180, 6, 'Benjamin Flanag', 14946);
insert into WORKER (worker_id, workhoures, name, salary)
values (2190, 11, 'Blair Bentley', 10407);
insert into WORKER (worker_id, workhoures, name, salary)
values (2200, 6, 'Elisabeth Ammon', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2210, 7, 'Cyndi Duncan', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2220, 10, 'Ron Ward', 17889);
insert into WORKER (worker_id, workhoures, name, salary)
values (2230, 8, 'Claire Ferrell', 12129);
insert into WORKER (worker_id, workhoures, name, salary)
values (2240, 5, 'Sigourney Galla', 13497);
insert into WORKER (worker_id, workhoures, name, salary)
values (2250, 10, 'Cathy Makowicz', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2260, 4, 'Lee Danger', 16578);
insert into WORKER (worker_id, workhoures, name, salary)
values (2270, 4, 'Stewart Rizzo', 10817);
insert into WORKER (worker_id, workhoures, name, salary)
values (2280, 8, 'Lupe Sellers', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2290, 5, 'Ronnie Numan', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2300, 8, 'Barry Bale', 4326);
insert into WORKER (worker_id, workhoures, name, salary)
values (2310, 5, 'Stevie Walsh', 14854);
insert into WORKER (worker_id, workhoures, name, salary)
values (2320, 10, 'Ceili Hiatt', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2330, 4, 'Oliver Osbourne', 3500);
insert into WORKER (worker_id, workhoures, name, salary)
values (2340, 9, 'Tommy Dunn', 15340);
insert into WORKER (worker_id, workhoures, name, salary)
values (2350, 4, 'Nigel Rifkin', 5260);
insert into WORKER (worker_id, workhoures, name, salary)
values (2360, 10, 'Jeanne Estevez', 3500);
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
prompt Enabling foreign key constraints for DISHS...
alter table DISHS enable constraint SYS_C007473;
prompt Enabling foreign key constraints for THE_ORDER...
alter table THE_ORDER enable constraint SYS_C007489;
prompt Enabling foreign key constraints for BELONG...
alter table BELONG enable constraint SYS_C007494;
alter table BELONG enable constraint SYS_C007495;
prompt Enabling foreign key constraints for CONTAIN...
alter table CONTAIN enable constraint SYS_C007505;
alter table CONTAIN enable constraint SYS_C007506;
prompt Enabling foreign key constraints for WORKINGIN...
alter table WORKINGIN enable constraint SYS_C007515;
alter table WORKINGIN enable constraint SYS_C007516;
prompt Enabling triggers for CATERING...
alter table CATERING enable all triggers;
prompt Enabling triggers for DISHS...
alter table DISHS enable all triggers;
prompt Enabling triggers for CUSTOMER...
alter table CUSTOMER enable all triggers;
prompt Enabling triggers for THE_ORDER...
alter table THE_ORDER enable all triggers;
prompt Enabling triggers for BELONG...
alter table BELONG enable all triggers;
prompt Enabling triggers for MATERIAL...
alter table MATERIAL enable all triggers;
prompt Enabling triggers for CONTAIN...
alter table CONTAIN enable all triggers;
prompt Enabling triggers for WORKER...
alter table WORKER enable all triggers;
prompt Enabling triggers for WORKINGIN...
alter table WORKINGIN enable all triggers;
set feedback on
set define on
prompt Done.
