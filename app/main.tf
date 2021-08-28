#Definir o plugin a ser Utilizado
terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

#Maquina Virtual EC2
resource "aws_instance" "servidor-apache" {

    # Número de Máquinas Criadas
    count = 2
    ami           = var.ami["linux"]
    instance_type = var.ami["micro"]

    tags = {
        Name = "servidor-web-${count.index}" # Pegar Index da Máquina Criada
    }

    ## Associar Chave de Acesso
    key_name = "terraform-aws-kg"

    ## Associar Security Group Acesso SSH
    vpc_security_group_ids = [aws_security_group.acesso-ssh.id, aws_security_group.acesso-http.id]

    user_data = file("scripts/install-apache.sh")

    
    
  
}

## Configurando o Security Group
resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssh"
  description = "acesso-ssh"

  ingress = [
    {
      description      = "acesso-ssh"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks =  null
      prefix_list_ids   = null
      security_groups   = null
      self              = null
    }
  ]

  tags = {
    Name = "acesso-ssh"
  }
}

resource "aws_security_group" "acesso-http" {
  name        = "acesso-http"
  description = "acesso-http"

  ingress  = [
    {
      description      = "acesso-http"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks =  null
      prefix_list_ids   = null
      security_groups   = null
      self              = null
    }
  ]

   egress  = [
    {
      description      = "acesso-http-saida"
      from_port        = 0
      to_port          = 0
      protocol         = "ALL"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks =  null
      prefix_list_ids   = null
      security_groups   = null
      self              = null
    }
  ]
  
  tags = {
    Name = "acesso-http"
  }

}

#Configurar Instância do RS com MySQL
/*
resource "aws_db_instance" "servidor-banco" {
  
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb_exemplo"
  username             = "root"
  password             = "1q2w3e4r"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  publicly_accessible  = true
  

    tags = {
    Name = "servidor-mysql"
  }
  
}*/