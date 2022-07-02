resource "snowflake_schema_grant" "grant" {
  for_each          = { for entry in local.config_privileges : "${entry.grant_resource_name}.${entry.role_name}.${entry.privileges}" => entry }
  database_name     = var.database_name
  schema_name       = var.schema_name
  privilege         = each.privilege
  roles             = [each.role_name]
  with_grant_option = false
}