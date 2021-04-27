

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
replacemevar_display_max_depth=10
replacemevar_display_max_children=256
replacemevar_display_max_data=1024
replacememode="debug"
replacemestart_with_request="yes"
replacemeremote_autostart = 1
  }
  $iniContent["xdebug"] = $xdebug
   
   New-BurntToastNotification -Text "Xdebug enabled","Xdebug enabled"

}

$temp = "";


$iniContent | Out-IniFile -Force  | $temp

$temp | Set-Content "C:\laragon\bin\php\php-7.2.19-Win32-VC15-x64\php.ini"

C:\laragon\laragon.exe reload apache
