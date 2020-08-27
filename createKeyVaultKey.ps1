param (
     [string] $keyVaultName,
     [string] $keyName
)
                  
write-Output keyVaultName: $keyVaultName
write-Output keyName: $keyName
$key = Add-AzKeyVaultKey -VaultName $keyVaultName  -name $keyName -Destination 'Software'
write-Output $keyName
$DeploymentScriptOutputs = @{}
$DeploymentScriptOutputs['keyVaultKeyUrl'] = $key.Id
