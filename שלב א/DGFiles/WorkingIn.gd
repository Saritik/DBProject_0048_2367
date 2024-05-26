
[General]
Version=1

[Preferences]
Username=
Password=2850
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SARITITI
Name=WORKINGIN
Count=10..20

[Record]
Name=WORKER_ID
Type=NUMBER
Size=5
Data=List(select WORKER_ID from WORKER)
Master=

[Record]
Name=CATERING_ID
Type=NUMBER
Size=5
Data=List(select CATERONG_ID from CATERING)
Master=

