
[General]
Version=1

[Preferences]
Username=
Password=2076
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SARITITI
Name=BELONG
Count=400

[Record]
Name=AMOUNT
Type=NUMBER
Size=6
Data=Random(100, 100000)
Master=

[Record]
Name=DISHS_ID
Type=NUMBER
Size=5
Data=List(select DISHS_ID from DISHS)
Master=

[Record]
Name=ORDER_ID
Type=NUMBER
Size=5
Data=List(select ORDER_ID from THE_ORDER)
Master=

