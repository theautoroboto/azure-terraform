# limit short_name to <= 8 characters to allow for 4 char hex randomizer
env_short_name         = "azfog"
location               = "centralus"

##############################
##  CONTRACTS               ##
##  These are items which   ##
##  we are fully dependent  ##
##  upon and represent an   ##
##  agreement set forth     ##
##  with a 'provider'.      ##
##############################

# az account list --query "[?contains(name,'whatever')].{Name:name,SubID:id}" -o tsv
# az account list --query "[?contains(name,'whatever') || contains(name,'something')].[name,id,tenantId]" -o table
subscription_id     = ""
tenant_id           = ""

# env_name makes up a large part of the resources created by this script, but also
# represents the prefix of our pre-defined resource group (i.e. env_name-rg1).
env_name              = ""

# az ad group list --query "[?contains(displayName,'PCF')].displayName" -o tsv
# the owner variable is used as the group name to be given ownership RBAC to the resultant resource group
owner                 = ""

# pcf_spoke_vnet              = ""
# pcf_spoke_resource_group    = ""
pcf_spoke_vnet              = ""
pcf_spoke_resource_group    = ""
