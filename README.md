# Task Manager

## Overview
Task Manager is a full-stack web application for managing tasks. It consists of:
- **Backend:** ASP.NET Core Web API
- **Frontend:** Angular 19
- **Database:** Azure SQL
- **Deployment:** Azure Web Apps

## Features
### Backend (TaskManagerAPI)
- RESTful API built with ASP.NET 9.
- User authentication and authorization.
- CRUD operations for tasks.
- Integrated with Azure SQL Database.
- CORS configuration for frontend communication.
- Hosted on Azure App Services.

### Frontend (TaskManagerFrontEnd)
- Developed using Angular 19.
- Responsive user interface.
- Task management features (create, update, delete, view tasks).
- Communicates with the backend via HTTP API.
- Deployed on Azure Web Apps.

## Tech Stack
- **Backend:** C# .NET 9, Entity Framework Core, Azure SQL
- **Frontend:** Angular 19, TypeScript, Bootstrap
- **Hosting:** Azure App Service
- **CI/CD:** GitHub Actions


```

## Getting Started
### Prerequisites
- **Node.js 20+** (for Angular frontend)
- **.NET SDK 9.0** (for API)
- **Azure CLI** (for deployment)

### Setup & Run Backend (TaskManagerAPI)
```sh
# Navigate to backend directory
cd TaskManagerAPI

# Restore dependencies
dotnet restore

# Run the application
dotnet run
```
API should be available at `https://localhost:7021/api`.
LIVE API at `https://taskmanagerapi-gfg7hcesd6bkh4ct.southafricanorth-01.azurewebsites.net/`.

### Setup & Run Frontend (TaskManagerFrontEnd)
```sh
# Navigate to frontend directory
cd TaskManagerFrontEnd

# Install dependencies
npm install

# Run frontend app
ng serve
```
Frontend should be available at `http://localhost:4200/`.
LIVE FrontEnd at `https://taskmanagerfrontend-f0akg3d0bkg2ghcs.southafricanorth-01.azurewebsites.net/`.

## Deployment
### **GitHub Actions CI/CD**
This project uses GitHub Actions for continuous deployment to Azure App Service.
#### **Manual Deployment**
1. Push changes to the `main` branch.
2. GitHub Actions will build and deploy the app.
3. Deployment status in **GitHub Actions** tab.

### **Azure Configuration**
**secrets** are set in GitHub repository:
- `AZURE_WEBAPP_PUBLISH_PROFILE` (for API)
- `AZURE_WEBAPP_PUBLISH_PROFILE_FRONTEND` (for frontend)

## Troubleshooting
### CORS Issues
If facing `No 'Access-Control-Allow-Origin' header` errors:
- Ensure the **CORS settings** in Azure allow the frontend URL.
- Check that **CORS is enabled** in `Program.cs`:
```csharp
app.UseCors(policy =>
    policy.WithOrigins("https://taskmanagerapi-gfg7hcesd6bkh4ct.southafricanorth-01.azurewebsites.net")
          .AllowAnyMethod()
          .AllowAnyHeader()
          .AllowCredentials());
```


---
🚀 **y CHOENE.**

