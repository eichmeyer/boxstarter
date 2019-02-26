# Description: Boxstarter Script
# Author: https://twitter.com/HEichmeyer
# Based on a template by GhostOnTheWire5
#
# Install boxstarter:
#  	. { iwr -useb http://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
# NOTE the "." above is required.
#
# Run this boxstarter by calling the following from **elevated** powershell:
#   example: Install-BoxstarterPackage -PackageName  https://raw.githubusercontent.com/eichmeyer/boxstarter/master/boxstarter.ps1 -DisableReboots
# Learn more: http://boxstarter.org/Learn/WebLauncher

Update-ExecutionPolicy -Policy RemoteSigned

# Workaround for nested chocolatey folders resulting in path too long error

$ChocoCachePath = "C:\Temp"
New-Item -Path $ChocoCachePath -ItemType directory -Force

# Trust PSGallery
Get-PackageProvider -Name NuGet -ForceBootstrap
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

# Temporary

Disable-UAC
choco feature enable -n=allowGlobalConfirmation

#############################
# Privacy / Security Settings
#############################

#Disable-BingSearch
Disable-GameBarTips

# Privacy: Let apps use my advertising ID: Disable
If (-Not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
    New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo | Out-Null
}
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

# WiFi Sense: HotSpot Sharing: Disable
If (-Not (Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
    New-Item -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting | Out-Null
}
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting -Name value -Type DWord -Value 0

# WiFi Sense: Shared HotSpot Auto-Connect: Disable
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots -Name value -Type DWord -Value 0

# Start Menu: Disable Bing Search Results
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0

# Disable SMBv1
Disable-WindowsOptionalFeature -Online -FeatureName smb1protocol

############################
# Personal Preferences on UI
############################

Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions -EnableShowFullPathInTitleBar -EnableOpenFileExplorerToQuickAccess -EnableShowRecentFilesInQuickAccess -EnableShowFrequentFoldersInQuickAccess -EnableExpandToOpenFolder
Set-TaskbarOptions -Size Small -Dock Bottom -Combine Full -Lock

# Better File Explorer
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1		
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1		
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

# Lock screen (not sleep) on lid close
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name AwayModeEnabled -Type DWord -Value 1

# Disable Xbox Gamebar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name GameDVR_Enabled -Type DWord -Value 0

# Turn off People in Taskbar
If (-Not (Test-Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People | Out-Null
}
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name PeopleBand -Type DWord -Value 0

###############################
# Windows 10 Metro App Removals
###############################

# 3D Builder
Get-AppxPackage Microsoft.3DBuilder | Remove-AppxPackage

# Alarms
#Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage

# Autodesk
Get-AppxPackage *Autodesk* | Remove-AppxPackage

# Bing Weather, News, Sports, and Finance (Money):
Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage

# BubbleWitch
Get-AppxPackage *BubbleWitch* | Remove-AppxPackage

# Candy Crush
Get-AppxPackage king.com.CandyCrush* | Remove-AppxPackage

# Comms Phone
Get-AppxPackage Microsoft.CommsPhone | Remove-AppxPackage

# Disney Magic Kingdom
Get-AppxPackage *DisneyMagicKingdom* | Remove-AppxPackage

# Dropbox
Get-AppxPackage *Dropbox* | Remove-AppxPackage

# Facebook
Get-AppxPackage *Facebook* | Remove-AppxPackage

# Feedback Hub
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage

# Get Started
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage

# Hidden City: Hidden Object Adventure
Get-AppxPackage *HiddenCityMysteryofShadows* | Remove-AppxPackage

# Keeper
Get-AppxPackage *Keeper* | Remove-AppxPackage

# Maps
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage

# March of Empires
Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage

# Messaging
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage

# Minecraft
Get-AppxPackage *Minecraft* | Remove-AppxPackage

# Netflix
Get-AppxPackage *Netflix* | Remove-AppxPackage

# One Connect
Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage


# Phone
Get-AppxPackage Microsoft.WindowsPhone | Remove-AppxPackage

# Plex
Get-AppxPackage *Plex* | Remove-AppxPackage

# Skype (Metro version)
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage

# Sound Recorder
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage

# Solitaire
Get-AppxPackage *Solitaire* | Remove-AppxPackage

# Sticky Notes
#Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage

# Sway
Get-AppxPackage Microsoft.Office.Sway | Remove-AppxPackage

# Paint 3D
Get-AppxPackage Microsoft.MSPaint | Remove-AppxPackage

# Print 3D
Get-AppxPackage Microsoft.Print3D | Remove-AppxPackage

# Wallet
Get-AppxPackage Microsoft.Wallet | Remove-AppxPackage

# DesktopAppInstaller
Get-AppxPackage MMicrosoft.DesktopAppInstaller | Remove-AppxPackage

# Mixed Reality Portal
Get-AppxPackage Microsoft.MixedReality.Portal | Remove-AppxPackage

# Xbox
Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage
Get-AppxPackage Microsoft.Xbox.TCUI | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxGameOverlay | Remove-AppxPackage



###################################
# Windows Subsystems/Roles/Features
###################################

#cinst Microsoft-Hyper-V-All -source windowsFeatures
cinst Microsoft-Windows-Subsystem-Linux -source windowsFeatures
cinst TelnetClient -source windowsFeatures



########
# AWS
########

# Install AWS CLI
#cup awscli --cacheLocation $ChocoCachePath 

# Installing AWS Tools for Windows
#cup awstools.powershell --cacheLocation $ChocoCachePath

########
# Azure
########

# Install Azure cli
cup azure-cli --cacheLocation $ChocoCachePath

#####
# Git
#####

# Install git & git credential manager
cup git --cacheLocation $ChocoCachePath
cup git-credential-manager-for-windows --cacheLocation $ChocoCachePath


##############
# PowerShell
##############

# Installing Azure PowerShell modules
Install-Module -Name AzureRM -Scope AllUsers
Install-Module -Name Azure -Scope AllUsers -AllowClobber

####################
# Visual Studio Code
####################

# Install Visual Studio Code
cup visualstudiocode --cacheLocation $ChocoCachePath

# Install Visual Studio Code Extensions

code --install-extension ms-vscode.csharp
code --install-extension ms-vscode.PowerShell
code --install-extension ms-vscode.azurecli
code --install-extension ms-azuretools.vscode-azurefunctions
code --install-extension ms-mssql.mssql
code --install-extension mindginative.terraform-snippets
code --install-extension mauve.terraform
code --install-extension ipedrazas.kubernetes-snippets
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension emilast.LogFileHighlighter

#######
# Tools
#######

cup winrar --cacheLocation $ChocoCachePath
cup du --cacheLocation $ChocoCachePath


# clean up the cache directory
Remove-Item $ChocoCachePath -Recurse

#--- Restore Temporary Settings ---
choco feature disable -n=allowGlobalConfirmation
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
Enable-UAC