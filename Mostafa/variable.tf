variable my-region {
        type = string
        default = "us-east-1"
}
variable my-access-key {}
variable my-secret-key {}
variable vpc_CIDR {
    type  = string
    default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
    type = list(string)
    default = [ "10.0.0.0/20", "10.0.16.0/20", "10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20" ]
}

variable "public_subnet_cidr_block_1" {
    type = string
    default = "10.0.0.0/20"
}

variable "public_subnet_cidr_block_2" {
    type = string
    default = "10.0.16.0/20"
}

variable "private_subnet_cidr_block_1" {
    type = string
    default = "10.0.128.0/20"
}

variable "private_subnet_cidr_block_2" {
    type = string
    default = "10.0.144.0/20"
}

variable "private_subnet_cidr_block_3" {
    type = string
    default = "10.0.160.0/20"
}

variable "private_subnet_cidr_block_4" {
    type = string
    default = "10.0.176.0/20"
}
