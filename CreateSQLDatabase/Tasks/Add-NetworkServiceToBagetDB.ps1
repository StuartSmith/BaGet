Task Add-NetworkServiceToBagetDb {
   param (
      [string]$SqlServerInstance = "(localdb)\$DataBaseInstance" ,
      [string]$databaseName = "$schemaName"  
    )  

$loginName = "NT AUTHORITY\NETWORK SERVICE"

# Define the SQL command
$sql = @"
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'$loginName')
    CREATE LOGIN [$loginName] FROM WINDOWS;

USE [$databaseName];
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'NETWORK SERVICE')
BEGIN
    CREATE USER [$loginName] FOR LOGIN [$loginName];
    EXEC sp_addrolemember N'db_owner', N'[$loginName]';
END
"@


# Connect to the LocalDB instance
   $connectionString = "Server=$SqlServerInstance;Integrated Security=true;"
   $connection = New-Object System.Data.SqlClient.SqlConnection $connectionString
   $command = $connection.CreateCommand()
   


   $connection.Open()

   $sql = @"
SET NOEXEC OFF
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NOCOUNT ON
SET XACT_ABORT ON
"@

   $command.CommandText = $sql
   $command.ExecuteNonQuery()
#--======================
#--Create Login
#--=======================


     $sql = @"
    USE master;
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = N'NT AUTHORITY\NETWORK SERVICE')
	BEGIN
	CREATE LOGIN [NT AUTHORITY\NETWORK SERVICE]
		FROM WINDOWS WITH DEFAULT_LANGUAGE = [us_english];
		PRINT 'Created Login NT AUTHORITY\NETWORK SERVICE';
	end
else
	Begin
		 PRINT 'Login NT AUTHORITY\NETWORK SERVICE already exists';
	end
"@

   $command.CommandText = $sql
   $command.ExecuteNonQuery()

#--===========================
#--Create User
#--============================

    $sql = @"
USE [$databaseName];
IF not EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'NT AUTHORITY\NETWORK SERVICE')
	BEGIN
		CREATE USER [NT AUTHORITY\NETWORK SERVICE] FOR LOGIN [NT AUTHORITY\NETWORK SERVICE]
		WITH DEFAULT_SCHEMA = [dbo];
		PRINT 'Created User NT AUTHORITY\NETWORK SERVICE';
	END
ELSE
	BEGIN
		PRINT 'USER NT AUTHORITY\NETWORK SERVICE already exists '
	end
"@

   $command.CommandText = $sql
   $command.ExecuteNonQuery()



#--=========================
#--Create Schema
#--=========================

   $sql = @"
   IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'NT AUTHORITY\NETWORK SERVICE')	
	Begin
		exec('CREATE SCHEMA [NT AUTHORITY\NETWORK SERVICE] AUTHORIZATION [NT AUTHORITY\NETWORK SERVICE]')
		PRINT 'Created SCHEMA NT AUTHORITY\NETWORK SERVICE';
	end
else
	Begin
		PRINT 'SCHEMA NT AUTHORITY\NETWORK SERVICE already exists';
	end

"@

   $command.CommandText = $sql
   $command.ExecuteNonQuery()

 $sql = @"
USE [$databaseName];
ALTER ROLE db_owner ADD MEMBER [NT AUTHORITY\NETWORK SERVICE];
"@

   $command.CommandText = $sql
   $command.ExecuteNonQuery()


   $sql = @"
USE [$databaseName];
ALTER ROLE db_datareader ADD MEMBER [NT AUTHORITY\NETWORK SERVICE];
"@

   $command.CommandText = $sql
   $command.ExecuteNonQuery()



   $connection.Close()
   
}