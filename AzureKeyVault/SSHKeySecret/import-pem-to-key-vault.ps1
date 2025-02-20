# Ensure the local environment is using Az modules and AzureRM has been removed.
# AzureRM and Az are not compatible.
# https://basvo.github.io/azure/azurerm/powershell/2021/03/05/remove-azurerm-before-installing-az-module.html
#
# uninstall-module Azure
# uninstall-module AzureRM
# Get-Module -ListAvailable | Where {$_.Name -like 'AzureRM.*'}
# $Modules = Get-Module -ListAvailable | Where {$_.Name -like 'AzureRM.*'}
# Foreach ($Module in $Modules) {Uninstall-Module $Module}
# if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Module -Name AzureRM -ListAvailable)) {
#     Write-Warning -Message ('Az module not installed. Having both the AzureRM and ' +
#       'Az modules installed at the same time is not supported.')
# } else {
#     Install-Module -Name Az -AllowClobber -Scope CurrentUser
# }

# If needed install Az module
# Install-Module -Name Az -AllowClobber -Force -Scope CurrentUser
# Connect to Azure if needed 
# Connect-AzAccount
########################################################################################


# Import Azure module (if not already imported)
Import-Module Az.KeyVault

# Define the path to your PEM valid private key file
$pemFilePath = "pathtovalidsshprivatekeyfile.pem"

# Define the Azure Key Vault name
$vaultName = "keyvaultname"

# Define the name for the secret in Azure Key Vault
$secretName = "secretname"

# Read the PEM file content as a string (including the newlines)
$pemKeyContent = Get-Content -Path $pemFilePath -Raw

# Store the base64-encoded key in Azure Key Vault as a secret using the correct cmdlet
Set-AzKeyVaultSecret -VaultName $vaultName -Name $secretName -SecretValue (ConvertTo-SecureString -String $pemKeyContent -AsPlainText -Force)

Write-Host "RSA private key has been successfully imported into Key Vault."
