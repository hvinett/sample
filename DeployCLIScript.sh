#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"
    case "$key" in
    --primaryInstanceKeyVaultName)  
        primaryInstanceKeyVaultName=$2
        shift
        shift
        echo "primaryInstanceKeyVaultName: $primaryInstanceKeyVaultName"
        ;;
	--primaryInstanceKeyName)  
        primaryInstanceKeyName=$2
        shift
        shift
        echo "primaryInstanceKeyName: $primaryInstanceKeyName"
        ;;
	--replicaInstanceKeyVaultName)  
        replicaInstanceKeyVaultName=$2
        shift
        shift
        echo "replicaInstanceKeyVaultName: $replicaInstanceKeyVaultName"
        ;;
	--replicaInstanceKeyName)  
        replicaInstanceKeyName=$2
        shift
        shift
        echo "replicaInstanceKeyName: $replicaInstanceKeyName"
        ;;
	--backupInstanceKeyVaultName)  
        backupInstanceKeyVaultName=$2
        shift
        shift
        echo "backupInstanceKeyVaultName: $backupInstanceKeyVaultName"
        ;;
	--backupInstanceKeyName)  
        backupInstanceKeyName=$2
        shift
        shift
        echo "backupInstanceKeyName: $backupInstanceKeyName"
        ;;
     *)
        echo "Invalid parameter: $1"
        exit 1
        ;;
    esac
done

## TODO: create disk encryption set keys if they are not present in their respective key vaults already. 

primaryInstanceDiskEncryptionSetKeyVaultKeyUrl=$(az keyvault key show --vault-name "$primaryInstanceKeyVaultName"  --name "$primaryInstanceKeyName" --query key.kid)
exitCode=$?
if [ $exitCode -ne 0 ]
then
	az keyvault key create --vault-name $primaryInstanceKeyVaultName  --name $primaryInstanceKeyName
	primaryInstanceDiskEncryptionSetKeyVaultKeyUrl=$(az keyvault key show --vault-name "$primaryInstanceKeyVaultName"  --name "$primaryInstanceKeyName" --query key.kid)
fi

replicaInstanceDiskEncryptionSetKeyVaultKeyUrl=$(az keyvault key show --vault-name "$replicaInstanceKeyVaultName"  --name "$replicaInstanceKeyName" --query key.kid)
exitCode=$?
if [ $exitCode -ne 0 ]
then
	az keyvault key create --vault-name $replicaInstanceKeyVaultName  --name $replicaInstanceKeyName
	replicaInstanceDiskEncryptionSetKeyVaultKeyUrl=$(az keyvault key show --vault-name $replicaInstanceKeyVaultName  --name $replicaInstanceKeyName --query key.kid)
fi


backupInstanceDiskEncryptionSetKeyVaultKeyUrl=$(az keyvault key show --vault-name $backupInstanceKeyVaultName  --name $backupInstanceKeyName --query key.kid)
exitCode=$?
if [ $exitCode -ne 0 ]
then
	az keyvault key create --vault-name $backupInstanceKeyVaultName  --name $backupInstanceKeyName
	backupInstanceDiskEncryptionSetKeyVaultKeyUrl=$(az keyvault key show --vault-name $backupInstanceKeyVaultName  --name $backupInstanceKeyName --query key.kid)
fi

echo "{\"primaryInstanceDiskEncryptionSetKeyVaultKeyUrl\": $primaryInstanceDiskEncryptionSetKeyVaultKeyUrl, \"replicaInstanceDiskEncryptionSetKeyVaultKeyUrl\": $replicaInstanceDiskEncryptionSetKeyVaultKeyUrl, \"backupInstanceDiskEncryptionSetKeyVaultKeyUrl\": $backupInstanceDiskEncryptionSetKeyVaultKeyUrl}" > $AZ_SCRIPTS_OUTPUT_PATH
