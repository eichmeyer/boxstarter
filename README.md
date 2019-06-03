# boxstarter
OS configuration template

Run this Boxstarter by calling the following from an **ELEVATED PowerShell instance**:

     set-executionpolicy Unrestricted
     . { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
     Install-BoxstarterPackage -DisableReboots -PackageName https://github.com/eichmeyer/boxstarter/master/boxstarter.ps1
