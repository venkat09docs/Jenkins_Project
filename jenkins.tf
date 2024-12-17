data "aws_ami" "amazon_linux_ami" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "jenkinsserver_sg" {
  name        = "jenkins_sg"
  description = "Allow SSH, Jenkins Port and HTTP inbound traffic and all outbound traffic"
  # vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_ssh_jenkins_http"
  }

  dynamic "ingress" {
        for_each = var.jenkins_sg_ports
        content {
            from_port   = ingress.value
            to_port     = ingress.value
            protocol    = "tcp"
            cidr_blocks = var.sg_cidr
        }
    }   

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.sg_cidr    
  }
}

resource "aws_instance" "master_server" {
  
  ami           = data.aws_ami.amazon_linux_ami.id 
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkinsserver_sg.id]
  key_name      = var.Key_pair_name  
  user_data = file(var.master_userdata_script)
  tags = var.jenkins_master_node_tags
}

resource "aws_instance" "slave_server" {
  
  ami           = data.aws_ami.amazon_linux_ami.id 
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkinsserver_sg.id]
  key_name      = var.Key_pair_name  
  user_data = file(var.slave_userdata_script)
  tags = var.jenkins_slave_node_tags
}