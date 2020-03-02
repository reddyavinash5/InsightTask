# Dynamic Parameters  
param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$vaultname,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$inputfile
)
#Un-interrupted Azure Login
$azureAccountName = "avinash.r@*****.com" 
$azurePassword = ConvertTo-SecureString "Mypassword&" -AsPlainText -Force
$psCred = New-Object System.Management.Automation.PSCredential($azureAccountName, $azurePassword)
Login-AzureRmAccount -Credential $psCred -TenantId adbbbd82-****-****-****-3cc59f3c1fdd

# Parse json file into json object
$jsonObj = Get-Content -Raw $inputfile | ConvertFrom-Json

#Loop through the Hash keys and create secret name, secrte value in azure keyvault
foreach ($item in $jsonObj) {
    $secretValue = (ConvertTo-SecureString -String $item.SecretValue -AsPlainText -Force)
    Set-AzureKeyVaultSecret -VaultName $vaultname -Name $item.SecretName -SecretValue $secretValue
}