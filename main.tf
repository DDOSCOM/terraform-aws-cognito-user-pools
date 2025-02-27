resource "aws_cognito_user_pool" "this" {
  name = var.name # This value is mandatory and must be provided to define the Cognito pool name.

  sms_authentication_message = var.auth_sms_message
  email_verification_message = var.html_email_message == "" ? var.auth_sms_message : var.html_email_message
  email_verification_subject = var.email_verification_subject # This value is mandatory and defines the subject line for email verification messages.

  auto_verified_attributes = var.auto_verified_attributes

  dynamic "software_token_mfa_configuration" {
    for_each = var.enable_software_token_mfa ? [1] : []
    content {
      enabled = true
    }
  }

  email_configuration {
    email_sending_account  = var.email_sending_account
    reply_to_email_address = var.reply_to_email_address # This value is mandatory and must be provided to ensure proper SES configuration
    source_arn             = var.ses_configuration_arn  # This value is mandatory for configuring the SES integration with Cognito.
    from_email_address     = var.ses_from_email         # This value is mandatory and specifies the "From" email address for SES.
  }

  dynamic "sms_configuration" {
    for_each = var.enable_sms_sns ? [1] : []
    content {
      external_id    = var.sms_external_id
      sns_caller_arn = var.sms_sns_caller_arn # This value is mandatory when SMS SNS is enabled for Cognito.
      sns_region     = var.aws_region         # This value is mandatory and defines the AWS region where resources will be deployed.
    }
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = var.email_recovery_name
      priority = var.email_recovery_priority
    }
    recovery_mechanism {
      name     = var.phone_number_recovery_name
      priority = var.phone_number_recovery_priority
    }
  }

  username_attributes = var.username_attributes
  username_configuration {
    case_sensitive = var.username_case_sensitive
  }

  password_policy {
    minimum_length    = var.password_minimum_length
    require_lowercase = var.require_lowercase
    require_uppercase = var.require_uppercase
    require_symbols   = var.require_symbols
    require_numbers   = var.require_numbers
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = var.default_attribute_required
    string_attribute_constraints {
      min_length = 1
      max_length = 50
    }
  }

  schema {
    name                     = "name"
    attribute_data_type      = "String"
    required                 = var.default_attribute_required
    mutable                  = true
    developer_only_attribute = false
    string_attribute_constraints {
      min_length = 3
      max_length = 2048
    }
  }

  schema {
    name                     = "given_name"
    attribute_data_type      = "String"
    required                 = true
    mutable                  = true
    developer_only_attribute = false
    string_attribute_constraints {
      min_length = 3
      max_length = 2048
    }
  }

  schema {
    name                     = "family_name"
    attribute_data_type      = "String"
    required                 = true
    mutable                  = true
    developer_only_attribute = false
    string_attribute_constraints {
      min_length = 3
      max_length = 2048
    }
  }

  schema {
    name                     = "org"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = var.default_attribute_required
    developer_only_attribute = false
    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }

  lambda_config {
    post_confirmation    = var.post_confirmation_lambda
    pre_token_generation = var.pre_token_generation_lambda
    pre_sign_up          = var.pre_sign_up_lambda
    post_authentication  = var.post_authentication_lambda
    user_migration       = var.user_migration_lambda
  }

  tags = var.tags
}

resource "aws_cognito_identity_provider" "facebook" {
  count         = var.facebook_idp_enabled ? 1 : 0
  user_pool_id  = aws_cognito_user_pool.this.id
  provider_name = "Facebook"
  provider_type = "Facebook"
  provider_details = {
    client_id        = var.facebook_id
    client_secret    = var.facebook_secret
    authorize_scopes = "public_profile,email"
  }
  attribute_mapping = {
    username    = "id"
    email       = "email"
    name        = "name"
    given_name  = "given_name"
    family_name = "family_name"
  }
}

resource "aws_cognito_identity_provider" "google" {
  count         = var.google_idp_enabled ? 1 : 0
  user_pool_id  = aws_cognito_user_pool.this.id
  provider_name = "Google"
  provider_type = "Google"
  provider_details = {
    client_id        = var.google_id
    client_secret    = var.google_secret
    authorize_scopes = "profile email openid"
  }
  attribute_mapping = {
    username    = "sub"
    email       = "email"
    name        = "name"
    given_name  = "given_name"
    family_name = "family_name"
  }
}

resource "aws_cognito_identity_provider" "apple" {
  count         = var.apple_idp_enabled ? 1 : 0
  user_pool_id  = aws_cognito_user_pool.this.id
  provider_name = "SignInWithApple"
  provider_type = "SignInWithApple"
  provider_details = {
    client_id        = var.apple_service_id
    team_id          = var.apple_team_id
    key_id           = var.apple_key_id      # This value is mandatory when enabling SignInWithApple for the Cognito user pool.
    private_key      = var.apple_private_key # This value is mandatory and specifies the path to the Apple private key for SignInWithApple.
    authorize_scopes = "email name"
  }

  attribute_mapping = {
    username    = "sub"
    email       = "email"
    name        = "name"
    given_name  = "firstName"
    family_name = "lastName"
  }
}

resource "aws_cognito_user_pool_domain" "this" {
  count = var.domain == "" ? 0 : 1

  domain          = var.domain # This value is mandatory and specifies the custom domain for the Cognito user pool.
  user_pool_id    = aws_cognito_user_pool.this.id
  certificate_arn = var.certificate_arn # This value is mandatory when using a custom domain with Route53 for the Cognito user pool.
}

resource "aws_route53_record" "this" {
  count   = var.domain == "" ? 0 : 1
  zone_id = var.route53_zone_id # This value is mandatory and specifies the Route53 zone ID for DNS configuration.
  name    = var.domain          # This value is mandatory and specifies the custom domain for the Cognito user pool.
  type    = "CNAME"
  ttl     = 10
  records = [aws_cognito_user_pool_domain.this[0].cloudfront_distribution]
}

resource "aws_cognito_user_pool_client" "this" {
  depends_on = [
    aws_cognito_user_pool_domain.this
  ]
  name                         = var.client_name
  user_pool_id                 = aws_cognito_user_pool.this.id
  callback_urls                = var.callback_urls
  logout_urls                  = var.logout_urls
  supported_identity_providers = local.supported_identity_providers

  explicit_auth_flows = distinct(concat(
    ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"],
    var.auth_flows
  ))

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = var.allowed_oauth_flows
  allowed_oauth_scopes                 = var.allowed_oauth_scopes
  id_token_validity                    = var.id_token_validity
  access_token_validity                = var.access_token_validity
  refresh_token_validity               = var.refresh_token_validity
  generate_secret                      = var.generate_secret

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}

resource "aws_cognito_identity_pool" "this" {
  identity_pool_name               = aws_cognito_user_pool.this.name
  allow_unauthenticated_identities = false
  allow_classic_flow               = false

  cognito_identity_providers {
    client_id     = aws_cognito_user_pool_client.this.id
    provider_name = "cognito-idp.${var.aws_region}.amazonaws.com/${aws_cognito_user_pool.this.id}"
  }
}
