## So far 
#$usage = "-action (setCredentials,getCredentials)"
#param(
#    [string] $action = $(throw "$usage")
#)
$action = "getCredentials"

$NDMConfigPath = "C:\Projects\testlab\EDIG_TPManager\NDMServ-mod.ini"
$NDMConfigData = Get-Content -Path $NDMConfigPath
#$NewNDMConfigPath = "C:\Projects\testlab\EDIG_TPManager\NDMServ-New.ini"

$CredentialsFile = "C:\Projects\testlab\EDIG_TPManager\ndmcreds.csv"
$CredentialsList = @()
Function getNDMRacfUser {
    param($line)
    ## 0802MainframeNodeID = (EDISVNDM,HJ5@POZ7)
    if($line -like "*MainframeNodeID*") {
        $result = $line.Split("=")
        $racfPair = $result[1].trim()
        $racfPair = $racfPair.TrimStart("(")
        $racfPair = $racfPair.TrimEnd(")")
        $result  = $racfPair.Split(",")
        $result[0].Trim()
    }
}

Function getNDMRacfPassword {
    param($line)
    ## 0802MainframeNodeID = (EDISVNDM,HJ5@POZ7)
    
    if($line -like "*MainframeNodeID*") {
        $result = $line.Split("=")
        $racfPair = $result[1].trim()
        $racfPair = $racfPair.TrimStart("(")
        $racfPair = $racfPair.TrimEnd(")")
        $result  = $racfPair.Split(",")
        $result[1].Trim()
    }
}

Function setNDMRacfPassword {
    param($line)
    ## 0802MainframeNodeID = (EDISVNDM,HJ5@POZ7)
    if($line -like "*MainframeNodeID*") {
        $result = $line.Split("=")
        $racfPair = $result[1].trim()
        $racfPair = $racfPair.TrimStart("(")
        $racfPair = $racfPair.TrimEnd(")")
        $result  = $racfPair.Split(",")
        $newPassword = getNewNDMRacfPassword 
        $line -replace($result[1],$newPassword)
    }
}

Function getNewNDMRacfPassword {
    param([string] $username)
}

## Function password generator
## legnth 8
## special characters # $ @
## A-z
Function passGen {
    $Password = ([char[]]([char]65..[char]90) + ([char[]]([char]97..[char]122)) + 0..7 | Sort-Object {Get-Random})[0..7] -join ''
    $Password


    
}


foreach ($line in $NDMConfigData) {
    $racfID = ""
    $racfPass = ""
    ## 0802MainframeNodeID = (EDISVNDM,HJ5@POZ7)
    if($line -like "*MainframeNodeID*") {
        Write-Output $line
        $racfID = getNDMRacfUser -line $line
        $racfPass = getNDMRacfPassword -line $line
        #passGen
        if($action -eq "getCredentials") {
            ## Write creds to list
            $credential = $racfID + "," + $racfPass
            $CredentialsList += $credential
            ##Add-Content -Path $CredentialsFile -Value $credential
        } elseif ($action -eq "setCredentials") {
            ## compare creds to list and write out new config
            ## if()
        }
    }
    
}

if( $CredentialsList.Length -gt 0 ) {
    $CredentialsList | Select-Object -Unique | Out-File -FilePath $CredentialsFile -Append 
}