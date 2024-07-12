resource "aws_cognito_user_pool" "this" {
  name = var.name

  sms_authentication_message = var.auth_sms_message
  email_verification_message = var.html_email_message == "" ? var.auth_sms_message : var.html_email_message
  email_verification_subject = var.email_verification_subject

  auto_verified_attributes = var.auto_verified_attributes

  dynamic "software_token_mfa_configuration" {
    for_each = var.enable_software_token_mfa ? [1] : []
    content {
      enabled = true
    }
  }

  email_configuration {
    email_sending_account  = var.email_sending_account
    reply_to_email_address = var.reply_to_email_address
    source_arn             = var.ses_configuration_arn
    from_email_address     = var.ses_from_email
  }

  dynamic "sms_configuration" {
    for_each = var.enable_sms_sns ? [1] : []
    content {
      external_id    = var.sms_external_id
      sns_caller_arn = var.sms_sns_caller_arn
      sns_region     = var.sms_sns_region
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
    minimum_length = var.password_minimum_length
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = false
    string_attribute_constraints {
      min_length = 1
      max_length = 50
    }
  }

  schema {
    name                     = "name"
    attribute_data_type      = "String"
    required                 = false
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
    required                 = false
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
    key_id           = var.apple_key_id
    private_key      = file(var.apple_private_key_path)
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
  domain          = var.domain
  user_pool_id    = aws_cognito_user_pool.this.id
  certificate_arn = var.certificate_arn
}

resource "aws_route53_record" "this" {
  zone_id = var.route53_zone_id
  name    = var.domain
  type    = "CNAME"
  ttl     = 10
  records = [aws_cognito_user_pool_domain.this.cloudfront_distribution_arn]
}

resource "aws_cognito_user_pool_client" "this" {
  depends_on = [
    aws_cognito_user_pool_domain.this
  ]
  name                                 = var.client_name
  user_pool_id                         = aws_cognito_user_pool.this.id
  callback_urls                        = var.callback_urls
  logout_urls                          = var.logout_urls
  supported_identity_providers         = local.supported_identity_providers

  explicit_auth_flows = var.auth_flows
}


resource "aws_cognito_identity_pool" "this" {
  identity_pool_name = aws_cognito_user_pool.this.name
  allow_unauthenticated_identities = false
  allow_classic_flow               = false

  cognito_identity_providers {
    client_id     = aws_cognito_user_pool_client.this.id
    provider_name = "cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool.this.id}"
  }
}
