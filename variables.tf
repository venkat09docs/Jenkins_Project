variable "aws_region_name" {
    type = string
    default = "ap-southeast-1"  
}

variable "jenkins_sg_ports" {
  type = list(number)
  default = [ 22, 80, 8080 ]
}

variable "sg_cidr" {
  default = ["0.0.0.0/0"]
}

variable "instance_type" {
    default = "t2.micro"
}

variable "Key_pair_name" {
  default = "server_key"
}

variable "jenkins_master_node_tags" {
  type = map
  default = {
    Name = "Master Node",
    Env  = "Dev"
  }
}

variable "jenkins_slave_node_tags" {
  type = map
  default = {
    Name = "Build Server",
    Env  = "Dev"
  }
}

variable "master_userdata_script" {
  default = "./scripts/master_setup.sh"
}

variable "slave_userdata_script" {
  default = "./scripts/slave_setup.sh"
}