

    if ($LASTEXITCODE -eq 1)   {
        Write-Error "PSAKE build Failed" -ForegroundColor Red
        exit 1
    }
    
    Write-Host " "
      if ($LASTEXITCODE -eq 0) {
            Write-Host "Build was Successful. " -ForegroundColor Green
       }
    Write-Host " "
    
    # Puase the script if running in interactive mode...
    if ($env:INTERACTIVE -eq "TRUE"){
        
         Write-Host "Press Any Key to Continue (Interactive Environment Variable $env:INTERACTIVE) " -ForegroundColor Green
        
         Write-Host " "
        [void][System.Console]::ReadKey($FALSE)
    } else {
        Write-Host "Interactive Environment Variable is $env:INTERACTIVE "
    }
    
