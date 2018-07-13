# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "ami_id" {
  description = "The ID of the AMI for the Jenkins Master instance."
}

variable "subnet_id" {
  description = "ID for the subnet to deploy the Nexus server into"
}

variable "vpc_id" {
  description = "VPC ID for the security group"
}

variable "name" {
  description = "unique name to give this instance"
}

variable "allowed_inbound_cidr_blocks" {
  description = "List of cidr blocks allowed access to the security group"
  type        = "list"
  default     = []
}

variable "allowed_inbound_security_groups" {
  description = "List of security groups allowed access to the security group"
  type        = "list"
  default     = []
}

variable "jenkins_slave_security_groups" {
  description = "List of security groups to allow access to Jenkins slave ports"
  type        = "list"
  default     = []
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "instance_type" {
  description = "The instance type of the instance (t2.micro, m4.large, etc)"
  default     = "m4.large"
}

variable "ssh_key_name" {
  description = "The name of an EC2 Key Pair that can be used to SSH to the EC2 Instances in this swarm. Set to an empty string to not associate a Key Pair."
  default     = ""
}

variable "http_access_port" {
  description = "The port for http access"
  default     = "8080"
}

variable "ssh_port" {
  description = "The port for ssh access"
  default     = "22"
}

variable "jnlp_access_port" {
  description = "The port for jnlp access"
  default     = "8085"
}

variable "user_data" {
  description = "Instance initialization script"
  default     = ""
}

variable "tags" {
  description = "Tags to apply to the EC2 instance. Name will be applied by default."
  type        = "map"
  default     = {}
}
