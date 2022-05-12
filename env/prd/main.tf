module "aws-prd" {
  source = "../../infra"
  flavor = "t2.micro"
  region_aws = "us-west-2"
  chave_ssh = "prd-iac"
  nome = "production"
  grupoDeSeguranca = "production"
  minimo = 1
  maximo = 10
  nomeGrupo = "production"
}