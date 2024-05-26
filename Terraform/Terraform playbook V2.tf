# Define the AWS provider and specify the region
provider "aws" {
  region = "us-east-1" # Specify your desired region
}

# Use a data source to fetch the current public IP address of the machine running Terraform
data "http" "my_ip" {
  url = "http://ipinfo.io/ip" # This URL returns the public IP address
}


# Define a security group for the Jenkins server
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"                # Name of the security group
  description = "Security group for Jenkins server allowing SSH and HTTP access" # Description of the security group

  # Ingress rule to allow SSH access (port 22) from your IP address
  ingress {
    from_port   = 22                        # Starting port
    to_port     = 22                        # Ending port
    protocol    = "tcp"                     # Protocol type
    cidr_blocks = ["${chomp(data.http.my_ip.body)}/32"] # CIDR block for your IP address
  }

  # Ingress rule to allow HTTP access (port 8080) from your IP address
  ingress {
    from_port   = 8080                      # Starting port
    to_port     = 8080                      # Ending port
    protocol    = "tcp"                     # Protocol type
    cidr_blocks = ["${chomp(data.http.my_ip.body)}/32"] # CIDR block for your IP address
  }

  # Egress rule to allow outbound HTTP traffic (port 80)
  egress {
    from_port   = 80                        # Starting port
    to_port     = 80                        # Ending port
    protocol    = "tcp"                     # Protocol type
    cidr_blocks = ["0.0.0.0/0"]             # Allow traffic to any IP address
  }

  # Egress rule to allow outbound HTTPS traffic (port 443)
  egress {
    from_port   = 443                       # Starting port
    to_port     = 443                       # Ending port
    protocol    = "tcp"                     # Protocol type
    cidr_blocks = ["0.0.0.0/0"]             # Allow traffic to any IP address
  }

  # Egress rule to allow outbound DNS traffic (port 53) over UDP
  egress {
    from_port   = 53                        # Starting port
    to_port     = 53                        # Ending port
    protocol    = "udp"                     # Protocol type
    cidr_blocks = ["0.0.0.0/0"]             # Allow traffic to any IP address
  }
}

# Define the AWS EC2 instance for the Jenkins server
resource "aws_instance" "jenkins_server" {
  ami           = "ami-0bb84b8ffd87024d8"   # Amazon Linux 2 AMI ID (update as needed)
  instance_type = "t2.micro"                # Instance type eligible for free tier
  key_name      = "Devops_Project_Key_1"  # Key pair name for SSH access
  
  tags = {
    Name = "Jenkins_Server_Via_Terraform"   # Tag to identify the instance
  }

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id] # Attach the security group to the instance
}

# Output the public IP address of the EC2 instance
output "instance_public_ip" {
  description = "The public IP of the Jenkins server" # Description of the output
  value       = aws_instance.jenkins_server.public_ip # Value to output (the public IP address)
}