Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope CurrentUser

# get windows version
$winVer = [System.Environment]::OSVersion.Version

# rename the machine
# callable: Rename-Machine("PC-BOB")
function Rename-Machine {
  param(
    [string[]] $ComputerName
  )
  
  Write-Host "Renaming the machine to " $Computername
  Rename-Computer -NewName $ComputerName -Restart
}

# join a domain
# callable: Join-Domain("conto.so". "OU=testOU,DC=domain,DC=Domain,DC=com")
function Join-Domain {
  param(
    [string[]] $Domain
    [string[]] $OUPath
  )
  
  Write-Host "Joining domain " $Domain
  Add-Computer -DomainName $Domain -OUPath $OUPath
}

# add user or group to a localgroup
# callable: Add-LocalGroup("Administrators", "conto.so\timo.sarkar")
function Add-LocalGroup {
  param(
    [string[]] $LocalGroup
    [string[]] $DomainObject
  )
  
  Write-Host "Adding ${DomainObject} to ${LocalGroup}..."
  Add-LocalGroupMember -Group $LocalGroup -Member $DomainObject
}

####################################################################
########################## Distribution ############################
####################################################################
# installs software and configurs them from a configuration file
# callable: Install("C:\test\installation.json")
function Install {
  param(
    [string[]] $InstallationFile
  )
  
  Write-Host "${InstallationFile} is set as installation source..."
  # parse JSONfile with installation metadata from here on
  $Applications = Get-Content -Path $InstallationFile | ConvertFrom-Json 
  
  # output the applications it found
  Write-Host "Found the following applications to install: "
  $Applications | Format-Table
  
  Read-Host -Prompt "Press any key to continue..."

  # Testing JSON Objects
  <#foreach ($application in $Applications) {
   # write-host "$($application.ApplicationName) has the binaryLocation: $($application.BinaryLocation) and the flags: $($application.InstallFlags)"
  }#>
  
  # clear the screen
  [System.Console]::Clear()
  
  # INstall and configure Applications and Scripts isolatedly
  foreach ($application in $Applications) {
    if ($application.Type -eq "Application") {
      Write-Host "Installing application: ${application.ApplicationName}"
      
      # download the binary and store it in %TEMP%
      Invoke-WebRequest -URI $application.BinaryLocation -OutFile %TEMP%\$application.ApplicationName -UseBasicParsing
      
      # if application does not have installationflags
      if ($application.InstallationFlags -eq "") {
        Start-Process -Path %TEMP%\$application.ApplicationName
      }
      
      # start installer with InstallationFlags
      Start-Process -Path %TEMP%\$application.ApplicationName -ArgumentList $application.InstallationFlags

      # after it is done, remove %TEMP%\$application.ApplicationName
      Remove-Item -path %TEMP%\$application.ApplicationName -Force
    }
    
    if ($application.Type -eq"Script") {
    
    }
  }
}


