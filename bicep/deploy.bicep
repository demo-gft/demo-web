param appName string
param location string
param sku string = 'B1'
param netFrameworkVersion string = 'v6.0'
param runtimeStack string = 'DOTNETCORE|6.0'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: '${appName}-plan'
  location: location
  kind: 'linux'
  sku: {
    name: sku
    tier: 'Basic'
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: appName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_DOTNET_VERSION'
          value: netFrameworkVersion
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: runtimeStack
        }
      ]
    }
  }
}
