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
| [aws_cognito_identity_provider.apple](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_provider) | resource |
| [aws_cognito_identity_provider.facebook](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_provider) | resource |
| [aws_cognito_identity_provider.google](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_provider) | resource |
| [aws_cognito_user_pool.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apple_idp_enabled"></a> [apple\_idp\_enabled](#input\_apple\_idp\_enabled) | Enable the Apple Social login integration | `bool` | `false` | no |
| <a name="input_apple_key_id"></a> [apple\_key\_id](#input\_apple\_key\_id) | n/a | `string` | `null` | no |
| <a name="input_apple_private_key_path"></a> [apple\_private\_key\_path](#input\_apple\_private\_key\_path) | n/a | `string` | `null` | no |
| <a name="input_apple_service_id"></a> [apple\_service\_id](#input\_apple\_service\_id) | n/a | `string` | `null` | no |
| <a name="input_apple_team_id"></a> [apple\_team\_id](#input\_apple\_team\_id) | n/a | `string` | `null` | no |
| <a name="input_auth_sms_message"></a> [auth\_sms\_message](#input\_auth\_sms\_message) | n/a | `string` | `"Este código te lo envía {####}"` | no |
| <a name="input_callback_urls"></a> [callback\_urls](#input\_callback\_urls) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | n/a | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_facebook_id"></a> [facebook\_id](#input\_facebook\_id) | n/a | `string` | `null` | no |
| <a name="input_facebook_idp_enabled"></a> [facebook\_idp\_enabled](#input\_facebook\_idp\_enabled) | Enable the Facebook Social login integration | `bool` | `false` | no |
| <a name="input_facebook_secret"></a> [facebook\_secret](#input\_facebook\_secret) | n/a | `string` | `null` | no |
| <a name="input_google_id"></a> [google\_id](#input\_google\_id) | n/a | `string` | `null` | no |
| <a name="input_google_idp_enabled"></a> [google\_idp\_enabled](#input\_google\_idp\_enabled) | Enable the Google Social login integration | `bool` | `false` | no |
| <a name="input_google_secret"></a> [google\_secret](#input\_google\_secret) | n/a | `string` | `null` | no |
| <a name="input_logout_urls"></a> [logout\_urls](#input\_logout\_urls) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Cognito pool name | `string` | n/a | yes |
| <a name="input_post_authentication_lambda"></a> [post\_authentication\_lambda](#input\_post\_authentication\_lambda) | Cognito lambda trigger | `string` | `null` | no |
| <a name="input_post_confirmation_lambda"></a> [post\_confirmation\_lambda](#input\_post\_confirmation\_lambda) | Cognito lambda trigger | `string` | `null` | no |
| <a name="input_pre_sign_up_lambda"></a> [pre\_sign\_up\_lambda](#input\_pre\_sign\_up\_lambda) | Cognito lambda trigger | `string` | `null` | no |
| <a name="input_pre_token_generation_lambda"></a> [pre\_token\_generation\_lambda](#input\_pre\_token\_generation\_lambda) | Cognito lambda trigger | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | n/a | `string` | n/a | yes |
| <a name="input_ses_configuration_arn"></a> [ses\_configuration\_arn](#input\_ses\_configuration\_arn) | n/a | `string` | n/a | yes |
| <a name="input_ses_from_email"></a> [ses\_from\_email](#input\_ses\_from\_email) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_user_migration_lambda"></a> [user\_migration\_lambda](#input\_user\_migration\_lambda) | Cognito lambda trigger | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Cognito user pool ARN |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | Cognito user pool client id |
| <a name="output_pool_id"></a> [pool\_id](#output\_pool\_id) | Cognito Pool id |
<!-- END_TF_DOCS -->