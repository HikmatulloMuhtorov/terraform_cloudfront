variable "env" {
    type = string
    description = "Current environment"
    default = "dev"
}
variable "project" {
    type = string
    description = "Name of the project"
    default = "s3-Cloudfront"
}

variable "region" {
    type = string
    description = "Current Region"
    default = "us-east-1"
}

variable "stage" {
    type = string
    description = "Current Stage"
    default = "Dev"
}

variable "zone_id" {
    type = string
    description = "Hosted Zone ID"
    default = "Z07081532T0NKBK6PLAGV"
}