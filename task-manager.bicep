// Azure Resource Group
param location string = 'southafricanorth'
param resourceGroupName string = 'TaskManagerRG'

// SQL Database Parameters
param sqlServerName string = 'taskmanagersqlserver'
param sqlAdminUser string = 'adminuser'
param sqlAdminPassword string = 'YourStrongP@ssw0rd'
param sqlDbName string = 'TaskManagerDB'

// App Service Parameters
param apiAppName string = 'TaskManagerAPI'
param appServicePlanName string = 'TaskManagerPlan'

// Static Web App (Frontend)
param frontendAppName string = 'TaskManagerUI'

// Create the Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

// Create the SQL Server
resource sqlServer 'Microsoft.Sql/servers@2022-02-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlAdminUser
    administratorLoginPassword: sqlAdminPassword
  }
  dependsOn: [ rg ]
}

// Create the SQL Database (Basic Tier)
resource sqlDatabase 'Microsoft.Sql/servers/databases@2022-02-01-preview' = {
  parent: sqlServer
  name: sqlDbName
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
  }
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
}

// Create the App Service Plan (Free Tier)
resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    tier: 'Free'
    name: 'F1'
  }
  dependsOn: [ rg ]
}

// Create the Web App (API)
resource apiApp 'Microsoft.Web/sites@2021-02-01' = {
  name: apiAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
  dependsOn: [ appServicePlan ]
}

// Configure the Connection String for API
resource apiConfig 'Microsoft.Web/sites/config@2021-02-01' = {
  parent: apiApp
  name: 'web'
  properties: {
    connectionStrings: [
      {
        name: 'DefaultConnection'
        value: 'Server=tcp:${sqlServerName}.database.windows.net,1433;Database=${sqlDbName};User ID=${sqlAdminUser}@${sqlServerName};Password=${sqlAdminPassword};Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
        type: 'SQLAzure'
      }
    ]
  }
}

// Create Static Web App for Frontend (Free Tier)
resource frontendApp 'Microsoft.Web/staticSites@2021-02-01' = {
  name: frontendAppName
  location: location
  properties: {
    sku: {
      name: 'Free'
    }
  }
  dependsOn: [ rg ]
}
