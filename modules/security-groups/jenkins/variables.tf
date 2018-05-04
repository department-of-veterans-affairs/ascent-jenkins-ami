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
  default     = "jenkins"
}

variable "description" {
  description = "Description of the security group"
  default     = "Jenkins Server SG"
}

variable "http_access_port" {
  description = "The port for http access"
  default     = "8080"
}

variable "jnlp_access_port" {
  description = "The port for jnlp access"
  default     = "8085"
}

variable "ssh_port" {
  description = "The port for ssh access"
  default     = "22"
}

variable "monitoring_client_port" {
  description = "The port for the monitoring client"
  default     = "9100"
}

variable "allowed_cidr_blocks" {
  description = "List of cidr blocks allowed access to the security group"
  type        = "list"
  default     = ["0.0.0.0/0"]
}

variable "icmp_upper_bound_port" {
  description = "The upper bound port for ICMP connections"
  default     = 0
}

variable "icmp_lower_bound_port" {
  description = "The lower bound port for ICMP connections"
  default     = -1
}
