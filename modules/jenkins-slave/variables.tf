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

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "instance_type" {
  description = "The instance type of the instance (t2.micro, m4.large, etc)"
  default     = "m4.4xlarge"
}

variable "tags" {
  description = "List fo extra tag blocks added to the instance. Each element in the list is a map containing keys 'key', 'value', and 'propagate_at_launch' mapped to the respective values."
  type        = "list"
  default     = []
}

variable "ssh_key_name" {
  description = "The name of an EC2 Key Pair that can be used to SSH to the EC2 Instances in this swarm. Set to an empty string to not associate a Key Pair."
  default     = ""
}

variable "ssh_port" {
  description = "The port for ssh access"
  default     = "22"
}

variable "api_port" {
  description = "The port for docker api"
  default     = "2375"
}

variable "user_data" {
  description = "Instance initialization script"
  default     = ""
}
