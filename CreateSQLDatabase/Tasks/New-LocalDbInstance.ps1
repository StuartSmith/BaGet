Task New-LocalDbInstance {

    # Get the list of all LocalDB instances
    $instances = & sqllocaldb i

    # Check if the specified instance exists in the list
    if ($instances -contains $DataBaseInstance) {
        Write-Output "LocalDB instance '$DataBaseInstance' exists."
        Write-Output "Stopping instance '$DataBaseInstance' "
        $Output =  & sqllocaldb stop  $DataBaseInstance
        if ($Output -contains  "fail") {    
          Throw  "$target Could not Remove database instance $DataBaseInstance " 
          Throw  "$target Could not Remove database instance $DataBaseInstance " 
          exit 1
        }

        Write-Output "Deleting instance '$DataBaseInstance' "
        $Output =  & sqllocaldb delete  $DataBaseInstance
        if ($Output -contains  "fail") {    
          Throw  "$target Could not Remove database instance $DataBaseInstance " 
          exit 1
        }
    } else {
        Write-Output "LocalDB instance '$DataBaseInstance' does not exist."
    }

    #Remove any previous Database instances if they Exist
    $Output = & sqllocaldb create $DataBaseInstance 
    Write-Output $Output
    if ($Output -contains  "fail") {
      Write-Verbose "Encountered problem while creating $DataBaseInstance."
      Throw "$target finished with errors." 
      exit 1
    }

    #Create a new  Database instance
    $Output = & sqllocaldb start $DataBaseInstance 
    Write-Output $Output
    if ($Output -contains  "fail") {
      Write-Verbose "Encountered problem while starting $DataBaseInstance."
      Throw "$target finished with errors." 
      exit 1
    }   
}