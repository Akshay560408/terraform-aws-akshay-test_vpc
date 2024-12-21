variable "vpc_config" {
  description = "To get the CIDR and Name of VPC from user"
  type = object({
    cidr_block = string
    name       = string
  })
  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid CIDR format"
  }
}

variable "subnet_config" {
  description = "Get the CIDR block and AZ for creating subnet/s"
  type = map(object({
    cidr_block = string
    az = string
    public = optional(bool, false)
  }))
  validation {
    condition = alltrue([for config in var.subnet_config: can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid CIDR format"
  }
  
}