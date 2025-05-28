terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.90.0"
    }
  }
}

provider "aws" {
  region     = ""
  access_key = ""
  secret_key = ""
}

#provider "aws" {
#  region  = "ap-northeast-1"
#  profile = "terraform-cloud-user"
#}