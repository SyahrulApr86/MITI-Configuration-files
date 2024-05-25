FROM nextcloud:latest

# Set fixed environment variables
ENV MYSQL_DATABASE=nextclouddb \
    MYSQL_USER=databaseuser

# Set environment variables from build arguments
ARG MYSQL_PASSWORD
ARG MYSQL_HOST
ARG NEXTCLOUD_ADMIN_USER
ARG NEXTCLOUD_ADMIN_PASSWORD
ARG NEXTCLOUD_TRUSTED_DOMAINS

RUN echo "MYSQL_PASSWORD=${MYSQL_PASSWORD}" && \
    echo "MYSQL_HOST=${MYSQL_HOST}" && \
    echo "NEXTCLOUD_ADMIN_USER=${NEXTCLOUD_ADMIN_USER}" && \
    echo "NEXTCLOUD_ADMIN_PASSWORD=${NEXTCLOUD_ADMIN_PASSWORD}" && \
    echo "NEXTCLOUD_TRUSTED_DOMAINS=${NEXTCLOUD_TRUSTED_DOMAINS}"

ENV MYSQL_PASSWORD=${MYSQL_PASSWORD} \
    MYSQL_HOST=${MYSQL_HOST} \
    NEXTCLOUD_ADMIN_USER=${NEXTCLOUD_ADMIN_USER} \
    NEXTCLOUD_ADMIN_PASSWORD=${NEXTCLOUD_ADMIN_PASSWORD} \
    NEXTCLOUD_TRUSTED_DOMAINS=${NEXTCLOUD_TRUSTED_DOMAINS}

# Copy scripts to the image
COPY update_ip.sh /usr/local/bin/update_ip.sh
COPY add_trusted_domain.php /usr/local/bin/add_trusted_domain.php
COPY custom_entrypoint.sh /custom_entrypoint.sh

# Give execute permissions on the scripts
RUN chmod +x /usr/local/bin/update_ip.sh
RUN chmod +x /usr/local/bin/add_trusted_domain.php
RUN chmod +x /custom_entrypoint.sh

# Set the new custom entrypoint
ENTRYPOINT ["/custom_entrypoint.sh"]
