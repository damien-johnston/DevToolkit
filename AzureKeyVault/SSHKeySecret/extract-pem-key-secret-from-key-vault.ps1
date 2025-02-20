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
# Import-Module Az.KeyVault

# Define the Azure Key Vault name
$vaultName = "keyvaultname"

# Define the name for the secret in Azure Key Vault
$secretName = "secretname"

# Retrieve the secret from Azure Key Vault
$retrievedSecret = Get-AzKeyVaultSecret -VaultName $vaultName -Name $secretName

# # Convert the SecureString to plain text
$base64PemKey = $retrievedSecret.SecretValue

# # Convert the SecureString to plain text using Marshal
$base64PemKeyPlainText = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($base64PemKey))

# Output the original PEM content
Write-Host "The extracted PEM key content is:"
Write-Host $base64PemKeyPlainText

# Optionally, save the extracted PEM content to a file
$outputPemFilePath = "pathtoextractedkeyfile.pem"
$base64PemKeyPlainText | Out-File -FilePath $outputPemFilePath

Write-Host "The PEM key has been successfully saved to $outputPemFilePath"