param
(
$vCenter,
$Cluster,
$EsxHost,
$Volume,
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

#Set some variables to use throughout script
#$vcenter_server = "corpvcenter-v.hy-vee.net"  #vCenter server to connect to

#Connect to vCenter
$vc_connection = Connect-VIServer -Server $vCenter -Credential $Creds


#Get ESXcli commands to resignature clone volume
$esxcli = Get-EsxCli -Server $vCenter -VMhost $EsxHost -V2

$resig = @{

    volumelabel = $Volume

}

$esxcli.storage.vmfs.snapshot.resignature.Invoke($resig)
