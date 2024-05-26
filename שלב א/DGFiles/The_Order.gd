
[General]
Version=1

[Preferences]
Username=
Password=2373
Database=
DateFormat=dd-mm-yyyy
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SARITITI
Name=THE_ORDER
Count=10..20

[Record]
Name=ORDER_ID
Type=NUMBER
Size=5
Data=Random(1000, 99999)
Master=

[Record]
Name=TOTALPRICE
Type=NUMBER
Size=7
Data=Random(100, 9999999)
Master=

[Record]
Name=ORDER_DATE
Type=DATE
Size=
Data=Random(26/05/2020, 26/05/2024)
Master=

[Record]
Name=ADDRESS
Type=VARCHAR2
Size=20
Data=Address1
Master=

[Record]
Name=PHONENUMBER
Type=VARCHAR2
Size=11
Data=Random(100, 999) + '-' + Random(1000000, 9999999)
Master=

[Record]
Name=CUSTOMER_ID
Type=NUMBER
Size=5
Data=List(select CUSTOMER_ID from CUSTOMER)
Master=

