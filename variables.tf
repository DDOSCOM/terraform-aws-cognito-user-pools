variable "name" {
  description = "Cognito pool name"
  type        = string
  default     = ""
}

variable "ses_configuration_arn" {
  description = "SES configuration ARN"
  type        = string
  default     = ""
}

variable "ses_from_email" {
  description = "From email address for SES"
  type        = string
  default     = ""
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
  default     = ""
}

variable "auto_verified_attributes" {
  description = "List of attributes to be auto-verified in Cognito"
  type        = list(string)
  default     = ["email", "phone_number"]
}


variable "enable_software_token_mfa" {
  description = "Boolean to enable/disable software token MFA configuration"
  type        = bool
  default     = false
}

variable "email_sending_account" {
  description = "Email sending account"
  type        = string
  default     = "COGNITO_DEFAULT"
}

variable "reply_to_email_address" {
  description = "Reply-to email address"
  type        = string
  default     = ""
}

variable "sms_external_id" {
  description = "SMS external ID"
  type        = string
  default     = ""
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

variable "email_recovery_name" {
  description = "Email recovery mechanism name"
  type        = string
  default     = "verified_email"
}

variable "email_recovery_priority" {
  description = "Email recovery mechanism priority"
  type        = number
  default     = 1
}

variable "phone_number_recovery_name" {
  description = "Phone number recovery mechanism name"
  type        = string
  default     = "verified_phone_number"
}

variable "phone_number_recovery_priority" {
  description = "Phone number recovery mechanism priority"
  type        = number
  default     = 2
}

variable "username_attributes" {
  description = "Username attributes"
  type        = list(string)
  default     = ["email", "phone_number"]
}

variable "username_case_sensitive" {
  description = "Username case sensitive"
  type        = bool
  default     = false
}

variable "password_minimum_length" {
  description = "Password minimum length"
  type        = number
  default     = 8
}

variable "client_name" {
  description = "Client name"
  type        = string
  default     = "default-service-client"
}

variable "callback_urls" {
  description = "Callback URLs"
  type        = list(string)
  default     = ["http://localhost:3000"]
}

variable "logout_urls" {
  description = "Logout URLs"
  type        = list(string)
  default     = ["http://localhost:3000"]
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "domain" {
  description = "Cognito domain"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "Certificate ARN"
  type        = string
  default     = ""
}


variable "route53_zone_id" {
  description = "Route53 zone ID"
  type        = string
  default     = ""
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
  default     = "null"
}

variable "facebook_secret" {
  description = "Facebook client secret"
  type        = string
  default     = "null"
}

variable "google_idp_enabled" {
  description = "Enable Google IdP"
  type        = bool
  default     = false
}

variable "google_id" {
  description = "Google client ID"
  type        = string
  default     = "null"
}

variable "google_secret" {
  description = "Google client secret"
  type        = string
  default     = "null"
}

variable "apple_idp_enabled" {
  description = "Enable Apple IdP"
  type        = bool
  default     = false
}

variable "apple_service_id" {
  description = "Apple service ID"
  type        = string
  default     = "null"
}

variable "apple_team_id" {
  description = "Apple team ID"
  type        = string
  default     = "null"
}

variable "apple_key_id" {
  description = "Apple key ID"
  type        = string
  default     = "null"
}

variable "apple_private_key" {
  description = "Path to Apple private key"
  type        = string
  default     = "null"
}

variable "allowed_oauth_flows" {
  description = "List of allowed OAuth flows"
  type        = list(string)
  default     = ["code", "implicit"]
}

variable "allowed_oauth_scopes" {
  description = "List of allowed OAuth scopes"
  type        = list(string)
  default     = ["email", "openid", "profile"]
}

variable "id_token_validity" {
  description = "Validity duration for ID tokens (in minutes)"
  type        = number
  default     = 60
}

variable "access_token_validity" {
  description = "Validity duration for Access tokens (in minutes)"
  type        = number
  default     = 60
}

variable "refresh_token_validity" {
  description = "Validity duration for Refresh tokens (in days)"
  type        = number
  default     = 30
}

variable "generate_secret" {
  description = "Whether to generate a secret for the client"
  type        = bool
  default     = false
}

variable "require_lowercase" {
  description = "Determines if lowercase characters are required in the password policy"
  type        = bool
  default     = false
}

variable "require_uppercase" {
  description = "Determines if uppercase characters are required in the password policy"
  type        = bool
  default     = false
}

variable "require_symbols" {
  description = "Determines if symbols are required in the password policy"
  type        = bool
  default     = false
}

variable "require_numbers" {
  description = "Determines if numbers are required in the password policy"
  type        = bool
  default     = false
}

variable "default_attribute_required" {
  description = "Valor por defecto para el atributo 'required' en los esquemas de Cognito."
  type        = bool
  default     = false
}
