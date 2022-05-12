module "aws-dev" {
  source = "../../infra"
  flavor = "t2.micro"
  region_aws = "us-west-2"
  chave_ssh = "dev-iac"
  nome = "development"
  grupoDeSeguranca = "development"
  minimo = 0
  maximo = 2
  nomeGrupo = "devlopment"
}