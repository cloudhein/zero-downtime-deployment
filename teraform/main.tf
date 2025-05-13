resource "tls_private_key" "hcp-keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "hcp_publickey" {
  key_name   = "hcp-publickey"
  public_key = tls_private_key.hcp-keypair.public_key_openssh
  #   public_key = var.publickey_openssh
}
