# Exibir Informações na Saida do Console
output "servidor-public-address-0" {
    value = aws_instance.servidor-apache[0].public_dns  
}

output "servidor-public-ip-0" {
    value = aws_instance.servidor-apache[0].public_ip
}

output "servidor-public-address-1" {
    value = aws_instance.servidor-apache[1].public_dns  
}

output "servidor-public-ip-1" {
    value = aws_instance.servidor-apache[1].public_ip
}

output "associate_public_ip_address" {
    value = aws_instance.servidor-apache[0].associate_public_ip_address
}