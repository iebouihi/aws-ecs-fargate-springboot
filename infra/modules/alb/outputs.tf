output "dns_name" {
  value = aws_lb.this.dns_name
}

output "security_group_id" {
  value = aws_security_group.alb.id
}

output "target_group_arn" {
  value = aws_lb_target_group.app.arn
  # ECS rejects a target group that is not yet attached to a load balancer,
  # so consumers of this output wait for the listener.
  depends_on = [aws_lb_listener.http]
}

output "listener_arn" {
  value = aws_lb_listener.http.arn
}

output "arn_suffix" {
  value = aws_lb.this.arn_suffix
}

output "target_group_arn_suffix" {
  value = aws_lb_target_group.app.arn_suffix
}
