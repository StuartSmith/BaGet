if ((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {    
    Write-Host "PowerShell is running as administrator."

    & choco feature enable -n allowGlobalConfirmation
    & choco install nuget.commandline
} else {
    Write-Host "PowerShell is NOT running as administrator."
}


& nuget install psake


Import-Module (Resolve-Path ".\psake*\tools\psake\psake.psm1")