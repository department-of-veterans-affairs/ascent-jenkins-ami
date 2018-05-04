# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "key_name" {
    description = "Desired name of AWS key pair"
}

variable "instance_subnet_id" {
    description = "ID for the subnet to deploy the Nexus server into"
}

variable "env" {
    description = "Environment tag value"
}

variable "vpc_id" {
    description = "VPC ID for the security group"
}


# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "instance_type" {
    description = "The instance type of the instance (t2.micro, m4.large, etc)"
    default     = "m4.large"
}

variable "instance_name" {
    description = "The name for the Name tag of the instance"
    default     = "jenkins-master"
}

variable "san" {
  description = "The name for the SAN tag of the instance"
  default     = "jenkins.internal.vets-api.gov"
}

variable "project_name" {
    description = "The name for the ProjectName tag of the instance"
    default     = "VAEC AWS Gov General Support Service"
}

variable "vaecid" {
    description = "The name for the VAECID tag of the instance"
    default     = "AWG20170915001"
}

variable "ami_id" {
    description = "ID for the AMI to launch the instance as. If left blank, default to the latest AMI named 'ascent-jenkins-master *'"
    default     = ""
}
