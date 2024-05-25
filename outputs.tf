output "pool_id" {
  description = "Cognito Pool id"
  value       = resource.aws_cognito_user_pool.this.id
}

output "client_id" {
  description = "Cognito user pool client id"
  value       = resource.aws_cognito_user_pool_client.this.id
}

output "arn" {
  description = "Cognito user pool ARN"
  value       = resource.aws_cognito_user_pool.this.arn
}