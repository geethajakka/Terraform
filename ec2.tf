resource "random_pet" "sg" {
  
}

resource "aws_vpc" "aws_vpc_demo" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name="vpc_demo"
  }
}

resource "aws_subnet" "aws_subnet_demo" {
    vpc_id = aws_vpc.aws_vpc_demo.id
    cidr_block = "172.16.10.0/24"
    tags = {
      Name="subnet_demo"
    }
}

resource "aws_network_interface" "aws_network_interface_demo" {
  subnet_id = aws_subnet.aws_subnet_demo.id
  private_ip = ["172.16.10.100"]
  tags = {
    Name="network_interface_demo"
  }
}

resource "aws_security_group" "aws_security_group_demo" {
  name = "${random_pet.sg.id}-sg"
  vpc_id = aws_vpc.aws_vpc_demo.id
  ingress = {
    from_port="8080"
    to_port="8080"
    protocol="tcp"
    cidr_block=["0.0.0.0/0"]

  }
}

resource "aws_instance" "aws_ec2_demo" {
  ami = "ami-0d682f26195e9ec0f"
  instance_type = "t2.micro"
  network_interface {
    network_interface_id = aws_network_interface.aws_network_interface_demo.id
    device_index = 0
  }
}