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
resource "aws_instance" "srv-jenkins" {

    # Número de Máquinas Criadas
    count = 1
    ami           = var.ami["linux"]
    instance_type = var.ami["micro"]

    tags = {
        Name = "srv-jenkins-${count.index}" # Pegar Index da Máquina Criada
    }

    ## Associar Chave de Acesso
    key_name = "key-terraform-aws"

    ## Associar Security Group Acesso SSH
    vpc_security_group_ids = [aws_security_group.acesso-ssh.id, aws_security_group.acesso-http.id]

    user_data = file("scripts/install-jenkins.sh")
      
}

## Servidor Tomcat
resource "aws_instance" "srv-tomcat" {

    # Número de Máquinas Criadas
    count = 2
    ami           = var.ami["linux"]
    instance_type = var.ami["micro"]

    tags = {
        Name = "srv-tomcat-${count.index}" # Pegar Index da Máquina Criada
    }

    ## Associar Chave de Acesso
    key_name = "key-terraform-aws"

    ## Associar Security Group Acesso SSH
    vpc_security_group_ids = [aws_security_group.acesso-ssh.id, aws_security_group.acesso-http.id]

    user_data = file("scripts/install-tomcat.sh")
      
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
    },
     {
      description      = "acesso-http"
      from_port        = 8080
      to_port          = 8080
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

resource "aws_security_group" "acesso-mysql" {
  name        = "acesso-mysql"
  description = "acesso-mysql"
  
  ingress  = [
    {
      description      = "acesso-mysql"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks =  null
      prefix_list_ids   = null
      security_groups   = null
      self              = null
    }]

   egress  = [
    {
      description      = "acesso-mysql-saida"
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
    Name = "acesso-mysql"
  }

}

#Configurar Instância do RS com MySQL
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

  vpc_security_group_ids = [aws_security_group.acesso-mysql.id]

    tags = {
      Name = "servidor-mysql"
    }
}


resource "aws_elb" "load-balance-elb" {
  name               = "projeto-elb"
  availability_zones = ["us-east-1b","us-east-1c","us-east-1a"]
  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
    
  }

  instances                   = [aws_instance.srv-tomcat[0].id, aws_instance.srv-tomcat[1].id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "projeto-elb"
  }
}