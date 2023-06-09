# I put "this" cnnfiguration in "this" file because this is for ec-2 instance creation
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical, the publisher of Ubuntu AMIs
}


resource "aws_key_pair" "local_key" {
  key_name   = "AWS_Key"
  public_key = file("~/.ssh/as4_key.pub")
}

resource "aws_instance" "ubuntu" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.ubuntu.id
  for_each = toset(["web", "app"])
  
  tags = {
    Name = "ubuntu-${each.value}"
    Server = "${each.key}-server"
  }

  key_name               = aws_key_pair.local_key.id
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id              = aws_subnet.main.id

  root_block_device {
    volume_size = 10
  }
}
