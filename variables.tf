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

variable "mfa_configuration" {
  description = "MFA configuration"
  type        = string
}

variable "allow_admin_create_user_only" {
  description = "Allow only admin to create users"
  type        = bool
}

variable "software_token_mfa_enabled" {
  description = "Enable software token MFA"
  type        = bool
}

variable "auto_verified_attributes" {
  description = "Auto-verified attributes"
  type        = list(string)
}

variable "alias_attributes" {
  description = "Alias attributes"
  type        = list(string)
}

variable "device_challenge_required_on_new_device" {
  description = "Challenge required on new device"
  type        = bool
}

variable "device_only_remembered_on_user_prompt" {
  description = "Only remembered on user prompt"
  type        = bool
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
  description = "SMS SNS caller ARN"
  type        = string
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

variable "password_require_lowercase" {
  description = "Password require lowercase"
  type        = bool
}

variable "password_require_uppercase" {
  description = "Password require uppercase"
  type        = bool
}

variable "password_require_symbols" {
  description = "Password require symbols"
  type        = bool
}

variable "password_require_numbers" {
  description = "Password require numbers"
  type        = bool
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

variable "client_name" {
  description = "Client name"
  type        = string
}

variable "callback_urls" {
  description = "Callback URLs"
  type        = list(string)
  default     = [""]
}

variable "logout_urls" {
  description = "Logout URLs"
  type        = list(string)
  default     = [""]
}

variable "allowed_oauth_flows" {
  description = "Allowed OAuth flows"
  type        = list(string)
}

variable "allowed_oauth_scopes" {
  description = "Allowed OAuth scopes"
  type        = list(string)
}

variable "id_token_validity" {
  description = "ID token validity"
  type        = number
}

variable "access_token_validity" {
  description = "Access token validity"
  type        = number
}

variable "generate_secret" {
  description = "Generate secret"
  type        = bool
}

variable "token_validity_units_access_token" {
  description = "Token validity units for access token"
  type        = string
}

variable "token_validity_units_id_token" {
  description = "Token validity units for ID token"
  type        = string
}

variable "token_validity_units_refresh_token" {
  description = "Token validity units for refresh token"
  type        = string
}

variable "explicit_auth_flows" {
  description = "Explicit auth flows"
  type        = list(string)
}

variable "allow_unauthenticated_identities" {
  description = "Allow unauthenticated identities"
  type        = bool
}

variable "allow_classic_flow" {
  description = "Allow classic flow"
  type        = bool
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
