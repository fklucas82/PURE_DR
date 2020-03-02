# Pure_DR
Workbook for automating DR from Pure Storage

Clone the most recent replicated snapshots at Chaska and Attach them to Chaska Hosts

Currently configured specifically for pure-wdm-ds0 and pure-wdm-ds1

1. Identifies the most recent snapshot on Chas-Pure1

2. Clones new volumes from that snapshot

3. Adds the volumes to the host group for the ChasApps-Cluster

4. Scans the iSCSI HBAs in ChasApps-Cluster to pick up the new volumes

5. Resignatures the new volumes and adds them as Datastores

Desired Future Updates:

 - Add more datastores

 - Rename the cloned datastores
 
 - Add VMs to inventory 
 
 - Modify network settings on VMs to use Chaska networks
 
 - Power on VMs
 
 - Create ansible bridge server at Chaska and update add_datastores.yml to use that server
 
 - Make it more efficient / Run Faster

REQUIRES:
Modules:
pyvmomi 
purestorage

Ansible Bridge Server requires VMware PowerCLI powershell modules

Additional testing:

- I think if someone manually creates a snapshot it might screw up the logic I use to identify the most recent datastore.

Reference:
https://blog.purestorage.com/from-zero-to-ansible-for-the-pure-storage-flasharray-in-one-easy-lesson/
