# Dynamic Parameters  
param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$vaultname,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$inputfile
)
#Un-interrupted Azure Login
$azureAccountName = "avinash.r@*****.com" 
$azurePassword = ConvertTo-SecureString "MyPassowrd&" -AsPlainText -Force
$psCred = New-Object System.Management.Automation.PSCredential($azureAccountName, $azurePassword)
Login-AzureRmAccount -Credential $psCred -TenantId adbbbd82-****-****-****-3cc59f3c1fdd

# Create Hash table
$hash = Get-Content -Raw $inputfile | ConvertFrom-StringData

#Loop through the Hash keys and create secret name, secrte value in azure keyvault
foreach ($key in $hash.Keys) {
    $secretValue = (ConvertTo-SecureString -String $hash[$key] -AsPlainText -Force)
    Set-AzureKeyVaultSecret -VaultName $vaultname -Name $key -SecretValue $secretValue
}