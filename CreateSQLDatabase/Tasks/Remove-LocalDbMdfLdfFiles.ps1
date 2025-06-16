Task Remove-LocalDbMdfLdfFiles{
    param (
      [string]$SqlServerInstance = "(localdb)\$DataBaseInstance"    
    )   
  
    if ($SqlServerInstance.Contains("localdb")) {
      $filePath = "$env:LOCALAPPDATA\Microsoft\Microsoft SQL Server Local DB\Instances\$DataBaseInstance\$($SchemaName)_Primary.mdf"
      # Check if the file exists
      if (Test-Path -Path $filePath) {
        # Remove the file
        Remove-Item -Path $filePath -Force
        Write-Output "File removed: $filePath"
      } else {
        Write-Output "File not found: $filePath"
      }
  
      $filePath = "$env:LOCALAPPDATA\Microsoft\Microsoft SQL Server Local DB\Instances\$DataBaseInstance\$($SchemaName)_Primary.ldf"
      # Check if the file exists
      if (Test-Path -Path $filePath) {
        # Remove the file
        Remove-Item -Path $filePath -Force
        Write-Output "File removed: $filePath"
      } else {
      Write-Output "File not found: $filePath"
      }

      $filePath = "$env:LOCALAPPDATA\Microsoft\Microsoft SQL Server Local DB\Instances\$DataBaseInstance\$($SchemaName)_Primary_log.ldf"
      # Check if the file exists
      if (Test-Path -Path $filePath) {
        # Remove the file
        Remove-Item -Path $filePath -Force
        Write-Output "File removed: $filePath"
      } else {
      Write-Output "File not found: $filePath"
      }
      
    } else {
      Write-Output "Not a LocalDB leaving mdf and ldf files"
    }

    

  
   
  }