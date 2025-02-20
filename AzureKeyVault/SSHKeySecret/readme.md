Usage

```
# Ensure the local environment is setup to run Az modules.
# Make sure the local environment is using Az modules and AzureRM has been removed.
# AzureRM and Az are not compatible.
# https://basvo.github.io/azure/azurerm/powershell/2021/03/05/remove-azurerm-before-installing-az-module.html

uninstall-module Azure
uninstall-module AzureRM
Get-Module -ListAvailable | Where {$_.Name -like 'AzureRM.*'}
$Modules = Get-Module -ListAvailable | Where {$_.Name -like 'AzureRM.*'}
Foreach ($Module in $Modules) {Uninstall-Module $Module}
if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Module -Name AzureRM -ListAvailable)) {
    Write-Warning -Message ('Az module not installed. Having both the AzureRM and ' +
      'Az modules installed at the same time is not supported.')
} else {
    Install-Module -Name Az -AllowClobber -Scope CurrentUser
}

# If needed install Az module
Install-Module -Name Az -AllowClobber -Force -Scope CurrentUser
# Connect to Azure if needed 
Connect-AzAccount
```


Connect to Azure
Configure and run import-pem-to-key-vault.ps1 to import a private key as a secret.
Configure and run extract-pem-key-secret-from-key-vault.ps1 to save the export the secret as a valid key.

```.\import-pem-to-key-vault.ps1```

Once complete verify the secret is valid for use.
Copy the secret out of key vault. This can be done manually via the Azure portal or by configuring and executing 

```.\extract-pem-key-secret-from-key-vault.ps1``` 

Use the created pem file for a ssh tunnel or other operation. 