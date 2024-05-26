
[General]
Version=1

[Preferences]
Username=
Password=2659
Database=
DateFormat=dd-mm-yyyy
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SARITITI
Name=CONTAIN
Count=10..20

[Record]
Name=QUANTITY
Type=NUMBER
Size=6
Data=Random(1, 100000)
Master=

[Record]
Name=DISHS_ID
Type=NUMBER
Size=5
Data=List(select DISHS_ID from DISHS)
Master=

[Record]
Name=MATERIAL_ID
Type=NUMBER
Size=5
Data=List(select MATERIAL_ID from MATERIAL)
Master=

