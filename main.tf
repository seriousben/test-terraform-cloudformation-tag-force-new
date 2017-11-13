provider "aws" {
  region  = "us-east-1"
  profile = "perso"
}

resource "aws_key_pair" "main" {
  key_name = "main"

  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_cloudformation_stack" "hello-world" {
  name = "hello-world"

  parameters {
    ManagerSize          = 1
    ClusterSize          = 1
    EnableCloudWatchLogs = "no"
    EnableCloudStorEfs   = "no"
    KeyName              = "${aws_key_pair.main.key_name}"
  }

  tags {
    Tag = "initial value"
  }

  capabilities  = ["CAPABILITY_IAM"]
  template_body = "${file("cloudformation.tmpl")}"
}
