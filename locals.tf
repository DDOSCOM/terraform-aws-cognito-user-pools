locals {
  supported_identity_providers = flatten([
    "COGNITO",
    var.apple_idp_enabled ? ["SignInWithApple"] : [],
    var.facebook_idp_enabled ? ["Facebook"] : [],
    var.google_idp_enabled ? ["Google"] : []
  ])
}
