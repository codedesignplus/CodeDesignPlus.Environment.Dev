#Requires -RunAsAdministrator
# Configuración del script

$ErrorActionPreference = "Stop" # Detener el script si hay un error

Write-Host "---------------------------------"
Write-Host "STARTING INSTALLATION SCRIPT"
Write-Host "---------------------------------"

# Función para verificar si un programa está instalado (usando winget)
function Confirm-WingetPackageInstalled {
    param (
        [string]$PackageId
    )
    try {
        winget show $PackageId | Out-Null
        return $true
    } catch {
        return $false
    }
}

# Función para instalar un paquete usando winget
function Install-WingetPackage {
    param (
        [string]$PackageId,
        [string]$PackageName
    )
    if (-not (Confirm-WingetPackageInstalled -PackageId $PackageId)) {
        Write-Host "Installing $PackageName..."
        winget install $PackageId --disable-interactivity --silent
    } else {
        Write-Host "$PackageName is already installed."
    }
}

# ---------------------------------
# 1 - Installing Node.js LTS
# ---------------------------------
Write-Host "1 - Installing Node.js LTS"
Install-WingetPackage -PackageId "OpenJS.NodeJS.LTS" -PackageName "Node.js LTS"
Write-Host "Verifying Node.js installation..."
node -v
npm -v


# ---------------------------------
# 2 - Installing .NET SDK
# ---------------------------------
Write-Host "2 - Installing .NET SDK"
Install-WingetPackage -PackageId "Microsoft.DotNet.SDK.9" -PackageName ".NET SDK"
Write-Host "Verifying .NET SDK installation..."
dotnet --version


# ---------------------------------
# 3 - Installing Visual Studio Code
# ---------------------------------
Write-Host "3 - Installing Visual Studio Code"
Install-WingetPackage -PackageId "Microsoft.VisualStudioCode" -PackageName "Visual Studio Code"


# ---------------------------------
# 4 - Installing Git
# ---------------------------------
Write-Host "4 - Installing Git"
Install-WingetPackage -PackageId "Git.Git" -PackageName "Git"


# ---------------------------------
# 5 - Installing Postman
# ---------------------------------
Write-Host "5 - Installing Postman"
Install-WingetPackage -PackageId "Postman.Postman" -PackageName "Postman"

# ---------------------------------
# 6 - Installing Draw.io
# ---------------------------------
Write-Host "6 - Installing Draw.io"
Install-WingetPackage -PackageId "JGraph.Draw" -PackageName "Draw.io"

# ---------------------------------
# 7 - Installing MongoDB Compass
# ---------------------------------
Write-Host "7 - Installing MongoDB Compass"
Install-WingetPackage -PackageId "MongoDB.Compass.Full" -PackageName "MongoDB Compass"

# ---------------------------------
# 8 - Installing K6
# ---------------------------------
Write-Host "8 - Installing K6"
Install-WingetPackage -PackageId "k6.k6" -PackageName "K6"

# ---------------------------------
# 9 - Installing Docker Desktop
# ---------------------------------
Write-Host "9 - Installing Docker Desktop"
Install-WingetPackage -PackageId "Docker.DockerDesktop" -PackageName "Docker Desktop"

# ---------------------------------
# 10 - Installing Hashicorp Vault
# ---------------------------------
Write-Host "10 - Installing Hashicorp Vault"
Install-WingetPackage -PackageId "Hashicorp.Vault" -PackageName "Hashicorp Vault"

# ---------------------------------
# 11 - Installing pnpm
# ---------------------------------
Write-Host "11 - Installing pnpm"
Install-WingetPackage -PackageId "pnpm.pnpm" -PackageName "pnpm"

# ---------------------------------
# 12 - Installing Yarn
# ---------------------------------
Write-Host "12 - Installing Yarn"
Install-WingetPackage -PackageId "Yarn.Yarn" -PackageName "Yarn"


# ---------------------------------
# 13 - Installing Yeoman
# ---------------------------------
Write-Host "13 - Installing Yeoman"
if (-not (Get-Command yo -ErrorAction SilentlyContinue)) {
  Write-Host "Installing Yeoman (yo) globally..."
  yarn global add yo
} else {
    Write-Host "Yeoman (yo) is already installed."
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


Write-Host "---------------------------------"
Write-Host "INSTALLATION SCRIPT FINISHED"
Write-Host "---------------------------------"