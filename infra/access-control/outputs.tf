output "users" {
  value = module.access_control.users
}

output "groups" {
  value = module.access_control.groups
}

output "ci-user" {
  value = local.ci_user
}
