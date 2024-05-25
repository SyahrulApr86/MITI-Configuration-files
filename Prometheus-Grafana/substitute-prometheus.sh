#!/bin/bash

# Load environment variables from .env file
set -o allexport
source ../.env
set +o allexport

# Substitute variables in prometheus.yml.template and create prometheus.yml
envsubst < ./prometheus/prometheus.yml.template > ./prometheus/prometheus.yml
