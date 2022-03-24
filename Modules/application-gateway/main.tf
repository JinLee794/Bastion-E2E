#User assigned identity to access KeyVault OBO (on behalf of) Application Gateway
resource "azurerm_user_assigned_identity" "managed_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "mi-appgw01-${local.project}-${var.environment}"
}

#RBAC on Application Gateway
resource "azurerm_role_assignment" "managed_identity_appgtw_role" {
  scope                = azurerm_application_gateway.app_gateway.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.managed_identity.principal_id
  depends_on           = [azurerm_user_assigned_identity.managed_identity]
}

#Assign KeyVault access to Managed Identity
resource "azurerm_key_vault_access_policy" "managed_identity_kv_access" {
  key_vault_id = data.azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.managed_identity.principal_id
  secret_permissions = [
    "get", "list"
  ]
  certificate_permissions = [
    "get", "list"
  ]
  storage_permissions = []
  key_permissions     = []
}

resource "azurerm_application_gateway" "app_gateway" {
  name                = var.AppGatewayName
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  sku {
    name = "WAF_v2"
    tier = "WAF_v2"
  }
  autoscale_configuration {
    min_capacity = 1
    max_capacity = 10
  }
  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.subnet5_ID
  }
  ssl_certificate {
    name                = "PublicIpGatewayCert"
    key_vault_secret_id = data.azurerm_key_vault_certificate.appgw01-cert-pfx.secret_id
  }
  frontend_ip_configuration {
    name                 = "appGwPublicFrontendIp"
    public_ip_address_id = var.Public_IP_ID
  }
  frontend_port {
    name = "port_443"
    port = 443
  }
  frontend_port {
    name = "port_80"
    port = 80
  }
  backend_address_pool {
    name = "beap-pdpreact-${local.project}-${var.environment}"
    fqdns = [
      var.pdpreact_fqdn
    ]
  }
  backend_address_pool {
    name = "beap-pdpauthproxy-${local.project}-${var.environment}"
    fqdns = [
      var.pdpauthproxy_fqdn
    ]
  }

  backend_http_settings {
    name                                = "bes-pdpreact-${local.project}-${var.environment}"
    port                                = 443
    protocol                            = "Https"
    cookie_based_affinity               = "Enabled"
    pick_host_name_from_backend_address = true
    affinity_cookie_name                = "ApplicationGatewayAffinity"
    path                                = null
    request_timeout                     = 60
    probe_name                          = "probe-pdpreact-${local.project}-${var.environment}"
  }

  backend_http_settings {
    name                                = "bes-pdpauthproxy-${local.project}-${var.environment}"
    port                                = 443
    protocol                            = "Https"
    cookie_based_affinity               = "Disabled"
    pick_host_name_from_backend_address = true
    affinity_cookie_name                = "ApplicationGatewayAffinity"
    path                                = ""
    request_timeout                     = 60
  }

  http_listener {
    name                           = "fel-ssl-redirect-${local.project}-${var.environment}"
    frontend_ip_configuration_name = "appGwPublicFrontendIp"
    frontend_port_name             = "port_80"
    protocol                       = "Http"
  }
  http_listener {
    name                           = "fel-react-${local.project}-${var.environment}"
    frontend_ip_configuration_name = "appGwPublicFrontendIp"
    frontend_port_name             = "port_443"
    protocol                       = "Https"
    ssl_certificate_name           = "PublicIpGatewayCert"
  }

  url_path_map {
    name                               = "login-session-${local.project}-${var.environment}"
    default_backend_http_settings_name = "bes-pdpreact-${local.project}-${var.environment}"
    default_backend_address_pool_name  = "beap-pdpreact-${local.project}-${var.environment}"
    path_rule {
      name = "login"
      paths = [
        "/login"
      ]
      backend_address_pool_name  = "beap-pdpauthproxy-${local.project}-${var.environment}"
      backend_http_settings_name = "bes-pdpauthproxy-${local.project}-${var.environment}"
    }
  }

  request_routing_rule {
    name                        = "route-redirect-80-443-${local.project}-${var.environment}"
    rule_type                   = "Basic"
    http_listener_name          = "fel-ssl-redirect-${local.project}-${var.environment}"
    redirect_configuration_name = "route-redirect-80-443-${local.project}-${var.environment}"
  }

  request_routing_rule {
    name               = "login-session-${local.project}-${var.environment}"
    rule_type          = "PathBasedRouting"
    http_listener_name = "fel-react-${local.project}-${var.environment}"
    url_path_map_name  = "login-session-${local.project}-${var.environment}"
  }

  probe {
    name                                      = "probe-pdpreact-${local.project}-${var.environment}"
    protocol                                  = "Https"
    path                                      = "/"
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
  }

  redirect_configuration {
    name                 = "route-redirect-80-443-${local.project}-${var.environment}"
    redirect_type        = "Permanent"
    target_listener_name = "fel-react-${local.project}-${var.environment}"
    include_path         = true
    include_query_string = true
  }

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20170401S"
  }

  #WAF configuration replaced with azurerm_web_application_firewall_policy
  #  waf_configuration {
  #    enabled            = true
  #    firewall_mode      = "Prevention"
  #    rule_set_type      = "OWASP"
  #    rule_set_version   = "3.1"
  #    request_body_check = var.request_body_check
  #    disabled_rule_group {
  #      rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
  #      rules           = ["942440"]
  #    }
  #  }

  firewall_policy_id = azurerm_web_application_firewall_policy.wafpolicy.id

  enable_http2 = true
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.managed_identity.id]
  }
}

#generate random to force null resources to trigger every time
resource "random_id" "random" {
  keepers = {
    uuid = uuid()
  }
  byte_length = 8
  depends_on  = [azurerm_application_gateway.app_gateway]
}
resource "null_resource" "default_ssl_policy" {
  triggers = { random = random_id.random.hex }
  provisioner "local-exec" {
    command = "az network application-gateway ssl-policy set --gateway-name ${var.AppGatewayName} --resource-group ${var.resource_group_name} --name AppGwSslPolicy20170401S --policy-type Predefined"
  }
  depends_on = [azurerm_application_gateway.app_gateway]
}

resource "null_resource" "app_gateway_ssl_policy" {
  triggers = { random = random_id.random.hex }
  provisioner "local-exec" {
    command = "az network application-gateway ssl-profile add --gateway-name ${var.AppGatewayName} --resource-group ${var.resource_group_name} --name AppGwSslPolicy20170401S --policy-name AppGwSslPolicy20170401S --policy-type Predefined"
  }
  depends_on = [null_resource.default_ssl_policy, azurerm_application_gateway.app_gateway]
}

resource "null_resource" "http_listener_ssl_policy" {
  triggers = { random = random_id.random.hex }
  provisioner "local-exec" {
    command = "az network application-gateway http-listener update --gateway-name ${var.AppGatewayName} --resource-group ${var.resource_group_name} --name $LISTENER_NAME --set $SSL_PROFILE"
    environment = {
      LISTENER_NAME = "fel-react-${local.project}-${var.environment}"
      SSL_PROFILE   = "sslProfile.id='${azurerm_application_gateway.app_gateway.id}/sslProfiles/AppGwSslPolicy20170401S'"
    }
  }
  depends_on = [null_resource.app_gateway_ssl_policy, azurerm_application_gateway.app_gateway]
}