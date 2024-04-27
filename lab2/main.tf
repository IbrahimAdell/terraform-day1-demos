provider "aws" {
  profile = "default"
  region = "us-east-1"
}

# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "NTI-VPC"
  }
}


# Create internet gateway 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "NTI-IGW"
  }
}

# Create subnet
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "NTI-subnet"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "NTI-RT"
  }
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

# Create security group for EC2 instances
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "NTI_sg"
  }
}

# Launch EC2 instance in the public subnet
resource "aws_instance" "ec2_instance" {
  ami         		        = "ami-080e1f13689e07408"
  instance_type 		= "t2.micro"
  associate_public_ip_address   = true
  subnet_id    			= aws_subnet.subnet.id
  vpc_security_group_ids 	= [aws_security_group.ec2_sg.id]  
  tags = {
      Name = "NTI-ec2"
    } 
  user_data = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
EOF
}


#Create CloudWatch dashboard to monitor the EC2 performance CPU,Memory
resource "aws_cloudwatch_dashboard" "ec2_dashboard" {
  dashboard_name = "NTI-dashboard"
  dashboard_body = <<-JSON
  {
    "widgets": [
      {
        "type": "metric",
        "x": 0,
        "y": 0,
        "width": 6,
        "height": 6,
        "properties": {
          "metrics": [
            ["AWS/EC2", "CPUUtilization", "InstanceId", "${aws_instance.ec2_instance.id}"]
          ],
          "region": "us-east-1",
          "title": "EC2 Metrics",
          "period": 300
        }
      }
    ]
  }
  JSON
}

#Create SNS to send mail
resource "aws_sns_topic" "cloudwatch_sns_topic" {
  name = "NTI-sns"
}

#Configure SNS 
resource "aws_sns_topic_subscription" "cloudwatch_sns_subscription" {
  topic_arn = aws_sns_topic.cloudwatch_sns_topic.arn
  protocol  = "email"
  endpoint  = "ibrahimadel1010@gmail.com"
}

#Set CloudWatch alarm for cpu
resource "aws_cloudwatch_metric_alarm" "ec2_cpu_alarm" {
  alarm_name          = "NTIe-EC2CPUMetricAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "Alarm when CPU utilization is greater than 70% for 2 periods"

  dimensions = {
    InstanceId = aws_instance.ec2_instance.id
  }

  alarm_actions = [aws_sns_topic.cloudwatch_sns_topic.arn]
}

resource "aws_s3_bucket" "s3-remote-state" {
  bucket = "ntis3bucket1"
  tags = {
    Name   = "NTI-bucket"
  } 
   
}

resource "aws_s3_bucket_versioning" "enable"{
  bucket = aws_s3_bucket.s3-remote-state.id
  versioning_configuration {
      status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "NTIe-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}

#terraform {
 #   backend "s3" {
  #      bucket         = "NTI-remote-statefile"
   #     key            = "terraform.tfstate"
    #    region         = "us-east-1"
     #   dynamodb_table = "NTI-locks"
   #     encrypt        = true
    #}
#}

