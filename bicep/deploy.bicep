param appName string
param location string
param sku string = 'F1'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appName
  location: location
  sku: {
    name: sku
    tier: 'Free'
  }
  properties: {
    numberOfWorkers: 1
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: appName
  location: location
  dependsOn: [
    appServicePlan
  ]
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
      ]
      netFrameworkVersion: 'v6.0'
      use32BitWorkerProcess: false
    }
  }
}

