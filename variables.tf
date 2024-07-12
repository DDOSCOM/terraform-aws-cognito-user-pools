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
  description = "List of attributes to be auto-verified in Cognito"
  type        = list(string)
  default     = []
}


variable "enable_software_token_mfa" {
  description = "Boolean to enable/disable software token MFA configuration"
  type        = bool
  default     = false
}

variable "email_sending_account" {
  description = "Email sending account"
  type        = string
  default     = "DEVELOPER"  # Valor por defecto razonable
}

variable "reply_to_email_address" {
  description = "Reply-to email address"
  type        = string
  default     = "admin@default.com"  # Valor por defecto razonable
}

variable "sms_external_id" {
  description = "SMS external ID"
  type        = string
  default     = ""  # Valor por defecto vacío si es opcional
}

variable "enable_sms_sns" {
  description = "Boolean to enable/disable the creation of the SNS SMS policy"
  type        = bool
  default     = false
}

variable "sms_sns_caller_arn" {
  description = "SNS caller ARN for Cognito SMS configuration"
  type        = string
  default     = null
}

variable "sms_sns_region" {
  description = "SMS SNS region"
  type        = string
  default     = "us-east-1"  # Valor por defecto razonable
}

variable "email_recovery_name" {
  description = "Email recovery mechanism name"
  type        = string
  default     = "verified_email"  # Valor por defecto razonable
}

variable "email_recovery_priority" {
  description = "Email recovery mechanism priority"
  type        = number
  default     = 1  # Valor por defecto razonable
}

variable "phone_number_recovery_name" {
  description = "Phone number recovery mechanism name"
  type        = string
  default     = "verified_phone_number"  # Valor por defecto razonable
}

variable "phone_number_recovery_priority" {
  description = "Phone number recovery mechanism priority"
  type        = number
  default     = 2  # Valor por defecto razonable
}

variable "username_attributes" {
  description = "Username attributes"
  type        = list(string)
  default     = ["email", "phone_number"]  # Valor por defecto razonable
}

variable "username_case_sensitive" {
  description = "Username case sensitive"
  type        = bool
  default     = false  # Valor por defecto razonable
}

variable "password_minimum_length" {
  description = "Password minimum length"
  type        = number
  default     = 8  # Valor por defecto razonable
}

variable "client_name" {
  description = "Client name"
  type        = string
  default     = "default_client"  # Valor por defecto razonable
}

variable "callback_urls" {
  description = "Callback URLs"
  type        = list(string)
  default     = ["http://localhost:3000"]  # Valor por defecto razonable
}

variable "logout_urls" {
  description = "Logout URLs"
  type        = list(string)
  default     = ["http://localhost:3000"]  # Valor por defecto razonable
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"  # Valor por defecto razonable
}

variable "domain" {
  description = "Cognito domain"
  type        = string
  default     = "default.domain.com"  # Valor por defecto razonable
}

variable "certificate_arn" {
  description = "Certificate ARN"
  type        = string
  default     = ""  # Valor por defecto vacío si es opcional
}


variable "route53_zone_id" {
  description = "Route53 zone ID"
  type        = string
}

variable "auth_flows" {
  description = "List of allowed authentication flows"
  type        = list(string)
  default     = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
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
  description = "Enable Facebook IdP"
  type        = bool
  default     = false
}

variable "facebook_id" {
  description = "Facebook client ID"
  type        = string
  default     = ""
}

variable "facebook_secret" {
  description = "Facebook client secret"
  type        = string
  default     = ""
}

variable "google_idp_enabled" {
  description = "Enable Google IdP"
  type        = bool
  default     = false
}

variable "google_id" {
  description = "Google client ID"
  type        = string
  default     = ""
}

variable "google_secret" {
  description = "Google client secret"
  type        = string
  default     = ""
}

variable "apple_idp_enabled" {
  description = "Enable Apple IdP"
  type        = bool
  default     = false
}

variable "apple_service_id" {
  description = "Apple service ID"
  type        = string
  default     = ""
}

variable "apple_team_id" {
  description = "Apple team ID"
  type        = string
  default     = ""
}

variable "apple_key_id" {
  description = "Apple key ID"
  type        = string
  default     = ""
}

variable "apple_private_key_path" {
  description = "Path to Apple private key"
  type        = string
  default     = ""
}
