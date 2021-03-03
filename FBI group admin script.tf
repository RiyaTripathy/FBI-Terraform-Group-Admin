variable "org_name" {}
variable "api_token" {}
variable "base_url" {}

provider "okta" {
    org_name = var.org_name
    base_url = var.base_url
    api_token = var.api_token
  }

  resource "okta_group" "FBIAdmin_group" {
  name        = "FBI Group Admin"
  description = "FBI users with group admin and report admin privileges"
}
data "okta_group" "FBI_groupid" {
  name = "FBI Group Admin"
}
data "okta_group" "FBI_member" {
  name = "FBI Member"
} 
data "okta_group" "FBI_memberadmin" {
  name = "FBI Member Admin"
} 
resource "okta_group_role" "groupadmin_role" {
  group_id = data.okta_group.FBI_groupid.id
  role_type = "GROUP_MEMBERSHIP_ADMIN"
  target_group_list = [data.okta_group.FBI_member.id,data.okta_group.FBI_memberadmin.id]
}
resource "okta_group_role" "reportadmin_role" {
  group_id = data.okta_group.FBI_groupid.id
  role_type = "REPORT_ADMIN"
}

