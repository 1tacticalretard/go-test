# VPN CONFIGURATION STEPS
1. Run terraform init & apply, as usual; this will also generate .pem key for VPN Server instance.
2. Log in to the EC2 instance named `VPN_Server_Instance` after Terraform code is applied. SSH key with the name of `VPN_Server_Key-private.pem` is auto-generated for this. The command to be used is:
```
ssh -i "VPN_Server_Key-private.pem" ubuntu@<paste_vpn_server_public_ip_here>
```
3. Once done, run this command to get initial OpenVPN admin password:
```
sudo cat /usr/local/openvpn_as/init.log | grep "account with" | sed 's/.*"\(.*\)".*/\1/'
```
4. Save the outputted value and use it as a password at https://<paste_vpn_server_public_ip_here>:943/admin . Thus, paste `openvpn` as username and the output from step 3 as password.
5. After that, in order to set up VPN connection, feel free to refer to [this video guide](https://www.youtube.com/watch?v=WhTGWYYtUMg).

    Note: 
    - VPC CIDR by default is: `192.168.0.0/16`.
    - Private subnet CIDR by default is: `192.168.2.0/24`

    Both values can be viewed and modified in `main.tf` file.

The target connection address can be found (and accessed with active VPN connection) at:

    -   `Amazon Elastic Container Service -> Clusters -> go-test-cluster -> Infrastructure -> Container instances -> <container_instance_name> > Resources and Networking > Private IP`
    - `Amazon EC2 > Instances > go-test-cluster > Networking > Private IP`
Once VPN connection is stable, and the container instance is up and running, you can view it at http://<your_instance_private_ip_address>/ping . 