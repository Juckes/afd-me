# Taken from afd-module
resource "azurerm_cdn_frontdoor_profile" "profile" {
  name                = var.name # link this to the environment too so read dev.frontdoor...

  resource_group_name = var.resource_group_name
  # resource_group_name = data.azurerm_resource_group.current.name
  sku_name            = var.sku_name # sku_name = "${title(var.tier)}_AzureFrontDoor"

  tags = merge(
    local.common_tags,
    # var.additional_tags_all,
    # var.additional_tags
  )
}

# ---------
# Endpoints
# ---------
resource "azurerm_cdn_frontdoor_endpoint" "endpoints" {
  for_each = var.endpoints

  name                     = each.key
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.profile.id
  enabled                  = each.value.enabled

  tags = merge(
    local.common_tags,
    # var.additional_tags_all,
    # each.value.additional_tags
  )
}



# data "azurerm_resource_group" "current" {
#   name = var.azure.resource_group_name
# }
