# Dynamic Parameters  
param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$vaultname
)
#Service Principal can be used as an alternative
$azureAccountName = "avinash.r@****.com" 
$azurePassword = ConvertTo-SecureString "MyPassword&" -AsPlainText -Force
$psCred = New-Object System.Management.Automation.PSCredential($azureAccountName, $azurePassword)
Login-AzureRmAccount -Credential $psCred -TenantId adbbbd82-****-****-****-3cc59f3c1fdd


$hash = $null
$hash = @{ }

$secrets = Get-AzureKeyVaultSecret -VaultName $vaultname

# Loop through all the secrets and construct a hash of secret name and secret value
foreach ($secret in $secrets) {

    $secretValue = (Get-AzureKeyVaultSecret -VaultName $vaultname -name $secret.Name).SecretValueText
    $hash.Add($secret.Name, $secretValue)
}
Write-Output $hash
