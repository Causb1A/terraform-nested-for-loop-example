locals {
  grant_config = yamldecode(templatefile("role_permissions.yaml", {
    user_role_name  = "user role name"
    admin_role_name = "admin role name"
  }))

  config_privileges = distinct(flatten([
    for each_grant in local.grant_config : [
      for privilege in each_grant.privilege : {
        grant_resource_name = each_grant.grant_resource_name
        role_name           = each_grant.role_name
        privileges          = privilege
      }
  ]]))
}

#grant_config = yamldecode(templatefile("/role_permissions.yaml", {user_role_name  = "user_name", admin_role_name = "admin_name"}))

# distinct(flatten([for each_grant in yamldecode(templatefile("role_permissions.yaml", {user_role_name  = "user_name", admin_role_name = "admin_name"})) : [for privilege in each_grant.privilege : {grant_resource_name = each_grant.grant_resource_name, role_name  = each_grant.role_name, privileges = privilege}]]))
