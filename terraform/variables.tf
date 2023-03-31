# I put "this" cnnfiguration in "this" file because this is the only one start with variable
variable "base_cidr_block" {
  description = "default cidr block for vpc"
  default     = "10.0.0.0/16"
}
