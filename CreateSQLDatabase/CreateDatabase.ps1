#Prerequisits.
    #Visual Studio
        #Visual studio build tools or visual studio has been installed With the database build tools option being installed as well.
    #SQL Server Express Local DB 
        #SQL Server Express Local DB can be installed with the following command line
            #choco install sqllocaldb 
        



. .\setup.ps1
. .\Version.ps1


Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted 

$BuildMode      = "Debug";
$BuildMode      = "Release";


try {
   
    Invoke-Psake .\psakefile.ps1 CreateDatabase -properties @{"BuildMode"=$BuildMode ; "ProductVersion"= $ProductVersion;"FileVersion"= $FileVersion; } 

}
catch {    
    Write-Error $_
    exit 1
}

. .\Invoke-FinishPsake.ps1

