resource "tls_private_key" "vpn_server_key_gen" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "vpn_server_ssh_key" {
  key_name   = "VPN_Server_Key"
  public_key = tls_private_key.vpn_server_key_gen.public_key_openssh
}
resource "local_sensitive_file" "vpn_server_private_ssh_key" {
  filename        = "${aws_key_pair.vpn_server_ssh_key.key_name}-private.pem"
  file_permission = "0400"
  content         = tls_private_key.vpn_server_key_gen.private_key_pem
}

resource "aws_instance" "vpn_server" {
  depends_on             = [module.go-test-networking]
  monitoring             = false
  ami                    = "ami-0557a15b87f6559cf"
  instance_type          = "t2.micro"
  subnet_id              = module.go-test-networking.public_subnet_ids[0]
  key_name               = aws_key_pair.vpn_server_ssh_key.key_name
  vpc_security_group_ids = [module.go-test-networking.security_group_id]
  user_data              = <<-EOF
    #!/bin/bash
    apt update && apt -y install ca-certificates wget net-tools gnupg
    wget https://as-repository.openvpn.net/as-repo-public.asc -qO /etc/apt/trusted.gpg.d/as-repository.asc
    echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/as-repository.asc] http://as-repository.openvpn.net/as/debian jammy main">/etc/apt/sources.list.d/openvpn-as-repo.list
    apt update && apt -y install openvpn-as apache2
    myIP=`curl icanhazip.com`
    echo "VPN SERVER -- Instance IP address: $myIP" > /var/www/html/index.html
    sudo service apache2 restart
  EOF
  tags = {
    Name = "VPN_Server_Instance"
  }
}

