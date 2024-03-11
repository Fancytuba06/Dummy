#vpc 
variable "vpc_Name" {
   type = string
   description = "vpc name"
}

#vpc ip
variable "vpc_cidr_block" {
   type = string
   description = "vpc ip"
} 

#pubsubnet
variable "pub_sub_Name" {
   type = string
   description = "pubulic subnet"
} 

#prisubnet
variable "pri_sub_Name" {
   type = string
   description = "private subnet"
} 


variable "igtw_Name" {
   type = string
   description = "internetgateway"
} 

variable "irt_Name" {
   type = string
   description = "route table"
} 


