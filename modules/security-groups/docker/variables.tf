# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "vpc_id" {
  description = "The VPC id for the security group"
}


# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "name" {
  description = "Name of the security group"
  default     = "jenkins-docker-slave"
}

variable "description" {
  description = "Description of the security group"
  default     = "Security Group for Docker node running Jenkins slaves"
}

variable "ssh_port" {
  description = "The port for ssh access"
  default     = "22"
}

variable "jenkins_unencrypted_port" {
  description = "Port for unencrypted traffic from jenkins"
  default     = "2375"
}

variable "jenkins_encrypted_port" {
  description = "Port for encrypted traffic from jenkins"
  default     = "2376"
}

variable "allowed_cidr_blocks" {
  description = "List of cidr blocks allowed access to the security group"
  type        = "list"
  default     = ["0.0.0.0/0"]
}
