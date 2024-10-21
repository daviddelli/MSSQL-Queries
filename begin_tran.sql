USE [db]
GO

DECLARE @commit BIT
SET @commit=0
PRINT 'Server '+QUOTENAME(CONVERT(NVARCHAR(MAX),SERVERPROPERTY('ServerName')))+',database '+QUOTENAME(CONVERT(NVARCHAR(MAX),DB_NAME()))+';';
SET XACT_ABORT ON
BEGIN TRAN

--------- Inserire qui la query ----------------------------------
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
------------------------------------------------------------------

IF(@commit=1)
	BEGIN
		 Print 'The transaction was commited'
		 commit
	END
ELSE
	BEGIN
		Print 'The transaction was rolled back'
		rollback
	END
GO
