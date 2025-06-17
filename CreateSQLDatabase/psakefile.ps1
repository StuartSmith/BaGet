# Set preferences
$VerbosePreference = "Continue"
$ErrorActionPreference = 'Stop'

# Get the current directory
$current_dir = Get-Location

# Set build parameters
$buildmode = "Debug"

$schemaName = "Baget"


$Msbuild= ""       #Path to MSBUILD Executable
$SqlPackage=""     #Path to SQL Package Executable
$publishXML=""     #Path to the XML Publish file to use with SQLPackage.

#Database Parameters
$DataBaseInstance = "BagetInstance"

#$icon = "$current_dir\..\res\AppIcon.ico"
$title = "Baget"
$target = "Build"
$PSProjectDirectory = Resolve-Path .

# Define the array of solution files
[string[]] $Solutions = @()
$Solutions += "..\BaGet.sln"

# Define the array of solution files
[string[]] $TestFiles = @()



. ./Tasks/Get-LocationofVisualStudio.ps1
. ./Tasks/New-LocalDbInstance.ps1
. ./Tasks/Remove-PreviousDb.ps1
. ./Tasks/Remove-LocalDbMdfLdfFiles.ps1
. ./Tasks/New-BagetDb.ps1
. ./Tasks/Add-NetworkServiceToBagetDb.ps1
. ./Tasks/Remove-LocalDbInstance.ps1

                                            

Task CreateDatabase -depends  Remove-LocalDbInstance, `
                              Remove-LocalDbMdfLdfFiles,  
                              New-LocalDbInstance,  
                              #Remove-PreviousDb, `
                              New-BagetDb,
                              Add-NetworkServiceToBagetDb

function SuppressUnusedVariableWarnings{
  SuppressUnusedVariableWarning;

  # Function to suppress warnings for unused variables by assigning them as needed
    # Assign the current directory to a global variable
    $FakeFunc:current_dir = Get-Location

  # Set build parameters
    $FakeFunc:buildmode = "Debug"
    $FakeFunc:ProductVersion  = "3.4.5.6"
    $FakeFunc:FileVersion  = "7.9.20.22"



    $FakeFunc:Msbuild= ""       #Path to MSBUILD Executable
    $FakeFunc:SqlPackage=""     #Path to SQL Package Executable
    $FakeFunc:publishXML=""     #Path to the XML Publish file to use with SQLPackage.

  #Database Parameters


  #$icon = "$current_dir\..\res\AppIcon.ico"
  $FakeFunc:title = "Baget"
  $FakeFunc:target = "Build"
  $FakeFunc:PSProjectDirectory = Resolve-Path .

  $FakeFunc:TestFiles = @()

}





















