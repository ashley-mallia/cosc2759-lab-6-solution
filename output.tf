output "lb_endpoint" {
  value = aws_lb.todo_app.dns_name
}

output "db_endpoint" {
  value = aws_rds_cluster.postgresql.endpoint
}

output "db_user" {
  value = aws_rds_cluster.postgresql.master_username
}

output "db_pass" {
  value = aws_rds_cluster.postgresql.master_password
  sensitive = true
}
