# Terraform Cognito User Pools

## Description

This is a Lightweight terraform module to deploy a base stable versión of a Cognito User Pool and a Cognito Identity Pool

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 1.1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cognito_identity_pool.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_pool) | resource |
| [aws_cognito_user_pool.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apple_idp_enabled"></a> [apple\_idp\_enabled](#input\_apple\_idp\_enabled) | Enable Apple IDP | `bool` | `false` | no |
| <a name="input_apple_key_id"></a> [apple\_key\_id](#input\_apple\_key\_id) | Apple key ID | `string` | `null` | no |
| <a name="input_apple_private_key_path"></a> [apple\_private\_key\_path](#input\_apple\_private\_key\_path) | Apple private key path | `string` | `null` | no |
| <a name="input_apple_service_id"></a> [apple\_service\_id](#input\_apple\_service\_id) | Apple service ID | `string` | `null` | no |
| <a name="input_apple_team_id"></a> [apple\_team\_id](#input\_apple\_team\_id) | Apple team ID | `string` | `null` | no |
| <a name="input_auth_sms_message"></a> [auth\_sms\_message](#input\_auth\_sms\_message) | Authentication SMS message | `string` | `"Este código te lo envía {####}"` | no |
| <a name="input_auto_verified_attributes"></a> [auto\_verified\_attributes](#input\_auto\_verified\_attributes) | Auto-verified attributes | `list(string)` | n/a | yes |
| <a name="input_callback_urls"></a> [callback\_urls](#input\_callback\_urls) | Callback URLs | `list(string)` | n/a | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | Certificate ARN | `string` | n/a | yes |
| <a name="input_client_name"></a> [client\_name](#input\_client\_name) | Client name | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | Cognito domain | `string` | n/a | yes |
| <a name="input_email_recovery_name"></a> [email\_recovery\_name](#input\_email\_recovery\_name) | Email recovery mechanism name | `string` | n/a | yes |
| <a name="input_email_recovery_priority"></a> [email\_recovery\_priority](#input\_email\_recovery\_priority) | Email recovery mechanism priority | `number` | n/a | yes |
| <a name="input_email_sending_account"></a> [email\_sending\_account](#input\_email\_sending\_account) | Email sending account | `string` | n/a | yes |
| <a name="input_email_verification_subject"></a> [email\_verification\_subject](#input\_email\_verification\_subject) | Email verification subject | `string` | n/a | yes |
| <a name="input_enable_sms_sns"></a> [enable\_sms\_sns](#input\_enable\_sms\_sns) | Boolean to enable/disable the creation of the SNS SMS policy | `bool` | `false` | no |
| <a name="input_facebook_id"></a> [facebook\_id](#input\_facebook\_id) | Facebook ID | `string` | `null` | no |
| <a name="input_facebook_idp_enabled"></a> [facebook\_idp\_enabled](#input\_facebook\_idp\_enabled) | Enable Facebook IDP | `bool` | `false` | no |
| <a name="input_facebook_secret"></a> [facebook\_secret](#input\_facebook\_secret) | Facebook secret | `string` | `null` | no |
| <a name="input_google_id"></a> [google\_id](#input\_google\_id) | Google ID | `string` | `null` | no |
| <a name="input_google_idp_enabled"></a> [google\_idp\_enabled](#input\_google\_idp\_enabled) | Enable Google IDP | `bool` | `false` | no |
| <a name="input_google_secret"></a> [google\_secret](#input\_google\_secret) | Google secret | `string` | `null` | no |
| <a name="input_html_email_message"></a> [html\_email\_message](#input\_html\_email\_message) | Custom HTML email message | `string` | `""` | no |
| <a name="input_logout_urls"></a> [logout\_urls](#input\_logout\_urls) | Logout URLs | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Cognito pool name | `string` | n/a | yes |
| <a name="input_password_minimum_length"></a> [password\_minimum\_length](#input\_password\_minimum\_length) | Password minimum length | `number` | n/a | yes |
| <a name="input_phone_number_recovery_name"></a> [phone\_number\_recovery\_name](#input\_phone\_number\_recovery\_name) | Phone number recovery mechanism name | `string` | n/a | yes |
| <a name="input_phone_number_recovery_priority"></a> [phone\_number\_recovery\_priority](#input\_phone\_number\_recovery\_priority) | Phone number recovery mechanism priority | `number` | n/a | yes |
| <a name="input_post_authentication_lambda"></a> [post\_authentication\_lambda](#input\_post\_authentication\_lambda) | Post authentication Lambda | `string` | `null` | no |
| <a name="input_post_confirmation_lambda"></a> [post\_confirmation\_lambda](#input\_post\_confirmation\_lambda) | Post confirmation Lambda | `string` | `null` | no |
| <a name="input_pre_sign_up_lambda"></a> [pre\_sign\_up\_lambda](#input\_pre\_sign\_up\_lambda) | Pre sign-up Lambda | `string` | `null` | no |
| <a name="input_pre_token_generation_lambda"></a> [pre\_token\_generation\_lambda](#input\_pre\_token\_generation\_lambda) | Pre token generation Lambda | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_reply_to_email_address"></a> [reply\_to\_email\_address](#input\_reply\_to\_email\_address) | Reply-to email address | `string` | n/a | yes |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | Route53 zone ID | `string` | n/a | yes |
| <a name="input_ses_configuration_arn"></a> [ses\_configuration\_arn](#input\_ses\_configuration\_arn) | SES configuration ARN | `string` | n/a | yes |
| <a name="input_ses_from_email"></a> [ses\_from\_email](#input\_ses\_from\_email) | From email address for SES | `string` | n/a | yes |
| <a name="input_sms_external_id"></a> [sms\_external\_id](#input\_sms\_external\_id) | SMS external ID | `string` | n/a | yes |
| <a name="input_sms_sns_caller_arn"></a> [sms\_sns\_caller\_arn](#input\_sms\_sns\_caller\_arn) | SNS caller ARN for Cognito SMS configuration | `string` | `null` | no |
| <a name="input_sms_sns_region"></a> [sms\_sns\_region](#input\_sms\_sns\_region) | SMS SNS region | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(string)` | `{}` | no |
| <a name="input_user_migration_lambda"></a> [user\_migration\_lambda](#input\_user\_migration\_lambda) | User migration Lambda | `string` | `null` | no |
| <a name="input_username_attributes"></a> [username\_attributes](#input\_username\_attributes) | Username attributes | `list(string)` | n/a | yes |
| <a name="input_username_case_sensitive"></a> [username\_case\_sensitive](#input\_username\_case\_sensitive) | Username case sensitive | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Cognito user pool ARN |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | Cognito user pool client id |
| <a name="output_pool_id"></a> [pool\_id](#output\_pool\_id) | Cognito Pool id |
