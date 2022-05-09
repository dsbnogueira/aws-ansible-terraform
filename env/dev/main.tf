module "aws-dev" {
  source = "../../infra"
  flavor = "t2.micro"
  region_aws = "us-west-2"
  chave_ssh = "dev-iac"
  nome = "development"
}

output "dev_public_ip" {
  value = module.aws-dev.public_ip
}