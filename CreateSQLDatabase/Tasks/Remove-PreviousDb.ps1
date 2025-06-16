Task Remove-PreviousDb {  
    param (
      [string]$SqlServerInstance = "(localdb)\$DataBaseInstance"
    )
  
  # Create the XML content with the updated connection string
  $sqlCommand = @"
  IF EXISTS (SELECT name FROM sys.databases WHERE name = N'$schemaName')
  BEGIN
    DROP DATABASE [$schemaName]
  END
"@     
  # Command to execute the SQL command using sqlcmd       
  $sqlCmdCommand = "sqlcmd -S `"$SqlServerInstance`" -Q `"$sqlCommand`""
  
  
  try {
      # Execute the sqlcmd command
      Write-Output "Executing: $sqlCmdCommand"
      Invoke-Expression $sqlCmdCommand
      Write-Output "Database '$schemaName' removed successfully from instance '$LocalDbInstance' if it existed."
      
    } catch {
      Write-Error "An error occurred while removing the database: $schemaName $_"
      throw "$target, An error occurred while removing the database: $schemaName $_"
      exit 1
    }
  
    if ($LASTEXITCODE -eq 1) {
      Write-Verbose "Encountered an error Removing Master Database: $schemaName"
      Throw "$target Encountered an error Removing Master Database: $schemaName" 
      exit 1
    }
  }