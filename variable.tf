variable "region" {
    description = "aws region"
    default     = "us-east-1"
    type        = string
}

variable "instance_type" {
    description = "ec2 instance type"
    default     = "t2.micro"
    type        = string 
}