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
# callable: InstallFrom("C:\test\software.cfg")
function InstallFrom {
  param(
    [string[]] $InstallationFile
  )
  
  Write-Host "${InstallationFile} is set as installation source..."
}

