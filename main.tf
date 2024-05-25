resource "aws_cognito_user_pool" "this" {
  name = var.name

  sms_authentication_message = var.auth_sms_message
  email_verification_message = var.auth_sms_message
  email_verification_subject = "Código de verificación"
  mfa_configuration          = "OPTIONAL"

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  software_token_mfa_configuration {
    enabled = true
  }

  auto_verified_attributes = ["email"]

  device_configuration {
    challenge_required_on_new_device      = true
    device_only_remembered_on_user_prompt = false
  }

  email_configuration {
    email_sending_account = "DEVELOPER"
    source_arn            = var.ses_configuration_arn
    from_email_address    = var.ses_from_email
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 2
    }

    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 1
    }
  }

  username_attributes = ["email"]
  username_configuration {
    case_sensitive = false
  }

  password_policy {
    minimum_length    = 6
    require_lowercase = false
    require_uppercase = false
    require_symbols   = false
    require_numbers   = false
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true
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
    private_key      = var.apple_private_key_path
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
  name                                 = "client"
  user_pool_id                         = aws_cognito_user_pool.this.id
  callback_urls                        = var.callback_urls
  logout_urls                          = var.logout_urls
  supported_identity_providers         = local.supported_identity_providers
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  id_token_validity                    = 60
  access_token_validity                = 60
  generate_secret                      = false
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
  ]
}

resource "aws_cognito_identity_pool" "this" {
  identity_pool_name               = aws_cognito_user_pool.this.name
  allow_unauthenticated_identities = false
  allow_classic_flow               = false

  cognito_identity_providers {
    client_id     = aws_cognito_user_pool_client.this.id
    provider_name = "cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool.this.id}"
  }
}
