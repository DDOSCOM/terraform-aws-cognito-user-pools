resource "aws_iam_role" "cognito_sms_role" {
  name = "sns-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cognito-idp.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    "Name" = "sns-role"
  }
}

resource "aws_iam_role_policy" "cognito_sms_policy" {
  name   = "cognito_sms_policy"
  role   = aws_iam_role.cognito_sms_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "sns:Publish"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_cognito_user_pool" "this" {
  name = var.name

  sms_authentication_message = var.auth_sms_message
  email_verification_message = var.html_email_message == "" ? var.auth_sms_message : var.html_email_message
  email_verification_subject = var.email_verification_subject
  mfa_configuration          = var.mfa_configuration

  admin_create_user_config {
    allow_admin_create_user_only = var.allow_admin_create_user_only
  }

  software_token_mfa_configuration {
    enabled = var.software_token_mfa_enabled
  }

  auto_verified_attributes = var.auto_verified_attributes
  # alias_attributes         = var.alias_attributes

  device_configuration {
    challenge_required_on_new_device      = var.device_challenge_required_on_new_device
    device_only_remembered_on_user_prompt = var.device_only_remembered_on_user_prompt
  }

  email_configuration {
    email_sending_account  = var.email_sending_account
    reply_to_email_address = var.reply_to_email_address
    source_arn             = var.ses_configuration_arn
    from_email_address     = var.ses_from_email
  }

  sms_configuration {
    external_id    = var.sms_external_id
    sns_caller_arn = aws_iam_role.cognito_sms_role.arn
    sns_region     = var.sms_sns_region
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
    require_lowercase = var.password_require_lowercase
    require_uppercase = var.password_require_uppercase
    require_symbols   = var.password_require_symbols
    require_numbers   = var.password_require_numbers
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
  name                                 = var.client_name
  user_pool_id                         = aws_cognito_user_pool.this.id
  callback_urls                        = var.callback_urls
  logout_urls                          = var.logout_urls
  supported_identity_providers         = local.supported_identity_providers
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = var.allowed_oauth_flows
  allowed_oauth_scopes                 = var.allowed_oauth_scopes
  id_token_validity                    = var.id_token_validity
  access_token_validity                = var.access_token_validity
  generate_secret                      = var.generate_secret
  token_validity_units {
    access_token  = var.token_validity_units_access_token
    id_token      = var.token_validity_units_id_token
    refresh_token = var.token_validity_units_refresh_token
  }
  explicit_auth_flows = var.explicit_auth_flows
}

resource "aws_cognito_identity_pool" "this" {
  identity_pool_name               = aws_cognito_user_pool.this.name
  allow_unauthenticated_identities = var.allow_unauthenticated_identities
  allow_classic_flow               = var.allow_classic_flow

  cognito_identity_providers {
    client_id     = aws_cognito_user_pool_client.this.id
    provider_name = "cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool.this.id}"
  }
}
