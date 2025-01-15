Write-Host "Installing Node.js LTS"
winget install OpenJS.NodeJS.LTS --disable-interactivity --silent

Write-Host "Installing dotnet SDK"
winget install Microsoft.DotNet.SDK.9 --disable-interactivity --silent

Write-Host "Installing Visual Studio Code"
winget install Microsoft.VisualStudioCode --disable-interactivity --silent

Write-Host "Installing Git"
winget install --id Git.Git -e --source winget --disable-interactivity --silent

Write-Host "Installing Postman"
winget install --id Postman.Postman --disable-interactivity --silent

Write-Host "Installing Draw.io"
winget install --id JGraph.Draw --disable-interactivity --silent

Write-Host "Installing MongoDB Compass"
winget install -e --id MongoDB.Compass.Full --disable-interactivity --silent

Write-Host "Installing K6"
winget install -e --id k6.k6 --disable-interactivity --silent

Write-Host "Installing Docker Desktop"
winget install -e --id Docker.DockerDesktop --disable-interactivity --silent

Write-Host "Installing Hashicorp Vault"
winget install --id=Hashicorp.Vault -e --disable-interactivity --silent

Write-Host "Installing pnpm"
winget install -e --id pnpm.pnpm

Write-Host "Installing Yarn"
winget install -e --id Yarn.Yarn

Write-Host "Installing Yeoman"
yarn global add yo

Write-Host "Installing Extensions for Visual Studio Code"
code --install-extension github.codespaces
code --install-extension github.copilot
code --install-extension github.copilot-chat
code --install-extension github.vscode-github-actions
code --install-extension ms-dotnettools.csdevkit
code --install-extension ms-dotnettools.csharp
code --install-extension ms-dotnettools.vscode-dotnet-runtime
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.cpptools-extension-pack
code --install-extension ms-vscode.cpptools-themes
code --install-extension ms-vscode.test-adapter-converter
code --install-extension pkief.material-icon-theme`
code --install-extension vivaxy.vscode-conventional-commits

Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform, Microsoft-Windows-Subsystem-Linux
wsl --set-default-version 2