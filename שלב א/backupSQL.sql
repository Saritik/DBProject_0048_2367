prompt PL/SQL Developer import file
prompt Created on יום ראשון 26 מאי 2024 by משתמש
set feedback off
set define off
prompt Creating CATERING...
create table CATERING
(
  catering_id NUMBER(5) not null,
  name        VARCHAR2(15) not null,
  cosher      CHAR(1) not null
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
  type        VARCHAR2(15) not null,
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
alter table DISHS disable constraint SYS_C007162;
prompt Disabling foreign key constraints for THE_ORDER...
alter table THE_ORDER disable constraint SYS_C007193;
prompt Disabling foreign key constraints for BELONG...
alter table BELONG disable constraint SYS_C007198;
alter table BELONG disable constraint SYS_C007199;
prompt Disabling foreign key constraints for CONTAIN...
alter table CONTAIN disable constraint SYS_C007184;
alter table CONTAIN disable constraint SYS_C007185;
prompt Disabling foreign key constraints for WORKINGIN...
alter table WORKINGIN disable constraint SYS_C007178;
alter table WORKINGIN disable constraint SYS_C007179;
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
values (16, 116, 'Bruschetta', 'Meat', 286);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (18, 227, 'Sate Ayam Kampu', 'None', 474);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (20, 53, 'Bihun', 'None', 640);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (22, 138, 'Shawarma', 'Dairy', 666);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (24, 192, 'Sate Lilit', 'None', 198);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (26, 94, 'Pad Thai', 'Dairy', 52);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (28, 207, 'Sate Padang Buk', 'Dairy', 379);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (30, 167, 'Sate Padang Sol', 'None', 689);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (32, 178, 'Risotto', 'None', 59);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (34, 164, 'Sate Padang Tan', 'None', 611);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (36, 246, 'Sate Padang Pes', 'Meat', 661);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (38, 71, 'Schnitzel', 'Dairy', 284);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (40, 120, 'Sate Padang Saw', 'Meat', 706);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (42, 111, 'Sate Lilit', 'Meat', 223);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (44, 29, 'Sate Kikil', 'None', 80);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (46, 177, 'Sambal', 'Dairy', 213);
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
values (58, 147, 'Sate Burung', 'Dairy', 599);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (60, 69, 'Sate Padang Sol', 'None', 459);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (62, 246, 'Kroket', 'Meat', 656);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (64, 35, 'Sate Padang Lim', 'Meat', 12);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (66, 27, 'Sate Daging Sap', 'Dairy', 158);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (68, 22, 'Soto Ayam', 'None', 690);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (70, 202, 'Soto Kudus', 'Meat', 761);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (72, 63, 'Sate Lilit', 'None', 694);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (74, 145, 'Bakpao', 'None', 355);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (76, 118, 'Sate Padang Aga', 'Dairy', 131);
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
values (102, 37, 'Sate Padang Pas', 'Meat', 396);
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
values (152, 219, 'Sate Padang Sol', 'Meat', 191);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (154, 79, 'Sate Padang Pad', 'Dairy', 251);
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
values (188, 226, 'Sate Padang Aga', 'Dairy', 111);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (190, 238, 'Sate Daging Sap', 'Dairy', 76);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (192, 250, 'Sate Padang Buk', 'Meat', 770);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (194, 38, 'Sate Kikil', 'Meat', 377);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (196, 85, 'Sup Buntut', 'Dairy', 751);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (198, 167, 'Lemper', 'Meat', 549);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (200, 90, 'Sate Padang Tan', 'Meat', 647);
commit;
prompt 100 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (202, 228, 'Soto Ayam', 'None', 336);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (204, 20, 'Laksa', 'Meat', 550);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (206, 43, 'Sate Burung', 'Dairy', 373);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (208, 164, 'Sate Padang Sol', 'None', 781);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (210, 192, 'Sate Padang Saw', 'Dairy', 200);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (212, 29, 'Sate Ambal', 'Meat', 99);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (214, 99, 'Crepe', 'None', 570);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (216, 85, 'Maki', 'None', 761);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (218, 99, 'Sate Padang Par', 'None', 743);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (220, 127, 'Sate Padang Sol', 'Meat', 240);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (222, 131, 'Sate Maranggi', 'Dairy', 787);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (224, 249, 'Empanada', 'None', 486);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (226, 107, 'Sate Padang Sol', 'Meat', 9);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (228, 39, 'Sate Padang Aga', 'Meat', 551);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (230, 123, 'Sate Padang Par', 'None', 8);
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
values (270, 175, 'Focaccia', 'Meat', 137);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (272, 65, 'Sate Padang Sij', 'Dairy', 761);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (274, 52, 'Sate Padang Pas', 'Meat', 367);
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
values (294, 168, 'Fajitas', 'Meat', 280);
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
values (314, 105, 'Sate Krecek', 'Meat', 86);
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
values (328, 107, 'Sate Padang Pas', 'Dairy', 473);
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
values (340, 144, 'Tiramisu', 'Dairy', 229);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (342, 240, 'Sate Padang Buk', 'None', 400);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (344, 167, 'Sate Padang Aga', 'None', 212);
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
values (362, 72, 'Kroket', 'Dairy', 352);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (364, 48, 'Kroket', 'None', 127);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (366, 167, 'Sate Padang Pas', 'None', 229);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (368, 166, 'Sate Padang Buk', 'Meat', 76);
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
values (386, 74, 'Sate Padang Pas', 'Meat', 93);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (388, 209, 'Sate Blora', 'Dairy', 775);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (390, 43, 'Soto Medan', 'Meat', 510);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (392, 176, 'Sate Padang Tan', 'None', 699);
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
values (412, 238, 'Bihun', 'None', 8);
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
values (474, 62, 'Lumpia', 'Meat', 779);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (476, 211, 'Tacos', 'None', 91);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (478, 112, 'Soto Ayam', 'Dairy', 68);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (480, 185, 'Karedok', 'Dairy', 157);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (482, 190, 'Sate Padang Par', 'None', 689);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (484, 121, 'Bibimbap', 'None', 224);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (486, 83, 'Sate Taoco', 'None', 678);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (488, 177, 'Sate Padang Pay', 'Dairy', 65);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (490, 136, 'Soto Medan', 'Meat', 325);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (492, 88, 'Sate Padang Pad', 'Meat', 149);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (494, 228, 'Sate Klatak', 'Meat', 748);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (496, 195, 'Fajitas', 'None', 544);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (498, 204, 'Sate Ayam Kampu', 'None', 542);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (500, 238, 'Sate Padang Pes', 'None', 239);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (502, 143, 'Bibimbap', 'None', 280);
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
values (518, 203, 'Sate Padang Lim', 'Meat', 568);
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
values (542, 90, 'Lasagna', 'Meat', 695);
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
values (564, 41, 'Sate Padang Pay', 'None', 666);
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
values (588, 39, 'Sate Padang Pad', 'Dairy', 17);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (590, 76, 'Sate Padang Sol', 'Dairy', 70);
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
values (606, 124, 'Lumpia', 'Meat', 490);
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
values (626, 168, 'Hummus', 'None', 111);
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
values (664, 235, 'Sate Banjar', 'Meat', 528);
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
values (692, 38, 'Soto Banjar', 'Meat', 153);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (694, 141, 'Klepon', 'Meat', 625);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (696, 42, 'Sate Padang Sol', 'Meat', 619);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (698, 150, 'Sate Padang Sol', 'Dairy', 415);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (700, 111, 'Sate Padang Pay', 'Meat', 706);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (702, 134, 'Sushi', 'Meat', 566);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (704, 157, 'Rawon', 'None', 264);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (706, 47, 'Karedok', 'Meat', 33);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (708, 125, 'Ceviche', 'None', 536);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (710, 50, 'Lemper', 'None', 699);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (712, 67, 'Pad Thai', 'Dairy', 427);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (714, 220, 'Kerak Telor', 'Meat', 639);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (716, 63, 'Sushi', 'Meat', 679);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (718, 97, 'Borscht', 'Dairy', 151);
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
values (754, 136, 'Kebab', 'Meat', 135);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (756, 98, 'Sate Padang Saw', 'None', 681);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (758, 118, 'Sate Padang Dha', 'Dairy', 709);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (760, 228, 'Serabi', 'Dairy', 355);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (762, 57, 'Biryani', 'Dairy', 108);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (764, 228, 'Pepes', 'Dairy', 747);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (766, 200, 'Kue Lapis', 'Dairy', 781);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (768, 72, 'Tahu Gejrot', 'Meat', 714);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (770, 56, 'Kerak Telor', 'None', 323);
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
values (782, 213, 'Sate Padang Tan', 'None', 677);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (784, 46, 'Sate Padang', 'Meat', 561);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (786, 168, 'Sate Banjar', 'None', 284);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (788, 20, 'Dim Sum', 'Dairy', 52);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (790, 153, 'Sate Padang Pay', 'Dairy', 343);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (792, 201, 'Sate Padang Buk', 'Dairy', 52);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (794, 83, 'Sate Tegal', 'Dairy', 179);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (796, 59, 'Sate Lilit', 'None', 413);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (798, 186, 'Kimchi', 'None', 574);
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
values (810, 32, 'Sate Padang Pas', 'Dairy', 53);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (812, 218, 'Sate Padang', 'None', 797);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (814, 202, 'Sate Padang Pes', 'Meat', 258);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (816, 140, 'Sate Padang Aga', 'None', 118);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (818, 55, 'Tongseng', 'None', 400);
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
values (838, 129, 'Lasagna', 'Meat', 720);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (840, 245, 'Croissant', 'None', 111);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (842, 234, 'Bihun', 'Meat', 129);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (844, 53, 'Sate Padang Pad', 'Dairy', 463);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (846, 41, 'Sate Padang Sij', 'None', 121);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (848, 236, 'Sambal', 'Dairy', 135);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (850, 116, 'Sate Padang Pas', 'Meat', 640);
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
values (866, 152, 'Sate Padang Par', 'Meat', 192);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (868, 153, 'Tabbouleh', 'Dairy', 164);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (870, 22, 'Sate Padang Dha', 'Meat', 566);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (872, 234, 'Sate Padang Sol', 'Meat', 379);
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
values (896, 156, 'Baklava', 'Meat', 611);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (898, 204, 'Perkedel', 'Dairy', 571);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (900, 151, 'Sate Padang Lim', 'Dairy', 682);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (902, 178, 'Sate Padang Sij', 'None', 526);
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
values (914, 249, 'Sate Padang Lub', 'Dairy', 763);
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
values (926, 43, 'Sate Padang Sol', 'Meat', 318);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (928, 247, 'Sate Padang Sol', 'None', 751);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (930, 67, 'Sate Padang Sij', 'Meat', 794);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (932, 111, 'Empanada', 'Dairy', 611);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (934, 59, 'Rawon', 'Dairy', 52);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (936, 139, 'Clafoutis', 'None', 129);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (938, 141, 'Sate Ayam', 'Meat', 212);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (940, 150, 'Sate Padang Buk', 'Meat', 79);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (942, 63, 'Sate Padang Pas', 'Dairy', 33);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (944, 85, 'Kebab', 'None', 94);
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
values (984, 191, 'Sate Banjar', 'Meat', 17);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (986, 82, 'Sate Padang Pes', 'None', 55);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (988, 91, 'Sate Padang Saw', 'None', 141);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (990, 81, 'Otak-Otak', 'Meat', 318);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (992, 118, 'Pierogi', 'Meat', 243);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (994, 223, 'Sate Padang Sol', 'Meat', 398);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (996, 174, 'Sate Padang Men', 'Meat', 544);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (998, 129, 'Sate Padang Saw', 'None', 52);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1000, 110, 'Sate Padang Aga', 'Dairy', 758);
commit;
prompt 500 records committed...
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1002, 155, 'Sate Padang Dha', 'Dairy', 249);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1004, 219, 'Capcay', 'Dairy', 397);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1006, 131, 'Sate Sapi', 'Dairy', 208);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1008, 186, 'Baklava', 'Dairy', 744);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1010, 25, 'Sate Padang Saw', 'Dairy', 519);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1012, 193, 'Sate Ponorogo', 'Dairy', 160);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1014, 215, 'Sate Gulai', 'Dairy', 144);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1016, 242, 'Sate Padang Par', 'None', 423);
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
values (1044, 104, 'Sate Padang Sij', 'Dairy', 55);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1046, 181, 'Sate Padang Sol', 'Meat', 677);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1048, 69, 'Es Teler', 'Meat', 729);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1050, 84, 'Sate Sapi', 'Dairy', 560);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1052, 68, 'Sate Padang Pas', 'Dairy', 467);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1054, 140, 'Rawon', 'Dairy', 679);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1056, 26, 'Kroket', 'None', 656);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1058, 176, 'Otak-Otak', 'None', 437);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1060, 45, 'Sate Padang Par', 'Meat', 680);
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
values (1074, 74, 'Tahu Sumedang', 'Meat', 711);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1076, 193, 'Sate Sapi', 'None', 79);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1078, 96, 'Sate Padang Buk', 'None', 570);
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
values (1096, 108, 'Sate Padang Lim', 'Dairy', 787);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1098, 52, 'Sate Padang Pay', 'Meat', 791);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1100, 105, 'Sate Padang Aga', 'Dairy', 464);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1102, 103, 'Sate Telur Puyu', 'None', 297);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1104, 213, 'Sate Ayam Kampu', 'None', 243);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1106, 114, 'Sate Padang Tan', 'Meat', 175);
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
values (1120, 77, 'Sate Padang Tan', 'Meat', 790);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1122, 177, 'Sate Ayam', 'None', 714);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1124, 118, 'Sate Padang Pas', 'Meat', 82);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1126, 218, 'Sate Padang Pas', 'Dairy', 795);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1128, 217, 'Bakso', 'Dairy', 78);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1130, 87, 'Sate Kikil', 'None', 404);
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
values (1144, 99, 'Sate Meranggi', 'Dairy', 80);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1146, 126, 'Sate Padang Lim', 'Dairy', 229);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1148, 191, 'Sate Telur Puyu', 'Meat', 21);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1150, 93, 'Sate Padang Pad', 'Dairy', 404);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1152, 169, 'Sate Susu', 'Meat', 179);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1154, 180, 'Sate Sapi', 'None', 206);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1156, 44, 'Soto', 'Dairy', 527);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1158, 173, 'Falooda', 'Meat', 157);
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
values (1192, 104, 'Kroket', 'None', 591);
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
values (1206, 70, 'Sate Padang Lub', 'Dairy', 433);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1208, 247, 'Sate Padang Sij', 'Dairy', 55);
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
values (1224, 111, 'Sate Padang Pas', 'Dairy', 47);
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
values (1246, 70, 'Tapenade', 'None', 490);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1248, 114, 'Sate Pentol', 'Dairy', 689);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1250, 172, 'Sate Padang', 'None', 226);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1252, 145, 'Sate Lilit', 'Meat', 349);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1254, 216, 'Pecel', 'Dairy', 347);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1256, 22, 'Kolak', 'Meat', 755);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1258, 99, 'Rawon', 'Meat', 591);
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
values (1282, 95, 'Sate Pentol', 'Meat', 312);
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
values (1300, 234, 'Tahu Sumedang', 'Meat', 277);
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
values (1324, 79, 'Tiramisu', 'Meat', 445);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1326, 101, 'Pizza', 'Dairy', 202);
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
values (1344, 221, 'Croissant', 'Dairy', 91);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1346, 220, 'Lumpia', 'Meat', 733);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1348, 179, 'Sate Udang', 'None', 426);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1350, 96, 'Pho', 'Meat', 8);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1352, 218, 'Sate Padang Pad', 'Meat', 377);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1354, 34, 'Perkedel', 'Meat', 54);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1356, 77, 'Soto Kudus', 'Meat', 408);
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
values (1370, 71, 'Croissant', 'None', 49);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1372, 46, 'Schnitzel', 'Meat', 751);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1374, 131, 'Sate Padang Pay', 'Meat', 526);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1376, 156, 'Sate Padang Lub', 'Meat', 729);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1378, 138, 'Sate Padang Pay', 'None', 580);
insert into DISHS (dishs_id, price, name, coshertype, catering_id)
values (1380, 182, 'Cannoli', 'Meat', 510);
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
values (76784, 'Chris Miller', 'chris.mi@hotmail.com', '680 High Riverside N', '628-3754265', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (53919, 'David Williams', 'david.wi@hotmail.com', '459 Oak Bristol GA', '636-5817095', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (98654, 'Laura Brown', 'laura.brow@yahoo.com', '702 High Franklin IL', '798-2017579', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (36997, 'Alex Williams', 'alex.wil@hotmail.com', '690 Main Georgetown ', '106-3585082', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (56477, 'Alex Davis', 'alex.dav@example.com', '237 Maple Greenfield', '413-9079902', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (65687, 'Chris Jones', 'chris.jone@yahoo.com', '187 Broadway Bristol', '703-2911076', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (59374, 'Laura Brown', 'laura.br@outlook.com', '462 Main Springfield', '418-2185103', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (37149, 'Michael Davis', 'michael.@outlook.com', '616 2nd Madison FL', '464-7254100', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (73822, 'Katie Miller', 'katie.mill@yahoo.com', '476 High Bristol TX', '134-2341536', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (79696, 'Sarah Jones', 'sarah.jo@example.com', '230 Oak Fairview MI', '749-5773304', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (29903, 'Emily Jones', 'emily.jo@outlook.com', '284 3rd Greenfield N', '272-4292762', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (39638, 'Sarah Moore', 'sarah.moor@gmail.com', '755 3rd Riverside NY', '840-2754927', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (17352, 'Emily Moore', 'emily.mo@example.com', '536 2nd Madison GA', '213-6238357', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91393, 'Sarah Davis', 'sarah.davi@gmail.com', '940 3rd Bristol GA', '925-8928440', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (56199, 'Katie Wilson', 'katie.wi@outlook.com', '117 2nd Fairview CA', '499-3533741', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (68339, 'Chris Davis', 'chris.davi@gmail.com', '948 3rd Springfield ', '773-2229995', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (76134, 'David Smith', 'david.sm@hotmail.com', '233 2nd Franklin MI', '669-7326879', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (36072, 'John Williams', 'john.willi@yahoo.com', '277 Main Bristol MI', '955-2877070', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (37588, 'Jane Jones', 'jane.jon@hotmail.com', '577 Cedar Bristol MI', '467-9936932', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (16694, 'Jane Taylor', 'jane.tay@outlook.com', '533 Pine Springfield', '207-3359981', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (10744, 'Emily Taylor', 'emily.tayl@yahoo.com', '821 Oak Clinton FL', '973-4339439', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (89204, 'John Brown', 'john.bro@outlook.com', '318 Main Georgetown ', '157-5465081', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (1808, 'Michael Wilson', 'michael.@outlook.com', '969 High Greenville ', '184-4587140', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (32075, 'Alex Jones', 'alex.jon@example.com', '626 2nd Springfield ', '393-5183207', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (34843, 'Laura Moore', 'laura.moor@yahoo.com', '395 Oak Springfield ', '719-2111325', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (69827, 'David Miller', 'david.mi@example.com', '729 Oak Bristol TX', '559-3214137', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (22818, 'Laura Moore', 'laura.mo@hotmail.com', '722 Elm Greenville F', '107-7699389', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (30106, 'Laura Smith', 'laura.sm@example.com', '328 2nd Greenville F', '667-7284259', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (43410, 'Chris Wilson', 'chris.wi@hotmail.com', '671 2nd Madison TX', '504-1245948', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (65489, 'Emily Brown', 'emily.br@hotmail.com', '325 Main Bristol NY', '897-5529802', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (54634, 'Emily Moore', 'emily.moor@gmail.com', '731 Elm Fairview OH', '147-1191979', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (19438, 'Jane Miller', 'jane.mil@hotmail.com', '869 Main Georgetown ', '561-1829120', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (689, 'David Miller', 'david.mill@gmail.com', '925 Pine Madison TX', '641-4297856', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (58700, 'David Moore', 'david.mo@hotmail.com', '759 Cedar Springfiel', '879-6584975', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (7961, 'David Moore', 'david.moor@gmail.com', '974 Oak Clinton FL', '972-4931089', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (78711, 'Sarah Miller', 'sarah.mill@gmail.com', '926 Elm Greenville O', '773-1767196', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (69306, 'Laura Williams', 'laura.wi@hotmail.com', '312 3rd Riverside GA', '735-3148708', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (88732, 'Jane Jones', 'jane.jon@example.com', '353 Cedar Greenfield', '146-3295586', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (92207, 'John Miller', 'john.mil@hotmail.com', '140 Cedar Riverside ', '200-4955673', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (9637, 'Jane Miller', 'jane.mil@example.com', '978 Maple Greenville', '400-3119379', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (19682, 'Katie Moore', 'katie.moor@yahoo.com', '743 Maple Greenville', '837-7784397', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (21008, 'Sarah Johnson', 'sarah.john@gmail.com', '958 Pine Franklin NC', '202-2814612', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (44605, 'Katie Miller', 'katie.mill@gmail.com', '632 High Bristol GA', '493-9427433', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (33796, 'Alex Johnson', 'alex.joh@example.com', '683 3rd Fairview TX', '899-4834016', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (31446, 'Katie Williams', 'katie.wi@example.com', '344 2nd Fairview OH', '214-7483621', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (72636, 'Laura Williams', 'laura.wi@outlook.com', '229 3rd Clinton IL', '853-4227521', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (27070, 'Sarah Brown', 'sarah.brow@yahoo.com', '552 3rd Fairview NC', '864-3377763', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (27971, 'Sarah Taylor', 'sarah.ta@example.com', '543 Elm Georgetown N', '805-8386908', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (45984, 'Jane Moore', 'jane.moo@hotmail.com', '681 3rd Greenville M', '459-3093719', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (68227, 'Emily Moore', 'emily.mo@example.com', '182 Main Madison MI', '290-7159403', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (96613, 'David Moore', 'david.mo@example.com', '782 Main Fairview IL', '951-5316785', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (64137, 'Katie Brown', 'katie.br@hotmail.com', '377 Oak Georgetown I', '266-1551215', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (80939, 'Jane Smith', 'jane.smi@hotmail.com', '711 Pine Greenfield ', '279-2859214', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (81992, 'Sarah Davis', 'sarah.da@example.com', '939 High Franklin NC', '326-8238496', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (29642, 'Sarah Smith', 'sarah.sm@hotmail.com', '451 High Greenville ', '349-1881735', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (17421, 'Chris Jones', 'chris.jo@example.com', '521 Oak Riverside FL', '986-5161204', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (35728, 'Michael Johnson', 'michael.@example.com', '600 2nd Madison TX', '650-3011986', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (15424, 'Laura Moore', 'laura.moor@gmail.com', '396 Cedar Georgetown', '882-2237103', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (85666, 'Jane Wilson', 'jane.wil@hotmail.com', '456 Broadway Madison', '611-1916124', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (61528, 'Laura Davis', 'laura.da@hotmail.com', '360 High Madison IL', '406-1283019', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (94944, 'Sarah Taylor', 'sarah.tayl@yahoo.com', '458 Cedar Fairview G', '973-2777486', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (93334, 'Chris Miller', 'chris.mi@outlook.com', '278 3rd Greenfield O', '383-3673109', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (62672, 'Laura Smith', 'laura.sm@hotmail.com', '491 3rd Greenfield N', '687-6598253', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (21318, 'Emily Williams', 'emily.wi@outlook.com', '188 Oak Madison IL', '852-7594221', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (66276, 'Chris Johnson', 'chris.john@gmail.com', '360 Oak Springfield ', '950-7678486', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (61363, 'Laura Moore', 'laura.moor@gmail.com', '132 High Greenfield ', '348-4438180', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (4304, 'David Smith', 'david.sm@hotmail.com', '290 Elm Madison GA', '401-3923552', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (57300, 'Sarah Wilson', 'sarah.wils@yahoo.com', '660 Oak Georgetown N', '270-3372375', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (32080, 'Chris Moore', 'chris.mo@example.com', '202 Maple Fairview N', '680-4277653', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (43385, 'Sarah Williams', 'sarah.will@yahoo.com', '539 Cedar Clinton CA', '368-5067181', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (62334, 'Laura Miller', 'laura.mi@hotmail.com', '423 3rd Springfield ', '347-1378354', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (3131, 'John Wilson', 'john.wil@outlook.com', '408 3rd Bristol NY', '840-4338673', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (95704, 'Katie Wilson', 'katie.wi@example.com', '337 High Greenville ', '450-1683456', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42102, 'Chris Moore', 'chris.mo@hotmail.com', '619 Elm Greenfield N', '850-8827373', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (73726, 'Katie Brown', 'katie.br@hotmail.com', '226 Oak Springfield ', '483-4251971', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (67074, 'David Miller', 'david.mi@outlook.com', '231 Pine Riverside C', '806-2192207', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (38753, 'Sarah Davis', 'sarah.da@example.com', '849 High Greenville ', '978-6385337', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (73195, 'Jane Miller', 'jane.mille@yahoo.com', '496 Main Georgetown ', '210-2981582', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (21210, 'Katie Jones', 'katie.jo@outlook.com', '181 High Madison PA', '458-7673277', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (25113, 'Michael Miller', 'michael.@hotmail.com', '568 2nd Greenville I', '524-6066247', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (94272, 'Chris Moore', 'chris.mo@outlook.com', '381 Broadway Riversi', '529-7171379', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (87283, 'John Miller', 'john.mille@gmail.com', '861 Maple Franklin N', '698-4228215', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (37101, 'Michael Davis', 'michael.da@gmail.com', '561 2nd Greenville P', '772-2579343', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (99574, 'David Wilson', 'david.wi@example.com', '866 Elm Bristol NC', '301-3092888', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (3026, 'Jane Williams', 'jane.willi@yahoo.com', '199 Oak Clinton TX', '355-6334792', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (84726, 'Laura Davis', 'laura.davi@yahoo.com', '282 Maple Franklin C', '976-5444144', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (61715, 'Katie Taylor', 'katie.ta@hotmail.com', '143 Cedar Franklin M', '624-7548333', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (24674, 'Katie Taylor', 'katie.ta@outlook.com', '131 2nd Fairview NC', '235-5977079', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (75891, 'Emily Jones', 'emily.jone@yahoo.com', '606 Oak Clinton PA', '958-1898720', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (44678, 'Chris Smith', 'chris.sm@example.com', '253 Oak Springfield ', '927-2564046', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (26127, 'Sarah Miller', 'sarah.mill@yahoo.com', '521 Maple Greenville', '240-6588049', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (63084, 'Jane Williams', 'jane.wil@outlook.com', '455 Cedar Fairview C', '807-1027049', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (5237, 'Jane Jones', 'jane.jon@hotmail.com', '290 Elm Franklin MI', '208-4098277', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (41976, 'Katie Williams', 'katie.will@gmail.com', '115 Main Springfield', '831-9575658', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (34839, 'Emily Smith', 'emily.sm@example.com', '829 Oak Greenville P', '816-8735213', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (76036, 'John Brown', 'john.brown@gmail.com', '495 Pine Madison TX', '544-1093082', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42201, 'Laura Davis', 'laura.davi@yahoo.com', '918 Oak Springfield ', '628-8901427', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (92025, 'Alex Miller', 'alex.mil@example.com', '448 Maple Georgetown', '497-1283398', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (81880, 'Jane Williams', 'jane.wil@outlook.com', '464 Elm Franklin FL', '935-1017471', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (39850, 'Emily Johnson', 'emily.jo@hotmail.com', '500 Broadway Fairvie', '475-1348475', 'CreditCard');
commit;
prompt 100 records committed...
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (13916, 'Alex Taylor', 'alex.tay@hotmail.com', '814 Pine Riverside T', '989-7254216', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (95197, 'Emily Williams', 'emily.wi@hotmail.com', '103 2nd Greenville M', '705-7992508', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (19683, 'Chris Miller', 'chris.mi@hotmail.com', '103 Pine Springfield', '551-9825490', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (75906, 'Alex Miller', 'alex.mil@hotmail.com', '538 Maple Bristol NY', '397-7548781', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (8778, 'Michael Brown', 'michael.br@yahoo.com', '133 Pine Springfield', '676-6266229', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (45593, 'Chris Davis', 'chris.da@outlook.com', '712 3rd Fairview TX', '261-2937270', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (35579, 'Emily Taylor', 'emily.ta@outlook.com', '304 Pine Riverside C', '920-4583851', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (24008, 'Sarah Taylor', 'sarah.ta@example.com', '589 Cedar Greenville', '816-3723627', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (72996, 'Alex Moore', 'alex.moo@example.com', '221 High Greenfield ', '527-3738725', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (82096, 'Chris Smith', 'chris.sm@example.com', '609 Pine Springfield', '889-7646629', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (12398, 'Katie Brown', 'katie.br@hotmail.com', '484 High Georgetown ', '493-1888599', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (87148, 'Chris Johnson', 'chris.jo@hotmail.com', '139 Broadway Bristol', '344-5724991', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (88114, 'Michael Smith', 'michael.@example.com', '514 3rd Georgetown N', '971-5698084', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (39213, 'Emily Williams', 'emily.wi@example.com', '921 Pine Georgetown ', '347-1545258', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (61109, 'Sarah Johnson', 'sarah.john@yahoo.com', '996 3rd Georgetown O', '826-1373865', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (17803, 'Katie Jones', 'katie.jo@hotmail.com', '175 Maple Fairview M', '256-8595074', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (22744, 'Chris Miller', 'chris.mi@hotmail.com', '872 Oak Greenfield N', '639-9938513', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (26024, 'Alex Moore', 'alex.moo@example.com', '454 Pine Fairview OH', '296-2236961', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (36377, 'Emily Wilson', 'emily.wi@hotmail.com', '185 2nd Greenville F', '444-4303948', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (183, 'Laura Taylor', 'laura.ta@outlook.com', '589 Oak Madison TX', '450-5521956', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (64909, 'Katie Johnson', 'katie.jo@example.com', '888 3rd Bristol MI', '280-3059689', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (78122, 'Michael Taylor', 'michael.@example.com', '824 Maple Springfiel', '639-2048976', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (65557, 'Alex Moore', 'alex.moore@gmail.com', '241 Elm Fairview TX', '304-8002578', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (32912, 'Jane Taylor', 'jane.taylo@gmail.com', '267 High Franklin NC', '334-7089852', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (63004, 'Laura Taylor', 'laura.ta@hotmail.com', '484 Broadway Georget', '857-9687288', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (59705, 'Chris Miller', 'chris.mill@gmail.com', '226 Maple Clinton PA', '118-2991768', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (61882, 'Alex Miller', 'alex.mil@example.com', '250 Main Greenfield ', '405-6282425', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97861, 'Alex Davis', 'alex.davis@gmail.com', '603 High Greenfield ', '756-8941882', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (92450, 'Jane Brown', 'jane.brown@yahoo.com', '166 Elm Clinton OH', '755-3477448', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (36098, 'Laura Taylor', 'laura.tayl@yahoo.com', '385 Broadway Bristol', '744-2035160', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (51737, 'Katie Moore', 'katie.mo@example.com', '589 2nd Bristol GA', '619-6692694', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (59491, 'Emily Williams', 'emily.will@gmail.com', '634 Cedar Greenville', '355-8907671', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (16425, 'Emily Brown', 'emily.br@example.com', '500 2nd Franklin TX', '352-9067451', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (19416, 'Emily Moore', 'emily.mo@hotmail.com', '971 Main Georgetown ', '191-9935580', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (11541, 'Chris Smith', 'chris.sm@hotmail.com', '933 Elm Franklin TX', '870-4296518', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (85019, 'David Williams', 'david.wi@example.com', '385 High Fairview MI', '147-4639829', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (14323, 'John Jones', 'john.jon@hotmail.com', '502 Maple Franklin T', '369-9516322', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (70323, 'Sarah Davis', 'sarah.davi@gmail.com', '766 Cedar Madison IL', '563-9112019', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (41634, 'Jane Smith', 'jane.smith@yahoo.com', '863 3rd Fairview OH', '898-7884126', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42636, 'Katie Williams', 'katie.wi@hotmail.com', '198 2nd Fairview MI', '535-6993688', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (62025, 'John Jones', 'john.jon@hotmail.com', '371 Oak Georgetown O', '939-5788288', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (29964, 'Katie Miller', 'katie.mi@hotmail.com', '801 Oak Bristol GA', '404-3009407', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (73449, 'Emily Williams', 'emily.will@gmail.com', '980 Pine Greenfield ', '573-5445938', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (11050, 'Sarah Moore', 'sarah.mo@outlook.com', '737 Main Georgetown ', '454-5975413', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (14382, 'Katie Wilson', 'katie.wi@outlook.com', '725 Main Springfield', '702-5164666', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (54325, 'David Taylor', 'david.tayl@gmail.com', '794 Pine Greenville ', '198-6586291', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (22674, 'Sarah Miller', 'sarah.mi@outlook.com', '574 Main Fairview MI', '795-3477730', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (37772, 'Alex Brown', 'alex.brown@yahoo.com', '877 Cedar Greenville', '887-4315586', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (95293, 'Alex Smith', 'alex.smi@hotmail.com', '918 2nd Springfield ', '762-3882134', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (95849, 'John Smith', 'john.smith@gmail.com', '704 Elm Riverside OH', '647-6775946', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (26035, 'John Davis', 'john.dav@outlook.com', '985 Cedar Madison PA', '623-1937204', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (28759, 'Jane Davis', 'jane.dav@outlook.com', '944 Elm Greenfield N', '117-1757880', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (67005, 'Jane Miller', 'jane.mille@yahoo.com', '170 2nd Springfield ', '427-1172669', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (26650, 'Emily Davis', 'emily.da@outlook.com', '778 Maple Springfiel', '109-3199555', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (89951, 'Emily Moore', 'emily.mo@hotmail.com', '855 Broadway Riversi', '214-7462380', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (87046, 'David Moore', 'david.mo@hotmail.com', '991 Cedar Greenville', '829-1459598', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (30132, 'Laura Johnson', 'laura.jo@outlook.com', '886 Elm Clinton PA', '304-6206327', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97677, 'Emily Smith', 'emily.smit@gmail.com', '779 Cedar Franklin G', '394-5454992', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (15512, 'Chris Moore', 'chris.mo@example.com', '189 Pine Greenville ', '276-5936964', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (82634, 'Alex Jones', 'alex.jon@outlook.com', '302 3rd Greenville G', '845-2102942', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (70360, 'Katie Johnson', 'katie.jo@outlook.com', '637 Elm Georgetown O', '584-8323027', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (31368, 'Alex Wilson', 'alex.wil@hotmail.com', '983 High Springfield', '584-3226199', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (57091, 'Jane Williams', 'jane.willi@yahoo.com', '545 3rd Fairview IL', '650-6803421', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (21621, 'Chris Miller', 'chris.mi@outlook.com', '130 Maple Greenville', '846-7197817', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (34822, 'Jane Jones', 'jane.jon@hotmail.com', '547 Pine Georgetown ', '405-2416525', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42649, 'Laura Williams', 'laura.will@gmail.com', '833 High Clinton PA', '748-9974031', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (98425, 'David Brown', 'david.brow@gmail.com', '857 Broadway Frankli', '212-2165218', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (69795, 'Laura Taylor', 'laura.ta@outlook.com', '341 Oak Madison CA', '861-9075734', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (31433, 'Jane Miller', 'jane.mil@outlook.com', '165 Cedar Bristol OH', '165-2532638', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (5421, 'Jane Taylor', 'jane.taylo@gmail.com', '437 Cedar Georgetown', '331-4116953', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (70541, 'Katie Smith', 'katie.smit@gmail.com', '174 Oak Clinton MI', '593-1896451', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (54553, 'John Williams', 'john.willi@gmail.com', '126 Pine Franklin PA', '792-9002023', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (7915, 'Laura Smith', 'laura.sm@outlook.com', '926 Maple Georgetown', '466-8275181', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (30344, 'Michael Johnson', 'michael.jo@yahoo.com', '778 Broadway Greenvi', '603-4562413', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (40098, 'Michael Smith', 'michael.@example.com', '544 Maple Fairview N', '211-4268749', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (71464, 'Katie Davis', 'katie.davi@gmail.com', '520 Elm Riverside IL', '518-9174557', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (6990, 'Katie Brown', 'katie.br@example.com', '595 Main Clinton GA', '715-7504238', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (21876, 'Emily Taylor', 'emily.ta@example.com', '114 3rd Clinton CA', '538-6266611', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (73696, 'John Taylor', 'john.tay@hotmail.com', '398 Cedar Greenville', '316-4356077', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (60059, 'Michael Jones', 'michael.@example.com', '601 High Madison FL', '151-7005896', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (969, 'Chris Smith', 'chris.smit@gmail.com', '764 Elm Greenfield T', '712-1707642', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (65479, 'Emily Miller', 'emily.mi@hotmail.com', '142 Oak Clinton NC', '342-7295959', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (11376, 'Sarah Taylor', 'sarah.tayl@yahoo.com', '915 Broadway Springf', '166-8649748', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (25581, 'David Moore', 'david.moor@gmail.com', '716 Oak Fairview OH', '547-6274084', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (61931, 'Chris Davis', 'chris.da@hotmail.com', '750 High Clinton GA', '643-3661921', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (73319, 'Katie Williams', 'katie.will@gmail.com', '893 High Greenfield ', '684-2966566', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (5922, 'Emily Wilson', 'emily.wils@gmail.com', '954 Pine Fairview CA', '147-7321499', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (37976, 'Alex Moore', 'alex.moore@gmail.com', '525 Oak Madison TX', '766-3226203', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (71060, 'Katie Miller', 'katie.mi@outlook.com', '585 2nd Fairview NC', '875-7798465', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (40015, 'Alex Williams', 'alex.wil@outlook.com', '174 2nd Madison TX', '992-3885115', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (68251, 'Jane Miller', 'jane.mil@hotmail.com', '523 Maple Georgetown', '719-6666605', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (93754, 'John Williams', 'john.willi@yahoo.com', '177 Pine Clinton OH', '959-6055972', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (34867, 'Chris Williams', 'chris.wi@example.com', '188 Maple Riverside ', '406-7871037', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (9612, 'Emily Taylor', 'emily.tayl@gmail.com', '303 Elm Greenfield M', '319-6111245', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (78939, 'John Taylor', 'john.tay@hotmail.com', '553 Elm Greenfield T', '448-3464882', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (39925, 'Chris Davis', 'chris.da@example.com', '165 Broadway Greenvi', '781-8884765', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (543, 'Sarah Miller', 'sarah.mi@outlook.com', '553 Broadway Bristol', '462-3743547', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (86783, 'David Miller', 'david.mi@example.com', '300 Pine Franklin GA', '799-5728771', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42806, 'Alex Williams', 'alex.willi@gmail.com', '328 Elm Clinton NY', '240-4004152', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (77081, 'Laura Brown', 'laura.br@outlook.com', '742 Maple Fairview C', '447-5038761', 'Cash');
commit;
prompt 200 records committed...
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (14178, 'John Moore', 'john.moore@yahoo.com', '936 High Fairview CA', '606-2944730', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (30174, 'David Taylor', 'david.ta@hotmail.com', '340 Cedar Springfiel', '862-6169102', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (78485, 'Michael Brown', 'michael.br@yahoo.com', '509 Oak Georgetown G', '711-5901997', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (56332, 'Emily Taylor', 'emily.tayl@yahoo.com', '669 Maple Clinton IL', '884-6956773', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (62576, 'Michael Davis', 'michael.da@gmail.com', '443 2nd Georgetown O', '488-6574512', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (63036, 'Michael Jones', 'michael.@hotmail.com', '305 3rd Madison MI', '277-7004890', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (48677, 'Jane Smith', 'jane.smi@example.com', '286 Pine Springfield', '777-1394117', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (16397, 'Chris Johnson', 'chris.jo@example.com', '778 Maple Greenville', '579-4396665', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (64901, 'Katie Moore', 'katie.mo@outlook.com', '259 Oak Franklin GA', '417-6068810', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (47026, 'Chris Davis', 'chris.davi@gmail.com', '798 Cedar Madison NY', '241-1552438', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (55688, 'Jane Brown', 'jane.bro@hotmail.com', '117 Pine Greenfield ', '572-6319127', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (86943, 'Emily Johnson', 'emily.jo@hotmail.com', '483 Elm Georgetown O', '252-2541542', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (63220, 'Laura Taylor', 'laura.ta@hotmail.com', '952 3rd Georgetown N', '774-1826438', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (69825, 'Jane Brown', 'jane.brown@gmail.com', '407 High Georgetown ', '101-5229522', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (24132, 'Laura Wilson', 'laura.wils@gmail.com', '674 Main Georgetown ', '609-9177160', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (61000, 'Emily Williams', 'emily.wi@hotmail.com', '895 Elm Georgetown O', '264-4624539', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (84191, 'Laura Jones', 'laura.jo@hotmail.com', '344 3rd Bristol PA', '486-7788483', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (96987, 'John Williams', 'john.wil@example.com', '769 3rd Georgetown P', '296-4855439', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (28029, 'Sarah Miller', 'sarah.mill@gmail.com', '585 Cedar Riverside ', '431-3315226', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (4576, 'Michael Smith', 'michael.@hotmail.com', '264 Pine Bristol CA', '787-7112246', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (35942, 'John Johnson', 'john.joh@example.com', '230 Broadway Frankli', '166-5755318', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (66975, 'Michael Jones', 'michael.jo@gmail.com', '728 Maple Springfiel', '125-6479907', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (57993, 'Michael Miller', 'michael.@hotmail.com', '938 Maple Madison NC', '555-6848963', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (40644, 'John Miller', 'john.mil@outlook.com', '973 Broadway Clinton', '748-3603192', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (88146, 'Alex Miller', 'alex.mil@outlook.com', '509 Elm Riverside NC', '125-5021790', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (84609, 'John Brown', 'john.brown@yahoo.com', '911 Main Springfield', '181-8298878', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (68534, 'Emily Moore', 'emily.mo@example.com', '129 Broadway Greenfi', '901-2665646', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (86714, 'Laura Smith', 'laura.smit@yahoo.com', '668 3rd Greenville C', '655-7107194', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (66224, 'Emily Miller', 'emily.mi@example.com', '672 Main Springfield', '282-2688044', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (74286, 'Jane Williams', 'jane.willi@yahoo.com', '269 Broadway Frankli', '440-9098668', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (52324, 'David Brown', 'david.br@example.com', '384 3rd Clinton PA', '587-8604042', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (71391, 'Katie Moore', 'katie.mo@outlook.com', '315 High Georgetown ', '400-3815204', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91873, 'Alex Johnson', 'alex.joh@hotmail.com', '550 Main Greenfield ', '522-8081371', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (64829, 'Michael Miller', 'michael.@example.com', '376 Oak Franklin NY', '124-1169361', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (79361, 'Katie Williams', 'katie.wi@example.com', '213 Main Riverside P', '550-7511276', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (21378, 'John Brown', 'john.bro@example.com', '743 Pine Georgetown ', '678-4869070', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (27485, 'John Jones', 'john.jon@hotmail.com', '495 3rd Fairview FL', '211-7095773', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (25176, 'Michael Davis', 'michael.da@yahoo.com', '374 Oak Greenfield P', '436-5376434', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (39945, 'John Brown', 'john.bro@outlook.com', '235 Pine Madison CA', '436-9264337', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (93298, 'Katie Jones', 'katie.jo@outlook.com', '933 Broadway Greenfi', '624-6472791', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (11706, 'Laura Brown', 'laura.br@outlook.com', '746 2nd Fairview NY', '382-4681095', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (1067, 'Katie Taylor', 'katie.ta@hotmail.com', '322 Pine Greenfield ', '252-7183804', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (40393, 'Alex Miller', 'alex.mil@hotmail.com', '615 3rd Greenville C', '489-8874555', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (69664, 'Alex Wilson', 'alex.wilso@yahoo.com', '918 Elm Georgetown T', '343-5918073', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (83545, 'Michael Jones', 'michael.@outlook.com', '361 Pine Riverside C', '558-9971312', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (29721, 'John Smith', 'john.smith@yahoo.com', '760 Maple Fairview M', '180-1944599', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (79861, 'John Brown', 'john.brown@gmail.com', '122 Oak Springfield ', '366-5374829', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (46666, 'Emily Brown', 'emily.br@outlook.com', '628 Main Clinton PA', '612-5818247', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (15681, 'Sarah Moore', 'sarah.moor@yahoo.com', '774 Cedar Greenville', '584-9525982', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (81596, 'Emily Brown', 'emily.br@hotmail.com', '673 Cedar Greenville', '561-8913519', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (8358, 'Chris Taylor', 'chris.ta@hotmail.com', '721 Main Franklin OH', '487-4362221', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (24296, 'Chris Moore', 'chris.mo@outlook.com', '896 Elm Springfield ', '490-7376615', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (62454, 'Michael Jones', 'michael.jo@gmail.com', '795 Elm Madison NC', '854-1817479', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (47195, 'Jane Davis', 'jane.dav@outlook.com', '834 Broadway Clinton', '808-9288402', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (3305, 'John Johnson', 'john.johns@gmail.com', '839 Elm Greenville N', '272-7694227', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (33920, 'Laura Johnson', 'laura.jo@hotmail.com', '704 Broadway Frankli', '650-1058156', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (20720, 'Jane Johnson', 'jane.joh@outlook.com', '578 Pine Fairview PA', '696-4353335', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (57611, 'Jane Moore', 'jane.moo@hotmail.com', '507 3rd Springfield ', '299-5322274', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (27791, 'Katie Jones', 'katie.jo@outlook.com', '155 3rd Franklin NY', '598-9105113', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (26189, 'Emily Jones', 'emily.jo@example.com', '244 Elm Bristol IL', '747-1244794', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (48155, 'John Smith', 'john.smi@example.com', '431 Elm Springfield ', '429-1484917', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (33040, 'Katie Miller', 'katie.mill@yahoo.com', '979 2nd Greenfield C', '299-2474396', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (49645, 'Sarah Smith', 'sarah.sm@example.com', '837 Pine Fairview CA', '859-2905573', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (55703, 'Alex Moore', 'alex.moore@gmail.com', '500 Elm Greenville T', '632-2388548', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (30697, 'Katie Davis', 'katie.da@hotmail.com', '486 Cedar Clinton PA', '139-3643067', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (54590, 'Michael Wilson', 'michael.wi@yahoo.com', '282 Pine Bristol TX', '799-7762339', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (51101, 'Sarah Miller', 'sarah.mill@yahoo.com', '928 Pine Madison OH', '210-3775555', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97930, 'Jane Taylor', 'jane.taylo@yahoo.com', '541 Pine Springfield', '345-3082846', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (46289, 'Emily Taylor', 'emily.ta@example.com', '633 2nd Riverside NY', '603-5556812', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (24115, 'Sarah Johnson', 'sarah.jo@hotmail.com', '904 Pine Clinton IL', '830-3369935', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (2526, 'Jane Jones', 'jane.jon@example.com', '531 Main Riverside M', '227-4001302', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (11292, 'Katie Williams', 'katie.wi@hotmail.com', '482 Elm Clinton TX', '653-7953975', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (87841, 'Emily Moore', 'emily.moor@gmail.com', '312 3rd Franklin PA', '375-3139332', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (55531, 'Jane Wilson', 'jane.wilso@gmail.com', '397 Oak Greenville C', '380-5257069', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (53869, 'Sarah Miller', 'sarah.mi@outlook.com', '830 Cedar Fairview F', '973-9286689', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (21291, 'John Moore', 'john.moo@hotmail.com', '169 Main Bristol TX', '607-2974445', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (45017, 'Emily Moore', 'emily.mo@hotmail.com', '113 High Franklin MI', '172-3018264', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (44681, 'John Johnson', 'john.johns@gmail.com', '316 3rd Franklin TX', '927-1677900', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (52999, 'John Jones', 'john.jones@gmail.com', '641 Broadway Frankli', '851-6484140', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (22555, 'Michael Taylor', 'michael.ta@gmail.com', '126 Elm Springfield ', '255-5309341', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (13255, 'Michael Davis', 'michael.@hotmail.com', '541 High Madison TX', '248-9364270', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (4048, 'Katie Wilson', 'katie.wi@example.com', '844 Elm Riverside IL', '424-2818860', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (73599, 'Sarah Brown', 'sarah.brow@gmail.com', '790 3rd Georgetown F', '940-1307058', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97929, 'Chris Smith', 'chris.sm@hotmail.com', '920 Oak Greenfield O', '629-5141950', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (5324, 'Jane Smith', 'jane.smi@hotmail.com', '106 3rd Greenville T', '466-6626642', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (48002, 'Emily Brown', 'emily.br@hotmail.com', '189 Main Bristol IL', '210-7746481', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (86659, 'Sarah Davis', 'sarah.da@hotmail.com', '870 Elm Madison NY', '440-6727736', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (93405, 'Chris Jones', 'chris.jone@gmail.com', '391 High Riverside N', '256-1139885', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (28182, 'John Davis', 'john.davis@yahoo.com', '985 2nd Springfield ', '959-9915687', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (88664, 'Katie Miller', 'katie.mill@gmail.com', '595 Cedar Madison PA', '885-9211107', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (83181, 'Emily Johnson', 'emily.jo@example.com', '257 Elm Greenville I', '142-4098209', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (12119, 'Katie Johnson', 'katie.john@yahoo.com', '157 High Greenfield ', '217-3409316', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (22012, 'Sarah Taylor', 'sarah.ta@outlook.com', '587 3rd Franklin IL', '617-1251036', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (90416, 'Michael Smith', 'michael.sm@gmail.com', '877 3rd Riverside FL', '326-1711824', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97016, 'Katie Wilson', 'katie.wi@example.com', '301 Pine Greenville ', '852-2331092', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (22498, 'Laura Wilson', 'laura.wils@gmail.com', '162 Maple Springfiel', '111-4676734', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (98467, 'Katie Miller', 'katie.mi@hotmail.com', '463 Main Georgetown ', '813-6464142', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91694, 'Jane Miller', 'jane.mil@hotmail.com', '449 2nd Fairview NY', '364-8474032', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (57213, 'Katie Taylor', 'katie.tayl@yahoo.com', '152 3rd Greenville I', '707-5134390', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (82702, 'Emily Jones', 'emily.jo@outlook.com', '417 Pine Fairview PA', '396-5367149', 'Bit');
commit;
prompt 300 records committed...
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (79147, 'Jane Johnson', 'jane.joh@hotmail.com', '967 High Madison MI', '827-1985393', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (54956, 'Emily Taylor', 'emily.ta@hotmail.com', '736 Elm Springfield ', '329-8871782', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91928, 'John Brown', 'john.bro@outlook.com', '961 Oak Franklin MI', '645-9018307', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91396, 'Sarah Jones', 'sarah.jone@yahoo.com', '615 High Greenville ', '624-8915836', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (31638, 'Chris Williams', 'chris.wi@hotmail.com', '666 Cedar Georgetown', '477-8939664', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91445, 'Chris Williams', 'chris.will@yahoo.com', '256 High Greenville ', '580-4328093', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (74187, 'Alex Johnson', 'alex.joh@outlook.com', '639 High Clinton GA', '889-4081060', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (71975, 'David Johnson', 'david.john@gmail.com', '481 2nd Franklin GA', '334-7597333', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (85098, 'Alex Smith', 'alex.smi@outlook.com', '500 Broadway Fairvie', '386-4234125', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (28265, 'Sarah Davis', 'sarah.da@hotmail.com', '640 3rd Springfield ', '408-7003884', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (29702, 'David Moore', 'david.moor@gmail.com', '701 Broadway Fairvie', '673-8748860', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (18702, 'Sarah Taylor', 'sarah.ta@hotmail.com', '997 Main Clinton TX', '337-9995398', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (63489, 'Emily Miller', 'emily.mi@example.com', '880 Maple Springfiel', '158-7992149', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (11713, 'Michael Smith', 'michael.@example.com', '717 Elm Riverside TX', '518-3643990', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (25980, 'Katie Davis', 'katie.davi@yahoo.com', '131 Cedar Greenfield', '875-3419793', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (94578, 'David Taylor', 'david.tayl@gmail.com', '678 3rd Springfield ', '713-4104557', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (41762, 'Sarah Miller', 'sarah.mill@yahoo.com', '492 3rd Springfield ', '436-5929666', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (66071, 'Michael Jones', 'michael.@outlook.com', '993 Main Riverside M', '656-7201341', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (7029, 'Emily Williams', 'emily.will@yahoo.com', '778 Maple Greenfield', '397-4195544', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (38883, 'David Brown', 'david.br@hotmail.com', '739 Elm Franklin MI', '837-1732776', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (58436, 'David Moore', 'david.mo@outlook.com', '467 Pine Riverside T', '183-9124185', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (96382, 'Alex Taylor', 'alex.tay@outlook.com', '957 Main Fairview PA', '163-5823845', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (98984, 'John Smith', 'john.smi@hotmail.com', '904 Elm Clinton TX', '756-6263689', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (33584, 'Katie Brown', 'katie.br@example.com', '331 3rd Madison IL', '743-8999983', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (51400, 'Alex Brown', 'alex.brown@yahoo.com', '738 Pine Madison OH', '800-7192066', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (74647, 'Laura Wilson', 'laura.wils@yahoo.com', '370 Elm Springfield ', '930-3236814', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (25902, 'Sarah Brown', 'sarah.br@outlook.com', '710 High Springfield', '880-6305138', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (16596, 'Katie Wilson', 'katie.wils@yahoo.com', '492 High Clinton NY', '600-6805545', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (67227, 'Alex Johnson', 'alex.joh@example.com', '556 Cedar Madison FL', '714-1332627', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (25429, 'Sarah Moore', 'sarah.moor@yahoo.com', '653 Elm Springfield ', '118-9405386', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (58806, 'Chris Miller', 'chris.mi@example.com', '218 Pine Franklin MI', '648-9071860', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (62668, 'Alex Taylor', 'alex.taylo@yahoo.com', '501 Maple Clinton FL', '263-4811601', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (14928, 'Sarah Wilson', 'sarah.wils@yahoo.com', '742 Oak Springfield ', '486-4496997', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (57243, 'Emily Wilson', 'emily.wi@hotmail.com', '728 Elm Fairview IL', '591-2307588', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (60419, 'John Davis', 'john.dav@outlook.com', '602 Oak Fairview GA', '346-8699843', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (71642, 'John Moore', 'john.moo@outlook.com', '505 Main Fairview GA', '497-9397982', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (64193, 'David Miller', 'david.mill@gmail.com', '199 Oak Clinton TX', '163-1117571', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (19348, 'Chris Johnson', 'chris.john@gmail.com', '186 Pine Madison CA', '506-6388662', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (66299, 'Michael Smith', 'michael.@example.com', '510 Broadway Clinton', '308-5006077', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (99888, 'Sarah Moore', 'sarah.moor@gmail.com', '677 Cedar Springfiel', '364-9711009', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (77906, 'Alex Jones', 'alex.jones@yahoo.com', '409 Main Clinton TX', '988-6412426', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (16243, 'Michael Smith', 'michael.@example.com', '582 Elm Fairview PA', '309-2558871', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (19936, 'Emily Taylor', 'emily.ta@outlook.com', '965 Elm Clinton PA', '106-3945909', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (50786, 'Emily Moore', 'emily.mo@example.com', '585 Pine Springfield', '940-4561336', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (18952, 'Katie Miller', 'katie.mill@gmail.com', '111 2nd Greenfield O', '855-4844322', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (44652, 'Sarah Miller', 'sarah.mi@hotmail.com', '439 Oak Franklin IL', '536-4992829', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (29478, 'Jane Davis', 'jane.dav@example.com', '159 Cedar Madison MI', '484-8036281', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42377, 'Sarah Brown', 'sarah.brow@gmail.com', '688 High Clinton IL', '733-3289069', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (3398, 'Emily Taylor', 'emily.ta@outlook.com', '819 Cedar Georgetown', '322-8669536', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (93600, 'Katie Davis', 'katie.davi@gmail.com', '837 Elm Springfield ', '852-9876242', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (15217, 'David Davis', 'david.da@outlook.com', '699 Oak Clinton NC', '251-1565707', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (24467, 'Michael Smith', 'michael.@example.com', '821 Pine Georgetown ', '187-2043793', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (10276, 'Michael Johnson', 'michael.jo@yahoo.com', '457 High Greenfield ', '929-7043499', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (3877, 'Katie Miller', 'katie.mi@example.com', '180 Cedar Riverside ', '449-7618322', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (12768, 'Michael Johnson', 'michael.jo@gmail.com', '600 High Springfield', '633-8867999', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (26529, 'Laura Jones', 'laura.jo@hotmail.com', '651 Oak Madison PA', '934-1388883', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (19080, 'Chris Johnson', 'chris.john@yahoo.com', '533 Pine Franklin NC', '463-2732977', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (82022, 'Chris Jones', 'chris.jo@hotmail.com', '388 Pine Springfield', '518-4197807', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (99958, 'Katie Wilson', 'katie.wi@example.com', '658 Maple Bristol CA', '919-3448806', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97712, 'Laura Brown', 'laura.br@example.com', '539 High Greenville ', '846-3929178', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (60528, 'Alex Johnson', 'alex.joh@outlook.com', '758 Maple Greenfield', '535-7563690', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (71890, 'Laura Williams', 'laura.will@gmail.com', '759 High Madison TX', '944-7698428', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (50747, 'Alex Wilson', 'alex.wilso@gmail.com', '996 Maple Fairview N', '406-7766161', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (64456, 'Alex Brown', 'alex.bro@outlook.com', '498 Maple Greenfield', '890-7139177', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (51223, 'David Smith', 'david.smit@yahoo.com', '760 Broadway Greenvi', '579-7939113', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (55455, 'Emily Williams', 'emily.will@gmail.com', '595 High Bristol MI', '695-2469722', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (74937, 'Emily Taylor', 'emily.ta@outlook.com', '883 Maple Springfiel', '529-1534852', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (31125, 'Jane Davis', 'jane.dav@outlook.com', '820 Pine Fairview FL', '566-6514772', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42953, 'Katie Johnson', 'katie.jo@outlook.com', '382 Elm Greenfield I', '159-6005766', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (70755, 'David Jones', 'david.jone@yahoo.com', '867 Elm Madison NY', '276-3859674', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (3645, 'Chris Miller', 'chris.mi@hotmail.com', '276 Pine Bristol CA', '288-6473149', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (5359, 'Sarah Johnson', 'sarah.jo@outlook.com', '313 Oak Springfield ', '882-9474360', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (64893, 'Katie Wilson', 'katie.wi@example.com', '576 Cedar Madison NC', '901-2336453', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (76981, 'Alex Moore', 'alex.moore@yahoo.com', '773 Broadway Georget', '416-6839713', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (70521, 'Michael Brown', 'michael.@example.com', '294 Elm Greenfield M', '512-5145951', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (41744, 'John Williams', 'john.willi@gmail.com', '618 Oak Fairview TX', '588-8529969', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (83131, 'John Davis', 'john.dav@example.com', '334 Pine Clinton NY', '304-6659467', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (51184, 'Katie Brown', 'katie.brow@yahoo.com', '872 Cedar Greenfield', '698-3679424', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (84145, 'Jane Williams', 'jane.wil@outlook.com', '241 3rd Greenfield P', '468-7186753', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (10215, 'Jane Smith', 'jane.smith@gmail.com', '555 Elm Greenfield I', '953-3719662', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (23284, 'Chris Taylor', 'chris.ta@example.com', '892 3rd Georgetown P', '218-1759549', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (99072, 'Emily Smith', 'emily.smit@gmail.com', '612 3rd Greenfield C', '838-9187361', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (9421, 'Katie Williams', 'katie.wi@outlook.com', '138 Broadway Greenfi', '863-1468632', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (5810, 'Sarah Miller', 'sarah.mill@gmail.com', '964 Maple Madison PA', '859-7539095', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (46454, 'Chris Davis', 'chris.da@hotmail.com', '946 2nd Greenfield T', '644-8928678', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (37844, 'Alex Miller', 'alex.mil@example.com', '402 Pine Riverside P', '315-2132540', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (46523, 'Sarah Taylor', 'sarah.ta@hotmail.com', '302 Cedar Madison GA', '172-4841790', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91524, 'Laura Johnson', 'laura.john@yahoo.com', '187 2nd Clinton NC', '453-6807388', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (35577, 'Laura Davis', 'laura.davi@yahoo.com', '796 Cedar Springfiel', '617-9601433', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (62962, 'Jane Johnson', 'jane.joh@example.com', '254 Pine Franklin CA', '651-6138480', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (647, 'John Moore', 'john.moore@yahoo.com', '585 3rd Franklin NY', '140-2689837', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (68159, 'Jane Davis', 'jane.dav@hotmail.com', '712 3rd Greenville C', '736-5876410', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (86505, 'Chris Taylor', 'chris.ta@outlook.com', '904 Broadway Georget', '726-5338436', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (79427, 'Emily Miller', 'emily.mi@hotmail.com', '506 2nd Georgetown P', '989-5265854', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (11110, 'Katie Smith', 'katie.smit@yahoo.com', '493 Pine Bristol TX', '288-2565545', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (95545, 'Sarah Moore', 'sarah.mo@example.com', '837 Cedar Madison TX', '719-2423125', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (12636, 'Katie Smith', 'katie.sm@outlook.com', '190 High Franklin OH', '900-8812250', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91311, 'Michael Brown', 'michael.@hotmail.com', '199 Pine Madison PA', '583-5607592', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (70061, 'Katie Smith', 'katie.smit@yahoo.com', '588 Cedar Madison NC', '573-2783146', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (67425, 'Laura Moore', 'laura.mo@example.com', '889 Main Springfield', '445-8765859', 'Cash');
commit;
prompt 400 records committed...
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (83210, 'Emily Miller', 'emily.mill@yahoo.com', '959 Cedar Bristol TX', '300-5729523', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (38940, 'David Miller', 'david.mill@gmail.com', '105 Pine Greenville ', '753-8485671', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (24689, 'Laura Brown', 'laura.brow@yahoo.com', '677 High Bristol IL', '394-1453477', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (82382, 'David Johnson', 'david.jo@example.com', '594 High Springfield', '119-5656340', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (6133, 'Michael Miller', 'michael.mi@gmail.com', '541 3rd Greenville I', '451-5065082', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (92239, 'Laura Smith', 'laura.sm@hotmail.com', '805 Broadway Greenvi', '774-7496277', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (38357, 'Jane Jones', 'jane.jon@outlook.com', '125 Main Fairview CA', '766-2168044', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (18340, 'Katie Wilson', 'katie.wils@gmail.com', '286 High Springfield', '740-6916225', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (18906, 'David Moore', 'david.moor@yahoo.com', '238 2nd Greenfield F', '387-3888347', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (57330, 'Katie Jones', 'katie.jo@hotmail.com', '992 High Bristol TX', '875-1608797', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (94347, 'Katie Taylor', 'katie.tayl@yahoo.com', '717 Maple Bristol IL', '610-5315294', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (24658, 'Sarah Taylor', 'sarah.tayl@gmail.com', '239 3rd Georgetown T', '232-5771717', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (78663, 'Michael Jones', 'michael.@example.com', '361 Elm Bristol PA', '347-4669832', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (26544, 'Sarah Johnson', 'sarah.john@yahoo.com', '412 Elm Georgetown P', '274-9598147', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (23957, 'John Taylor', 'john.tay@outlook.com', '530 High Bristol IL', '925-1881171', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (89750, 'David Jones', 'david.jone@yahoo.com', '500 Broadway Georget', '857-6116316', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (82941, 'John Taylor', 'john.tay@outlook.com', '165 High Greenfield ', '755-7238895', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (67485, 'Alex Wilson', 'alex.wilso@gmail.com', '246 2nd Georgetown I', '302-6826798', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91117, 'Katie Moore', 'katie.mo@hotmail.com', '851 High Clinton TX', '994-5654739', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (34130, 'Alex Davis', 'alex.dav@hotmail.com', '530 3rd Springfield ', '236-7495781', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (86400, 'Alex Jones', 'alex.jon@outlook.com', '663 Cedar Georgetown', '750-5921122', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (70647, 'Alex Miller', 'alex.mil@hotmail.com', '692 Oak Fairview NY', '982-8241300', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (4665, 'Jane Smith', 'jane.smi@hotmail.com', '234 Pine Fairview GA', '919-7097439', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (83675, 'Katie Moore', 'katie.mo@outlook.com', '164 Main Clinton PA', '851-1176416', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (53531, 'Chris Smith', 'chris.sm@example.com', '391 Main Greenfield ', '512-6241780', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (93114, 'Jane Wilson', 'jane.wilso@gmail.com', '958 2nd Fairview IL', '265-5439662', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (42158, 'Sarah Brown', 'sarah.brow@yahoo.com', '744 3rd Fairview NY', '443-2922937', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (44628, 'Alex Smith', 'alex.smith@gmail.com', '416 Broadway Riversi', '871-3356824', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97144, 'Jane Johnson', 'jane.joh@outlook.com', '206 Cedar Georgetown', '225-9258296', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (91620, 'David Johnson', 'david.jo@example.com', '687 Elm Franklin NC', '633-4152815', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (27641, 'Chris Smith', 'chris.smit@yahoo.com', '471 High Greenville ', '955-5736933', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (74651, 'Katie Williams', 'katie.wi@outlook.com', '705 High Bristol PA', '119-5846937', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (55303, 'Michael Davis', 'michael.@example.com', '803 High Clinton TX', '772-9043487', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (45399, 'David Smith', 'david.smit@gmail.com', '591 Elm Greenfield P', '151-9263843', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (55984, 'Michael Taylor', 'michael.@example.com', '104 Broadway Riversi', '116-2829614', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (32641, 'Alex Taylor', 'alex.tay@outlook.com', '395 Pine Fairview PA', '234-3545854', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (70515, 'David Johnson', 'david.jo@example.com', '672 2nd Riverside TX', '776-6282396', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (14244, 'Chris Jones', 'chris.jone@yahoo.com', '711 3rd Greenfield G', '889-8043072', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (32409, 'Laura Moore', 'laura.mo@hotmail.com', '669 Elm Greenville F', '329-5891605', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (64040, 'David Brown', 'david.br@hotmail.com', '367 Cedar Greenfield', '295-1573260', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (36176, 'Alex Taylor', 'alex.tay@example.com', '798 Broadway Riversi', '860-2124322', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (37209, 'Katie Brown', 'katie.br@hotmail.com', '477 Main Clinton NY', '659-2102763', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (40073, 'Michael Miller', 'michael.@hotmail.com', '527 Maple Madison GA', '771-4642732', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (97912, 'Laura Smith', 'laura.sm@example.com', '685 Broadway Frankli', '717-6479085', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (72048, 'John Johnson', 'john.joh@outlook.com', '636 Elm Springfield ', '695-4635260', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (18219, 'Michael Moore', 'michael.mo@yahoo.com', '983 Maple Madison CA', '496-7241046', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (56456, 'Alex Moore', 'alex.moo@hotmail.com', '839 Maple Greenville', '817-2097411', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (53393, 'Jane Jones', 'jane.jon@example.com', '996 Main Bristol IL', '869-9595358', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (71521, 'Sarah Moore', 'sarah.moor@gmail.com', '456 Cedar Springfiel', '485-9292141', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (60222, 'Alex Smith', 'alex.smi@hotmail.com', '945 2nd Franklin IL', '423-6402263', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (4820, 'Michael Johnson', 'michael.@outlook.com', '529 2nd Greenfield M', '960-9447014', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (1828, 'John Davis', 'john.dav@example.com', '640 3rd Springfield ', '445-1257717', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (10344, 'Alex Moore', 'alex.moo@outlook.com', '781 Elm Franklin NY', '400-6857959', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (87977, 'Alex Wilson', 'alex.wil@outlook.com', '549 Cedar Springfiel', '421-3678665', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (10721, 'Sarah Wilson', 'sarah.wi@outlook.com', '360 2nd Springfield ', '607-7729924', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (22798, 'Jane Moore', 'jane.moo@hotmail.com', '691 3rd Clinton PA', '407-8684087', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (71500, 'Michael Johnson', 'michael.@hotmail.com', '910 Maple Clinton PA', '415-4434459', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (38391, 'Laura Wilson', 'laura.wi@outlook.com', '235 Maple Madison OH', '335-1767479', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (16210, 'Sarah Wilson', 'sarah.wils@yahoo.com', '902 Pine Madison OH', '692-1254290', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (50594, 'Sarah Smith', 'sarah.sm@example.com', '102 2nd Georgetown N', '164-8706773', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (94309, 'Sarah Wilson', 'sarah.wi@hotmail.com', '263 Main Bristol CA', '247-3863078', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (84512, 'Jane Jones', 'jane.jon@example.com', '756 High Franklin NY', '694-4116981', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (52106, 'Chris Miller', 'chris.mi@hotmail.com', '866 3rd Georgetown M', '703-6301852', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (8797, 'David Moore', 'david.mo@example.com', '122 Broadway Frankli', '888-8396101', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (48566, 'Laura Miller', 'laura.mi@hotmail.com', '362 2nd Franklin TX', '987-8465870', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (49187, 'Michael Brown', 'michael.br@yahoo.com', '128 Oak Greenfield N', '121-2207751', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (92453, 'Emily Williams', 'emily.will@gmail.com', '897 Oak Clinton NC', '232-1634107', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (84971, 'Jane Wilson', 'jane.wilso@gmail.com', '761 Pine Springfield', '387-7522754', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (95931, 'Laura Miller', 'laura.mi@outlook.com', '608 High Greenville ', '742-6902562', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (84712, 'Laura Williams', 'laura.wi@hotmail.com', '843 Broadway Madison', '169-9063898', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (9437, 'Michael Taylor', 'michael.@example.com', '561 2nd Springfield ', '484-9183993', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (44275, 'Jane Johnson', 'jane.joh@example.com', '592 Oak Fairview GA', '102-1379332', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (68611, 'Chris Moore', 'chris.moor@yahoo.com', '130 2nd Springfield ', '897-9084615', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (57844, 'Jane Williams', 'jane.wil@hotmail.com', '789 High Greenville ', '563-4297375', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (80481, 'Sarah Davis', 'sarah.da@example.com', '991 Main Georgetown ', '129-2762380', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (86150, 'Katie Johnson', 'katie.john@yahoo.com', '844 Oak Greenfield N', '109-1937711', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (72700, 'David Taylor', 'david.tayl@yahoo.com', '774 Broadway Madison', '839-1637680', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (58038, 'Katie Brown', 'katie.brow@yahoo.com', '866 Cedar Georgetown', '642-9641918', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (44755, 'John Miller', 'john.mille@yahoo.com', '399 Main Greenfield ', '924-8695062', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (9409, 'Jane Williams', 'jane.wil@hotmail.com', '413 Broadway Madison', '254-2974636', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (80219, 'Chris Jones', 'chris.jo@outlook.com', '781 3rd Franklin TX', '177-8787376', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (25370, 'Sarah Miller', 'sarah.mill@yahoo.com', '980 Cedar Bristol NY', '717-3767543', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (52720, 'Laura Jones', 'laura.jone@yahoo.com', '478 Pine Fairview CA', '884-7396468', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (33470, 'Laura Taylor', 'laura.tayl@yahoo.com', '712 Elm Fairview OH', '972-4595434', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (11020, 'Jane Moore', 'jane.moo@example.com', '215 Elm Franklin TX', '914-3367868', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (27133, 'Emily Miller', 'emily.mi@example.com', '941 Oak Bristol NY', '439-4839567', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (7721, 'Laura Brown', 'laura.br@hotmail.com', '799 Cedar Fairview C', '450-4158567', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (49215, 'Katie Miller', 'katie.mill@gmail.com', '314 3rd Georgetown N', '485-2818773', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (14023, 'Emily Taylor', 'emily.tayl@yahoo.com', '936 Oak Clinton NY', '397-2012055', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (77193, 'John Jones', 'john.jones@gmail.com', '499 Elm Springfield ', '401-1502488', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (9732, 'Sarah Davis', 'sarah.da@hotmail.com', '708 High Fairview NC', '188-9264625', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (72669, 'Laura Jones', 'laura.jo@outlook.com', '968 Pine Springfield', '600-2593051', 'Bit');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (80825, 'David Taylor', 'david.tayl@gmail.com', '104 Broadway Madison', '484-9649907', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (90975, 'Michael Taylor', 'michael.@hotmail.com', '386 Main Greenville ', '607-4528419', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (73248, 'Michael Johnson', 'michael.@hotmail.com', '196 Elm Georgetown O', '303-9917273', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (58530, 'Jane Wilson', 'jane.wilso@gmail.com', '520 Elm Greenfield C', '333-5396028', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (22904, 'Jane Taylor', 'jane.tay@outlook.com', '449 3rd Franklin TX', '804-5706725', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (45268, 'Jane Brown', 'jane.brown@gmail.com', '516 Main Madison PA', '461-3065078', 'Cash');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (55374, 'Chris Brown', 'chris.br@outlook.com', '765 Cedar Greenfield', '865-1196841', 'CreditCard');
insert into CUSTOMER (customer_id, name, email, address, phonenumber, paymentdetails)
values (5630, 'Michael Jones', 'michael.@hotmail.com', '408 2nd Greenville N', '444-2858787', 'CreditCard');
commit;
prompt 500 records loaded
prompt Loading THE_ORDER...
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (57077, 1770673, to_date('19-09-2020', 'dd-mm-yyyy'), '84 Berry Street', '131-9221032', 10344);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (53411, 2098450, to_date('20-07-2020', 'dd-mm-yyyy'), '972 France Drive', '175-9749531', 50747);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (36871, 9951877, to_date('28-09-2021', 'dd-mm-yyyy'), '24 Zahn Street', '731-3324142', 66224);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28283, 7663054, to_date('29-08-2023', 'dd-mm-yyyy'), '58 Rains Blvd', '995-4963084', 18219);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (72062, 9288581, to_date('20-11-2021', 'dd-mm-yyyy'), '18 Hilversum Street', '624-7111650', 689);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (97753, 1500086, to_date('24-03-2021', 'dd-mm-yyyy'), '243 Shandling Drive', '479-2529685', 66975);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (56070, 9756503, to_date('04-10-2021', 'dd-mm-yyyy'), '30 Lofgren Blvd', '987-2416388', 49187);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (12685, 684820, to_date('28-12-2022', 'dd-mm-yyyy'), '59 Bonneville Drive', '282-2908735', 55531);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (82852, 5113651, to_date('07-03-2021', 'dd-mm-yyyy'), '31 Harris', '995-4889461', 73696);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (49364, 645558, to_date('15-02-2021', 'dd-mm-yyyy'), '593 Gore Ave', '295-7960251', 72669);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (33113, 1349396, to_date('16-09-2021', 'dd-mm-yyyy'), '92 Laguna Bbeach Str', '570-1934418', 67425);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (74692, 4169251, to_date('13-03-2022', 'dd-mm-yyyy'), '63 Bening Road', '476-1282348', 71890);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (66529, 7772874, to_date('07-09-2022', 'dd-mm-yyyy'), '93rd Street', '762-3802611', 97712);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (18882, 8228354, to_date('29-11-2021', 'dd-mm-yyyy'), '73rd Street', '689-8767219', 70323);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (47533, 8328659, to_date('04-02-2022', 'dd-mm-yyyy'), '11st Street', '137-9641318', 21008);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (86385, 1009993, to_date('16-03-2022', 'dd-mm-yyyy'), '62 Marie Street', '668-4448512', 38357);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (54306, 5361153, to_date('29-05-2023', 'dd-mm-yyyy'), '58 Brisbane Drive', '490-4874749', 61882);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (54628, 8366479, to_date('31-07-2023', 'dd-mm-yyyy'), '75 Cronin Drive', '638-3907205', 18702);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (62325, 2219530, to_date('27-11-2021', 'dd-mm-yyyy'), '65 Sam Road', '944-7685119', 95704);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (57504, 5795786, to_date('13-10-2021', 'dd-mm-yyyy'), '9 Kurtwood Road', '955-5407627', 49645);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (95438, 734651, to_date('30-04-2021', 'dd-mm-yyyy'), '52 Thurman Street', '918-4481840', 26035);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (80048, 704430, to_date('14-03-2022', 'dd-mm-yyyy'), '68 Sylvester Drive', '522-4865122', 91311);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (59384, 9509458, to_date('12-01-2022', 'dd-mm-yyyy'), '78 Chirignago', '367-7359266', 88664);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10566, 3893651, to_date('02-05-2023', 'dd-mm-yyyy'), '71st Street', '220-3640773', 86505);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (23183, 4890636, to_date('07-02-2023', 'dd-mm-yyyy'), '92 Candice Blvd', '179-4877047', 97929);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (2114, 5271254, to_date('11-08-2020', 'dd-mm-yyyy'), '94 O''Connor Ave', '736-2919258', 92450);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (63692, 5238063, to_date('05-06-2022', 'dd-mm-yyyy'), '86 Hampton Road', '397-7005136', 49215);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (98946, 5873332, to_date('12-02-2024', 'dd-mm-yyyy'), '18 Alessandro Drive', '552-1730056', 21210);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (4034, 2603850, to_date('29-09-2021', 'dd-mm-yyyy'), '327 Garry Road', '446-3225655', 92207);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81540, 7339895, to_date('16-07-2023', 'dd-mm-yyyy'), '81 DiFranco Street', '350-1071802', 58806);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (23755, 255576, to_date('05-02-2022', 'dd-mm-yyyy'), '94 Allison Ave', '933-2626839', 56199);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (55355, 5541658, to_date('16-09-2021', 'dd-mm-yyyy'), '4 Santa Cruz Drive', '234-7135359', 88114);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (83629, 1197090, to_date('14-04-2023', 'dd-mm-yyyy'), '423 Gilberto Road', '321-9225001', 91928);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (8310, 806472, to_date('02-08-2021', 'dd-mm-yyyy'), '1 Ronnie Road', '280-8550657', 70061);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (67669, 2219599, to_date('15-03-2021', 'dd-mm-yyyy'), '970 Swoosie Ave', '233-2666632', 10744);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (16969, 1538393, to_date('11-06-2023', 'dd-mm-yyyy'), '500 Katie Street', '610-4464147', 52106);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (71262, 4990716, to_date('04-05-2022', 'dd-mm-yyyy'), '43 Niigata Drive', '516-5608836', 55374);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (50003, 808182, to_date('11-03-2023', 'dd-mm-yyyy'), '21 Lena Street', '858-4547928', 60222);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (88121, 2634806, to_date('08-09-2023', 'dd-mm-yyyy'), '3 Costa Ave', '434-1355587', 76036);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (11926, 6497018, to_date('24-05-2021', 'dd-mm-yyyy'), '93 Thomas', '414-4372843', 64456);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (2533, 7219450, to_date('21-04-2023', 'dd-mm-yyyy'), '65 New Hope Road', '907-3335966', 93405);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (66973, 4732407, to_date('28-02-2021', 'dd-mm-yyyy'), '315 Frederiksberg Ro', '633-6101038', 3645);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (91505, 7009770, to_date('13-10-2022', 'dd-mm-yyyy'), '51 Hayward Drive', '924-8256362', 647);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (97512, 1473300, to_date('30-11-2020', 'dd-mm-yyyy'), '93 Rozenburg', '448-8280312', 37588);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (50714, 2654251, to_date('25-06-2020', 'dd-mm-yyyy'), '41 Derek Ave', '870-9082250', 64893);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (33352, 6760835, to_date('21-03-2023', 'dd-mm-yyyy'), '441 Wolf Drive', '695-9932510', 86783);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (22780, 6161120, to_date('14-11-2023', 'dd-mm-yyyy'), '44 Turner Drive', '395-4522969', 42158);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (61383, 6128358, to_date('04-12-2022', 'dd-mm-yyyy'), '33 Vassar Road', '245-9850195', 63004);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (11223, 8198249, to_date('06-02-2021', 'dd-mm-yyyy'), '99 Mariano Comense A', '803-9540975', 59374);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (59136, 8865235, to_date('02-12-2023', 'dd-mm-yyyy'), '63rd Street', '933-4989917', 11713);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (87178, 1407192, to_date('08-09-2022', 'dd-mm-yyyy'), '50 Bad Oeynhausen St', '364-8032812', 84191);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (42861, 437732, to_date('28-08-2022', 'dd-mm-yyyy'), '80 Perez Street', '659-8152298', 97712);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (5774, 7407541, to_date('28-06-2022', 'dd-mm-yyyy'), '85 Phoenix Street', '697-8530019', 24008);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (66539, 3340947, to_date('21-02-2022', 'dd-mm-yyyy'), '93rd Street', '152-6390629', 44605);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (5737, 1550934, to_date('06-11-2022', 'dd-mm-yyyy'), '98 Sewell Street', '296-2029142', 41976);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (2812, 9486462, to_date('03-03-2023', 'dd-mm-yyyy'), '72 Janeane Drive', '672-7207503', 23284);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (21582, 5864494, to_date('02-11-2021', 'dd-mm-yyyy'), '81 Barbara Street', '555-1077601', 77906);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (67912, 4424335, to_date('27-07-2020', 'dd-mm-yyyy'), '30 Wen Street', '839-2547984', 93298);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (96729, 6176492, to_date('19-11-2022', 'dd-mm-yyyy'), '49 Eric Street', '592-5877907', 10721);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (19438, 2237516, to_date('24-07-2023', 'dd-mm-yyyy'), '36 Tualatin Street', '381-8279007', 44605);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (12438, 4321567, to_date('18-01-2023', 'dd-mm-yyyy'), '87 Clive Street', '813-2214525', 76784);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (66572, 3938739, to_date('06-08-2020', 'dd-mm-yyyy'), '27 Weston Road', '487-6775341', 61000);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (42241, 4082303, to_date('21-11-2022', 'dd-mm-yyyy'), '79 Curtis-Hall Ave', '585-2581285', 68611);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (9029, 9475227, to_date('14-08-2020', 'dd-mm-yyyy'), '92 De Niro Street', '628-6040228', 69825);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (9821, 3290215, to_date('19-06-2023', 'dd-mm-yyyy'), '21 Sewell Street', '983-1706722', 32912);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (84737, 6077770, to_date('14-02-2023', 'dd-mm-yyyy'), '466 Mount Laurel Roa', '417-2239879', 50786);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (51696, 7727150, to_date('29-11-2020', 'dd-mm-yyyy'), '749 New Delhi', '891-3426287', 54553);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (87839, 4132784, to_date('03-11-2021', 'dd-mm-yyyy'), '45 Damon Drive', '147-5547359', 48677);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (8113, 8428136, to_date('28-10-2020', 'dd-mm-yyyy'), '30 Matthau Road', '697-6668371', 91311);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10259, 7714557, to_date('16-07-2020', 'dd-mm-yyyy'), '66 Omaha Drive', '602-6796847', 16243);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (51130, 3793171, to_date('16-02-2024', 'dd-mm-yyyy'), '91 Burke Road', '132-5650871', 3131);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (66048, 8022676, to_date('19-07-2021', 'dd-mm-yyyy'), '63 Fiennes Drive', '588-2343024', 49215);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (1118, 9527365, to_date('20-07-2022', 'dd-mm-yyyy'), '27 Strong Blvd', '436-1302973', 55688);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (16053, 4427576, to_date('26-03-2021', 'dd-mm-yyyy'), '91 Mount Olive Stree', '194-5963970', 91445);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (22437, 4856579, to_date('29-12-2020', 'dd-mm-yyyy'), '55 Chaam Blvd', '660-4498482', 62576);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (4444, 8223834, to_date('22-08-2020', 'dd-mm-yyyy'), '14 Spring Valley Str', '552-7498573', 10215);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (14559, 3747770, to_date('13-12-2020', 'dd-mm-yyyy'), '6 Talvin Street', '257-1692772', 94944);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (67327, 1704660, to_date('20-09-2022', 'dd-mm-yyyy'), '96 Kier Drive', '895-2469230', 18702);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (86669, 3555546, to_date('28-01-2023', 'dd-mm-yyyy'), '409 Purefoy', '901-2717534', 44652);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (47982, 252986, to_date('21-09-2020', 'dd-mm-yyyy'), '82nd Street', '517-4905260', 26650);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (27019, 6881021, to_date('13-11-2021', 'dd-mm-yyyy'), '91st Street', '848-9940967', 3305);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (90574, 3803719, to_date('27-10-2021', 'dd-mm-yyyy'), '33 Trevino Drive', '329-1616267', 63220);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (4520, 5149907, to_date('09-09-2023', 'dd-mm-yyyy'), '20 Marley Road', '641-5335938', 88664);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (21253, 905929, to_date('13-09-2022', 'dd-mm-yyyy'), '76 Lari Street', '832-9424263', 16425);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (61508, 2470183, to_date('10-05-2022', 'dd-mm-yyyy'), '34 Raybon Street', '186-8978721', 1067);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (36202, 2372550, to_date('07-09-2020', 'dd-mm-yyyy'), '50 Lippetal Blvd', '978-9954373', 21318);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (99197, 6462719, to_date('07-08-2022', 'dd-mm-yyyy'), '11 Neuquen Ave', '722-9387256', 6133);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (96065, 6794769, to_date('28-11-2020', 'dd-mm-yyyy'), '58 Rosco Blvd', '887-1290575', 5324);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (49131, 3432138, to_date('05-08-2020', 'dd-mm-yyyy'), '50 Porto alegre Stre', '263-9279472', 61882);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (57639, 7476492, to_date('30-01-2022', 'dd-mm-yyyy'), '77 Brooke Road', '455-1873995', 28182);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (88276, 3859085, to_date('28-05-2022', 'dd-mm-yyyy'), '478 Charlton Street', '194-5354407', 94309);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (41824, 6519495, to_date('06-04-2021', 'dd-mm-yyyy'), '9 Crouch Road', '498-9866841', 93754);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (73649, 2206770, to_date('01-06-2020', 'dd-mm-yyyy'), '224 Sevilla Drive', '734-7097418', 969);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (63965, 9464071, to_date('24-09-2020', 'dd-mm-yyyy'), '3 Elizabeth Street', '529-7520686', 71391);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (83877, 7769203, to_date('18-08-2021', 'dd-mm-yyyy'), '134 Foster City Stre', '352-2873236', 74286);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (97566, 4681788, to_date('29-04-2023', 'dd-mm-yyyy'), '45 Winans Road', '888-1864310', 37209);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (74438, 6753699, to_date('06-04-2023', 'dd-mm-yyyy'), '523 Holly Road', '119-6590630', 38753);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (77767, 6915165, to_date('03-11-2021', 'dd-mm-yyyy'), '58 Carol Drive', '680-5070118', 77906);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (21754, 5083750, to_date('27-10-2020', 'dd-mm-yyyy'), '9 Sugar Hill Street', '485-2075647', 74187);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (78900, 4314414, to_date('15-07-2023', 'dd-mm-yyyy'), '29 Uggams Blvd', '737-1742549', 27971);
commit;
prompt 100 records committed...
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (11585, 2721041, to_date('29-06-2020', 'dd-mm-yyyy'), '22 Rutger Street', '154-7992454', 88114);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (22197, 1843019, to_date('18-06-2022', 'dd-mm-yyyy'), '8 Tampa Blvd', '524-6235850', 39945);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (91387, 4699187, to_date('25-11-2021', 'dd-mm-yyyy'), '24 Rawlins Street', '943-9134346', 96987);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (45816, 1878100, to_date('07-06-2022', 'dd-mm-yyyy'), '12 Leon Road', '287-9319271', 62025);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (47843, 1984093, to_date('17-12-2023', 'dd-mm-yyyy'), '2 Fariq Road', '449-5333331', 4665);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (38831, 8977703, to_date('06-08-2023', 'dd-mm-yyyy'), '87 Maureen Road', '574-1714040', 28759);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (63677, 8755973, to_date('05-12-2022', 'dd-mm-yyyy'), '73 Vondie Road', '723-2293871', 79361);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10932, 7426987, to_date('10-08-2020', 'dd-mm-yyyy'), '19 Logue Street', '287-2048506', 32409);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (22192, 1828029, to_date('06-12-2023', 'dd-mm-yyyy'), '24 Gainesville Stree', '182-5226016', 45017);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (18335, 478898, to_date('31-12-2023', 'dd-mm-yyyy'), '9 Claire Street', '324-7234029', 89204);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (27335, 8699978, to_date('10-10-2023', 'dd-mm-yyyy'), '16 Marie Street', '518-1054557', 61931);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (7816, 2792076, to_date('16-03-2023', 'dd-mm-yyyy'), '606 Slmea Ave', '170-3336499', 5324);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (35465, 2366752, to_date('05-01-2021', 'dd-mm-yyyy'), '85 Lloyd Drive', '922-5389665', 96382);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (18177, 8457574, to_date('23-11-2020', 'dd-mm-yyyy'), '97 Shand Street', '258-2111295', 16596);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (91407, 9904837, to_date('11-05-2022', 'dd-mm-yyyy'), '85 Hjallerup', '879-4357808', 98467);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (22335, 3475552, to_date('12-05-2022', 'dd-mm-yyyy'), '85 Rush Street', '333-4278302', 42636);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (43408, 3368468, to_date('15-02-2024', 'dd-mm-yyyy'), '72nd Street', '145-7741204', 21621);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (96572, 4516168, to_date('04-12-2021', 'dd-mm-yyyy'), '26 Oates Road', '316-5275148', 31638);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10356, 3586990, to_date('13-07-2022', 'dd-mm-yyyy'), '28 Drew Drive', '619-8123958', 71521);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (78466, 1153407, to_date('27-04-2022', 'dd-mm-yyyy'), '17 Strathairn Blvd', '189-6030698', 92025);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (16157, 5067913, to_date('21-05-2023', 'dd-mm-yyyy'), '903 Belgrad Drive', '968-9901878', 18219);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (77726, 3650607, to_date('11-01-2023', 'dd-mm-yyyy'), '301 Shepherd', '405-4260697', 86400);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (76495, 2884552, to_date('28-10-2021', 'dd-mm-yyyy'), '2 Gabrielle Road', '166-3309576', 86150);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (47884, 9193054, to_date('02-10-2020', 'dd-mm-yyyy'), '49 Boulogne Street', '285-6327216', 57611);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (48875, 867868, to_date('17-06-2020', 'dd-mm-yyyy'), '682 Lapointe', '686-4371874', 72048);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (62735, 3570280, to_date('22-09-2020', 'dd-mm-yyyy'), '64 Hatfield Road', '215-1247903', 98467);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (87308, 9684163, to_date('02-01-2024', 'dd-mm-yyyy'), '73 McDiarmid Road', '148-8815711', 17421);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (90694, 5313703, to_date('22-12-2023', 'dd-mm-yyyy'), '60 Patton Street', '937-6229315', 8358);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (70141, 1839524, to_date('13-04-2023', 'dd-mm-yyyy'), '93 Victor Drive', '653-4753992', 71464);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (40032, 9615108, to_date('25-09-2021', 'dd-mm-yyyy'), '82 Woodward Drive', '821-2110696', 11541);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (22650, 8304175, to_date('09-05-2023', 'dd-mm-yyyy'), '21st Street', '797-6181279', 33470);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28183, 3933758, to_date('17-09-2020', 'dd-mm-yyyy'), '400 Lahr Drive', '413-8641609', 54590);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (34345, 67909, to_date('22-05-2023', 'dd-mm-yyyy'), '44 Ledger Street', '583-8865730', 99958);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (91588, 7699250, to_date('25-04-2022', 'dd-mm-yyyy'), '36 Macy Road', '664-1368715', 25581);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (15909, 5475025, to_date('13-06-2022', 'dd-mm-yyyy'), '45 Viterelli Blvd', '317-8523439', 29702);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (77972, 5991012, to_date('11-11-2020', 'dd-mm-yyyy'), '93 North Sydney Road', '838-9139049', 42377);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (91283, 1612504, to_date('05-03-2021', 'dd-mm-yyyy'), '86 Klein Drive', '934-3996915', 24115);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (94072, 8797477, to_date('02-01-2023', 'dd-mm-yyyy'), '43 Guzman Street', '204-2369928', 5630);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (24369, 6412733, to_date('02-12-2021', 'dd-mm-yyyy'), '347 Alessandria Road', '362-9093990', 88664);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (66102, 5580407, to_date('12-11-2021', 'dd-mm-yyyy'), '18 Kejae City Blvd', '826-7167565', 84726);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (60877, 8972324, to_date('29-08-2022', 'dd-mm-yyyy'), '62 Atlanta Road', '793-5783326', 46454);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (84015, 9755518, to_date('27-09-2021', 'dd-mm-yyyy'), '23 Pleasence', '610-7556358', 65687);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (22387, 9190324, to_date('27-12-2020', 'dd-mm-yyyy'), '37 Moffat Drive', '513-6177501', 61882);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (14050, 186924, to_date('03-12-2021', 'dd-mm-yyyy'), '535 Belgrad Road', '908-7230382', 63220);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (65669, 5763656, to_date('28-07-2020', 'dd-mm-yyyy'), '81st Street', '442-3174629', 79696);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28782, 9011730, to_date('28-12-2023', 'dd-mm-yyyy'), '473 Vonda Street', '304-7600254', 82382);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (60250, 4306100, to_date('24-07-2020', 'dd-mm-yyyy'), '11 Meredith Road', '240-6606110', 4304);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (13698, 6148680, to_date('06-02-2022', 'dd-mm-yyyy'), '92 Spacek Road', '176-7905876', 54956);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (57329, 8009606, to_date('03-02-2021', 'dd-mm-yyyy'), '67 Burton Street', '880-9723593', 61363);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (21810, 7163874, to_date('27-10-2023', 'dd-mm-yyyy'), '49 Carlene Road', '851-4709995', 69306);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (32261, 8976922, to_date('23-07-2020', 'dd-mm-yyyy'), '717 Gellar Drive', '747-9727503', 92453);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (56376, 7595209, to_date('10-12-2023', 'dd-mm-yyyy'), '537 Rourke Road', '977-7808353', 97861);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (96383, 867092, to_date('13-08-2023', 'dd-mm-yyyy'), '95 Sylvian Drive', '968-3886663', 25113);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (97495, 268458, to_date('10-11-2021', 'dd-mm-yyyy'), '46 Gil Street', '531-5180357', 969);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (17773, 1143868, to_date('30-08-2020', 'dd-mm-yyyy'), '16 Weiland Road', '599-7201198', 44681);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (7721, 5850041, to_date('24-12-2020', 'dd-mm-yyyy'), '549 Fariq Street', '217-5454498', 41762);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (73091, 5351852, to_date('06-12-2022', 'dd-mm-yyyy'), '80 Cambridge Street', '172-5070861', 79147);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (38062, 5168044, to_date('13-09-2020', 'dd-mm-yyyy'), '73 Liotta Road', '209-3599840', 43410);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (39336, 706326, to_date('23-04-2023', 'dd-mm-yyyy'), '51 Crowe Drive', '963-1984772', 87977);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28689, 6281042, to_date('22-06-2023', 'dd-mm-yyyy'), '60 Osbourne', '659-4900323', 40098);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (57784, 4750077, to_date('04-03-2021', 'dd-mm-yyyy'), '92nd Street', '290-3616022', 15424);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81884, 6206447, to_date('18-07-2022', 'dd-mm-yyyy'), '81 Rita Road', '396-9099843', 55703);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (95181, 7347639, to_date('20-11-2022', 'dd-mm-yyyy'), '47 Mewes Ave', '493-3441305', 82022);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (47020, 216498, to_date('04-06-2021', 'dd-mm-yyyy'), '62nd Street', '630-1117799', 63489);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (5715, 5634040, to_date('05-08-2020', 'dd-mm-yyyy'), '8 Sinatra Road', '361-4408257', 84145);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (4993, 1853094, to_date('04-09-2023', 'dd-mm-yyyy'), '60 Dorval', '980-1684132', 84609);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (82274, 5472711, to_date('04-01-2024', 'dd-mm-yyyy'), '65 Li Blvd', '159-2098912', 54325);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (53536, 2930528, to_date('28-03-2021', 'dd-mm-yyyy'), '368 Todd Street', '183-8013333', 96613);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28916, 2336788, to_date('19-11-2022', 'dd-mm-yyyy'), '61st Street', '194-6141686', 80481);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (99892, 924620, to_date('22-11-2023', 'dd-mm-yyyy'), '39 Magstadt Road', '580-1917867', 63220);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10173, 3314091, to_date('31-07-2022', 'dd-mm-yyyy'), '52 Madonna Street', '402-4622107', 42158);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (56461, 9728960, to_date('10-07-2022', 'dd-mm-yyyy'), '51 Warley Road', '887-9470871', 11050);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (60128, 548851, to_date('19-02-2023', 'dd-mm-yyyy'), '588 Frankfurt am Mai', '990-2781942', 79427);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (14838, 9590609, to_date('18-09-2022', 'dd-mm-yyyy'), '89 Smurfit Street', '638-7246592', 71975);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (70037, 2393934, to_date('07-12-2021', 'dd-mm-yyyy'), '27 Hatchet Road', '748-2566790', 22498);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (26864, 8781030, to_date('02-03-2021', 'dd-mm-yyyy'), '1 Byrne Drive', '310-8558362', 64137);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (83058, 4248261, to_date('19-02-2023', 'dd-mm-yyyy'), '12 Lenny Drive', '588-8868395', 6990);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (34506, 5349753, to_date('06-06-2020', 'dd-mm-yyyy'), '96 Santa Cruz Street', '367-5974747', 9612);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (96177, 429426, to_date('24-11-2023', 'dd-mm-yyyy'), '960 Annandale Drive', '743-7993981', 21210);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (7307, 5067232, to_date('30-08-2021', 'dd-mm-yyyy'), '192 Hatosy Street', '983-9443805', 5324);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (85424, 9335721, to_date('01-07-2023', 'dd-mm-yyyy'), '85 Londrina Blvd', '960-2911249', 38391);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (20547, 1096601, to_date('31-12-2021', 'dd-mm-yyyy'), '61st Street', '225-6452819', 30106);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (38522, 4346767, to_date('09-09-2020', 'dd-mm-yyyy'), '34 Albright Drive', '614-3918022', 64909);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (45380, 631870, to_date('17-09-2021', 'dd-mm-yyyy'), '4 Dzundza Road', '910-7900598', 34822);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (78252, 17414, to_date('26-11-2023', 'dd-mm-yyyy'), '98 Pierce Street', '976-2352300', 66299);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (42996, 1886356, to_date('18-10-2022', 'dd-mm-yyyy'), '3 Shirley Road', '144-5763723', 63084);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (95537, 2259631, to_date('05-12-2020', 'dd-mm-yyyy'), '994 Wrzburg Ave', '451-8461930', 42377);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (9721, 7038967, to_date('13-11-2023', 'dd-mm-yyyy'), '853 Gaby Ave', '313-1486334', 8778);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (80574, 9980330, to_date('27-10-2023', 'dd-mm-yyyy'), '61st Street', '779-1625765', 72636);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (20182, 4387409, to_date('21-04-2021', 'dd-mm-yyyy'), '141 El-Saher Ave', '955-7439847', 35942);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (29984, 6424317, to_date('15-10-2022', 'dd-mm-yyyy'), '60 Haverhill Blvd', '582-7157389', 79147);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (48026, 5463221, to_date('05-02-2022', 'dd-mm-yyyy'), '407 Swinton Street', '819-7133787', 11713);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (30419, 7755868, to_date('24-04-2023', 'dd-mm-yyyy'), '10 Vanian Street', '691-4232683', 47195);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (96486, 9691670, to_date('27-11-2020', 'dd-mm-yyyy'), '63rd Street', '506-5041182', 70323);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (80869, 8711101, to_date('31-12-2022', 'dd-mm-yyyy'), '11st Street', '594-5106847', 19348);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (72589, 8496231, to_date('30-08-2020', 'dd-mm-yyyy'), '22 Gerald Street', '233-4293709', 7961);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (97562, 7163456, to_date('18-01-2024', 'dd-mm-yyyy'), '1 Magnuson Road', '838-2631881', 88664);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (19106, 3477406, to_date('11-08-2023', 'dd-mm-yyyy'), '45 Concordville Road', '463-6436904', 74187);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (39025, 9759255, to_date('07-06-2020', 'dd-mm-yyyy'), '13 Frost', '360-1343833', 46523);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (97337, 3874947, to_date('15-09-2020', 'dd-mm-yyyy'), '96 Adkins', '988-9826430', 42953);
commit;
prompt 200 records committed...
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (65834, 8094472, to_date('09-04-2022', 'dd-mm-yyyy'), '83 Mahood Drive', '600-8388753', 85098);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (85934, 9332730, to_date('10-06-2023', 'dd-mm-yyyy'), '33 Schlieren Drive', '546-5444306', 83181);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (61156, 851545, to_date('11-03-2023', 'dd-mm-yyyy'), '795 Osment Street', '390-4777450', 15512);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (53565, 9520038, to_date('24-11-2022', 'dd-mm-yyyy'), '20 Tallahassee Drive', '928-9116851', 55703);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (20550, 2000540, to_date('12-06-2021', 'dd-mm-yyyy'), '17 Ljubljana Blvd', '824-1472873', 93298);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (97948, 442329, to_date('07-05-2022', 'dd-mm-yyyy'), '80 Thorton Street', '442-4207896', 61931);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (1759, 9039341, to_date('13-01-2022', 'dd-mm-yyyy'), '33 Noah Street', '646-9195203', 26035);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (36094, 3398867, to_date('23-01-2021', 'dd-mm-yyyy'), '88 Ruth Drive', '906-6097266', 38357);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10456, 790000, to_date('20-12-2020', 'dd-mm-yyyy'), '18 Buddy Street', '666-2948854', 60222);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (4421, 152469, to_date('22-01-2022', 'dd-mm-yyyy'), '43 Southampton Stree', '921-3121501', 65489);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (22156, 7071975, to_date('10-02-2022', 'dd-mm-yyyy'), '414 Coe Road', '322-3249547', 74286);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (34739, 64793, to_date('28-04-2023', 'dd-mm-yyyy'), '20 Gano Street', '414-3492109', 17352);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (90749, 4303525, to_date('12-06-2020', 'dd-mm-yyyy'), '408 Pretoria Road', '369-8623551', 55374);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (49799, 3948321, to_date('19-12-2020', 'dd-mm-yyyy'), '14 Grier Street', '478-8913495', 64909);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (66542, 2659180, to_date('06-01-2022', 'dd-mm-yyyy'), '44 Moreno Drive', '687-4611776', 37844);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (26780, 4215442, to_date('07-07-2023', 'dd-mm-yyyy'), '35 Rucker Road', '484-6575772', 7961);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (3352, 5066806, to_date('24-06-2023', 'dd-mm-yyyy'), '30 Abbotsford', '333-8354197', 69827);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (61920, 8992033, to_date('22-04-2021', 'dd-mm-yyyy'), '83 Arnold Blvd', '618-5628792', 25370);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (20764, 7422092, to_date('15-08-2021', 'dd-mm-yyyy'), '44 Lisa Blvd', '888-8874699', 63036);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (30826, 7710424, to_date('11-06-2023', 'dd-mm-yyyy'), '63 Azaria Street', '699-6131722', 72700);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (35349, 7290180, to_date('30-03-2022', 'dd-mm-yyyy'), '11 Gennevilliers Blv', '991-1487355', 62454);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (76833, 8088759, to_date('21-12-2023', 'dd-mm-yyyy'), '15 Gooding Blvd', '200-9453338', 55374);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (6926, 4396435, to_date('14-09-2020', 'dd-mm-yyyy'), '89 Macau Ave', '918-7574014', 22555);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (66646, 8664948, to_date('29-01-2023', 'dd-mm-yyyy'), '85 Houston Blvd', '113-4774227', 45593);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (87761, 1623225, to_date('13-12-2023', 'dd-mm-yyyy'), '4 Mae Drive', '572-4968964', 61882);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (52225, 9969083, to_date('13-10-2021', 'dd-mm-yyyy'), '29 Robin Ave', '821-4539251', 42806);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (85394, 6134656, to_date('20-07-2020', 'dd-mm-yyyy'), '89 Dupree Ave', '675-1511117', 88114);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (30221, 1374504, to_date('11-06-2022', 'dd-mm-yyyy'), '31 Bates', '355-2336609', 65557);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (19840, 2701156, to_date('21-12-2023', 'dd-mm-yyyy'), '52 Thurman', '624-5891693', 57243);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28969, 8197110, to_date('01-09-2021', 'dd-mm-yyyy'), '29 Choice Road', '264-5952279', 64901);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81066, 7253204, to_date('05-12-2021', 'dd-mm-yyyy'), '280 Colorado Springs', '738-5834244', 87841);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (21424, 4287417, to_date('16-04-2021', 'dd-mm-yyyy'), '9 Jill Road', '663-1925533', 41634);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (34379, 2814794, to_date('25-10-2022', 'dd-mm-yyyy'), '20 Macau Drive', '560-8340145', 43410);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (99880, 2644162, to_date('05-02-2022', 'dd-mm-yyyy'), '12 Allen Street', '217-4918899', 69795);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (38771, 1370813, to_date('10-12-2020', 'dd-mm-yyyy'), '81st Street', '879-9068006', 63036);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (71989, 8678949, to_date('22-10-2022', 'dd-mm-yyyy'), '47 Oszajca Drive', '331-9372183', 91928);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (22029, 1535033, to_date('01-01-2021', 'dd-mm-yyyy'), '42 Posener Street', '599-4472050', 50747);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (73581, 6555226, to_date('29-06-2021', 'dd-mm-yyyy'), '54 Barry', '350-1132059', 7029);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (40882, 6391521, to_date('15-05-2023', 'dd-mm-yyyy'), '54 Mobile Street', '335-1558897', 55303);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (87306, 2794687, to_date('20-07-2021', 'dd-mm-yyyy'), '22 Pacino Ave', '651-2540247', 70755);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10520, 6345079, to_date('11-05-2022', 'dd-mm-yyyy'), '96 Omar Ave', '991-9648670', 60528);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (23950, 4525817, to_date('10-08-2022', 'dd-mm-yyyy'), '577 Kate Drive', '416-1148679', 11050);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (78159, 4514199, to_date('15-09-2021', 'dd-mm-yyyy'), '84 Thurman Road', '951-9404370', 27070);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (91439, 3930716, to_date('03-01-2023', 'dd-mm-yyyy'), '49 Jamal Street', '807-5468148', 69306);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (63073, 8215851, to_date('28-03-2022', 'dd-mm-yyyy'), '668 Freising Drive', '790-9014338', 47026);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (48609, 255127, to_date('28-05-2022', 'dd-mm-yyyy'), '52nd Street', '668-3012634', 25980);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28516, 2223713, to_date('25-12-2023', 'dd-mm-yyyy'), '46 Humphrey Street', '153-5170668', 72700);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (85507, 1534271, to_date('23-02-2022', 'dd-mm-yyyy'), '91 Lawrence Drive', '412-5439762', 68611);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (61206, 6864460, to_date('08-07-2021', 'dd-mm-yyyy'), '53 Scaggs Street', '956-2102002', 91873);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (40020, 8494923, to_date('14-03-2022', 'dd-mm-yyyy'), '31 Leto Road', '635-3755930', 26544);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (90780, 1836776, to_date('16-03-2022', 'dd-mm-yyyy'), '6 Getty Road', '504-7019935', 29702);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (76900, 1376345, to_date('15-10-2021', 'dd-mm-yyyy'), '14 Lake worth Drive', '312-4846282', 74651);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (30593, 7031720, to_date('16-01-2022', 'dd-mm-yyyy'), '12 Horizon Blvd', '241-9448132', 86400);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (33755, 3251888, to_date('05-12-2022', 'dd-mm-yyyy'), '26 Ossie Street', '272-6892405', 21318);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (83726, 2643185, to_date('28-06-2020', 'dd-mm-yyyy'), '39 Long Island City ', '380-5220497', 60222);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (70915, 7274240, to_date('25-07-2022', 'dd-mm-yyyy'), '81 Broadbent Road', '708-9398688', 27641);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (69316, 715914, to_date('03-02-2024', 'dd-mm-yyyy'), '45 Magnuson Street', '599-5190206', 69306);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (32932, 6548485, to_date('05-11-2023', 'dd-mm-yyyy'), '18 Tisdale Road', '449-5419777', 14382);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10575, 7128299, to_date('17-02-2021', 'dd-mm-yyyy'), '80 Arjona Street', '170-4944212', 55374);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (96612, 8829222, to_date('15-02-2023', 'dd-mm-yyyy'), '57 Griffith Street', '453-2055941', 7029);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (14188, 4824883, to_date('30-01-2022', 'dd-mm-yyyy'), '21 Lucinda Street', '250-8161309', 1828);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (37504, 1099907, to_date('05-06-2023', 'dd-mm-yyyy'), '19 Peabo Road', '818-5924407', 54590);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (55297, 6301290, to_date('11-02-2023', 'dd-mm-yyyy'), '26 Verwood Street', '377-1757271', 21291);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (95533, 6146861, to_date('05-11-2023', 'dd-mm-yyyy'), '42 Julia Road', '287-6264314', 95931);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (50866, 8627612, to_date('26-04-2021', 'dd-mm-yyyy'), '81 Green bay Street', '950-8929837', 4304);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (47017, 8386259, to_date('20-09-2023', 'dd-mm-yyyy'), '59 Sledge Street', '411-3974961', 65479);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81943, 1187688, to_date('22-10-2020', 'dd-mm-yyyy'), '684 Heron', '337-9947003', 97930);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (57797, 8691751, to_date('22-01-2022', 'dd-mm-yyyy'), '77 Salt Road', '950-8577494', 97912);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (76326, 5951525, to_date('13-06-2023', 'dd-mm-yyyy'), '45 Farnham Ave', '746-5930277', 3645);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (21459, 177193, to_date('04-07-2021', 'dd-mm-yyyy'), '63 Balaban Drive', '458-9543328', 37844);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (8559, 9952499, to_date('28-03-2023', 'dd-mm-yyyy'), '23 Greenwood Street', '964-3896240', 83675);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (11265, 2085286, to_date('20-05-2021', 'dd-mm-yyyy'), '14 Leimen Drive', '681-1783415', 5421);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (25427, 8625711, to_date('03-08-2022', 'dd-mm-yyyy'), '3 Lennox Road', '675-6110158', 98425);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (27605, 6492828, to_date('03-06-2023', 'dd-mm-yyyy'), '74 Gelsenkirchen Roa', '936-8819952', 27070);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (11283, 7953159, to_date('01-08-2021', 'dd-mm-yyyy'), '7 Teng Street', '292-6192744', 17352);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (69178, 422818, to_date('17-03-2022', 'dd-mm-yyyy'), '769 Palminteri Road', '864-2295951', 91393);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (57878, 7657944, to_date('01-05-2021', 'dd-mm-yyyy'), '23rd Street', '563-1613378', 56477);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (19457, 2089150, to_date('06-05-2021', 'dd-mm-yyyy'), '877 Dench Road', '398-1700964', 61000);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (89172, 3839228, to_date('08-02-2023', 'dd-mm-yyyy'), '405 Andy Road', '746-6698736', 19080);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (22083, 2751934, to_date('03-09-2023', 'dd-mm-yyyy'), '62nd Street', '941-7713159', 10721);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (95644, 5905015, to_date('07-03-2023', 'dd-mm-yyyy'), '43rd Street', '824-4098998', 64893);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (6839, 701652, to_date('10-11-2023', 'dd-mm-yyyy'), '31st Street', '823-7065889', 51737);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (8235, 7370556, to_date('18-05-2023', 'dd-mm-yyyy'), '51 Lemmon Street', '910-4003084', 50594);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (16942, 4088586, to_date('01-01-2021', 'dd-mm-yyyy'), '76 Leelee Road', '536-5280762', 11110);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (78108, 4503781, to_date('09-09-2021', 'dd-mm-yyyy'), '31 Junior', '692-4562201', 1808);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (21257, 3696336, to_date('22-09-2020', 'dd-mm-yyyy'), '85 Irene Road', '723-2683871', 37101);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (50415, 1749101, to_date('19-12-2021', 'dd-mm-yyyy'), '82 Noseworthy Blvd', '954-8051606', 57300);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (36600, 552989, to_date('12-11-2022', 'dd-mm-yyyy'), '15 Hutton Ave', '562-7559012', 81596);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (32581, 1833904, to_date('20-10-2022', 'dd-mm-yyyy'), '35 Ismaning Road', '150-2067399', 44605);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (34856, 9765710, to_date('29-09-2022', 'dd-mm-yyyy'), '53rd Street', '652-2352627', 85019);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (86294, 8590161, to_date('01-08-2022', 'dd-mm-yyyy'), '4 Tillis', '965-9871539', 81596);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (3806, 478904, to_date('09-10-2020', 'dd-mm-yyyy'), '972 Cash Ave', '640-5094538', 45593);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (24034, 7621278, to_date('09-08-2022', 'dd-mm-yyyy'), '358 Worrell Street', '666-9229049', 18952);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (82130, 3084271, to_date('12-07-2023', 'dd-mm-yyyy'), '50 Pasadena Road', '172-3116072', 36377);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (3333, 1584443, to_date('12-04-2023', 'dd-mm-yyyy'), '62 Mos Road', '425-5948112', 98425);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (16911, 9681601, to_date('15-02-2024', 'dd-mm-yyyy'), '13 Dylan Blvd', '671-9334528', 29478);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (60546, 1434394, to_date('11-03-2021', 'dd-mm-yyyy'), '52 Nicolas Street', '786-6017167', 4048);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (40181, 9427058, to_date('02-12-2023', 'dd-mm-yyyy'), '68 Luzern Street', '112-8005594', 82702);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (13624, 3064357, to_date('19-10-2020', 'dd-mm-yyyy'), '99 Van Damme Street', '651-7230564', 10215);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (5550, 4145815, to_date('02-08-2021', 'dd-mm-yyyy'), '33rd Street', '949-4329929', 96613);
commit;
prompt 300 records committed...
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (80137, 2566888, to_date('27-08-2020', 'dd-mm-yyyy'), '28 Raybon Street', '929-8692225', 18952);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (32293, 8643708, to_date('06-10-2020', 'dd-mm-yyyy'), '17 Smurfit Street', '344-3482497', 72048);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (59637, 4774196, to_date('11-08-2021', 'dd-mm-yyyy'), '44 McGregor Ave', '123-5563880', 7915);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (26959, 1386143, to_date('04-09-2021', 'dd-mm-yyyy'), '12 Janice Road', '851-9484789', 44275);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (13898, 3534300, to_date('17-07-2023', 'dd-mm-yyyy'), '9 Des Plaines Ave', '757-8973029', 94944);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (1003, 8707797, to_date('08-09-2021', 'dd-mm-yyyy'), '403 Busta Drive', '725-9420043', 21008);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (20595, 9030701, to_date('01-11-2022', 'dd-mm-yyyy'), '49 Dave Street', '758-2283216', 95197);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (69493, 8404521, to_date('28-02-2022', 'dd-mm-yyyy'), '24 Mike Drive', '101-8468394', 93405);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (62607, 9509479, to_date('08-04-2021', 'dd-mm-yyyy'), '91st Street', '540-3634245', 69827);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (32883, 4241833, to_date('03-05-2022', 'dd-mm-yyyy'), '867 Sugar Hill Stree', '339-2181612', 22904);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (29806, 6422436, to_date('01-09-2021', 'dd-mm-yyyy'), '73 Anderson', '100-4338791', 51101);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (99957, 834364, to_date('24-01-2023', 'dd-mm-yyyy'), '77 Olsztyn', '427-3747857', 57213);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (29501, 7198126, to_date('30-04-2023', 'dd-mm-yyyy'), '37 Monk Street', '876-1114364', 7029);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (93832, 5779677, to_date('22-11-2021', 'dd-mm-yyyy'), '36 Lisbon', '110-4896953', 80219);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (15560, 7482052, to_date('28-11-2021', 'dd-mm-yyyy'), '65 Pearce Drive', '849-9481205', 29478);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (56170, 319051, to_date('24-07-2021', 'dd-mm-yyyy'), '36 Trejo Drive', '291-2974652', 30132);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (33702, 9231246, to_date('27-12-2020', 'dd-mm-yyyy'), '54 McAnally Drive', '738-3833362', 77193);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (34401, 460777, to_date('12-08-2021', 'dd-mm-yyyy'), '67 Marley Street', '368-7017269', 92239);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (41426, 2194993, to_date('25-03-2022', 'dd-mm-yyyy'), '50 Nagasaki Drive', '763-2483589', 47026);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (27220, 841115, to_date('29-04-2022', 'dd-mm-yyyy'), '59 Davidson Road', '237-3788833', 86659);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (95415, 7002909, to_date('13-03-2022', 'dd-mm-yyyy'), '63rd Street', '398-4961685', 41762);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (72075, 2070655, to_date('24-11-2021', 'dd-mm-yyyy'), '75 Austin', '880-1591526', 22904);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (84219, 1183822, to_date('14-11-2020', 'dd-mm-yyyy'), '26 Carlisle Drive', '377-5310447', 15217);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28186, 7862222, to_date('06-07-2023', 'dd-mm-yyyy'), '55 Lucinda Road', '117-7151828', 64137);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (26867, 424748, to_date('21-05-2022', 'dd-mm-yyyy'), '5 Gold Road', '955-4304519', 97144);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28453, 367628, to_date('16-12-2021', 'dd-mm-yyyy'), '76 Lizzy Ave', '120-8369302', 78122);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (59106, 2358112, to_date('24-06-2023', 'dd-mm-yyyy'), '86 Bo Drive', '171-4140884', 93298);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (39006, 5027782, to_date('03-10-2023', 'dd-mm-yyyy'), '56 Noumea Blvd', '279-2397753', 85019);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (70594, 594440, to_date('26-03-2022', 'dd-mm-yyyy'), '40 Maria Street', '969-3005229', 80481);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (44424, 9650596, to_date('13-11-2021', 'dd-mm-yyyy'), '97 Waits Road', '282-4097707', 66975);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (89775, 5727267, to_date('20-03-2023', 'dd-mm-yyyy'), '65 Campbell Drive', '602-2797170', 61528);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (9704, 3214206, to_date('15-07-2020', 'dd-mm-yyyy'), '49 Trace Road', '814-3387254', 86150);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (54338, 6780365, to_date('25-01-2022', 'dd-mm-yyyy'), '52 Frost Blvd', '780-1457522', 72636);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (80157, 1424578, to_date('26-01-2023', 'dd-mm-yyyy'), '57 McKellen Road', '792-5256556', 78485);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (34432, 6258583, to_date('03-02-2024', 'dd-mm-yyyy'), '17 Deerfield Drive', '392-7708092', 70323);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (12188, 8005115, to_date('18-05-2022', 'dd-mm-yyyy'), '374 Hauser Road', '888-2425851', 10744);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (68607, 125143, to_date('21-04-2022', 'dd-mm-yyyy'), '64 Fogerty Street', '628-3566684', 37101);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (86030, 7677460, to_date('26-08-2022', 'dd-mm-yyyy'), '93rd Street', '280-4850537', 50786);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81115, 4240848, to_date('21-08-2023', 'dd-mm-yyyy'), '68 Karon Ave', '638-6849086', 91873);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10587, 7913289, to_date('10-08-2021', 'dd-mm-yyyy'), '25 Lemmon Ave', '123-2362777', 75891);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (27276, 8654544, to_date('20-01-2022', 'dd-mm-yyyy'), '37 Annandale Road', '211-1533059', 93334);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (90546, 1528304, to_date('23-11-2021', 'dd-mm-yyyy'), '48 DeGraw Road', '810-2133151', 3877);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (34515, 6843644, to_date('22-09-2020', 'dd-mm-yyyy'), '44 Torino Street', '501-9508643', 30174);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (76831, 7456757, to_date('08-11-2020', 'dd-mm-yyyy'), '23 Kirk', '269-9863474', 64193);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (58329, 9960276, to_date('27-05-2021', 'dd-mm-yyyy'), '16 Crowe Blvd', '338-2943212', 57091);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (36206, 4239731, to_date('09-08-2023', 'dd-mm-yyyy'), '73 Parish Road', '849-3548172', 86943);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (83455, 8497485, to_date('23-03-2021', 'dd-mm-yyyy'), '77 Reid Street', '562-3154228', 80219);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (99041, 5262574, to_date('07-02-2024', 'dd-mm-yyyy'), '62nd Street', '812-7208555', 647);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (92596, 6544132, to_date('16-10-2020', 'dd-mm-yyyy'), '699 Caguas Road', '435-5789892', 99958);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (33204, 5024606, to_date('08-10-2022', 'dd-mm-yyyy'), '57 Borden Drive', '794-4137531', 37976);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (42145, 1920673, to_date('12-01-2022', 'dd-mm-yyyy'), '514 Derrick Ave', '553-9710062', 39925);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (72687, 8277964, to_date('22-06-2021', 'dd-mm-yyyy'), '53 Nakai Street', '853-1980484', 9612);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (74852, 3361490, to_date('08-11-2021', 'dd-mm-yyyy'), '90 Goodall Drive', '261-6972638', 82096);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81549, 282692, to_date('28-06-2023', 'dd-mm-yyyy'), '87 Vern Ave', '753-3900576', 45268);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28641, 6965535, to_date('13-10-2020', 'dd-mm-yyyy'), '328 Willard Road', '492-1439719', 32912);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (37528, 2588362, to_date('08-05-2022', 'dd-mm-yyyy'), '3 Annandale Street', '664-8533552', 48566);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (40788, 8520968, to_date('06-06-2020', 'dd-mm-yyyy'), '61 Taylor Blvd', '408-8478724', 48566);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (6748, 7853175, to_date('22-03-2021', 'dd-mm-yyyy'), '84 Horton Ave', '728-3063713', 62962);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (48655, 496569, to_date('22-09-2020', 'dd-mm-yyyy'), '74 Thomson Street', '176-5666022', 93334);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (67007, 9569081, to_date('18-04-2021', 'dd-mm-yyyy'), '17 Yucca Ave', '427-3032694', 22674);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (47447, 9883728, to_date('30-03-2022', 'dd-mm-yyyy'), '17 Leelee Street', '659-5686667', 11020);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (565, 1262981, to_date('04-10-2023', 'dd-mm-yyyy'), '64 McLean Road', '896-4720649', 79861);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (95698, 6723433, to_date('25-02-2021', 'dd-mm-yyyy'), '63 Iglesias Blvd', '187-1265771', 71464);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (76073, 7909042, to_date('07-01-2024', 'dd-mm-yyyy'), '52 Clark Street', '450-6299999', 78711);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (73440, 2236420, to_date('03-08-2022', 'dd-mm-yyyy'), '78 Wrzburg Road', '272-9041228', 39213);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (25303, 8643560, to_date('06-12-2022', 'dd-mm-yyyy'), '88 Grand-mere Drive', '511-4772023', 88114);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (37233, 5733281, to_date('23-11-2022', 'dd-mm-yyyy'), '33rd Street', '492-2958388', 24008);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (88871, 6233247, to_date('15-01-2021', 'dd-mm-yyyy'), '5 Ribisi Blvd', '110-4307327', 15681);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10691, 3181183, to_date('09-11-2020', 'dd-mm-yyyy'), '28 Garry Street', '488-1440045', 9437);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (61154, 8952312, to_date('11-08-2023', 'dd-mm-yyyy'), '72nd Street', '785-9481331', 39213);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (43686, 6297514, to_date('26-08-2023', 'dd-mm-yyyy'), '92 Stockholm Road', '556-1081067', 23284);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (18748, 9503, to_date('28-07-2023', 'dd-mm-yyyy'), '77 McGovern Drive', '368-3481572', 30106);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (96301, 8303666, to_date('12-11-2022', 'dd-mm-yyyy'), '86 Groton Blvd', '652-3099394', 42201);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (67132, 786293, to_date('05-08-2020', 'dd-mm-yyyy'), '853 Jackie Ave', '979-4073252', 31638);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (35100, 6628676, to_date('21-03-2023', 'dd-mm-yyyy'), '32 Malmצ Street', '217-8979428', 7915);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (88507, 7286518, to_date('25-11-2020', 'dd-mm-yyyy'), '73 Ving Ave', '932-2496252', 38940);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (5929, 531498, to_date('02-11-2021', 'dd-mm-yyyy'), '31 Vanessa', '877-7701466', 34839);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (31980, 7384920, to_date('21-07-2021', 'dd-mm-yyyy'), '26 Carradine Ave', '791-3615273', 39213);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (117, 2184832, to_date('25-11-2021', 'dd-mm-yyyy'), '1 Shelby Street', '261-6210573', 1808);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (15121, 8473898, to_date('21-09-2021', 'dd-mm-yyyy'), '790 Rickles Street', '941-9484552', 32075);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (60079, 9701636, to_date('06-06-2021', 'dd-mm-yyyy'), '48 Gavin Street', '611-3998270', 51223);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (16090, 7219453, to_date('04-02-2024', 'dd-mm-yyyy'), '78 Holland Road', '399-5497153', 73599);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (69961, 6509694, to_date('17-01-2022', 'dd-mm-yyyy'), '30 McAnally Street', '144-4745282', 15217);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (13205, 2873083, to_date('14-11-2023', 'dd-mm-yyyy'), '50 Belles Drive', '371-7468214', 71500);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (47784, 4326497, to_date('08-08-2022', 'dd-mm-yyyy'), '43 Coughlan Street', '178-2778632', 60528);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (49422, 8185650, to_date('28-06-2020', 'dd-mm-yyyy'), '61 Fonda Street', '634-3016824', 58806);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (47297, 6051331, to_date('25-12-2021', 'dd-mm-yyyy'), '677 Stills Drive', '200-7377658', 41744);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (14707, 2871254, to_date('16-01-2022', 'dd-mm-yyyy'), '66 Rip Road', '160-9555097', 70755);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (88163, 2451806, to_date('06-08-2023', 'dd-mm-yyyy'), '216 Condition Road', '582-6870571', 33796);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (91571, 4479036, to_date('20-07-2020', 'dd-mm-yyyy'), '26 Murray Road', '131-8396834', 32409);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (70166, 5630401, to_date('21-09-2022', 'dd-mm-yyyy'), '94 Goldwyn Road', '862-5037740', 88114);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (40135, 1332170, to_date('03-04-2022', 'dd-mm-yyyy'), '70 Ermey Ave', '554-4901397', 56199);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (39996, 2737934, to_date('17-06-2021', 'dd-mm-yyyy'), '9 Elizondo Road', '278-2662219', 24658);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81550, 6450860, to_date('30-05-2021', 'dd-mm-yyyy'), '69 Caine Road', '623-3484993', 92025);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (95035, 1763362, to_date('01-02-2024', 'dd-mm-yyyy'), '839 Mandy Road', '337-6188177', 38753);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (62440, 1466113, to_date('05-06-2023', 'dd-mm-yyyy'), '80 Braugher Road', '650-5015940', 21621);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (79588, 429672, to_date('19-07-2020', 'dd-mm-yyyy'), '55 Toledo Road', '661-2746017', 16596);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28838, 857298, to_date('26-05-2023', 'dd-mm-yyyy'), '40 Weller Drive', '972-3295800', 70360);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (94582, 3349698, to_date('10-06-2021', 'dd-mm-yyyy'), '4 Levy Street', '428-3753553', 70061);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (24898, 2430990, to_date('16-05-2022', 'dd-mm-yyyy'), '5 Michelle Street', '531-1636168', 22818);
commit;
prompt 400 records committed...
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (25048, 2048194, to_date('18-11-2023', 'dd-mm-yyyy'), '24 Steve Drive', '526-2101416', 52106);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (94770, 4993699, to_date('18-08-2020', 'dd-mm-yyyy'), '36 Merle Drive', '441-1683855', 27641);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (14390, 305578, to_date('21-10-2021', 'dd-mm-yyyy'), '62 Holmes Drive', '865-6401333', 93405);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (45669, 1382660, to_date('26-09-2021', 'dd-mm-yyyy'), '371 Weisz Ave', '121-6154257', 969);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (5187, 7421385, to_date('21-12-2023', 'dd-mm-yyyy'), '56 Soroe Drive', '550-7362999', 89204);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81252, 9903358, to_date('16-04-2022', 'dd-mm-yyyy'), '19 Loring Drive', '424-6537491', 82382);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (86420, 3308944, to_date('16-12-2022', 'dd-mm-yyyy'), '54 Ani Drive', '997-4416153', 33584);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (84163, 1293506, to_date('19-09-2021', 'dd-mm-yyyy'), '98 Rhys-Davies Blvd', '927-6025805', 82022);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (70939, 9491366, to_date('06-07-2023', 'dd-mm-yyyy'), '43 Ludbreg Drive', '169-1019924', 39213);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (65107, 4717329, to_date('19-07-2023', 'dd-mm-yyyy'), '24 Morse Road', '335-5603663', 46523);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (45457, 2725248, to_date('12-05-2023', 'dd-mm-yyyy'), '65 Americana Street', '936-5297177', 94578);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (68193, 2972874, to_date('26-07-2021', 'dd-mm-yyyy'), '99 Neustadt Street', '335-4042264', 99958);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (50419, 2419907, to_date('24-12-2021', 'dd-mm-yyyy'), '39 Stewart Blvd', '628-4890536', 52324);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (41496, 5480944, to_date('02-09-2022', 'dd-mm-yyyy'), '19 Lengdorf Road', '324-6495798', 37772);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (90952, 763531, to_date('07-08-2020', 'dd-mm-yyyy'), '89 Neuwirth Drive', '721-1597819', 16596);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (26604, 8168392, to_date('24-12-2021', 'dd-mm-yyyy'), '84 Nivola Drive', '520-9931751', 95931);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (78142, 3590540, to_date('17-04-2023', 'dd-mm-yyyy'), '11st Street', '904-6110497', 78711);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (63297, 3936941, to_date('06-09-2023', 'dd-mm-yyyy'), '89 LeVar Road', '882-7053707', 21876);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (79948, 9862517, to_date('08-12-2023', 'dd-mm-yyyy'), '62 Lauper Road', '990-3205032', 22818);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (62115, 3853730, to_date('08-01-2022', 'dd-mm-yyyy'), '98 McDowell Road', '897-3206760', 96987);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (78876, 1626206, to_date('27-01-2022', 'dd-mm-yyyy'), '48 Farrell Street', '856-3244894', 37149);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (50717, 1695637, to_date('02-05-2022', 'dd-mm-yyyy'), '27 Rachel Blvd', '906-3136035', 74937);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (4816, 9395292, to_date('15-07-2022', 'dd-mm-yyyy'), '99 Loretta', '272-5984996', 29964);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (52247, 8779811, to_date('29-12-2023', 'dd-mm-yyyy'), '22 Holly Street', '700-5313344', 27133);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (89411, 8666175, to_date('13-08-2021', 'dd-mm-yyyy'), '702 Stewart Road', '287-7446951', 98425);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (28484, 3373247, to_date('18-03-2022', 'dd-mm-yyyy'), '62 Joli Ave', '760-9591898', 97912);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (20873, 6534852, to_date('02-04-2022', 'dd-mm-yyyy'), '20 Rapaport Street', '484-9340544', 66276);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (86619, 9306684, to_date('25-05-2023', 'dd-mm-yyyy'), '87 Koteas Road', '219-1541334', 59705);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (75642, 4354274, to_date('21-06-2023', 'dd-mm-yyyy'), '3 Vai Drive', '456-1457778', 5324);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (99877, 9982906, to_date('16-08-2022', 'dd-mm-yyyy'), '35 Stoltz Road', '523-7091364', 90416);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81792, 4370386, to_date('13-10-2023', 'dd-mm-yyyy'), '61 Patrick Blvd', '598-4737429', 97677);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (2234, 8880719, to_date('26-04-2021', 'dd-mm-yyyy'), '74 Sizemore Blvd', '842-1249006', 26544);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (6819, 3092466, to_date('16-06-2023', 'dd-mm-yyyy'), '44 Rock Blvd', '317-4711247', 2526);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (40468, 5358553, to_date('02-12-2020', 'dd-mm-yyyy'), '86 Allison', '935-1674580', 19682);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (69592, 2137684, to_date('21-10-2022', 'dd-mm-yyyy'), '23 Bonneville Road', '912-3194279', 7915);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (66999, 2304965, to_date('05-12-2022', 'dd-mm-yyyy'), '49 Earl Ave', '771-7992152', 1828);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (37096, 8876585, to_date('21-11-2020', 'dd-mm-yyyy'), '40 Jesus Drive', '926-6168456', 54553);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (90709, 9857472, to_date('12-02-2023', 'dd-mm-yyyy'), '72 Kazem Blvd', '777-7591478', 80825);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (58894, 6624185, to_date('09-06-2021', 'dd-mm-yyyy'), '98 Haggard Drive', '205-7410802', 19682);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (8471, 2548264, to_date('06-07-2022', 'dd-mm-yyyy'), '43 Garofalo Drive', '580-5397099', 19416);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (53024, 1067871, to_date('07-06-2020', 'dd-mm-yyyy'), '26 Gilliam Street', '755-6543260', 69664);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (74936, 5766571, to_date('19-04-2022', 'dd-mm-yyyy'), '597 Ali Street', '170-1563021', 36377);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (22280, 9760227, to_date('14-04-2021', 'dd-mm-yyyy'), '99 Malkovich Drive', '146-2156357', 11541);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (77933, 4875613, to_date('30-11-2023', 'dd-mm-yyyy'), '614 Woodland Hills R', '675-3080528', 93754);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (2209, 4882214, to_date('18-10-2023', 'dd-mm-yyyy'), '77 Boucherville Road', '258-6591166', 17352);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (16391, 1520587, to_date('10-05-2021', 'dd-mm-yyyy'), '35 Gהvle Road', '754-1903405', 20720);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (46632, 3298028, to_date('25-01-2024', 'dd-mm-yyyy'), '53 Gabrielle Drive', '644-7526323', 72700);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (56255, 7326489, to_date('30-09-2021', 'dd-mm-yyyy'), '242 Kaysville Road', '680-8826861', 68611);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (70950, 5667336, to_date('06-04-2021', 'dd-mm-yyyy'), '49 Hunt Blvd', '911-3939241', 79147);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (74513, 6288117, to_date('27-02-2022', 'dd-mm-yyyy'), '84 Buckingham Road', '996-4050052', 97677);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (12043, 8554953, to_date('11-08-2021', 'dd-mm-yyyy'), '31 Holts Summit', '487-4287205', 19683);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (58017, 4824234, to_date('01-01-2021', 'dd-mm-yyyy'), '49 O''Donnell', '791-4279205', 10744);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (17955, 6768899, to_date('23-12-2023', 'dd-mm-yyyy'), '24 McDowall Road', '280-4390796', 36098);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (5991, 3315495, to_date('07-08-2022', 'dd-mm-yyyy'), '192 Carnes Ave', '170-1318656', 37976);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (39372, 9171278, to_date('20-07-2022', 'dd-mm-yyyy'), '642 Karlstad Drive', '428-4646701', 14323);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81636, 1213121, to_date('29-07-2023', 'dd-mm-yyyy'), '66 Pelvic', '292-2546318', 5810);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (26891, 6148546, to_date('05-06-2022', 'dd-mm-yyyy'), '79 McFerrin Street', '905-1386164', 84726);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (80810, 6263481, to_date('06-05-2022', 'dd-mm-yyyy'), '40 Krieger Drive', '125-5519738', 94272);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (81604, 6077304, to_date('29-09-2023', 'dd-mm-yyyy'), '73 Helen Street', '854-8702752', 37588);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (4510, 9285348, to_date('12-01-2022', 'dd-mm-yyyy'), '92 Sally Blvd', '425-4610750', 14244);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (97864, 4416676, to_date('07-04-2022', 'dd-mm-yyyy'), '680 Tarantino Street', '604-1754650', 67227);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (40160, 3216495, to_date('21-08-2021', 'dd-mm-yyyy'), '56 Maintenon Ave', '304-3916873', 37209);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (31048, 3896664, to_date('03-08-2023', 'dd-mm-yyyy'), '88 Wong Drive', '602-6485932', 68339);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (59137, 8301914, to_date('29-05-2023', 'dd-mm-yyyy'), '8 Kirsten Road', '546-3549997', 45268);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (97960, 7368258, to_date('05-01-2021', 'dd-mm-yyyy'), '63 Janeane Drive', '180-5102811', 11706);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (92736, 5397073, to_date('04-04-2023', 'dd-mm-yyyy'), '37 Bautzen Ave', '589-6863415', 68534);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (76150, 4216636, to_date('23-04-2021', 'dd-mm-yyyy'), '15 Kloten Road', '163-4594794', 25581);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (93085, 1759130, to_date('23-07-2021', 'dd-mm-yyyy'), '32 Ft. Lauderdale St', '834-9291378', 33040);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (19548, 1434706, to_date('23-11-2021', 'dd-mm-yyyy'), '13 Vallauris Road', '823-8366544', 36176);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (80904, 1507546, to_date('27-10-2021', 'dd-mm-yyyy'), '20 Dartmouth Drive', '882-7840112', 11541);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (71407, 4469923, to_date('06-04-2021', 'dd-mm-yyyy'), '51 Imbruglia Ave', '198-6431884', 18952);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (10784, 7220444, to_date('22-10-2022', 'dd-mm-yyyy'), '90 St Leonards', '152-3524299', 91694);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (11734, 7056946, to_date('24-10-2022', 'dd-mm-yyyy'), '72 Manchester Road', '372-8227769', 98467);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (53633, 7839391, to_date('16-08-2022', 'dd-mm-yyyy'), '63rd Street', '112-9869251', 1067);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (6027, 6755058, to_date('16-10-2022', 'dd-mm-yyyy'), '78 Etta Drive', '752-4612053', 54956);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (51321, 7112380, to_date('19-03-2023', 'dd-mm-yyyy'), '5 Solomon Drive', '310-1214463', 42102);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (78280, 8314680, to_date('12-06-2022', 'dd-mm-yyyy'), '92 Evett Street', '579-8253952', 57091);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (58152, 5741961, to_date('05-03-2022', 'dd-mm-yyyy'), '89 Vaughn Blvd', '717-2545698', 27971);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (8821, 5801548, to_date('20-10-2020', 'dd-mm-yyyy'), '76 Johnette Street', '365-2063957', 26189);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (6777, 8365610, to_date('22-11-2021', 'dd-mm-yyyy'), '52 Ammons', '293-5518116', 35942);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (45309, 2027568, to_date('21-09-2022', 'dd-mm-yyyy'), '223 Fehr', '412-7202586', 16596);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (65215, 4713141, to_date('05-04-2021', 'dd-mm-yyyy'), '66 Parsons', '641-1210774', 46454);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (29137, 7015169, to_date('11-02-2024', 'dd-mm-yyyy'), '51 Hamburg Blvd', '920-1188372', 84712);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (93930, 4343579, to_date('12-12-2020', 'dd-mm-yyyy'), '348 Edison', '266-9442887', 34822);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (47368, 7676363, to_date('18-10-2022', 'dd-mm-yyyy'), '33 Debbie Road', '262-5155456', 26024);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (59102, 9432539, to_date('19-05-2022', 'dd-mm-yyyy'), '21 Mantova Drive', '957-4880432', 67227);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (66451, 9302445, to_date('24-01-2024', 'dd-mm-yyyy'), '705 Phillips', '263-1542181', 44678);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (69891, 8048520, to_date('23-10-2022', 'dd-mm-yyyy'), '25 Beck Road', '472-2163540', 80481);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (76176, 2480178, to_date('08-11-2020', 'dd-mm-yyyy'), '29 Rupert Drive', '834-3788316', 73319);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (47614, 1194022, to_date('27-01-2024', 'dd-mm-yyyy'), '12 Pride Road', '288-3529846', 60059);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (44565, 9768622, to_date('25-06-2021', 'dd-mm-yyyy'), '271 Katt Blvd', '300-3446538', 9437);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (21701, 3726561, to_date('12-09-2020', 'dd-mm-yyyy'), '9 Quaid', '375-7110323', 15681);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (91016, 5149975, to_date('04-10-2020', 'dd-mm-yyyy'), '96 Mekhi Street', '867-3869974', 43410);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (63426, 3933221, to_date('05-09-2022', 'dd-mm-yyyy'), '852 Red Road', '876-5808260', 42102);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (19639, 8313117, to_date('08-07-2022', 'dd-mm-yyyy'), '31 Hiatt Drive', '945-4593326', 66224);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (23783, 4151355, to_date('20-06-2023', 'dd-mm-yyyy'), '20 Rowlands Street', '459-4479217', 53393);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (25987, 7197697, to_date('26-02-2022', 'dd-mm-yyyy'), '73 Sorvino Road', '734-9127108', 4820);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (43439, 582946, to_date('13-01-2021', 'dd-mm-yyyy'), '53 Lippetal Ave', '949-2069651', 57611);
insert into THE_ORDER (order_id, totalprice, order_date, address, phonenumber, customer_id)
values (13780, 7439774, to_date('11-11-2020', 'dd-mm-yyyy'), '4 Brando Street', '677-9262817', 19936);
commit;
prompt 499 records loaded
prompt Loading BELONG...
insert into BELONG (amount, dishs_id, order_id)
values (633690, 1108, 69178);
insert into BELONG (amount, dishs_id, order_id)
values (725135, 370, 1118);
insert into BELONG (amount, dishs_id, order_id)
values (655239, 42, 40160);
insert into BELONG (amount, dishs_id, order_id)
values (471115, 780, 86420);
insert into BELONG (amount, dishs_id, order_id)
values (214624, 918, 80904);
insert into BELONG (amount, dishs_id, order_id)
values (508938, 1388, 54338);
insert into BELONG (amount, dishs_id, order_id)
values (65803, 148, 47884);
insert into BELONG (amount, dishs_id, order_id)
values (46276, 1266, 89172);
insert into BELONG (amount, dishs_id, order_id)
values (388520, 1132, 29984);
insert into BELONG (amount, dishs_id, order_id)
values (794745, 682, 91407);
insert into BELONG (amount, dishs_id, order_id)
values (130732, 616, 66646);
insert into BELONG (amount, dishs_id, order_id)
values (714585, 1026, 71262);
insert into BELONG (amount, dishs_id, order_id)
values (154292, 304, 65669);
insert into BELONG (amount, dishs_id, order_id)
values (597745, 1278, 60877);
insert into BELONG (amount, dishs_id, order_id)
values (950038, 76, 91588);
insert into BELONG (amount, dishs_id, order_id)
values (931659, 568, 84219);
insert into BELONG (amount, dishs_id, order_id)
values (804636, 158, 97948);
insert into BELONG (amount, dishs_id, order_id)
values (784402, 290, 59137);
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
values (777537, 1274, 11585);
insert into BELONG (amount, dishs_id, order_id)
values (994728, 1104, 5991);
insert into BELONG (amount, dishs_id, order_id)
values (960425, 76, 69961);
insert into BELONG (amount, dishs_id, order_id)
values (32009, 406, 34506);
insert into BELONG (amount, dishs_id, order_id)
values (236719, 976, 58894);
insert into BELONG (amount, dishs_id, order_id)
values (217804, 182, 83726);
insert into BELONG (amount, dishs_id, order_id)
values (884593, 214, 37096);
insert into BELONG (amount, dishs_id, order_id)
values (689672, 1220, 39336);
insert into BELONG (amount, dishs_id, order_id)
values (416135, 1292, 99880);
insert into BELONG (amount, dishs_id, order_id)
values (925012, 1228, 81884);
insert into BELONG (amount, dishs_id, order_id)
values (66151, 498, 91387);
insert into BELONG (amount, dishs_id, order_id)
values (913942, 1092, 95415);
insert into BELONG (amount, dishs_id, order_id)
values (254631, 522, 1003);
insert into BELONG (amount, dishs_id, order_id)
values (112472, 368, 70939);
insert into BELONG (amount, dishs_id, order_id)
values (866443, 156, 95415);
insert into BELONG (amount, dishs_id, order_id)
values (717520, 1312, 10691);
insert into BELONG (amount, dishs_id, order_id)
values (488107, 1130, 6819);
insert into BELONG (amount, dishs_id, order_id)
values (550535, 1302, 91387);
insert into BELONG (amount, dishs_id, order_id)
values (635859, 992, 85424);
insert into BELONG (amount, dishs_id, order_id)
values (770941, 518, 69316);
insert into BELONG (amount, dishs_id, order_id)
values (320802, 530, 83455);
insert into BELONG (amount, dishs_id, order_id)
values (342272, 744, 63692);
insert into BELONG (amount, dishs_id, order_id)
values (329732, 1278, 69493);
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
values (613833, 1178, 97960);
insert into BELONG (amount, dishs_id, order_id)
values (284690, 1048, 28283);
insert into BELONG (amount, dishs_id, order_id)
values (577839, 868, 61156);
insert into BELONG (amount, dishs_id, order_id)
values (267737, 790, 10587);
insert into BELONG (amount, dishs_id, order_id)
values (960001, 292, 4510);
insert into BELONG (amount, dishs_id, order_id)
values (836706, 236, 17955);
insert into BELONG (amount, dishs_id, order_id)
values (364895, 1182, 81792);
insert into BELONG (amount, dishs_id, order_id)
values (971976, 796, 22197);
insert into BELONG (amount, dishs_id, order_id)
values (592342, 628, 70166);
insert into BELONG (amount, dishs_id, order_id)
values (748790, 230, 78900);
insert into BELONG (amount, dishs_id, order_id)
values (710165, 622, 97562);
insert into BELONG (amount, dishs_id, order_id)
values (488286, 530, 70594);
insert into BELONG (amount, dishs_id, order_id)
values (279968, 666, 10259);
insert into BELONG (amount, dishs_id, order_id)
values (698569, 1176, 42861);
insert into BELONG (amount, dishs_id, order_id)
values (706911, 34, 4034);
insert into BELONG (amount, dishs_id, order_id)
values (412139, 1008, 10784);
insert into BELONG (amount, dishs_id, order_id)
values (348772, 284, 47884);
insert into BELONG (amount, dishs_id, order_id)
values (654956, 822, 11265);
insert into BELONG (amount, dishs_id, order_id)
values (252887, 296, 6926);
insert into BELONG (amount, dishs_id, order_id)
values (203346, 180, 59136);
insert into BELONG (amount, dishs_id, order_id)
values (761313, 1072, 38831);
insert into BELONG (amount, dishs_id, order_id)
values (802438, 380, 8471);
insert into BELONG (amount, dishs_id, order_id)
values (784940, 904, 82852);
insert into BELONG (amount, dishs_id, order_id)
values (458252, 522, 15560);
insert into BELONG (amount, dishs_id, order_id)
values (869590, 128, 59384);
insert into BELONG (amount, dishs_id, order_id)
values (571995, 1324, 31980);
insert into BELONG (amount, dishs_id, order_id)
values (319855, 698, 82852);
insert into BELONG (amount, dishs_id, order_id)
values (390513, 1290, 40135);
insert into BELONG (amount, dishs_id, order_id)
values (168687, 682, 96301);
insert into BELONG (amount, dishs_id, order_id)
values (793780, 250, 8559);
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
values (58630, 404, 9821);
insert into BELONG (amount, dishs_id, order_id)
values (769072, 762, 95438);
insert into BELONG (amount, dishs_id, order_id)
values (872452, 30, 57878);
insert into BELONG (amount, dishs_id, order_id)
values (225089, 586, 62325);
insert into BELONG (amount, dishs_id, order_id)
values (906062, 958, 94770);
insert into BELONG (amount, dishs_id, order_id)
values (664464, 250, 81636);
insert into BELONG (amount, dishs_id, order_id)
values (272858, 60, 67007);
insert into BELONG (amount, dishs_id, order_id)
values (96946, 102, 81550);
insert into BELONG (amount, dishs_id, order_id)
values (725241, 496, 40788);
insert into BELONG (amount, dishs_id, order_id)
values (241766, 592, 11585);
insert into BELONG (amount, dishs_id, order_id)
values (773854, 1226, 18748);
commit;
prompt 100 records committed...
insert into BELONG (amount, dishs_id, order_id)
values (73635, 1194, 14707);
insert into BELONG (amount, dishs_id, order_id)
values (502466, 956, 3333);
insert into BELONG (amount, dishs_id, order_id)
values (553185, 1342, 65107);
insert into BELONG (amount, dishs_id, order_id)
values (250603, 402, 18177);
insert into BELONG (amount, dishs_id, order_id)
values (735360, 716, 94582);
insert into BELONG (amount, dishs_id, order_id)
values (479256, 318, 47297);
insert into BELONG (amount, dishs_id, order_id)
values (634230, 282, 87839);
insert into BELONG (amount, dishs_id, order_id)
values (695458, 958, 14838);
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
values (189898, 1388, 29137);
insert into BELONG (amount, dishs_id, order_id)
values (834984, 510, 81943);
insert into BELONG (amount, dishs_id, order_id)
values (764265, 292, 93085);
insert into BELONG (amount, dishs_id, order_id)
values (917385, 1144, 73440);
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
values (293159, 732, 51321);
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
values (593975, 962, 57639);
insert into BELONG (amount, dishs_id, order_id)
values (597542, 16, 4421);
insert into BELONG (amount, dishs_id, order_id)
values (466121, 746, 28516);
insert into BELONG (amount, dishs_id, order_id)
values (780565, 736, 90574);
insert into BELONG (amount, dishs_id, order_id)
values (281146, 926, 61206);
insert into BELONG (amount, dishs_id, order_id)
values (136508, 812, 37504);
insert into BELONG (amount, dishs_id, order_id)
values (713920, 1080, 14188);
insert into BELONG (amount, dishs_id, order_id)
values (503197, 64, 70141);
insert into BELONG (amount, dishs_id, order_id)
values (615666, 842, 78280);
insert into BELONG (amount, dishs_id, order_id)
values (933671, 966, 81540);
insert into BELONG (amount, dishs_id, order_id)
values (216241, 648, 91505);
insert into BELONG (amount, dishs_id, order_id)
values (12206, 578, 2114);
insert into BELONG (amount, dishs_id, order_id)
values (434500, 142, 29984);
insert into BELONG (amount, dishs_id, order_id)
values (52173, 818, 33702);
insert into BELONG (amount, dishs_id, order_id)
values (177513, 526, 42996);
insert into BELONG (amount, dishs_id, order_id)
values (674675, 878, 91439);
insert into BELONG (amount, dishs_id, order_id)
values (712830, 456, 79588);
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
values (527293, 1400, 83455);
insert into BELONG (amount, dishs_id, order_id)
values (52920, 558, 76176);
insert into BELONG (amount, dishs_id, order_id)
values (341760, 864, 59384);
insert into BELONG (amount, dishs_id, order_id)
values (534242, 60, 10356);
insert into BELONG (amount, dishs_id, order_id)
values (992740, 1346, 47884);
insert into BELONG (amount, dishs_id, order_id)
values (12982, 730, 5929);
insert into BELONG (amount, dishs_id, order_id)
values (758762, 282, 37096);
insert into BELONG (amount, dishs_id, order_id)
values (792871, 22, 33352);
insert into BELONG (amount, dishs_id, order_id)
values (227311, 1156, 90709);
insert into BELONG (amount, dishs_id, order_id)
values (676205, 1090, 26864);
insert into BELONG (amount, dishs_id, order_id)
values (671411, 396, 31980);
insert into BELONG (amount, dishs_id, order_id)
values (997141, 394, 17773);
insert into BELONG (amount, dishs_id, order_id)
values (114000, 902, 76900);
insert into BELONG (amount, dishs_id, order_id)
values (962758, 202, 35100);
insert into BELONG (amount, dishs_id, order_id)
values (614542, 810, 49131);
insert into BELONG (amount, dishs_id, order_id)
values (145548, 324, 75642);
insert into BELONG (amount, dishs_id, order_id)
values (883582, 1106, 25427);
insert into BELONG (amount, dishs_id, order_id)
values (896830, 1206, 43408);
insert into BELONG (amount, dishs_id, order_id)
values (682226, 1180, 29137);
insert into BELONG (amount, dishs_id, order_id)
values (6487, 1240, 28641);
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
values (527054, 924, 28916);
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
values (268728, 634, 97864);
commit;
prompt 200 records committed...
insert into BELONG (amount, dishs_id, order_id)
values (491143, 1032, 53565);
insert into BELONG (amount, dishs_id, order_id)
values (89591, 406, 10587);
insert into BELONG (amount, dishs_id, order_id)
values (793540, 1106, 96486);
insert into BELONG (amount, dishs_id, order_id)
values (737432, 590, 95537);
insert into BELONG (amount, dishs_id, order_id)
values (935770, 132, 10784);
insert into BELONG (amount, dishs_id, order_id)
values (517959, 386, 51130);
insert into BELONG (amount, dishs_id, order_id)
values (543027, 664, 39006);
insert into BELONG (amount, dishs_id, order_id)
values (866290, 338, 49131);
insert into BELONG (amount, dishs_id, order_id)
values (881589, 242, 65834);
insert into BELONG (amount, dishs_id, order_id)
values (816040, 844, 81540);
insert into BELONG (amount, dishs_id, order_id)
values (517385, 876, 28484);
insert into BELONG (amount, dishs_id, order_id)
values (739649, 50, 2533);
insert into BELONG (amount, dishs_id, order_id)
values (229380, 1268, 17773);
insert into BELONG (amount, dishs_id, order_id)
values (355227, 356, 76831);
insert into BELONG (amount, dishs_id, order_id)
values (276284, 628, 95537);
insert into BELONG (amount, dishs_id, order_id)
values (474192, 1160, 6819);
insert into BELONG (amount, dishs_id, order_id)
values (293021, 802, 94072);
insert into BELONG (amount, dishs_id, order_id)
values (548721, 90, 65107);
insert into BELONG (amount, dishs_id, order_id)
values (970480, 938, 8235);
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
values (243744, 338, 47884);
insert into BELONG (amount, dishs_id, order_id)
values (561479, 218, 57784);
insert into BELONG (amount, dishs_id, order_id)
values (749258, 1152, 32261);
insert into BELONG (amount, dishs_id, order_id)
values (476553, 188, 47884);
insert into BELONG (amount, dishs_id, order_id)
values (30454, 1266, 91283);
insert into BELONG (amount, dishs_id, order_id)
values (527881, 1394, 4993);
insert into BELONG (amount, dishs_id, order_id)
values (580845, 108, 53536);
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
values (963084, 848, 7307);
insert into BELONG (amount, dishs_id, order_id)
values (704765, 1330, 97337);
insert into BELONG (amount, dishs_id, order_id)
values (854209, 522, 57797);
insert into BELONG (amount, dishs_id, order_id)
values (494063, 988, 29501);
insert into BELONG (amount, dishs_id, order_id)
values (591137, 70, 90780);
insert into BELONG (amount, dishs_id, order_id)
values (347842, 1044, 72589);
insert into BELONG (amount, dishs_id, order_id)
values (756068, 418, 28484);
insert into BELONG (amount, dishs_id, order_id)
values (873260, 1344, 39025);
insert into BELONG (amount, dishs_id, order_id)
values (272610, 468, 23755);
insert into BELONG (amount, dishs_id, order_id)
values (455638, 700, 6926);
insert into BELONG (amount, dishs_id, order_id)
values (907289, 1060, 21754);
insert into BELONG (amount, dishs_id, order_id)
values (173226, 890, 46632);
insert into BELONG (amount, dishs_id, order_id)
values (917244, 260, 88871);
insert into BELONG (amount, dishs_id, order_id)
values (709117, 516, 81792);
insert into BELONG (amount, dishs_id, order_id)
values (662746, 592, 40181);
insert into BELONG (amount, dishs_id, order_id)
values (749731, 498, 6027);
insert into BELONG (amount, dishs_id, order_id)
values (856018, 194, 13698);
insert into BELONG (amount, dishs_id, order_id)
values (438944, 194, 81549);
insert into BELONG (amount, dishs_id, order_id)
values (2973, 638, 25303);
insert into BELONG (amount, dishs_id, order_id)
values (420218, 636, 34401);
insert into BELONG (amount, dishs_id, order_id)
values (833381, 96, 39372);
insert into BELONG (amount, dishs_id, order_id)
values (904852, 1304, 2812);
insert into BELONG (amount, dishs_id, order_id)
values (921781, 716, 71262);
insert into BELONG (amount, dishs_id, order_id)
values (620027, 820, 25987);
insert into BELONG (amount, dishs_id, order_id)
values (575537, 830, 96177);
insert into BELONG (amount, dishs_id, order_id)
values (475145, 584, 17955);
insert into BELONG (amount, dishs_id, order_id)
values (241487, 1228, 27019);
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
values (975952, 6, 11734);
insert into BELONG (amount, dishs_id, order_id)
values (187517, 1344, 86619);
insert into BELONG (amount, dishs_id, order_id)
values (760277, 602, 92736);
insert into BELONG (amount, dishs_id, order_id)
values (849718, 812, 84163);
insert into BELONG (amount, dishs_id, order_id)
values (221562, 28, 85507);
insert into BELONG (amount, dishs_id, order_id)
values (622691, 1360, 8471);
insert into BELONG (amount, dishs_id, order_id)
values (611193, 320, 27335);
insert into BELONG (amount, dishs_id, order_id)
values (875772, 16, 66102);
insert into BELONG (amount, dishs_id, order_id)
values (318502, 798, 10259);
insert into BELONG (amount, dishs_id, order_id)
values (152429, 312, 97960);
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
values (425898, 854, 48655);
insert into BELONG (amount, dishs_id, order_id)
values (612359, 74, 96572);
insert into BELONG (amount, dishs_id, order_id)
values (478453, 100, 47982);
insert into BELONG (amount, dishs_id, order_id)
values (962775, 1310, 78900);
insert into BELONG (amount, dishs_id, order_id)
values (756103, 64, 62735);
insert into BELONG (amount, dishs_id, order_id)
values (126374, 794, 28516);
insert into BELONG (amount, dishs_id, order_id)
values (318167, 254, 6839);
insert into BELONG (amount, dishs_id, order_id)
values (301473, 1040, 10259);
insert into BELONG (amount, dishs_id, order_id)
values (341159, 1198, 57878);
insert into BELONG (amount, dishs_id, order_id)
values (751357, 92, 34432);
insert into BELONG (amount, dishs_id, order_id)
values (889024, 1010, 76176);
insert into BELONG (amount, dishs_id, order_id)
values (337318, 1074, 93832);
insert into BELONG (amount, dishs_id, order_id)
values (440487, 170, 94072);
insert into BELONG (amount, dishs_id, order_id)
values (586082, 1356, 10575);
insert into BELONG (amount, dishs_id, order_id)
values (642653, 466, 88871);
commit;
prompt 300 records committed...
insert into BELONG (amount, dishs_id, order_id)
values (837519, 326, 58329);
insert into BELONG (amount, dishs_id, order_id)
values (797873, 1128, 97337);
insert into BELONG (amount, dishs_id, order_id)
values (532756, 1176, 87839);
insert into BELONG (amount, dishs_id, order_id)
values (162785, 596, 24898);
insert into BELONG (amount, dishs_id, order_id)
values (604574, 982, 85394);
insert into BELONG (amount, dishs_id, order_id)
values (567702, 1318, 39336);
insert into BELONG (amount, dishs_id, order_id)
values (276242, 838, 99877);
insert into BELONG (amount, dishs_id, order_id)
values (955469, 284, 48875);
insert into BELONG (amount, dishs_id, order_id)
values (925934, 182, 34506);
insert into BELONG (amount, dishs_id, order_id)
values (503766, 198, 81115);
insert into BELONG (amount, dishs_id, order_id)
values (99616, 1276, 27220);
insert into BELONG (amount, dishs_id, order_id)
values (853895, 1032, 76150);
insert into BELONG (amount, dishs_id, order_id)
values (806718, 1188, 59137);
insert into BELONG (amount, dishs_id, order_id)
values (926817, 1396, 26959);
insert into BELONG (amount, dishs_id, order_id)
values (989926, 38, 84163);
insert into BELONG (amount, dishs_id, order_id)
values (676964, 466, 81636);
insert into BELONG (amount, dishs_id, order_id)
values (62000, 1174, 16053);
insert into BELONG (amount, dishs_id, order_id)
values (236000, 282, 5737);
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
values (459054, 1292, 22335);
insert into BELONG (amount, dishs_id, order_id)
values (749582, 746, 24898);
insert into BELONG (amount, dishs_id, order_id)
values (400429, 846, 11265);
insert into BELONG (amount, dishs_id, order_id)
values (967180, 1080, 47843);
insert into BELONG (amount, dishs_id, order_id)
values (471939, 672, 10456);
insert into BELONG (amount, dishs_id, order_id)
values (422492, 1384, 81792);
insert into BELONG (amount, dishs_id, order_id)
values (518127, 218, 38522);
insert into BELONG (amount, dishs_id, order_id)
values (558239, 358, 6027);
insert into BELONG (amount, dishs_id, order_id)
values (558895, 904, 20873);
insert into BELONG (amount, dishs_id, order_id)
values (498298, 672, 59637);
insert into BELONG (amount, dishs_id, order_id)
values (797826, 698, 69891);
insert into BELONG (amount, dishs_id, order_id)
values (93000, 900, 63426);
insert into BELONG (amount, dishs_id, order_id)
values (55110, 248, 117);
insert into BELONG (amount, dishs_id, order_id)
values (568262, 884, 28641);
insert into BELONG (amount, dishs_id, order_id)
values (8254, 1054, 20764);
insert into BELONG (amount, dishs_id, order_id)
values (142701, 160, 2114);
insert into BELONG (amount, dishs_id, order_id)
values (603498, 1174, 28838);
insert into BELONG (amount, dishs_id, order_id)
values (167458, 1212, 9721);
insert into BELONG (amount, dishs_id, order_id)
values (45880, 1304, 94770);
insert into BELONG (amount, dishs_id, order_id)
values (328591, 1178, 62607);
insert into BELONG (amount, dishs_id, order_id)
values (457822, 1032, 10932);
insert into BELONG (amount, dishs_id, order_id)
values (531004, 1058, 2812);
insert into BELONG (amount, dishs_id, order_id)
values (674029, 1328, 16090);
insert into BELONG (amount, dishs_id, order_id)
values (82655, 1190, 16157);
insert into BELONG (amount, dishs_id, order_id)
values (270014, 96, 28183);
insert into BELONG (amount, dishs_id, order_id)
values (19873, 990, 36094);
insert into BELONG (amount, dishs_id, order_id)
values (879495, 996, 58894);
insert into BELONG (amount, dishs_id, order_id)
values (678723, 332, 4510);
insert into BELONG (amount, dishs_id, order_id)
values (691797, 1306, 86294);
insert into BELONG (amount, dishs_id, order_id)
values (230207, 100, 5774);
insert into BELONG (amount, dishs_id, order_id)
values (800391, 114, 56170);
insert into BELONG (amount, dishs_id, order_id)
values (675373, 632, 97562);
insert into BELONG (amount, dishs_id, order_id)
values (367866, 174, 83726);
insert into BELONG (amount, dishs_id, order_id)
values (54033, 20, 61154);
insert into BELONG (amount, dishs_id, order_id)
values (428728, 962, 84737);
insert into BELONG (amount, dishs_id, order_id)
values (159702, 798, 85934);
insert into BELONG (amount, dishs_id, order_id)
values (148172, 1392, 77726);
insert into BELONG (amount, dishs_id, order_id)
values (204745, 978, 10784);
insert into BELONG (amount, dishs_id, order_id)
values (540320, 1254, 97566);
insert into BELONG (amount, dishs_id, order_id)
values (433947, 1118, 38771);
insert into BELONG (amount, dishs_id, order_id)
values (598737, 1154, 53536);
insert into BELONG (amount, dishs_id, order_id)
values (974719, 900, 69178);
insert into BELONG (amount, dishs_id, order_id)
values (555647, 598, 88163);
insert into BELONG (amount, dishs_id, order_id)
values (35471, 882, 36202);
insert into BELONG (amount, dishs_id, order_id)
values (138365, 444, 98946);
insert into BELONG (amount, dishs_id, order_id)
values (239964, 418, 19840);
insert into BELONG (amount, dishs_id, order_id)
values (284136, 538, 61383);
insert into BELONG (amount, dishs_id, order_id)
values (229445, 522, 49131);
insert into BELONG (amount, dishs_id, order_id)
values (378756, 162, 48609);
insert into BELONG (amount, dishs_id, order_id)
values (976525, 288, 90694);
insert into BELONG (amount, dishs_id, order_id)
values (755428, 1022, 26959);
insert into BELONG (amount, dishs_id, order_id)
values (366788, 6, 97948);
insert into BELONG (amount, dishs_id, order_id)
values (497926, 670, 41496);
insert into BELONG (amount, dishs_id, order_id)
values (806996, 386, 59106);
insert into BELONG (amount, dishs_id, order_id)
values (591149, 628, 47017);
insert into BELONG (amount, dishs_id, order_id)
values (746250, 752, 78252);
insert into BELONG (amount, dishs_id, order_id)
values (723076, 712, 39006);
insert into BELONG (amount, dishs_id, order_id)
values (339105, 80, 80574);
insert into BELONG (amount, dishs_id, order_id)
values (619004, 1310, 69316);
insert into BELONG (amount, dishs_id, order_id)
values (872461, 534, 58152);
insert into BELONG (amount, dishs_id, order_id)
values (252492, 798, 34856);
insert into BELONG (amount, dishs_id, order_id)
values (314984, 54, 10456);
insert into BELONG (amount, dishs_id, order_id)
values (683951, 512, 79588);
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
values (504849, 106, 36206);
insert into BELONG (amount, dishs_id, order_id)
values (666344, 94, 10259);
insert into BELONG (amount, dishs_id, order_id)
values (907854, 206, 57784);
insert into BELONG (amount, dishs_id, order_id)
values (952972, 62, 63297);
insert into BELONG (amount, dishs_id, order_id)
values (894610, 968, 90952);
insert into BELONG (amount, dishs_id, order_id)
values (927728, 278, 21253);
commit;
prompt 400 records loaded
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
values (6786, 'Honey', 'plant', to_date('08-06-2024', 'dd-mm-yyyy'));
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
values (6457, 'Condensed Milk', 'meat', to_date('06-06-2024', 'dd-mm-yyyy'));
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
values (6893, 'Broth', 'dried food', to_date('07-06-2024', 'dd-mm-yyyy'));
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
values (2362, 'Chickpeas', 'meat', to_date('30-05-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6798, 'Jam', 'dairy', to_date('11-08-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (6956, 'Honeydew', 'dried food', to_date('21-12-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9296, 'Honeydew', 'meat', to_date('02-01-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (9195, 'Avocado', 'dried food', to_date('27-05-2025', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into MATERIAL (material_id, name, type, expirydate)
values (1186, 'Sriracha', 'plant', to_date('15-06-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7785, 'Peppers', 'meat', to_date('25-04-2025', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (7280, 'Cashews', 'meat', to_date('20-05-2026', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (5993, 'Tofu', 'dried food', to_date('26-06-2025', 'dd-mm-yyyy'));
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
values (6244, 'Walnuts', 'plant', to_date('02-06-2024', 'dd-mm-yyyy'));
insert into MATERIAL (material_id, name, type, expirydate)
values (8387, 'Thyme', 'dried food', to_date('28-05-2024', 'dd-mm-yyyy'));
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
values (4314, 'Pineapple', 'meat', to_date('24-05-2024', 'dd-mm-yyyy'));
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
values (496, 'Peanut Oil', 'dairy', to_date('26-05-2024', 'dd-mm-yyyy'));
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
commit;
prompt 200 records committed...
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
values (2952, 'Miso', 'plant', to_date('09-06-2024', 'dd-mm-yyyy'));
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
values (4132, 'Peanut Butter', 'meat', to_date('28-05-2024', 'dd-mm-yyyy'));
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
commit;
prompt 300 records committed...
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
values (2059, 'Nectarines', 'meat', to_date('08-06-2024', 'dd-mm-yyyy'));
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
values (2683, 'Beef', 'meat', to_date('31-05-2024', 'dd-mm-yyyy'));
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
prompt 394 records loaded
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
values (744474, 758, 2952);
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
values (295910, 498, 2059);
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
values (595388, 222, 2683);
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
commit;
prompt 100 records committed...
insert into CONTAIN (quantity, dishs_id, material_id)
values (798484, 1048, 3391);
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
values (702761, 188, 6786);
insert into CONTAIN (quantity, dishs_id, material_id)
values (766589, 564, 3177);
insert into CONTAIN (quantity, dishs_id, material_id)
values (30200, 418, 3861);
insert into CONTAIN (quantity, dishs_id, material_id)
values (234746, 888, 5783);
insert into CONTAIN (quantity, dishs_id, material_id)
values (989590, 1208, 2362);
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
values (662673, 1244, 2362);
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
commit;
prompt 200 records committed...
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
insert into CONTAIN (quantity, dishs_id, material_id)
values (374757, 988, 3894);
insert into CONTAIN (quantity, dishs_id, material_id)
values (433534, 502, 9275);
insert into CONTAIN (quantity, dishs_id, material_id)
values (306614, 1324, 2952);
insert into CONTAIN (quantity, dishs_id, material_id)
values (67887, 1326, 8697);
insert into CONTAIN (quantity, dishs_id, material_id)
values (858866, 1336, 8968);
insert into CONTAIN (quantity, dishs_id, material_id)
values (393624, 590, 2362);
insert into CONTAIN (quantity, dishs_id, material_id)
values (764089, 1370, 8154);
insert into CONTAIN (quantity, dishs_id, material_id)
values (35703, 934, 251);
insert into CONTAIN (quantity, dishs_id, material_id)
values (882914, 1374, 7846);
insert into CONTAIN (quantity, dishs_id, material_id)
values (913785, 1372, 2362);
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
values (985848, 1140, 2683);
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
commit;
prompt 300 records committed...
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
values (947799, 194, 6244);
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
values (3588, 1156, 6893);
insert into CONTAIN (quantity, dishs_id, material_id)
values (346165, 782, 9076);
insert into CONTAIN (quantity, dishs_id, material_id)
values (415235, 686, 7052);
insert into CONTAIN (quantity, dishs_id, material_id)
values (758035, 1206, 4840);
insert into CONTAIN (quantity, dishs_id, material_id)
values (839641, 682, 2059);
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
values (669226, 246, 2683);
insert into CONTAIN (quantity, dishs_id, material_id)
values (406022, 984, 7649);
insert into CONTAIN (quantity, dishs_id, material_id)
values (488359, 930, 6893);
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
values (771765, 1300, 2683);
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
prompt 400 records loaded
prompt Loading WORKER...
insert into WORKER (worker_id, workhoures, name, salary)
values (4830, 9, 'Rory Furtado', 11384);
insert into WORKER (worker_id, workhoures, name, salary)
values (4840, 10, 'Pierce Hudson', 19315);
insert into WORKER (worker_id, workhoures, name, salary)
values (4850, 6, 'Gordie Ammons', 14169);
insert into WORKER (worker_id, workhoures, name, salary)
values (4860, 10, 'Natasha Michael', 17568);
insert into WORKER (worker_id, workhoures, name, salary)
values (4870, 12, 'Lupe Nicks', 16376);
insert into WORKER (worker_id, workhoures, name, salary)
values (4880, 12, 'Crystal Loeb', 19417);
insert into WORKER (worker_id, workhoures, name, salary)
values (4890, 10, 'Teena Barnett', 14084);
insert into WORKER (worker_id, workhoures, name, salary)
values (4900, 9, 'Amanda Penders', 10588);
insert into WORKER (worker_id, workhoures, name, salary)
values (4910, 5, 'Daniel Pastore', 13597);
insert into WORKER (worker_id, workhoures, name, salary)
values (4920, 10, 'Lauren Peniston', 5018);
insert into WORKER (worker_id, workhoures, name, salary)
values (4930, 12, 'Benjamin Navarr', 9666);
insert into WORKER (worker_id, workhoures, name, salary)
values (4940, 4, 'Natasha Beals', 15577);
insert into WORKER (worker_id, workhoures, name, salary)
values (4950, 5, 'Beth Sellers', 4708);
insert into WORKER (worker_id, workhoures, name, salary)
values (4960, 8, 'Aaron Gooding', 17783);
insert into WORKER (worker_id, workhoures, name, salary)
values (4970, 11, 'Andy Ledger', 5022);
insert into WORKER (worker_id, workhoures, name, salary)
values (4980, 10, 'Neve Presley', 18523);
insert into WORKER (worker_id, workhoures, name, salary)
values (4990, 6, 'Isabella Dunn', 10013);
insert into WORKER (worker_id, workhoures, name, salary)
values (5000, 9, 'Shirley Mazzell', 5768);
insert into WORKER (worker_id, workhoures, name, salary)
values (5010, 8, 'Pablo Bean', 10401);
insert into WORKER (worker_id, workhoures, name, salary)
values (5020, 4, 'Michael Preston', 19300);
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
values (5100, 12, 'Janice Rickles', 13313);
insert into WORKER (worker_id, workhoures, name, salary)
values (5110, 11, 'Gavin Morales', 4718);
insert into WORKER (worker_id, workhoures, name, salary)
values (5120, 8, 'Oliver Connery', 12469);
insert into WORKER (worker_id, workhoures, name, salary)
values (5130, 6, 'Doug Deejay', 12257);
insert into WORKER (worker_id, workhoures, name, salary)
values (5140, 11, 'Shannyn Suvari', 10755);
insert into WORKER (worker_id, workhoures, name, salary)
values (5150, 7, 'Mark Donelly', 7632);
insert into WORKER (worker_id, workhoures, name, salary)
values (5160, 9, 'Powers Wine', 10712);
insert into WORKER (worker_id, workhoures, name, salary)
values (5170, 12, 'Oliver Woodward', 16014);
insert into WORKER (worker_id, workhoures, name, salary)
values (5180, 10, 'Hank Streep', 12442);
insert into WORKER (worker_id, workhoures, name, salary)
values (5190, 12, 'Mindy Smith', 10861);
insert into WORKER (worker_id, workhoures, name, salary)
values (5200, 12, 'Julie Costner', 5317);
insert into WORKER (worker_id, workhoures, name, salary)
values (5210, 7, 'Jann McPherson', 18142);
insert into WORKER (worker_id, workhoures, name, salary)
values (5220, 8, 'Lorraine Venora', 16705);
insert into WORKER (worker_id, workhoures, name, salary)
values (5230, 10, 'Vendetta Berkof', 5551);
insert into WORKER (worker_id, workhoures, name, salary)
values (5240, 8, 'Natalie Borgnin', 9683);
insert into WORKER (worker_id, workhoures, name, salary)
values (5250, 12, 'Hope Weston', 4731);
insert into WORKER (worker_id, workhoures, name, salary)
values (5260, 5, 'Hazel Goodman', 13763);
insert into WORKER (worker_id, workhoures, name, salary)
values (5270, 6, 'Faye Dafoe', 18489);
insert into WORKER (worker_id, workhoures, name, salary)
values (5280, 9, 'Rickie Hawthorn', 8602);
insert into WORKER (worker_id, workhoures, name, salary)
values (5290, 12, 'Vickie Jenkins', 17015);
insert into WORKER (worker_id, workhoures, name, salary)
values (5300, 12, 'Praga Dafoe', 8729);
insert into WORKER (worker_id, workhoures, name, salary)
values (5310, 11, 'Rebecca Tucci', 7102);
insert into WORKER (worker_id, workhoures, name, salary)
values (5320, 10, 'Steve Wilkinson', 13256);
insert into WORKER (worker_id, workhoures, name, salary)
values (5330, 5, 'Nastassja Monk', 14366);
insert into WORKER (worker_id, workhoures, name, salary)
values (5340, 9, 'Salma Bentley', 12603);
insert into WORKER (worker_id, workhoures, name, salary)
values (5350, 6, 'Miranda Simpson', 10459);
insert into WORKER (worker_id, workhoures, name, salary)
values (5360, 4, 'Lynn Landau', 4214);
insert into WORKER (worker_id, workhoures, name, salary)
values (5370, 7, 'Freda Thomas', 9296);
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
values (5430, 11, 'Kate Chinlund', 11879);
insert into WORKER (worker_id, workhoures, name, salary)
values (5440, 4, 'Sophie Eckhart', 12292);
insert into WORKER (worker_id, workhoures, name, salary)
values (5450, 10, 'Nicholas Tinsle', 13656);
insert into WORKER (worker_id, workhoures, name, salary)
values (5460, 5, 'Lindsey Neill', 7054);
insert into WORKER (worker_id, workhoures, name, salary)
values (5470, 12, 'Jody Child', 15282);
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
values (5550, 5, 'Rebeka Marx', 4624);
insert into WORKER (worker_id, workhoures, name, salary)
values (5560, 9, 'Grant Nash', 4964);
insert into WORKER (worker_id, workhoures, name, salary)
values (5570, 12, 'Vertical Robert', 11470);
insert into WORKER (worker_id, workhoures, name, salary)
values (5580, 9, 'Nik Tolkan', 17245);
insert into WORKER (worker_id, workhoures, name, salary)
values (5590, 7, 'Nick Eder', 18749);
insert into WORKER (worker_id, workhoures, name, salary)
values (5600, 8, 'Sissy Gibbons', 17647);
insert into WORKER (worker_id, workhoures, name, salary)
values (5610, 10, 'Eileen Marx', 16541);
insert into WORKER (worker_id, workhoures, name, salary)
values (5620, 4, 'Peabo Gooding', 4339);
insert into WORKER (worker_id, workhoures, name, salary)
values (5630, 7, 'Juliette Braugh', 11030);
insert into WORKER (worker_id, workhoures, name, salary)
values (5640, 5, 'Yaphet Gaynor', 11577);
insert into WORKER (worker_id, workhoures, name, salary)
values (5650, 11, 'Denis Harnes', 6722);
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
values (5720, 8, 'Miko Baranski', 6359);
insert into WORKER (worker_id, workhoures, name, salary)
values (5730, 4, 'Crystal Hubbard', 17116);
insert into WORKER (worker_id, workhoures, name, salary)
values (5740, 7, 'Bo Stamp', 19495);
insert into WORKER (worker_id, workhoures, name, salary)
values (5750, 12, 'Teena Nelligan', 12956);
insert into WORKER (worker_id, workhoures, name, salary)
values (5760, 11, 'Tony Harrison', 6777);
insert into WORKER (worker_id, workhoures, name, salary)
values (5770, 7, 'Nikki Palmer', 12027);
insert into WORKER (worker_id, workhoures, name, salary)
values (5780, 5, 'Vertical Rowlan', 19196);
insert into WORKER (worker_id, workhoures, name, salary)
values (5790, 11, 'Vickie Caine', 9206);
insert into WORKER (worker_id, workhoures, name, salary)
values (5800, 8, 'Chris Napolitan', 17575);
insert into WORKER (worker_id, workhoures, name, salary)
values (5810, 8, 'Rascal Giamatti', 19447);
insert into WORKER (worker_id, workhoures, name, salary)
values (5820, 10, 'Larenz Liotta', 15294);
commit;
prompt 100 records committed...
insert into WORKER (worker_id, workhoures, name, salary)
values (5830, 5, 'Adrien Lavigne', 12987);
insert into WORKER (worker_id, workhoures, name, salary)
values (5840, 7, 'Selma Travolta', 6010);
insert into WORKER (worker_id, workhoures, name, salary)
values (5850, 6, 'Freda Skaggs', 19577);
insert into WORKER (worker_id, workhoures, name, salary)
values (5860, 5, 'Julia Griggs', 12371);
insert into WORKER (worker_id, workhoures, name, salary)
values (5870, 12, 'Ethan Esposito', 17693);
insert into WORKER (worker_id, workhoures, name, salary)
values (5880, 6, 'Frank Blades', 15736);
insert into WORKER (worker_id, workhoures, name, salary)
values (5890, 9, 'Maureen Hawkins', 8758);
insert into WORKER (worker_id, workhoures, name, salary)
values (5900, 10, 'Mos Pacino', 6896);
insert into WORKER (worker_id, workhoures, name, salary)
values (5910, 9, 'Humberto McCrea', 4361);
insert into WORKER (worker_id, workhoures, name, salary)
values (5920, 4, 'Jonathan Holly', 13791);
insert into WORKER (worker_id, workhoures, name, salary)
values (5930, 6, 'Gary Pitney', 6474);
insert into WORKER (worker_id, workhoures, name, salary)
values (5940, 10, 'Charlton Metcal', 10230);
insert into WORKER (worker_id, workhoures, name, salary)
values (5950, 8, 'Cole Stiles', 12671);
insert into WORKER (worker_id, workhoures, name, salary)
values (5960, 4, 'Toshiro Harriso', 9608);
insert into WORKER (worker_id, workhoures, name, salary)
values (5970, 6, 'Debi O''Neill', 14347);
insert into WORKER (worker_id, workhoures, name, salary)
values (5980, 5, 'Amy Santana', 7625);
insert into WORKER (worker_id, workhoures, name, salary)
values (5990, 8, 'Murray Monk', 19939);
insert into WORKER (worker_id, workhoures, name, salary)
values (6000, 4, 'Shannon Davies', 14008);
insert into WORKER (worker_id, workhoures, name, salary)
values (2420, 5, 'Laura Westerber', 10434);
insert into WORKER (worker_id, workhoures, name, salary)
values (2430, 8, 'Angela Hutch', 14469);
insert into WORKER (worker_id, workhoures, name, salary)
values (2440, 7, 'Todd Aniston', 6902);
insert into WORKER (worker_id, workhoures, name, salary)
values (2450, 8, 'Azucar Worrell', 15831);
insert into WORKER (worker_id, workhoures, name, salary)
values (2460, 5, 'Remy Stigers', 10378);
insert into WORKER (worker_id, workhoures, name, salary)
values (2470, 5, 'Kiefer Moody', 17517);
insert into WORKER (worker_id, workhoures, name, salary)
values (2480, 10, 'Nicky Perlman', 15041);
insert into WORKER (worker_id, workhoures, name, salary)
values (2490, 8, 'Steven Cherry', 8423);
insert into WORKER (worker_id, workhoures, name, salary)
values (2500, 7, 'Dennis Hingle', 15312);
insert into WORKER (worker_id, workhoures, name, salary)
values (2510, 6, 'Merle Krumholtz', 5424);
insert into WORKER (worker_id, workhoures, name, salary)
values (2520, 11, 'Domingo Patton', 7575);
insert into WORKER (worker_id, workhoures, name, salary)
values (2530, 7, 'Ving Biel', 7594);
insert into WORKER (worker_id, workhoures, name, salary)
values (2540, 12, 'Jeffery Feore', 16895);
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
values (2600, 4, 'Leo Barrymore', 9134);
insert into WORKER (worker_id, workhoures, name, salary)
values (2610, 8, 'Corey Maguire', 18498);
insert into WORKER (worker_id, workhoures, name, salary)
values (2620, 7, 'Elisabeth Senio', 14089);
insert into WORKER (worker_id, workhoures, name, salary)
values (2630, 10, 'Vondie Bragg', 10759);
insert into WORKER (worker_id, workhoures, name, salary)
values (2640, 4, 'Ice Rubinek', 12788);
insert into WORKER (worker_id, workhoures, name, salary)
values (2650, 7, 'Carolyn Marin', 6990);
insert into WORKER (worker_id, workhoures, name, salary)
values (2660, 10, 'Rebeka Scaggs', 19471);
insert into WORKER (worker_id, workhoures, name, salary)
values (2670, 12, 'Brittany Dooley', 11760);
insert into WORKER (worker_id, workhoures, name, salary)
values (2680, 12, 'Armin Vanian', 4093);
insert into WORKER (worker_id, workhoures, name, salary)
values (2690, 8, 'Remy McElhone', 17586);
insert into WORKER (worker_id, workhoures, name, salary)
values (2700, 11, 'Mira Davis', 7039);
insert into WORKER (worker_id, workhoures, name, salary)
values (2710, 9, 'Nile Jonze', 8148);
insert into WORKER (worker_id, workhoures, name, salary)
values (2720, 6, 'Suzy Tinsley', 6842);
insert into WORKER (worker_id, workhoures, name, salary)
values (2730, 6, 'Jason Phillippe', 18516);
insert into WORKER (worker_id, workhoures, name, salary)
values (2740, 12, 'Tara Sherman', 4904);
insert into WORKER (worker_id, workhoures, name, salary)
values (2750, 5, 'Rolando Armstro', 12353);
insert into WORKER (worker_id, workhoures, name, salary)
values (2760, 9, 'Tramaine Dillan', 7215);
insert into WORKER (worker_id, workhoures, name, salary)
values (2770, 10, 'Lesley Cetera', 8152);
insert into WORKER (worker_id, workhoures, name, salary)
values (2780, 12, 'Kurt Strathairn', 15070);
insert into WORKER (worker_id, workhoures, name, salary)
values (2790, 10, 'Max Fariq', 6442);
insert into WORKER (worker_id, workhoures, name, salary)
values (2800, 7, 'Radney Francis', 8785);
insert into WORKER (worker_id, workhoures, name, salary)
values (2810, 12, 'Seth Arjona', 6011);
insert into WORKER (worker_id, workhoures, name, salary)
values (2820, 8, 'Meg Rhymes', 4426);
insert into WORKER (worker_id, workhoures, name, salary)
values (2830, 10, 'Kurtwood Fogert', 13124);
insert into WORKER (worker_id, workhoures, name, salary)
values (2840, 8, 'Jessica Winwood', 7515);
insert into WORKER (worker_id, workhoures, name, salary)
values (2850, 10, 'Buddy Zevon', 11745);
insert into WORKER (worker_id, workhoures, name, salary)
values (2860, 9, 'Elias Pride', 7757);
insert into WORKER (worker_id, workhoures, name, salary)
values (2870, 7, 'Val Lipnicki', 6748);
insert into WORKER (worker_id, workhoures, name, salary)
values (2880, 11, 'Juliet Field', 14757);
insert into WORKER (worker_id, workhoures, name, salary)
values (2890, 11, 'Chalee Winger', 12148);
insert into WORKER (worker_id, workhoures, name, salary)
values (2900, 9, 'Hope Mars', 6736);
insert into WORKER (worker_id, workhoures, name, salary)
values (2910, 11, 'Goldie Keitel', 16305);
insert into WORKER (worker_id, workhoures, name, salary)
values (2920, 5, 'Rita Crystal', 16256);
insert into WORKER (worker_id, workhoures, name, salary)
values (2930, 11, 'Red Ryan', 4155);
insert into WORKER (worker_id, workhoures, name, salary)
values (2940, 12, 'Roger Farrow', 16929);
insert into WORKER (worker_id, workhoures, name, salary)
values (2950, 7, 'Chantי Hurt', 4424);
insert into WORKER (worker_id, workhoures, name, salary)
values (2960, 11, 'Lindsey Cruz', 11145);
insert into WORKER (worker_id, workhoures, name, salary)
values (2970, 10, 'Quentin Stevens', 17845);
insert into WORKER (worker_id, workhoures, name, salary)
values (2980, 6, 'Cameron Shandli', 14787);
insert into WORKER (worker_id, workhoures, name, salary)
values (2990, 8, 'Maxine Conlee', 18379);
insert into WORKER (worker_id, workhoures, name, salary)
values (3000, 7, 'Edie Belle', 18951);
insert into WORKER (worker_id, workhoures, name, salary)
values (3010, 8, 'Nancy Weiss', 11432);
insert into WORKER (worker_id, workhoures, name, salary)
values (3020, 4, 'Malcolm Palmer', 8659);
insert into WORKER (worker_id, workhoures, name, salary)
values (3030, 4, 'Vern McLachlan', 5077);
insert into WORKER (worker_id, workhoures, name, salary)
values (3040, 4, 'Kid Keaton', 6587);
insert into WORKER (worker_id, workhoures, name, salary)
values (3050, 4, 'Vendetta Santan', 6273);
insert into WORKER (worker_id, workhoures, name, salary)
values (3060, 5, 'Doug Olyphant', 13779);
insert into WORKER (worker_id, workhoures, name, salary)
values (3070, 10, 'Al Jackman', 10076);
insert into WORKER (worker_id, workhoures, name, salary)
values (3080, 4, 'Brooke Richards', 7363);
insert into WORKER (worker_id, workhoures, name, salary)
values (3090, 11, 'Nicole Salonga', 13867);
insert into WORKER (worker_id, workhoures, name, salary)
values (3100, 9, 'Marie Mandrell', 11275);
insert into WORKER (worker_id, workhoures, name, salary)
values (3110, 5, 'Horace Weiland', 8566);
insert into WORKER (worker_id, workhoures, name, salary)
values (3120, 7, 'Sean McFerrin', 15974);
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
values (3190, 10, 'Patrick Reubens', 8995);
insert into WORKER (worker_id, workhoures, name, salary)
values (3200, 11, 'Carrie Conlee', 12443);
insert into WORKER (worker_id, workhoures, name, salary)
values (3210, 6, 'Taye Haslam', 19251);
insert into WORKER (worker_id, workhoures, name, salary)
values (3220, 6, 'Claude Magnuson', 12642);
insert into WORKER (worker_id, workhoures, name, salary)
values (3230, 10, 'Selma Gayle', 8525);
commit;
prompt 200 records committed...
insert into WORKER (worker_id, workhoures, name, salary)
values (3240, 12, 'Ben Abraham', 19649);
insert into WORKER (worker_id, workhoures, name, salary)
values (3250, 12, 'Jet Peet', 16645);
insert into WORKER (worker_id, workhoures, name, salary)
values (3260, 8, 'Nanci Howard', 9719);
insert into WORKER (worker_id, workhoures, name, salary)
values (3270, 7, 'Kimberly Martin', 10725);
insert into WORKER (worker_id, workhoures, name, salary)
values (3280, 9, 'Suzanne Sutherl', 7383);
insert into WORKER (worker_id, workhoures, name, salary)
values (3290, 5, 'Will Holden', 5389);
insert into WORKER (worker_id, workhoures, name, salary)
values (3300, 6, 'Jeffery Rollins', 6164);
insert into WORKER (worker_id, workhoures, name, salary)
values (3310, 4, 'Terri Monk', 15992);
insert into WORKER (worker_id, workhoures, name, salary)
values (3320, 4, 'Roddy Hagar', 10298);
insert into WORKER (worker_id, workhoures, name, salary)
values (3330, 4, 'Quentin Judd', 4827);
insert into WORKER (worker_id, workhoures, name, salary)
values (3340, 11, 'Dom Oakenfold', 5449);
insert into WORKER (worker_id, workhoures, name, salary)
values (3350, 7, 'Lesley Fogerty', 12361);
insert into WORKER (worker_id, workhoures, name, salary)
values (3360, 6, 'Oro Kadison', 18433);
insert into WORKER (worker_id, workhoures, name, salary)
values (3370, 7, 'Famke Day', 9439);
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
values (3430, 6, 'Terry Dafoe', 6761);
insert into WORKER (worker_id, workhoures, name, salary)
values (3440, 6, 'Davis Pullman', 5481);
insert into WORKER (worker_id, workhoures, name, salary)
values (3450, 6, 'Taylor Blackmor', 9819);
insert into WORKER (worker_id, workhoures, name, salary)
values (3460, 6, 'Chazz Assante', 16400);
insert into WORKER (worker_id, workhoures, name, salary)
values (3470, 5, 'Phoebe Kier', 14069);
insert into WORKER (worker_id, workhoures, name, salary)
values (3480, 10, 'Jose Favreau', 12429);
insert into WORKER (worker_id, workhoures, name, salary)
values (3490, 10, 'Wally McCabe', 13255);
insert into WORKER (worker_id, workhoures, name, salary)
values (3500, 10, 'Laura Paige', 16557);
insert into WORKER (worker_id, workhoures, name, salary)
values (3510, 11, 'Tracy Sisto', 13034);
insert into WORKER (worker_id, workhoures, name, salary)
values (3520, 9, 'Vincent McGill', 14667);
insert into WORKER (worker_id, workhoures, name, salary)
values (3530, 5, 'Mindy Balaban', 19200);
insert into WORKER (worker_id, workhoures, name, salary)
values (3540, 6, 'Clive Perrineau', 16264);
insert into WORKER (worker_id, workhoures, name, salary)
values (3550, 5, 'Nicolas Orton', 18896);
insert into WORKER (worker_id, workhoures, name, salary)
values (3560, 8, 'Brooke Chao', 12188);
insert into WORKER (worker_id, workhoures, name, salary)
values (3570, 8, 'Barbara McLachl', 18839);
insert into WORKER (worker_id, workhoures, name, salary)
values (3580, 8, 'Solomon Conroy', 5335);
insert into WORKER (worker_id, workhoures, name, salary)
values (3590, 10, 'Debra Bracco', 12535);
insert into WORKER (worker_id, workhoures, name, salary)
values (3600, 5, 'Madeline Avital', 18378);
insert into WORKER (worker_id, workhoures, name, salary)
values (3610, 5, 'Clint Baldwin', 4499);
insert into WORKER (worker_id, workhoures, name, salary)
values (3620, 7, 'Denzel Camp', 14478);
insert into WORKER (worker_id, workhoures, name, salary)
values (3630, 8, 'Lin Pacino', 11474);
insert into WORKER (worker_id, workhoures, name, salary)
values (3640, 6, 'Jeffery McDowel', 19011);
insert into WORKER (worker_id, workhoures, name, salary)
values (3650, 11, 'Sissy Hopper', 8647);
insert into WORKER (worker_id, workhoures, name, salary)
values (3660, 8, 'Lizzy Campbell', 10284);
insert into WORKER (worker_id, workhoures, name, salary)
values (3670, 10, 'Melba Cohn', 12873);
insert into WORKER (worker_id, workhoures, name, salary)
values (3680, 8, 'Quentin Browne', 11253);
insert into WORKER (worker_id, workhoures, name, salary)
values (3690, 10, 'Ron Schwimmer', 14889);
insert into WORKER (worker_id, workhoures, name, salary)
values (3700, 12, 'Stockard Berkle', 14242);
insert into WORKER (worker_id, workhoures, name, salary)
values (3710, 10, 'Bridgette Carlt', 16536);
insert into WORKER (worker_id, workhoures, name, salary)
values (3720, 10, 'Shannon Kingsle', 10661);
insert into WORKER (worker_id, workhoures, name, salary)
values (3730, 10, 'Irene Waits', 12974);
insert into WORKER (worker_id, workhoures, name, salary)
values (3740, 12, 'Pelvic Schiff', 13728);
insert into WORKER (worker_id, workhoures, name, salary)
values (3750, 5, 'Gary Myles', 15905);
insert into WORKER (worker_id, workhoures, name, salary)
values (3760, 10, 'Bobby von Sydow', 10182);
insert into WORKER (worker_id, workhoures, name, salary)
values (3770, 10, 'Norm Unger', 5789);
insert into WORKER (worker_id, workhoures, name, salary)
values (3780, 10, 'Dom Stigers', 17009);
insert into WORKER (worker_id, workhoures, name, salary)
values (3790, 6, 'Gaby Wong', 5064);
insert into WORKER (worker_id, workhoures, name, salary)
values (3800, 9, 'Rhys Pryce', 19153);
insert into WORKER (worker_id, workhoures, name, salary)
values (3810, 12, 'Jeff Thurman', 16365);
insert into WORKER (worker_id, workhoures, name, salary)
values (3820, 12, 'Vondie Caine', 12242);
insert into WORKER (worker_id, workhoures, name, salary)
values (3830, 12, 'Morgan Guest', 17739);
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
values (3900, 6, 'Heath Leoni', 16655);
insert into WORKER (worker_id, workhoures, name, salary)
values (3910, 6, 'Guy Marie', 8730);
insert into WORKER (worker_id, workhoures, name, salary)
values (3920, 5, 'Ty Springfield', 13003);
insert into WORKER (worker_id, workhoures, name, salary)
values (3930, 12, 'Neve McAnally', 18049);
insert into WORKER (worker_id, workhoures, name, salary)
values (3940, 10, 'Aaron Gallant', 12601);
insert into WORKER (worker_id, workhoures, name, salary)
values (3950, 12, 'Dar Hopper', 11700);
insert into WORKER (worker_id, workhoures, name, salary)
values (3960, 4, 'Spencer Holy', 5964);
insert into WORKER (worker_id, workhoures, name, salary)
values (3970, 11, 'Suzi Costa', 17766);
insert into WORKER (worker_id, workhoures, name, salary)
values (3980, 7, 'Lynn Bacharach', 4039);
insert into WORKER (worker_id, workhoures, name, salary)
values (3990, 11, 'Freddy Richter', 5488);
insert into WORKER (worker_id, workhoures, name, salary)
values (4000, 6, 'Shannyn McLachl', 17924);
insert into WORKER (worker_id, workhoures, name, salary)
values (4010, 5, 'Stellan Heather', 9497);
insert into WORKER (worker_id, workhoures, name, salary)
values (4020, 6, 'Christina Mahoo', 15581);
insert into WORKER (worker_id, workhoures, name, salary)
values (4030, 4, 'Devon Mann', 7022);
insert into WORKER (worker_id, workhoures, name, salary)
values (4040, 5, 'Toshiro Brown', 15562);
insert into WORKER (worker_id, workhoures, name, salary)
values (4050, 12, 'Nelly Cage', 12117);
insert into WORKER (worker_id, workhoures, name, salary)
values (4060, 7, 'Rebecca Favreau', 13725);
insert into WORKER (worker_id, workhoures, name, salary)
values (4070, 11, 'Ozzy Serbedzija', 18871);
insert into WORKER (worker_id, workhoures, name, salary)
values (4080, 7, 'Nils Ifans', 14952);
insert into WORKER (worker_id, workhoures, name, salary)
values (4090, 5, 'Lari Burmester', 17637);
insert into WORKER (worker_id, workhoures, name, salary)
values (4100, 11, 'Lennie Satriani', 9866);
insert into WORKER (worker_id, workhoures, name, salary)
values (4110, 7, 'Murray DeVita', 4241);
insert into WORKER (worker_id, workhoures, name, salary)
values (4120, 5, 'Famke Mould', 8555);
insert into WORKER (worker_id, workhoures, name, salary)
values (4130, 9, 'Pat Pearce', 14211);
insert into WORKER (worker_id, workhoures, name, salary)
values (4140, 6, 'Lois Kretschman', 19286);
insert into WORKER (worker_id, workhoures, name, salary)
values (4150, 12, 'Belinda Unger', 5983);
insert into WORKER (worker_id, workhoures, name, salary)
values (4160, 10, 'Denny Teng', 4225);
insert into WORKER (worker_id, workhoures, name, salary)
values (4170, 10, 'Mena Hong', 9134);
insert into WORKER (worker_id, workhoures, name, salary)
values (4180, 5, 'Samuel Fender', 4158);
insert into WORKER (worker_id, workhoures, name, salary)
values (4190, 7, 'Spike Belles', 9588);
insert into WORKER (worker_id, workhoures, name, salary)
values (4200, 9, 'Jesse Furtado', 16208);
insert into WORKER (worker_id, workhoures, name, salary)
values (4210, 6, 'Marc Roundtree', 19843);
insert into WORKER (worker_id, workhoures, name, salary)
values (4220, 7, 'Colm Hauser', 8549);
insert into WORKER (worker_id, workhoures, name, salary)
values (4230, 5, 'Avenged McGover', 14186);
commit;
prompt 300 records committed...
insert into WORKER (worker_id, workhoures, name, salary)
values (4240, 5, 'Christmas Mazar', 8135);
insert into WORKER (worker_id, workhoures, name, salary)
values (4250, 11, 'Terrence Stewar', 16912);
insert into WORKER (worker_id, workhoures, name, salary)
values (4260, 4, 'Debra Solido', 5411);
insert into WORKER (worker_id, workhoures, name, salary)
values (4270, 6, 'Jesus Warburton', 7546);
insert into WORKER (worker_id, workhoures, name, salary)
values (4280, 9, 'Stephanie Mathe', 12034);
insert into WORKER (worker_id, workhoures, name, salary)
values (4290, 9, 'Natascha Bracco', 11058);
insert into WORKER (worker_id, workhoures, name, salary)
values (4300, 4, 'Fairuza Goldber', 15591);
insert into WORKER (worker_id, workhoures, name, salary)
values (4310, 12, 'Nickel Palin', 5083);
insert into WORKER (worker_id, workhoures, name, salary)
values (4320, 8, 'Elizabeth Colem', 7318);
insert into WORKER (worker_id, workhoures, name, salary)
values (4330, 6, 'Sharon Sevenfol', 12139);
insert into WORKER (worker_id, workhoures, name, salary)
values (4340, 10, 'Hope Spears', 18824);
insert into WORKER (worker_id, workhoures, name, salary)
values (4350, 8, 'Dwight Collie', 8848);
insert into WORKER (worker_id, workhoures, name, salary)
values (4360, 8, 'CeCe Spacey', 7796);
insert into WORKER (worker_id, workhoures, name, salary)
values (4370, 5, 'Bridgette Cartl', 4152);
insert into WORKER (worker_id, workhoures, name, salary)
values (4380, 7, 'Burt Field', 8736);
insert into WORKER (worker_id, workhoures, name, salary)
values (4390, 7, 'Donal Giannini', 14534);
insert into WORKER (worker_id, workhoures, name, salary)
values (4400, 11, 'Geoffrey Hunter', 4664);
insert into WORKER (worker_id, workhoures, name, salary)
values (4410, 10, 'Penelope Katt', 16236);
insert into WORKER (worker_id, workhoures, name, salary)
values (4420, 8, 'Linda England', 15847);
insert into WORKER (worker_id, workhoures, name, salary)
values (4430, 12, 'Joanna Fonda', 18476);
insert into WORKER (worker_id, workhoures, name, salary)
values (4440, 8, 'Pat Plummer', 5509);
insert into WORKER (worker_id, workhoures, name, salary)
values (4450, 8, 'Peabo Estevez', 17669);
insert into WORKER (worker_id, workhoures, name, salary)
values (4460, 11, 'Greg Rea', 18563);
insert into WORKER (worker_id, workhoures, name, salary)
values (4470, 12, 'Denis Briscoe', 8646);
insert into WORKER (worker_id, workhoures, name, salary)
values (4480, 8, 'Chad Crow', 9311);
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
values (4560, 11, 'Kasey Heatherly', 4648);
insert into WORKER (worker_id, workhoures, name, salary)
values (4570, 12, 'Curtis Redford', 19966);
insert into WORKER (worker_id, workhoures, name, salary)
values (4580, 7, 'Ike Chestnut', 13782);
insert into WORKER (worker_id, workhoures, name, salary)
values (4590, 11, 'Taye Gertner', 5887);
insert into WORKER (worker_id, workhoures, name, salary)
values (4600, 5, 'Cornell Richard', 14093);
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
values (4710, 11, 'Adina Sandoval', 17770);
insert into WORKER (worker_id, workhoures, name, salary)
values (4720, 12, 'Crispin Carrack', 12196);
insert into WORKER (worker_id, workhoures, name, salary)
values (4730, 11, 'Neneh Shand', 4462);
insert into WORKER (worker_id, workhoures, name, salary)
values (4740, 8, 'Renee Roberts', 7825);
insert into WORKER (worker_id, workhoures, name, salary)
values (4750, 8, 'Drew Feliciano', 6641);
insert into WORKER (worker_id, workhoures, name, salary)
values (4760, 12, 'Sandra Parsons', 18893);
insert into WORKER (worker_id, workhoures, name, salary)
values (4770, 7, 'Gary Arjona', 5613);
insert into WORKER (worker_id, workhoures, name, salary)
values (4780, 6, 'Freda Soda', 6946);
insert into WORKER (worker_id, workhoures, name, salary)
values (4790, 11, 'Ellen Keener', 8599);
insert into WORKER (worker_id, workhoures, name, salary)
values (4800, 8, 'Deborah Taranti', 6434);
insert into WORKER (worker_id, workhoures, name, salary)
values (4810, 11, 'Aimee Seagal', 4953);
insert into WORKER (worker_id, workhoures, name, salary)
values (4820, 7, 'Gena Barrymore', 9422);
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
values (1050, 11, 'Anna Iglesias', 14436);
insert into WORKER (worker_id, workhoures, name, salary)
values (1060, 11, 'Mary Mirren', 5175);
insert into WORKER (worker_id, workhoures, name, salary)
values (1070, 8, 'Burt Jeter', 18958);
insert into WORKER (worker_id, workhoures, name, salary)
values (1080, 10, 'Anjelica El-Sah', 18540);
insert into WORKER (worker_id, workhoures, name, salary)
values (1090, 9, 'Keith Tucci', 12964);
insert into WORKER (worker_id, workhoures, name, salary)
values (1100, 4, 'Rene Coleman', 19867);
insert into WORKER (worker_id, workhoures, name, salary)
values (1110, 10, 'Rene Parm', 10183);
insert into WORKER (worker_id, workhoures, name, salary)
values (1120, 5, 'Avril Dreyfuss', 14987);
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
values (1180, 6, 'Edward Himmelma', 17251);
insert into WORKER (worker_id, workhoures, name, salary)
values (1190, 9, 'Colm Davis', 8288);
insert into WORKER (worker_id, workhoures, name, salary)
values (1200, 9, 'Spike Levert', 12997);
insert into WORKER (worker_id, workhoures, name, salary)
values (1210, 7, 'Rascal Crudup', 17092);
insert into WORKER (worker_id, workhoures, name, salary)
values (1220, 4, 'Charles Sorvino', 9588);
insert into WORKER (worker_id, workhoures, name, salary)
values (1230, 7, 'Clint Elwes', 16696);
insert into WORKER (worker_id, workhoures, name, salary)
values (1240, 11, 'Donna Moss', 14845);
insert into WORKER (worker_id, workhoures, name, salary)
values (1250, 12, 'Jimmy Dempsey', 18610);
insert into WORKER (worker_id, workhoures, name, salary)
values (1260, 6, 'Freddy Sanchez', 19269);
insert into WORKER (worker_id, workhoures, name, salary)
values (1270, 9, 'Dan Pullman', 13758);
insert into WORKER (worker_id, workhoures, name, salary)
values (1280, 7, 'Terri Nolte', 15762);
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
values (1390, 4, 'Chantי Begley', 13729);
commit;
prompt 400 records committed...
insert into WORKER (worker_id, workhoures, name, salary)
values (1400, 10, 'Nile Byrd', 12069);
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
values (1480, 8, 'Hugo Tomei', 12217);
insert into WORKER (worker_id, workhoures, name, salary)
values (1490, 12, 'Regina Craven', 10474);
insert into WORKER (worker_id, workhoures, name, salary)
values (1500, 10, 'Malcolm Fonda', 8637);
insert into WORKER (worker_id, workhoures, name, salary)
values (1510, 8, 'Steven Remar', 13174);
insert into WORKER (worker_id, workhoures, name, salary)
values (1520, 10, 'Dustin Napolita', 9718);
insert into WORKER (worker_id, workhoures, name, salary)
values (1530, 5, 'Randall Carrere', 14421);
insert into WORKER (worker_id, workhoures, name, salary)
values (1540, 8, 'Kim Wood', 8959);
insert into WORKER (worker_id, workhoures, name, salary)
values (1550, 7, 'Johnny Bancroft', 14918);
insert into WORKER (worker_id, workhoures, name, salary)
values (1560, 12, 'Alec Perlman', 7323);
insert into WORKER (worker_id, workhoures, name, salary)
values (1570, 7, 'Frank Pantolian', 11064);
insert into WORKER (worker_id, workhoures, name, salary)
values (1580, 10, 'Domingo O''Donne', 7951);
insert into WORKER (worker_id, workhoures, name, salary)
values (1590, 11, 'Mickey Karyo', 6173);
insert into WORKER (worker_id, workhoures, name, salary)
values (1600, 9, 'Chris Wong', 19887);
insert into WORKER (worker_id, workhoures, name, salary)
values (1610, 8, 'Nicky Boyle', 14696);
insert into WORKER (worker_id, workhoures, name, salary)
values (1620, 6, 'Nina Weber', 6787);
insert into WORKER (worker_id, workhoures, name, salary)
values (1630, 10, 'Harvey Supernaw', 11432);
insert into WORKER (worker_id, workhoures, name, salary)
values (1640, 7, 'Lea Farrell', 4650);
insert into WORKER (worker_id, workhoures, name, salary)
values (1650, 4, 'Diamond Leoni', 17754);
insert into WORKER (worker_id, workhoures, name, salary)
values (1660, 12, 'Nelly Rains', 8530);
insert into WORKER (worker_id, workhoures, name, salary)
values (1670, 10, 'Kenny Wakeling', 4824);
insert into WORKER (worker_id, workhoures, name, salary)
values (1680, 11, 'Gordie Webb', 12252);
insert into WORKER (worker_id, workhoures, name, salary)
values (1690, 5, 'Carrie-Anne Rey', 13813);
insert into WORKER (worker_id, workhoures, name, salary)
values (1700, 6, 'Pete Rhymes', 9136);
insert into WORKER (worker_id, workhoures, name, salary)
values (1710, 5, 'Samantha Reinho', 13120);
insert into WORKER (worker_id, workhoures, name, salary)
values (1720, 6, 'Aidan McDonnell', 17715);
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
values (1800, 7, 'Ian Malkovich', 18278);
insert into WORKER (worker_id, workhoures, name, salary)
values (1810, 6, 'Larenz Spader', 11867);
insert into WORKER (worker_id, workhoures, name, salary)
values (1820, 8, 'Freda Bassett', 4036);
insert into WORKER (worker_id, workhoures, name, salary)
values (1830, 4, 'Rade Vinton', 19758);
insert into WORKER (worker_id, workhoures, name, salary)
values (1840, 8, 'Natascha Marsde', 16382);
insert into WORKER (worker_id, workhoures, name, salary)
values (1850, 12, 'Darius Luongo', 7502);
insert into WORKER (worker_id, workhoures, name, salary)
values (1860, 6, 'Mindy Womack', 14454);
insert into WORKER (worker_id, workhoures, name, salary)
values (1870, 10, 'Denis Wagner', 5196);
insert into WORKER (worker_id, workhoures, name, salary)
values (1880, 10, 'Ray Doucette', 16354);
insert into WORKER (worker_id, workhoures, name, salary)
values (1890, 12, 'Tony Diffie', 18129);
insert into WORKER (worker_id, workhoures, name, salary)
values (1900, 7, 'James Preston', 13866);
insert into WORKER (worker_id, workhoures, name, salary)
values (1910, 10, 'Tori Campbell', 6005);
insert into WORKER (worker_id, workhoures, name, salary)
values (1920, 7, 'Howie Schneider', 8173);
insert into WORKER (worker_id, workhoures, name, salary)
values (1930, 8, 'Cheryl Stigers', 15165);
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
values (2040, 9, 'Millie Hewitt', 12350);
insert into WORKER (worker_id, workhoures, name, salary)
values (2050, 4, 'Amy Tempest', 17040);
insert into WORKER (worker_id, workhoures, name, salary)
values (2060, 5, 'Tommy Baker', 17810);
insert into WORKER (worker_id, workhoures, name, salary)
values (2070, 6, 'Russell Lerner', 17851);
insert into WORKER (worker_id, workhoures, name, salary)
values (2080, 5, 'Jean-Luc Dolenz', 8150);
insert into WORKER (worker_id, workhoures, name, salary)
values (2090, 11, 'Gerald Chandler', 13725);
insert into WORKER (worker_id, workhoures, name, salary)
values (2100, 5, 'Mykelti McKean', 9494);
insert into WORKER (worker_id, workhoures, name, salary)
values (2110, 5, 'Armand McElhone', 9547);
insert into WORKER (worker_id, workhoures, name, salary)
values (2120, 12, 'Gene Gough', 13548);
insert into WORKER (worker_id, workhoures, name, salary)
values (2130, 6, 'Gina Alda', 10027);
insert into WORKER (worker_id, workhoures, name, salary)
values (2140, 11, 'Harrison McCann', 16326);
insert into WORKER (worker_id, workhoures, name, salary)
values (2150, 6, 'Tori Gryner', 10913);
insert into WORKER (worker_id, workhoures, name, salary)
values (2160, 9, 'Jared Levin', 17865);
insert into WORKER (worker_id, workhoures, name, salary)
values (2390, 4, 'Nikka Fariq', 6698);
insert into WORKER (worker_id, workhoures, name, salary)
values (2400, 5, 'Marie Martinez', 18322);
insert into WORKER (worker_id, workhoures, name, salary)
values (2410, 4, 'Gilberto Brisco', 11291);
insert into WORKER (worker_id, workhoures, name, salary)
values (10, 5, 'Karen Hoffman', 15916);
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
values (90, 8, 'Jena Mazzello', 15979);
insert into WORKER (worker_id, workhoures, name, salary)
values (100, 6, 'Jennifer Arthur', 18128);
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
commit;
prompt 500 records committed...
insert into WORKER (worker_id, workhoures, name, salary)
values (210, 4, 'Seann Romijn-St', 11080);
insert into WORKER (worker_id, workhoures, name, salary)
values (220, 5, 'Kathy Brothers', 18427);
insert into WORKER (worker_id, workhoures, name, salary)
values (230, 8, 'Willem Pierce', 15066);
insert into WORKER (worker_id, workhoures, name, salary)
values (240, 10, 'Nancy Tennison', 9747);
insert into WORKER (worker_id, workhoures, name, salary)
values (250, 7, 'Ramsey Waite', 18867);
insert into WORKER (worker_id, workhoures, name, salary)
values (260, 9, 'Nile Yorn', 15465);
insert into WORKER (worker_id, workhoures, name, salary)
values (270, 12, 'Wendy Vince', 17621);
insert into WORKER (worker_id, workhoures, name, salary)
values (280, 12, 'Kazem Easton', 15979);
insert into WORKER (worker_id, workhoures, name, salary)
values (290, 4, 'Rufus Dench', 4167);
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
values (360, 10, 'Colm Borden', 5394);
insert into WORKER (worker_id, workhoures, name, salary)
values (370, 7, 'Juliette Jolie', 4637);
insert into WORKER (worker_id, workhoures, name, salary)
values (380, 11, 'Gerald Darren', 7355);
insert into WORKER (worker_id, workhoures, name, salary)
values (390, 9, 'Mint Myles', 7383);
insert into WORKER (worker_id, workhoures, name, salary)
values (400, 10, 'Alessandro Gatl', 19457);
insert into WORKER (worker_id, workhoures, name, salary)
values (410, 11, 'Kirsten Avital', 12816);
insert into WORKER (worker_id, workhoures, name, salary)
values (420, 7, 'Marty Chinlund', 12458);
insert into WORKER (worker_id, workhoures, name, salary)
values (430, 12, 'Lindsay Conley', 15773);
insert into WORKER (worker_id, workhoures, name, salary)
values (440, 12, 'Mae Orlando', 16327);
insert into WORKER (worker_id, workhoures, name, salary)
values (450, 11, 'Jody Hawke', 14534);
insert into WORKER (worker_id, workhoures, name, salary)
values (460, 8, 'Jackson Winwood', 10964);
insert into WORKER (worker_id, workhoures, name, salary)
values (470, 5, 'Denis Almond', 14048);
insert into WORKER (worker_id, workhoures, name, salary)
values (480, 9, 'Lari Keen', 17919);
insert into WORKER (worker_id, workhoures, name, salary)
values (490, 7, 'Mary-Louise Wat', 6146);
insert into WORKER (worker_id, workhoures, name, salary)
values (500, 8, 'Manu Cronin', 9109);
insert into WORKER (worker_id, workhoures, name, salary)
values (510, 10, 'Joseph Mars', 6762);
insert into WORKER (worker_id, workhoures, name, salary)
values (520, 5, 'Kitty Reid', 16540);
insert into WORKER (worker_id, workhoures, name, salary)
values (530, 4, 'Brothers Serbed', 6152);
insert into WORKER (worker_id, workhoures, name, salary)
values (540, 7, 'Nigel Durning', 11021);
insert into WORKER (worker_id, workhoures, name, salary)
values (550, 9, 'Sean Rubinek', 8109);
insert into WORKER (worker_id, workhoures, name, salary)
values (560, 10, 'Gerald Spears', 13887);
insert into WORKER (worker_id, workhoures, name, salary)
values (570, 10, 'Mekhi Jackson', 14189);
insert into WORKER (worker_id, workhoures, name, salary)
values (580, 8, 'Parker Forster', 9716);
insert into WORKER (worker_id, workhoures, name, salary)
values (590, 5, 'Lena Schwimmer', 16923);
insert into WORKER (worker_id, workhoures, name, salary)
values (600, 12, 'Patty Carlyle', 12048);
insert into WORKER (worker_id, workhoures, name, salary)
values (610, 4, 'Lois Gill', 18037);
insert into WORKER (worker_id, workhoures, name, salary)
values (620, 8, 'Corey Shalhoub', 10102);
insert into WORKER (worker_id, workhoures, name, salary)
values (630, 9, 'Geena Peterson', 7675);
insert into WORKER (worker_id, workhoures, name, salary)
values (640, 9, 'Jesus McIntosh', 4500);
insert into WORKER (worker_id, workhoures, name, salary)
values (650, 4, 'Ryan Rodgers', 16615);
insert into WORKER (worker_id, workhoures, name, salary)
values (660, 5, 'Wendy Fiennes', 19979);
insert into WORKER (worker_id, workhoures, name, salary)
values (670, 11, 'Joey Bloch', 17484);
insert into WORKER (worker_id, workhoures, name, salary)
values (680, 6, 'Anna Paquin', 15113);
insert into WORKER (worker_id, workhoures, name, salary)
values (690, 7, 'Ricky Heston', 10983);
insert into WORKER (worker_id, workhoures, name, salary)
values (700, 7, 'Graham Wood', 9034);
insert into WORKER (worker_id, workhoures, name, salary)
values (710, 5, 'Nastassja Skars', 9103);
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
values (770, 9, 'Jeanne Durning', 12037);
insert into WORKER (worker_id, workhoures, name, salary)
values (780, 7, 'Debby Palmer', 6892);
insert into WORKER (worker_id, workhoures, name, salary)
values (790, 4, 'Derrick Mirren', 19001);
insert into WORKER (worker_id, workhoures, name, salary)
values (800, 12, 'Seann Supernaw', 5465);
insert into WORKER (worker_id, workhoures, name, salary)
values (810, 12, 'Phil Colin Youn', 14545);
insert into WORKER (worker_id, workhoures, name, salary)
values (820, 9, 'Gwyneth Weiland', 19528);
insert into WORKER (worker_id, workhoures, name, salary)
values (830, 4, 'Patricia White', 5993);
insert into WORKER (worker_id, workhoures, name, salary)
values (840, 4, 'Daniel Danes', 12223);
insert into WORKER (worker_id, workhoures, name, salary)
values (850, 9, 'Todd Almond', 18492);
insert into WORKER (worker_id, workhoures, name, salary)
values (860, 9, 'Fats Harnes', 17004);
insert into WORKER (worker_id, workhoures, name, salary)
values (870, 6, 'Lea Richards', 6225);
insert into WORKER (worker_id, workhoures, name, salary)
values (880, 8, 'Garland Yankovi', 9345);
insert into WORKER (worker_id, workhoures, name, salary)
values (890, 7, 'Sara Turturro', 12639);
insert into WORKER (worker_id, workhoures, name, salary)
values (900, 4, 'Anthony Busey', 11465);
insert into WORKER (worker_id, workhoures, name, salary)
values (910, 5, 'Penelope Margul', 19656);
insert into WORKER (worker_id, workhoures, name, salary)
values (920, 5, 'Patty Gibbons', 14045);
insert into WORKER (worker_id, workhoures, name, salary)
values (930, 10, 'Karen Mars', 13893);
insert into WORKER (worker_id, workhoures, name, salary)
values (940, 10, 'Mary-Louise Col', 18945);
insert into WORKER (worker_id, workhoures, name, salary)
values (950, 6, 'Johnny Gayle', 13884);
insert into WORKER (worker_id, workhoures, name, salary)
values (960, 12, 'Javon McGill', 10925);
insert into WORKER (worker_id, workhoures, name, salary)
values (970, 4, 'Teena Stiller', 10296);
insert into WORKER (worker_id, workhoures, name, salary)
values (980, 5, 'Ty Broza', 18365);
insert into WORKER (worker_id, workhoures, name, salary)
values (2170, 12, 'Jody Dzundza', 15212);
insert into WORKER (worker_id, workhoures, name, salary)
values (2180, 6, 'Benjamin Flanag', 14946);
insert into WORKER (worker_id, workhoures, name, salary)
values (2190, 11, 'Blair Bentley', 10407);
insert into WORKER (worker_id, workhoures, name, salary)
values (2200, 6, 'Elisabeth Ammon', 18813);
insert into WORKER (worker_id, workhoures, name, salary)
values (2210, 7, 'Cyndi Duncan', 18681);
insert into WORKER (worker_id, workhoures, name, salary)
values (2220, 10, 'Ron Ward', 17889);
insert into WORKER (worker_id, workhoures, name, salary)
values (2230, 8, 'Claire Ferrell', 12129);
insert into WORKER (worker_id, workhoures, name, salary)
values (2240, 5, 'Sigourney Galla', 13497);
insert into WORKER (worker_id, workhoures, name, salary)
values (2250, 10, 'Cathy Makowicz', 12980);
insert into WORKER (worker_id, workhoures, name, salary)
values (2260, 4, 'Lee Danger', 16578);
insert into WORKER (worker_id, workhoures, name, salary)
values (2270, 4, 'Stewart Rizzo', 10817);
insert into WORKER (worker_id, workhoures, name, salary)
values (2280, 8, 'Lupe Sellers', 5409);
insert into WORKER (worker_id, workhoures, name, salary)
values (2290, 5, 'Ronnie Numan', 16795);
insert into WORKER (worker_id, workhoures, name, salary)
values (2300, 8, 'Barry Bale', 4326);
insert into WORKER (worker_id, workhoures, name, salary)
values (2310, 5, 'Stevie Walsh', 14854);
insert into WORKER (worker_id, workhoures, name, salary)
values (2320, 10, 'Ceili Hiatt', 11436);
insert into WORKER (worker_id, workhoures, name, salary)
values (2330, 4, 'Oliver Osbourne', 17950);
insert into WORKER (worker_id, workhoures, name, salary)
values (2340, 9, 'Tommy Dunn', 15340);
insert into WORKER (worker_id, workhoures, name, salary)
values (2350, 4, 'Nigel Rifkin', 5260);
insert into WORKER (worker_id, workhoures, name, salary)
values (2360, 10, 'Jeanne Estevez', 4851);
insert into WORKER (worker_id, workhoures, name, salary)
values (2370, 6, 'Colleen Amos', 12413);
insert into WORKER (worker_id, workhoures, name, salary)
values (2380, 9, 'Jerry Gandolfin', 19715);
commit;
prompt 600 records loaded
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
values (1390, 675);
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
commit;
prompt 200 records committed...
insert into WORKINGIN (worker_id, catering_id)
values (2690, 30);
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
commit;
prompt 300 records committed...
insert into WORKINGIN (worker_id, catering_id)
values (3700, 118);
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
commit;
prompt 400 records committed...
insert into WORKINGIN (worker_id, catering_id)
values (4760, 463);
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
prompt 500 records loaded
prompt Enabling foreign key constraints for DISHS...
alter table DISHS enable constraint SYS_C007162;
prompt Enabling foreign key constraints for THE_ORDER...
alter table THE_ORDER enable constraint SYS_C007193;
prompt Enabling foreign key constraints for BELONG...
alter table BELONG enable constraint SYS_C007198;
alter table BELONG enable constraint SYS_C007199;
prompt Enabling foreign key constraints for CONTAIN...
alter table CONTAIN enable constraint SYS_C007184;
alter table CONTAIN enable constraint SYS_C007185;
prompt Enabling foreign key constraints for WORKINGIN...
alter table WORKINGIN enable constraint SYS_C007178;
alter table WORKINGIN enable constraint SYS_C007179;
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
