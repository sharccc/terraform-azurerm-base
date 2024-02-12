terraform {
  required_providers {
    azurerm = {
      version = ">= 3.0.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}
}

variable "sample_name" {
  description = "unique name as resource identifier suffixed with resource type"
  default     = "sharccc"
}

#TODO find the link to the regions with region ids
variable "location" {
  description = "location for the resource group https://learn.microsoft.com/en-us/rest/api/resources/subscriptions/list-locations"
  default     = "Australia SouthEast"
}

variable "tag_owner" {
  description = "email address of the owner of the resources to include as tagging"
  default     = "nobody@nowhere.com"
}

locals {
  tags = {
    owner = var.tag_owner
    base  = "https://github.com/sharccc/terraform-azurerm-base"
  }
}

resource "azurerm_resource_group" "sample" {
  name     = join("-", [var.sample_name, "rg"])
  location = var.location
  tags     = merge(local.tags)
}