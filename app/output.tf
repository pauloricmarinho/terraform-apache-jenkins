# Exibir Informações na Saida do Console
output "JENKINS-public-address-0" {
    value = aws_instance.srv-jenkins[0].public_dns  
}

output "JENKINS-public-ip-0" {
    value = aws_instance.srv-jenkins[0].public_ip
}

output "TOMCAT-public-address-1" {
    value = aws_instance.srv-tomcat[0].public_dns  
}

output "TOMCAT-public-ip-1" {
    value = aws_instance.srv-tomcat[0].public_ip
}


output "TOMCAT-public-address-2" {
    value = aws_instance.srv-tomcat[1].public_dns  
}

output "TOMCAT-public-ip-2" {
    value = aws_instance.srv-tomcat[1].public_ip
}