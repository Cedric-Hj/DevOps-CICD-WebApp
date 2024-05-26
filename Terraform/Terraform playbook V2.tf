

#############################################################
#                                                           #
#                       EC2 creation                        #
#                                                           #
#############################################################


# Define the AWS provider and specify the region
provider "aws" {
  region = "us-east-1" # Specify your desired region
}

# Use a data source to fetch the current public IP address of the machine running Terraform
data "http" "myip" {
  url = "http://ipinfo.io/ip" # This URL returns the public IP address
}


# Define a security group for the Jenkins server
resource "aws_security_group" "DCHJ_SG" {
  name        = "DCHJ_SG"                # Name of the security group
  description = "Security group for server allowing SSH and HTTP access" # Description of the security group
  vpc_id = aws_vpc.DCHJ_VPC_Fullstack_CICD.id

  # Ingress rule to allow SSH access (port 22) from your IP address
  ingress {
    from_port   = 22                        # Starting port
    to_port     = 22                        # Ending port
    protocol    = "tcp"                     # Protocol type
    cidr_blocks = ["0.0.0.0/0"]  # CIDR block for your IP address
  }

  # Ingress rule to allow HTTP access (port 8080) from your IP address
  ingress {
    from_port   = 8080                      # Starting port
    to_port     = 8080                      # Ending port
    protocol    = "tcp"                     # Protocol type
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"] # CIDR block for your IP address
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

   egress {
    from_port   = 22                        # Starting port
    to_port     = 22                        # Ending port
    protocol    = "tcp"                     # Protocol type
    cidr_blocks = ["0.0.0.0/0"]             # Allow traffic to any IP address
  }
}

# Define the AWS EC2 instance for the Jenkins server
resource "aws_instance" "Servers" {
  ami           = "ami-04b70fa74e45c3917"   # Amazon Linux 2 AMI ID (update as needed)
  instance_type = "t2.micro"                # Instance type eligible for free tier
  key_name      = "Devops_Project_Key_1"  # Key pair name for SSH access
  vpc_security_group_ids = [aws_security_group.DCHJ_SG.id] # Attach the security group to the instance
  subnet_id = aws_subnet.DCHJ_Public_Subnet_01.id
  for_each = toset(["Jenkins_Master", "Jenkins_Slave", "Ansible"])

  tags = {
    Name = "${each.key}"
  }

}
/*
# Output the public IP address of the EC2 instance
output "instance_public_ip" {
  description = "The public IP of the Jenkins server" # Description of the output
  value       = aws_instance.${each.key}.public_ip # Value to output (the public IP address)
}*/
# Output the public IP address of each EC2 instance
output "instance_public_ip" {
  description = "The public IP addresses of the  servers" # Description of the output
  value       = { for server_name, server in aws_instance.Servers : server_name => server.public_ip }
}

# Output the private IP address of each EC2 instance
output "instance_private_ip" {
  description = "The private IP addresses of the servers" # Description of the output
  value       = { for server_name, server in aws_instance.Servers : server_name => server.private_ip }
}

#############################################################
#                                                           #
#                       VPC creation                        #
#                                                           #
#############################################################

# Create a VPC named DCHJ_VPC_Fullstack_CICD
resource "aws_vpc" "DCHJ_VPC_Fullstack_CICD" {
  cidr_block           = "10.0.0.0/16"  # IP range for the VPC
  enable_dns_support   = true  # Enable DNS support within the VPC
  enable_dns_hostnames = true  # Enable DNS hostnames for instances in the VPC

  # Tags are useful for identifying resources
  tags = {
    Name = "DCHJ_VPC_Fullstack_CICD"
  }
}

# Create public subnet 01 within the VPC (Can be copied to create another subnet)
resource "aws_subnet" "DCHJ_Public_Subnet_01" {
  vpc_id                  = aws_vpc.DCHJ_VPC_Fullstack_CICD.id  # Reference the VPC ID dinamicaly
  cidr_block              = "10.0.1.0/24"  # IP range for the subnet
  map_public_ip_on_launch = true  # Automatically assign public IP addresses to instances launched in this subnet
  availability_zone       = "us-east-1a"  # Change to your desired availability zone

  tags = {
    Name = "DCHJ_Public_Subnet_01"
  }
}

#Create public subnet 02 within the VPC
resource "aws_subnet" "DCHJ_Public_Subnet_02" {
  vpc_id                  = aws_vpc.DCHJ_VPC_Fullstack_CICD.id  # Reference the VPC ID dinamicaly
  cidr_block              = "10.0.2.0/24"  # IP range for the subnet
  map_public_ip_on_launch = true  # Automatically assign public IP addresses to instances launched in this subnet
  availability_zone       = "us-east-1b"  # Change to your desired availability zone

  tags = {
    Name = "DCHJ_Public_Subnet_02"
  }
}

/*
# Create a private subnet within the VPC
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.DCHJ_VPC_Fullstack_CICD.id  # Reference the VPC ID
  cidr_block        = "10.0.2.0/24"  # IP range for the subnet
  availability_zone = "us-east-1a"  # Change to your desired availability zone

  tags = {
    Name = "DCHJ_Private_Subnet"
  }
}*/

# Create an internet gateway for the VPC
resource "aws_internet_gateway" "DCHJ_igw" {
  vpc_id = aws_vpc.DCHJ_VPC_Fullstack_CICD.id  # Reference the VPC ID

  tags = {
    Name = "DCHJ_Internet_Gateway"
  }
}

# Create a route table for the public subnet
resource "aws_route_table" "DCHJ_public_rt" {
  vpc_id = aws_vpc.DCHJ_VPC_Fullstack_CICD.id  # Reference the VPC ID

  # Define a route that sends all traffic (0.0.0.0/0) to the internet gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.DCHJ_igw.id  # Reference the internet gateway ID
  }

  tags = {
    Name = "DCHJ_Public_Route_Table"
  }
}

# Associate the public subnet 01 with the public route table
resource "aws_route_table_association" "public_rta_assoc_subnet01" {
  subnet_id      = aws_subnet.DCHJ_Public_Subnet_01.id  # Reference the public subnet ID
  route_table_id = aws_route_table.DCHJ_public_rt.id  # Reference the public route table ID
}

# Associate the public subnet 02 with the public route table
resource "aws_route_table_association" "public_rt_assoc_subnet02" {
  subnet_id      = aws_subnet.DCHJ_Public_Subnet_02.id  # Reference the public subnet ID
  route_table_id = aws_route_table.DCHJ_public_rt.id  # Reference the public route table ID
}
/*
# Create a route table for the private subnet
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.DCHJ_VPC_Fullstack_CICD.id  # Reference the VPC ID

  tags = {
    Name = "DCHJ_Private_Route_Table"
  }
}

# Associate the private subnet with the private route table
resource "aws_route_table_association" "private_rt_assoc" {
  subnet_id      = aws_subnet.private_subnet.id  # Reference the private subnet ID
  route_table_id = aws_route_table.private_rt.id  # Reference the private route table ID
}
*/
