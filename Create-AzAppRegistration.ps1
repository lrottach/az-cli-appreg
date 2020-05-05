<#
.SYNOPSIS
  <Creating Azure App Registration>

.DESCRIPTION
  <Create Azure App Registration to onboard customers to SecureScore Export>

.INPUTS
  <Inputs if any, otherwise state None>

.OUTPUTS
  <Application ID and Secret for importing into Azure KeyVault>

.NOTES
  Version:        <0.1>
  Author:         <Lukas Rottach>
  Creation Date:  <05/05/2020>
  Purpose/Change: <Initial script development>
  
.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

# Example 01: Set error action preferences
# Example 02: Import Modules or reference other scripts

#----------------------------------------------------------[Declarations]----------------------------------------------------------

# Example
# Declare Variables in this area
$applicationName = "SecureScore ReadOnly"
$secretIdentifier = "SecureScoreAutomation"


#-----------------------------------------------------------[Functions]------------------------------------------------------------

# Example
# Use this area for writing functions

#-----------------------------------------------------------[Execution]------------------------------------------------------------

# Example
# Use this area for executing functions, commands, ...

# Sign in to Azure tenant
az login --use-device-code

# Creating Azure AD app registration
$applicationId = az ad app create --display-name $applicationName --query appId -o tsv

# Generating application secret
$applicationSecret = az ad app credential reset --id $applicationId --append --years 250 --query password -o tsv

# Assigning required permission to app (SecurityEvents.Read.All)
az ad app permission add --id $applicationId --api 00000003-0000-0000-c000-000000000000 --api-permissions bf394140-e372-4bf9-a898-299cfc7564e5=Role
az ad app permission list --id $applicationId

# Granting permissions to application registration
# az ad app permission grant --id $applicationId --api 00000003-0000-0000-c000-000000000000

# Granting admin consent to api permissions
az ad app permission admin-consent --id $applicationId