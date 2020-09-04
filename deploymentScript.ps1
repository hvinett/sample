param (
     [string] $primaryInstanceKeyVaultName,
     [string] $primaryInstanceKeyName,
     [string] $replicaInstanceKeyVaultName,
     [string] $replicaInstanceKeyName,
     [string] $backupInstanceKeyVaultName,
     [string] $backupInstanceKeyName
)
Write-Output $primaryInstanceKeyVaultName             
Write-Output $primaryInstanceKeyName      
Write-Output $replicaInstanceKeyVaultName      
Write-Output $replicaInstanceKeyName      
Write-Output $backupInstanceKeyVaultName      
Write-Output $backupInstanceKeyName      

$primaryInstanceDesKey = Add-AzKeyVaultKey -VaultName $primaryInstanceKeyVaultName  -name $primaryInstanceKeyName -Destination 'Software'
$replicaInstanceDesKey = Add-AzKeyVaultKey -VaultName $replicaInstanceKeyVaultName  -name $replicaInstanceKeyName -Destination 'Software'
$backupInstanceDesKey = Add-AzKeyVaultKey -VaultName $backupInstanceKeyVaultName  -name $backupInstanceKeyName -Destination 'Software'

$DeploymentScriptOutputs = @{}
$DeploymentScriptOutputs['primaryInstanceDesKeyVaultKeyUrl'] = $primaryInstanceDesKey.Id
$DeploymentScriptOutputs['replicaInstanceDesKeyVaultKeyUrl'] = $replicaInstanceDesKey.Id
$DeploymentScriptOutputs['backupInstanceDesKeyVaultKeyUrl'] = $backupInstanceDesKey.Id
