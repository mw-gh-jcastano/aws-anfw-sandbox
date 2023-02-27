variable "tags" {
  type        = map(string)
  description = "Map of tags to put on the resource"
  default     = {}
}

#variable "az_ids" {
#  description = "List of Availability Zone Identifiers.  default is \"a\",\"b\",\"c\""
#  type = list(string)
#  default = ["a", "b", "c"]
#}