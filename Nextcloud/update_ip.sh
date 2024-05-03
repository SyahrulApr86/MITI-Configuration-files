#!/bin/bash
echo "Starting update_ip.sh script..."

# Wait until the config.php file is available
while [ ! -f /var/www/html/config/config.php ]
do
  echo "Waiting for config.php to be created..."
  sleep 10
done
echo "config.php found."

# Get external IP
EXTERNAL_IP=$(curl -s http://icanhazip.com)
echo "External IP obtained: $EXTERNAL_IP"

sleep 5

# Call PHP script to add the IP to trusted domains
OUTPUT=$(php /usr/local/bin/add_trusted_domain.php $EXTERNAL_IP)
echo "PHP Script Output: $OUTPUT"

# Run Apache in foreground
echo "Starting Apache..."
exec apache2-foreground
