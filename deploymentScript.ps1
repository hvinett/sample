param (
     [string] $primaryKeyVaultName,
     [string] $primaryKeyName,
     [string] $replicaKeyVaultName,
     [string] $replicaKeyName,
     [string] $backupKeyVaultName,
     [string] $backupKeyName
)
                  

$primaryKey = Add-AzKeyVaultKey -VaultName $primaryKeyVaultName  -name $primaryKeyName -Destination 'Software'
$replicaKey = Add-AzKeyVaultKey -VaultName $replicaKeyVaultName  -name $replicaKeyName -Destination 'Software'
$backupKey = Add-AzKeyVaultKey -VaultName $backupKeyVaultName  -name $backupKeyName -Destination 'Software'

$DeploymentScriptOutputs = @{}
$DeploymentScriptOutputs['primaryKeyVaultKeyUrl'] = $primaryKey.Id
$DeploymentScriptOutputs['replicaKeyVaultKeyUrl'] = $replicaKey.Id
$DeploymentScriptOutputs['backupKeyVaultKeyUrl'] = $backupKey.Id
