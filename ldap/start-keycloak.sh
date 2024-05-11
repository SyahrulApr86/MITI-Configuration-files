#!/bin/bash

# Start Keycloak in development mode
/opt/keycloak/bin/kc.sh start-dev --http-relative-path / &
pid=$!

# Give Keycloak some time to start
sleep 60

# Retry logic for kcadm.sh
until /opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080 --realm master --user $KEYCLOAK_ADMIN --password $KEYCLOAK_ADMIN_PASSWORD; do
  echo "Retrying kcadm.sh config credentials..."
  sleep 5
done

/opt/keycloak/bin/kcadm.sh update realms/master -s sslRequired=NONE

# Wait for Keycloak process to exit
wait $pid
