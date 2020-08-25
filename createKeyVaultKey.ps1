param([string] $keyVaultName)
param([string] $keyName)
az keyvault key create --vault-name $keyVaultName -n $keyName --protection software
$keyVaultKeyUrl=$(az keyvault key show --vault-name $keyVaultName --name $keyName --query [key.kid] -o tsv)
Write-Output $keyVaultKeyUrl
