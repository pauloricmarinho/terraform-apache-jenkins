# Projeto Terraform AWS
Repositório Instâcnia Apache Tomcat, Servidor Jenkins  e Load Balance

**Baixar a Versão do Terraform e Configurar as Variáveis de Ambiente**

	https://releases.hashicorp.com/terraform/1.0.1/

**Terraform Providers AWS**

	https://registry.terraform.io/providers/hashicorp/aws/latest

**Gerar Chave Criptogratica e Importar para o Console do AWS - AMI**

`ssh-keygen.exe -f terraform-aws-kg -t rsa`

**Baixar AWS Client**

`msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi`

**Configurar a Conexão com via AWS Client**

`aws configure`

>AWS Access Key ID [None]:      $USER_KEY

>AWS Secret Access Key [None]:  $USER_SECRET_ACCESS

>Default region name [None]:    us-east-1

>Default output format [None]:  json

**Comandos Básicos do Terraform**

|                  |Descrição                      							|
|------------------|--------------------------------------------------------|
|terraform version |`Verificar a Versão do Terraform`            			|
|terraform init    |`Inicialziar o Diretório de Configuração do Terraform`  |
|terraform plan    |`Visualizar Instâncias a Serem Criadas no AWS`			|
|terraform show    |`Mostrar Instâncias Criadas dentro do Console do AWS`	|
|terraform apply   |`Aplicar o HCL do Terraform para Criação das Instâncias`|
|terraform destroy |`Destroi todas Instâncias Criadas via HCL no AWS`		|

**Desenvolvido por:**

- *Gabriel Rossi Lopes*
- *Lenon Izidorio dos Santos Fernandes*
- *Paulo Ricardo Marinho Pontes*