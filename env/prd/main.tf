module "aws-prd" {
  source = "../../infra"
  flavor = "t2.micro"
  region_aws = "us-west-2"
  chave_ssh = "prd-iac"
  nome = "production"
}

output "prd_public_ip" {
  value = module.aws-prd.public_ip
}