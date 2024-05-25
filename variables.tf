variable "name" {
  description = "Cognito pool name"
  type        = string
}

variable "ses_configuration_arn" {
  type = string
}

variable "ses_from_email" {
  type = string
}

variable "auth_sms_message" {
  type    = string
  default = "Este código te lo envía {####}"
}

variable "domain" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "region" {
  type = string
}

variable "callback_urls" {
  type    = list(string)
  default = [""]
}

variable "logout_urls" {
  type    = list(string)
  default = [""]
}

variable "route53_zone_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "post_confirmation_lambda" {
  description = "Cognito lambda trigger"
  type        = string
  default     = null
}

variable "pre_token_generation_lambda" {
  description = "Cognito lambda trigger"
  type        = string
  default     = null
}

variable "pre_sign_up_lambda" {
  description = "Cognito lambda trigger"
  type        = string
  default     = null
}

variable "post_authentication_lambda" {
  description = "Cognito lambda trigger"
  type        = string
  default     = null
}

variable "user_migration_lambda" {
  description = "Cognito lambda trigger"
  type        = string
  default     = null
}

variable "facebook_idp_enabled" {
  description = "Enable the Facebook Social login integration"
  type        = bool
  default     = false
}

variable "facebook_id" {
  type    = string
  default = null
}

variable "facebook_secret" {
  type    = string
  default = null
}

variable "google_idp_enabled" {
  description = "Enable the Google Social login integration"
  type        = bool
  default     = false
}

variable "google_id" {
  type    = string
  default = null
}

variable "google_secret" {
  type    = string
  default = null
}

variable "apple_idp_enabled" {
  description = "Enable the Apple Social login integration"
  type        = bool
  default     = false
}

variable "apple_service_id" {
  type    = string
  default = null
}

variable "apple_team_id" {
  type    = string
  default = null
}

variable "apple_key_id" {
  type    = string
  default = null
}

variable "apple_private_key_path" {
  type    = string
  default = null
}

variable "html_email_message" {
  description = "Custom HTML email file route"
  type        = string
  default     = ""
}
