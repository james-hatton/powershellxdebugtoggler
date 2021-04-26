

if (Get-Module -ListAvailable -Name BurntToast) {
    Write-Host "Already installed"
} 
else {
    try {
        Install-Module -Name BurntToast -AllowClobber -Confirm:$False -Force  
    }
    catch [Exception] {
        $_.message 
        exit
    }
}

if (Get-Module -ListAvailable -Name PsIni) {
    Write-Host "Already installed"
} 
else {
    try {
        Install-Module -Name PsIni -AllowClobber -Confirm:$False -Force  
    }
    catch [Exception] {
        $_.message 
        exit
    }
}



Import-Module BurntToast


$iniContent = Get-IniContent "C:\laragon\bin\php\php-7.2.19-Win32-VC15-x64\php.ini"


$isXDebugOn = $iniContent.Contains("xdebug")


If ($isXdebugOn)
{
 $iniContent.Remove("xdebug")
 New-BurntToastNotification -Text "Xdebug disabled","Xdebug disabled"
} 
Else
{


$xdebug = [ordered] @{
   zend_extension = "C:\laragon\bin\php\php-7.2.19-Win32-VC15-x64\ext\php_xdebug-3.0.4-7.2-vc15-x86_64.dll"
var_display_max_depth=10
var_display_max_children=256
var_display_max_data=1024
mode="debug"
start_with_request="yes"
  }
  $iniContent["xdebug"] = $xdebug
   
   New-BurntToastNotification -Text "Xdebug enabled","Xdebug enabled"

}

$iniContent | Out-IniFile -Force "C:\laragon\bin\php\php-7.2.19-Win32-VC15-x64\php.ini"

C:\laragon\laragon.exe reload apache
