# DSC by Mark Pazinci
# Breakdown by Marlon Singleton

## Variable local Log directory
[string] $LocalLogDirectory = "C:\Log" # (Breakdown) [DataType] and variable assignment
## Script Log File Name
[string] $ScriptLogName = $ServiceToInstall+"_Script_Log_"+(Get-Date).ToString('yyyyMMddHHmmss') # (Breakdown) '+' used to append strings, then converts and formats current date
## Local Log Path and File Name
[string] $LocalLogFileName = "$LocalLogDirectory\$ScriptLogName.log" # (Breakdown) Combines string variables into a path

try # (Breakdown) Start of common code pattern to deal with possible errors. Essentially "try" to run this block of code.
{
    If((Test-Path $LocalLogDirectory) -eq $false) {New-Item -Path $LocalLogDirectory -ItemType Directory} # (Breakdown) If C:\Log does not exist, create it
    If((Get-Acl $LocalLogDirectory).GetAccessRules($true,$false,[System.Security.Principal.NTAccount]) | Where-Object { $_.FileSystemRights -eq "Write" -and $_.AccessControlType -eq "Deny" }) {throw "Write Access to path ($LocalLogDirectory) Denied."}
    # (Breakdown) The above line get the Access Control List and state access denied for ACL members without write access.
    If((Test-Path $LocalLogFileName) -eq $false) {New-Item -Path $LocalLogFileName -ItemType File | Out-Null} # (Breakdown) If C:\Log\$ScriptLogName does not exist, create it
                    
    Start-Transcript -Path $LocalLogFileName -Append -IncludeInvocationHeader # (Breakdown) Start a record of this session
    Write-Verbose ("Starting Script: " + (Get-Date).ToString("yyyyMMddHHmmss")) -Verbose # (Breakdown) Adds text to verbose output stream
    
    Write-Verbose "Logging Parameters"
    Write-Verbose "Local Log Directory ($LocalLogDirectory)"

    ## Run a bit of code here
}
catch [System.SystemException] # (Breakdown) If specifically as SystemException error was thrown, run this block of code.
{
    Write-Verbose "An exception has occured during the installation process." -Verbose
    Write-Verbose ("Exception =>{0}`n" -f $_.Exception.ToString()) -Verbose # (Breakdown) Add first argument from exception string to verbose stream. !Someone let me know if I'm wrong!
}
catch # (Breakdown) Run this block for all other possible errors.
{
    Write-Verbose "An error has occured during the installation process." -Verbose
    Write-Verbose "Message => $_`n" -Verbose # (Breakdown) $_ is the current object in the pipeline which threw the error.
}
finally # (Breakdown) Run this block of code regardless of which previous blocks ran.
{
    Write-Verbose ("Ending Script: " + (Get-Date).ToString("yyyyMMddHHmmss")) -Verbose
    Stop-Transcript # (Breakdown) Stops recording this session
}

# Hopefully these breakdowns will help you customize and automate your own PowerShell scripts.
