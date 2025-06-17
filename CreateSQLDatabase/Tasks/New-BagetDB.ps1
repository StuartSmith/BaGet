Task New-BagetDb {
   param (
      [string]$SqlServerInstance = "(localdb)\$DataBaseInstance" ,
      [string]$databaseName = "$schemaName"  
    )  


    $mdf = "$env:LOCALAPPDATA\Microsoft\Microsoft SQL Server Local DB\Instances\$DataBaseInstance\$($SchemaName)_Primary.mdf"
    $ldf = "$env:LOCALAPPDATA\Microsoft\Microsoft SQL Server Local DB\Instances\$DataBaseInstance\$($SchemaName)_Primary.ldf"

# Define the SQL command

$sql = @"
CREATE DATABASE [$databaseName]
ON (NAME = N'$databaseName', FILENAME = N'$mdf'),
   (NAME = N'${databaseName}_log', FILENAME = N'$ldf')
"@



# Connect to the LocalDB instance
   $connectionString = "Server=$SqlServerInstance;Integrated Security=true;"
   $connection = New-Object System.Data.SqlClient.SqlConnection $connectionString
   $command = $connection.CreateCommand()
   $command.CommandText = $sql


   $connection.Open()
   Write-host " `nInvoking SQL: `n`n $SQL `n"
   $command.ExecuteNonQuery()
   $connection.Close()
   
}