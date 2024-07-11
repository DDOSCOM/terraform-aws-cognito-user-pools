variable "name" {
  description = "Cognito pool name"
  type        = string
}

variable "ses_configuration_arn" {
  description = "SES configuration ARN"
  type        = string
}

variable "ses_from_email" {
  description = "From email address for SES"
  type        = string
}

variable "auth_sms_message" {
  description = "Authentication SMS message"
  type        = string
  default     = "Este código te lo envía {####}"
}

variable "html_email_message" {
  description = "Custom HTML email message"
  type        = string
  default     = ""
}

variable "email_verification_subject" {
  description = "Email verification subject"
  type        = string
}

variable "auto_verified_attributes" {
  description = "Auto-verified attributes"
  type        = list(string)
}

variable "email_sending_account" {
  description = "Email sending account"
  type        = string
}

variable "reply_to_email_address" {
  description = "Reply-to email address"
  type        = string
}

variable "sms_external_id" {
  description = "SMS external ID"
  type        = string
}

variable "sms_sns_caller_arn" {
  description = "SNS caller ARN for Cognito SMS configuration"
  type        = string
  default     = null
}

variable "sms_sns_region" {
  description = "SMS SNS region"
  type        = string
}

variable "email_recovery_name" {
  description = "Email recovery mechanism name"
  type        = string
}

variable "email_recovery_priority" {
  description = "Email recovery mechanism priority"
  type        = number
}

variable "phone_number_recovery_name" {
  description = "Phone number recovery mechanism name"
  type        = string
}

variable "phone_number_recovery_priority" {
  description = "Phone number recovery mechanism priority"
  type        = number
}

variable "username_attributes" {
  description = "Username attributes"
  type        = list(string)
}

variable "username_case_sensitive" {
  description = "Username case sensitive"
  type        = bool
}

variable "password_minimum_length" {
  description = "Password minimum length"
  type        = number
}

variable "client_name" {
  description = "Client name"
  type        = string
}

variable "callback_urls" {
  description = "Callback URLs"
  type        = list(string)
}

variable "logout_urls" {
  description = "Logout URLs"
  type        = list(string)
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "domain" {
  description = "Cognito domain"
  type        = string
}

variable "certificate_arn" {
  description = "Certificate ARN"
  type        = string
}

variable "route53_zone_id" {
  description = "Route53 zone ID"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

variable "post_confirmation_lambda" {
  description = "Post confirmation Lambda"
  type        = string
  default     = null
}

variable "pre_token_generation_lambda" {
  description = "Pre token generation Lambda"
  type        = string
  default     = null
}

variable "pre_sign_up_lambda" {
  description = "Pre sign-up Lambda"
  type        = string
  default     = null
}

variable "post_authentication_lambda" {
  description = "Post authentication Lambda"
  type        = string
  default     = null
}

variable "user_migration_lambda" {
  description = "User migration Lambda"
  type        = string
  default     = null
}

variable "facebook_idp_enabled" {
  description = "Enable Facebook IDP"
  type        = bool
  default     = false
}

variable "facebook_id" {
  description = "Facebook ID"
  type        = string
  default     = null
}

variable "facebook_secret" {
  description = "Facebook secret"
  type        = string
  default     = null
}

variable "google_idp_enabled" {
  description = "Enable Google IDP"
  type        = bool
  default     = false
}

variable "google_id" {
  description = "Google ID"
  type        = string
  default     = null
}

variable "google_secret" {
  description = "Google secret"
  type        = string
  default     = null
}

variable "apple_idp_enabled" {
  description = "Enable Apple IDP"
  type        = bool
  default     = false
}

variable "apple_service_id" {
  description = "Apple service ID"
  type        = string
  default     = null
}

variable "apple_team_id" {
  description = "Apple team ID"
  type        = string
  default     = null
}

variable "apple_key_id" {
  description = "Apple key ID"
  type        = string
  default     = null
}

variable "apple_private_key_path" {
  description = "Apple private key path"
  type        = string
  default     = null
}
