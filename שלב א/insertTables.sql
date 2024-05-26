insert into SARITITI.CATERING (CATERING_ID, NAME, COSHER)
values (7613, 'Todd', 'Y');

insert into SARITITI.CATERING (CATERING_ID, NAME, COSHER)
values (7212, 'Balthazar', 'N');

insert into SARITITI.CATERING (CATERING_ID, NAME, COSHER)
values (9201, 'Scott', 'Y');

insert into SARITITI.CATERING (CATERING_ID, NAME, COSHER)
values (3704, 'Melanie', 'N');

insert into SARITITI.CATERING (CATERING_ID, NAME, COSHER)
values (4675, 'Ethan', 'N');

insert into SARITITI.CATERING (CATERING_ID, NAME, COSHER)
values (9484, 'Rose', 'Y');

insert into SARITITI.CATERING (CATERING_ID, NAME, COSHER)
values (6286, 'Night', 'Y');

insert into SARITITI.CATERING (CATERING_ID, NAME, COSHER)
values (2146, 'Rupert', 'N');

insert into SARITITI.CATERING (CATERING_ID, NAME, COSHER)
values (5820, 'Steven', 'N');

insert into SARITITI.CATERING (CATERING_ID, NAME, COSHER)
values (3075, 'Rod', 'Y');

insert into SARITITI.WORKER (WORKER_ID, WORKHOURES, NAME, SALARY)
values (2, 9, 'PattiMacy', 49215);

insert into SARITITI.WORKER (WORKER_ID, WORKHOURES, NAME, SALARY)
values (4, 12, 'ClayThomson', 67545);

insert into SARITITI.WORKER (WORKER_ID, WORKHOURES, NAME, SALARY)
values (6, 12, 'ArmandBlanchett', 84507);

insert into SARITITI.WORKER (WORKER_ID, WORKHOURES, NAME, SALARY)
values (8, 6, 'AntonioFinn', 18849);

insert into SARITITI.WORKER (WORKER_ID, WORKHOURES, NAME, SALARY)
values (10, 9, 'RobbyTravers', 65894);

insert into SARITITI.WORKER (WORKER_ID, WORKHOURES, NAME, SALARY)
values (12, 11, 'HaroldQuaid', 12663);

insert into SARITITI.WORKER (WORKER_ID, WORKHOURES, NAME, SALARY)
values (14, 10, 'OlgaStiller', 96226);

insert into SARITITI.WORKER (WORKER_ID, WORKHOURES, NAME, SALARY)
values (16, 12, 'ChristmasWalken', 37757);

insert into SARITITI.WORKER (WORKER_ID, WORKHOURES, NAME, SALARY)
values (18, 11, 'MorganTankard', 12830);

insert into SARITITI.WORKER (WORKER_ID, WORKHOURES, NAME, SALARY)
values (20, 5, 'JesseUggams', 46411);

insert into SARITITI.WORKINGIN (WORKER_ID, CATERING_ID)
values (1920, 316);

insert into SARITITI.WORKINGIN (WORKER_ID, CATERING_ID)
values (800, 277);

insert into SARITITI.WORKINGIN (WORKER_ID, CATERING_ID)
values (3810, 4);

insert into SARITITI.WORKINGIN (WORKER_ID, CATERING_ID)
values (920, 441);

insert into SARITITI.WORKINGIN (WORKER_ID, CATERING_ID)
values (1760, 755);

insert into SARITITI.WORKINGIN (WORKER_ID, CATERING_ID)
values (4780, 16);

insert into SARITITI.WORKINGIN (WORKER_ID, CATERING_ID)
values (3540, 799);

insert into SARITITI.WORKINGIN (WORKER_ID, CATERING_ID)
values (5490, 580);

insert into SARITITI.WORKINGIN (WORKER_ID, CATERING_ID)
values (890, 611);

insert into SARITITI.WORKINGIN (WORKER_ID, CATERING_ID)
values (1550, 781);

insert into SARITITI.DISHS (DISHS_ID, PRICE, NAME, COSHERTYPE, CATERING_ID)
values (1, 153, 'Pizza', 'Meat', 784);

insert into SARITITI.DISHS (DISHS_ID, PRICE, NAME, COSHERTYPE, CATERING_ID)
values (2, 79, 'Paella', 'None', 451);

insert into SARITITI.DISHS (DISHS_ID, PRICE, NAME, COSHERTYPE, CATERING_ID)
values (3, 157, 'Gyros', 'Meat', 528);

insert into SARITITI.DISHS (DISHS_ID, PRICE, NAME, COSHERTYPE, CATERING_ID)
values (4, 130, 'Ramen', 'None', 795);

insert into SARITITI.DISHS (DISHS_ID, PRICE, NAME, COSHERTYPE, CATERING_ID)
values (5, 155, 'Falafel', 'Meat', 522);

insert into SARITITI.DISHS (DISHS_ID, PRICE, NAME, COSHERTYPE, CATERING_ID)
values (6, 239, 'Bibimbap', 'Diry', 571);

insert into SARITITI.DISHS (DISHS_ID, PRICE, NAME, COSHERTYPE, CATERING_ID)
values (7, 210, 'Goulash', 'Diry', 651);

insert into SARITITI.DISHS (DISHS_ID, PRICE, NAME, COSHERTYPE, CATERING_ID)
values (8, 242, 'Tacos', 'Diry', 540);

insert into SARITITI.DISHS (DISHS_ID, PRICE, NAME, COSHERTYPE, CATERING_ID)
values (9, 185, 'Sushi', 'None', 116);

insert into SARITITI.DISHS (DISHS_ID, PRICE, NAME, COSHERTYPE, CATERING_ID)
values (10, 237, 'Samosa', 'Meat', 797);

insert into SARITITI.THE_ORDER (ORDER_ID, TOTALPRICE, ORDER_DATE, ADDRESS, PHONENUMBER, CUSTOMER_ID)
values (100, 592968, to_date('16-07-2026', 'dd-mm-yyyy'), '62 Jena Drive', '562-4854227', 26529);

insert into SARITITI.THE_ORDER (ORDER_ID, TOTALPRICE, ORDER_DATE, ADDRESS, PHONENUMBER, CUSTOMER_ID)
values (200, 811485, to_date('04-08-2024', 'dd-mm-yyyy'), '94 Carter Road', '144-3248383', 15217);

insert into SARITITI.THE_ORDER (ORDER_ID, TOTALPRICE, ORDER_DATE, ADDRESS, PHONENUMBER, CUSTOMER_ID)
values (300, 402420, to_date('21-03-2025', 'dd-mm-yyyy'), '11 Koteas Drive', '782-4219467', 3398);

insert into SARITITI.THE_ORDER (ORDER_ID, TOTALPRICE, ORDER_DATE, ADDRESS, PHONENUMBER, CUSTOMER_ID)
values (400, 764334, to_date('06-06-2024', 'dd-mm-yyyy'), '73rd Street', '858-3740339', 68251);

insert into SARITITI.THE_ORDER (ORDER_ID, TOTALPRICE, ORDER_DATE, ADDRESS, PHONENUMBER, CUSTOMER_ID)
values (500, 743525, to_date('08-01-2027', 'dd-mm-yyyy'), '49 Keeslar Drive', '861-3809018', 87283);

insert into SARITITI.THE_ORDER (ORDER_ID, TOTALPRICE, ORDER_DATE, ADDRESS, PHONENUMBER, CUSTOMER_ID)
values (600, 426504, to_date('22-02-2027', 'dd-mm-yyyy'), '51 Carole', '849-6058672', 55703);

insert into SARITITI.THE_ORDER (ORDER_ID, TOTALPRICE, ORDER_DATE, ADDRESS, PHONENUMBER, CUSTOMER_ID)
values (700, 940629, to_date('21-06-2024', 'dd-mm-yyyy'), '17 Brittany', '743-4051355', 16596);

insert into SARITITI.THE_ORDER (ORDER_ID, TOTALPRICE, ORDER_DATE, ADDRESS, PHONENUMBER, CUSTOMER_ID)
values (800, 862204, to_date('01-02-2027', 'dd-mm-yyyy'), '89 Pasadena Street', '438-1289929', 52106);

insert into SARITITI.THE_ORDER (ORDER_ID, TOTALPRICE, ORDER_DATE, ADDRESS, PHONENUMBER, CUSTOMER_ID)
values (900, 530915, to_date('06-02-2027', 'dd-mm-yyyy'), '5 Heslov Blvd', '604-4696507', 63004);

insert into SARITITI.THE_ORDER (ORDER_ID, TOTALPRICE, ORDER_DATE, ADDRESS, PHONENUMBER, CUSTOMER_ID)
values (1000, 453707, to_date('28-10-2026', 'dd-mm-yyyy'), '16 Laurie Blvd', '576-6430819', 87046);

insert into SARITITI.BELONG (AMOUNT, DISHS_ID, ORDER_ID)
values (53038, 596, 51130);

insert into SARITITI.BELONG (AMOUNT, DISHS_ID, ORDER_ID)
values (32991, 588, 99877);

insert into SARITITI.BELONG (AMOUNT, DISHS_ID, ORDER_ID)
values (23752, 580, 65669);

insert into SARITITI.BELONG (AMOUNT, DISHS_ID, ORDER_ID)
values (64399, 1094, 54338);

insert into SARITITI.BELONG (AMOUNT, DISHS_ID, ORDER_ID)
values (14102, 718, 48026);

insert into SARITITI.BELONG (AMOUNT, DISHS_ID, ORDER_ID)
values (34116, 632, 6839);

insert into SARITITI.BELONG (AMOUNT, DISHS_ID, ORDER_ID)
values (36056, 1246, 30593);

insert into SARITITI.BELONG (AMOUNT, DISHS_ID, ORDER_ID)
values (66436, 1170, 19106);

insert into SARITITI.BELONG (AMOUNT, DISHS_ID, ORDER_ID)
values (29856, 234, 36202);

insert into SARITITI.BELONG (AMOUNT, DISHS_ID, ORDER_ID)
values (38378, 1276, 32932);

insert into SARITITI.CUSTOMER (CUSTOMER_ID, NAME, EMAIL, ADDRESS, PHONENUMBER, PAYMENTDETAILS)
values (77929, 'RickyHong', 'ricky.hong@seafoxboa', '91 Jann Road', '837-6787514', 'Cash');

insert into SARITITI.CUSTOMER (CUSTOMER_ID, NAME, EMAIL, ADDRESS, PHONENUMBER, PAYMENTDETAILS)
values (61468, 'SamWopat', 'sam@grayhawksystems.', '377 Gore Street', '945-2164169', 'Cash');

insert into SARITITI.CUSTOMER (CUSTOMER_ID, NAME, EMAIL, ADDRESS, PHONENUMBER, PAYMENTDETAILS)
values (34675, 'DaryleBranagh', 'daryle@gsat.com', '44 Grant Ave', '474-5527421', 'Cash');

insert into SARITITI.CUSTOMER (CUSTOMER_ID, NAME, EMAIL, ADDRESS, PHONENUMBER, PAYMENTDETAILS)
values (80218, 'ToddBoone', 'todd.boone@ciwservic', '926 Juan Street', '593-2867530', 'Bit');

insert into SARITITI.CUSTOMER (CUSTOMER_ID, NAME, EMAIL, ADDRESS, PHONENUMBER, PAYMENTDETAILS)
values (76703, 'BoNess', 'bon@sprint.de', '13 New boston Road', '225-2830042', 'CreditCard');

insert into SARITITI.CUSTOMER (CUSTOMER_ID, NAME, EMAIL, ADDRESS, PHONENUMBER, PAYMENTDETAILS)
values (76870, 'JaredMathis', 'jared@voicelog.ca', '25 Shearer Road', '101-3396115', 'Cash');

insert into SARITITI.CUSTOMER (CUSTOMER_ID, NAME, EMAIL, ADDRESS, PHONENUMBER, PAYMENTDETAILS)
values (91166, 'ChrissieAndrews', 'chrissie@capitalbank', '99 Hagerty Road', '801-8702956', 'Bit');

insert into SARITITI.CUSTOMER (CUSTOMER_ID, NAME, EMAIL, ADDRESS, PHONENUMBER, PAYMENTDETAILS)
values (88477, 'BryanChristie', 'bryan.christie@anwor', '42nd Street', '415-2201023', 'Cash');

insert into SARITITI.CUSTOMER (CUSTOMER_ID, NAME, EMAIL, ADDRESS, PHONENUMBER, PAYMENTDETAILS)
values (27544, 'MiguelRemar', 'miguel.remar@deutsch', '96 McDonnell Street', '330-5220500', 'CreditCard');

insert into SARITITI.CUSTOMER (CUSTOMER_ID, NAME, EMAIL, ADDRESS, PHONENUMBER, PAYMENTDETAILS)
values (32718, 'OroOsment', 'oro@scooterstore.com', '888 Sellers Street', '135-3608016', 'Bit');

insert into SARITITI.MATERIAL (MATERIAL_ID, NAME, TYPE, EXPIRYDATE)
values (9843, 'Garlic', 'canning', to_date('27-09-2025', 'dd-mm-yyyy'));

insert into SARITITI.MATERIAL (MATERIAL_ID, NAME, TYPE, EXPIRYDATE)
values (54606, 'Tomatoes', 'Dairy', to_date('20-01-2026', 'dd-mm-yyyy'));

insert into SARITITI.MATERIAL (MATERIAL_ID, NAME, TYPE, EXPIRYDATE)
values (60472, 'Tomatoes', 'canning', to_date('01-09-2024', 'dd-mm-yyyy'));

insert into SARITITI.MATERIAL (MATERIAL_ID, NAME, TYPE, EXPIRYDATE)
values (38117, 'Spinach', 'Meat', to_date('27-11-2024', 'dd-mm-yyyy'));

insert into SARITITI.MATERIAL (MATERIAL_ID, NAME, TYPE, EXPIRYDATE)
values (82292, 'Cheese', 'Plant', to_date('07-07-2026', 'dd-mm-yyyy'));

insert into SARITITI.MATERIAL (MATERIAL_ID, NAME, TYPE, EXPIRYDATE)
values (52572, 'Broccoli', 'canning', to_date('26-12-2024', 'dd-mm-yyyy'));

insert into SARITITI.MATERIAL (MATERIAL_ID, NAME, TYPE, EXPIRYDATE)
values (12779, 'Potatoes', 'canning', to_date('28-10-2025', 'dd-mm-yyyy'));

insert into SARITITI.MATERIAL (MATERIAL_ID, NAME, TYPE, EXPIRYDATE)
values (45110, 'Broccoli', 'canning', to_date('07-04-2026', 'dd-mm-yyyy'));

insert into SARITITI.MATERIAL (MATERIAL_ID, NAME, TYPE, EXPIRYDATE)
values (56164, 'Potatoes', 'Meat', to_date('16-11-2025', 'dd-mm-yyyy'));

insert into SARITITI.MATERIAL (MATERIAL_ID, NAME, TYPE, EXPIRYDATE)
values (17048, 'Carrots', 'canning', to_date('07-12-2025', 'dd-mm-yyyy'));

insert into SARITITI.CONTAIN (QUANTITY, DISHS_ID, MATERIAL_ID)
values (19999, 90, 6478);

insert into SARITITI.CONTAIN (QUANTITY, DISHS_ID, MATERIAL_ID)
values (25866, 122, 3486);

insert into SARITITI.CONTAIN (QUANTITY, DISHS_ID, MATERIAL_ID)
values (12894, 102, 7076);

insert into SARITITI.CONTAIN (QUANTITY, DISHS_ID, MATERIAL_ID)
values (34889, 42, 6932);

insert into SARITITI.CONTAIN (QUANTITY, DISHS_ID, MATERIAL_ID)
values (50001, 594, 9497);

insert into SARITITI.CONTAIN (QUANTITY, DISHS_ID, MATERIAL_ID)
values (73834, 118, 7238);

insert into SARITITI.CONTAIN (QUANTITY, DISHS_ID, MATERIAL_ID)
values (40784, 472, 7128);

insert into SARITITI.CONTAIN (QUANTITY, DISHS_ID, MATERIAL_ID)
values (55423, 742, 6684);

insert into SARITITI.CONTAIN (QUANTITY, DISHS_ID, MATERIAL_ID)
values (10190, 746, 3861);

insert into SARITITI.CONTAIN (QUANTITY, DISHS_ID, MATERIAL_ID)
values (70203, 1038, 3034);
