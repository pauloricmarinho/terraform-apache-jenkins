variable  "ami" {
    type = map
    default = {
        "linux" = "ami-0747bdcabd34c712a"
        "micro" = "t2.micro"
    }
}