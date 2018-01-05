# Voorbeeld script 
# Gebruik NAME voor de meeste machines. Gebruik VERSION voor Lenovo machines.
# 
function Get-model ($type){
    Get-WmiObject -Query "SELECT * FROM Win32_ComputerSystemProduct WHERE Name = ""$type"""}

function Get-BIOS ($bios){
    Get-WmiObject -Query "SELECT * FROM Win32_BIOS WHERE SMBIOSBIOSVersion = ""$bios"""}

$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition #Alleen PowerShell 2
$SetupEXEParam = "/auto upgrade /DynamicUpdate Disable /Compat IgnoreWarning /InstallDrivers",$PSScriptRoot,"Drivers /ResizeRecoveryPartition Enable"
$SetupEXE = $PSScriptRoot+="Setup.exe"


if (Get-model "HP ProBook 470 G2")
{
    if (!(Get-BIOS "M74 Ver. 01.44") )
    {
        Write-Host "`nDeze machine heeft een te oude BIOS en zal geupdate worden." -ForegroundColor Yellow
        write-host "`nDe computer zal automatisch opnieuw starten." -ForegroundColor Yellow
        Write-host "`nStart daarna de procedure nogmaals." -ForegroundColor Yellow
        $UpdateEXE = $PSScriptRoot+="BIOS\sp81459\HPBIOSUPDREC.exe"
        #start-process -FilePath $UpdateEXE -ArgumentList "-s -b" -Wait
    }
}
