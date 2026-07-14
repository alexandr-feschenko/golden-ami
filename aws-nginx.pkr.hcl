packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}
source "amazon-ebs" "hw-packer" {
  region = "eu-north-1"
  instance_type = "t3.micro"
  ami_name = "packer-hw-{{timestamp}}"
  ssh_username = "ec2-user"
  source_ami_filter {
    most_recent = true
    owners = ["137112412989"]
    filters = {
      root-device-type = "ebs"
      name = "al2023-ami-2023.*-x86_64"
      virtualization-type = "hvm"
    }
  }
}
build {
  sources = [
    "source.amazon-ebs.hw-packer"
  ]
  provisioner "file" {
    source = "scripts/index.html"
    destination = "/tmp/index.html"
  }
  provisioner "shell" {
    scripts = ["scripts/install-nginx.sh"]
  }
}
