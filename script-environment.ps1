# Reference : https://github.com/DrBorg/YTScripts/blob/main/UsingWinget.ps1

#======================================================================
# NO POWERSHELL WINDOW DURING THE INSTALL
#======================================================================
$t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
add-type -name win -member $t -namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0)

#======================================================================
# CHECK IF THE SCRIPT IS ELEVATED / ELEVATE IF NOT
#======================================================================
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Exit
}

#======================================================================
# TURN OFF PROGRESS BAR TO MAKE SCRIPT RUN FASTER
#======================================================================

$ProgressPreference = 'SilentlyContinue'

#======================================================================
# BYPASS EXECUTION POLICY TO ALLOW SCRIPT TO RUN
#======================================================================

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Check if winget is installed
        Write-Host "Checking if Winget is Installed..."
        if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe) {
            #Checks if winget executable exists and if the Windows Version is 1809 or higher
            Write-Host "Winget Already Installed"
        }
        else {
            #Gets the computer's information
            $ComputerInfo = Get-ComputerInfo

            #Gets the Windows Edition
            $OSName = if ($ComputerInfo.OSName) {
                $ComputerInfo.OSName
            }else {
                $ComputerInfo.WindowsProductName
            }

            if (((($OSName.IndexOf("LTSC")) -ne -1) -or ($OSName.IndexOf("Server") -ne -1)) -and (($ComputerInfo.WindowsVersion) -ge "1809")) {
                
                Write-Host "Running Alternative Installer for LTSC/Server Editions"

                # Switching to winget-install from PSGallery from asheroto
                # Source: https://github.com/asheroto/winget-installer
                
                Start-Process powershell.exe -Verb RunAs -ArgumentList "-command irm https://raw.githubusercontent.com/ChrisTitusTech/winutil/$BranchToUse/winget.ps1 | iex | Out-Host" -WindowStyle Normal
                
            }
            elseif (((Get-ComputerInfo).WindowsVersion) -lt "1809") {
                #Checks if Windows Version is too old for winget
                Write-Host "Winget is not supported on this version of Windows (Pre-1809)"
            }
            else {
                #Installing Winget from the Microsoft Store
                Write-Host "Winget not found, installing it now."
                Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
                $nid = (Get-Process AppInstaller).Id
                Wait-Process -Id $nid
                Write-Host "Winget Installed"
            }
        }

# installing packages via winget
Write-Host "Installing required packages..."
$packages = @(
    "Node.js",
    "Microsoft.DotNet.SDK",
    "Microsoft.VisualStudioCode",
    "Git.Git",
    "Postman.Postman",
    "drawio.drawio",
    "MongoDB.Compass",
     "grafana.k6",
     "Docker.DockerDesktop",
    "HashiCorp.Vault",
    "pnpm.pnpm",
    "Yarn.Yarn",
    "Yeoman.Yo"
)

foreach ($package in $packages) {
    Write-Host "Installing $package..."
    winget install $package -h --accept-package-agreements --accept-source-agreements
    Write-Host "$package installed successfully."
}

# ---------------------------------
# 14 - Installing Extensions for Visual Studio Code
# ---------------------------------
Write-Host "14 - Installing Extensions for Visual Studio Code"
$extensions = @(
  "github.codespaces",
  "github.copilot",
  "github.copilot-chat",
  "github.vscode-github-actions",
  "ms-dotnettools.csdevkit",
  "ms-dotnettools.csharp",
  "ms-dotnettools.vscode-dotnet-runtime",
  "ms-vscode.cpptools",
  "ms-vscode.cpptools-extension-pack",
  "ms-vscode.cpptools-themes",
  "ms-vscode.test-adapter-converter",
  "pkief.material-icon-theme",
  "vivaxy.vscode-conventional-commits"
)

foreach ($extension in $extensions) {
  Write-Host "Installing extension: $extension"
   if (-not (code --list-extensions | Where-Object { $_ -eq $extension })) {
    code --install-extension $extension
    Write-Host "Extension: $extension installed correctly"
  } else{
       Write-Host "Extension: $extension is already installed"
  }
}

Write-Host "Script execution completed."