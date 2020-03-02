param
(
$vCenter,
$Cluster,
$Username,
$Password
)

$password=$password|ConvertTo-SecureString -AsPlainText -Force
$Creds = New-Object System.Management.Automation.PSCredential ($Username,$Password)

#Import modules if they have not been imported yet
if($null -eq (Get-Module VMware.PowerCLI))
{
    Import-Module VMware.PowerCLI
}

#Since we are not using a valid cert in vCenter, set PowerCLI config to ignore SSL warnings/errors
Set-PowerCLIConfiguration -InvalidCertificateAction:Ignore -Scope User -ProxyPolicy NoProxy -Confirm:$false
#Connect to vCenter
$vc_connection = Connect-VIServer -Server $vCenter -Credential $Creds


#Scan for new VMFS datastore
$ClusterHosts = Get-VMHost -Location $Cluster | Select Name
ForEach($ClusterHost in $ClusterHosts)
{
Get-VMHostStorage -Server $vCenter -VMHost $ClusterHost.Name -RescanVmfs
}