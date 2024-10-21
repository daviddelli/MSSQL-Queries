    
--//How to add a TDE encrypted user database to an Always On Availability Group//--



REPLICA PRIMARIA:


USE master 
GO
ALTER AVAILABILITY GROUP [ag-clc-prodbt] ADD DATABASE gsa




REPLICA SECONDARIA:


Ripristinare db da backup with norecovery (applicare diff + tlog)


USE master
GO 
ALTER DATABASE gsa SET HADR AVAILABILITY GROUP = [ag-clc-prodbt]    







