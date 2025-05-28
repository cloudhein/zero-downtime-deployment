terraform {
  backend "s3" {
    bucket       = "remote-state-bucket-dev-001"
    key          = "terraform/dev/terraform.tfstate"
    region       = "ap-northeast-1"
    encrypt      = true
    use_lockfile = true
    #profile      = "tf-s3-state-handler"
  }
}