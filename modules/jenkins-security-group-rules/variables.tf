# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "security_group_id" {
  description = "The id for the security group to add these rules to"
}

variable "allowed_cidr_blocks" {
  description = "List of cidr blocks allowed access to the security group"
  type        = "list"
  default     = []
}

variable "allowed_security_groups" {
  description = "List of security groups allowed access to the security group"
  type        = "list"
  default     = []
}


# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "http_access_port" {
  description = "The port for http access"
  default     = "8080"
}

variable "ssh_port" {
  description = "The port for ssh access"
  default     = "22"
}