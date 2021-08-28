variable  "ami" {
    type = map
    default = {
        "linux" = "ami-09e67e426f25ce0d7"
        "micro" = "t2.micro"
    }
}