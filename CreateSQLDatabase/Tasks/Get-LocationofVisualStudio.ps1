Task Get-LocationofVisualStudio {
	# Import the VSSetup module
	Install-Module VSSetup
	Import-Module VSSetup

	# Get all Visual Studio instances
	$vsInstances = Get-VSSetupInstance

	# Find the latest version
	$latestVSInstance = $vsInstances | Sort-Object -Property Version -Descending | Select-Object -First 1

	# Output the latest version and its path
	if ($latestVSInstance) {
		$latestVSVersion = $latestVSInstance.Version
		$latestVSPath = $latestVSInstance.InstallationPath
		$global:Msbuild =  $latestVSPath + "\MSBuild\Current\Bin\msbuild.exe"
        $global:SqlPackageExe =  $latestVSPath + "\Common7\IDE\Extensions\Microsoft\SQLDB\DAC\SqlPackage.exe"

		Write-Output "Latest Visual Studio Version: $latestVSVersion"
		Write-Output "Path: $latestVSPath"
		Write-Output "MSBUILD: $global:Msbuild"
        Write-Output "SqlPackage: $global:SqlPackageExe"
	} else {
		Write-Output "No Visual Studio instances found."
		Throw  "$target Could not find Visual Studio installed. This is required for creating the Dac pack" 
        exit 1
	}
	
}