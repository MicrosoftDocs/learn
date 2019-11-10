#!/bin/bash

# Create the resource group.
az group create \
  --name my-rg \
  --location westus

# Create the app service plan.
az appservice plan create \
  --resource-group my-rg \
  --name my-asp

# Create the app service.
az webapp create \
  --resource-group my-rg \
  --plan my-asp \
  --name my-webapp