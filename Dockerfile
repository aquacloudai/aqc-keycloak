# Use the official Keycloak image
FROM quay.io/keycloak/keycloak:latest

# Copy your custom theme into the container
COPY keycloak-themes/aquacloud /opt/keycloak/themes/aquacloud

# Optional: Set permissions (if needed)
USER root
RUN chown -R keycloak:keycloak /opt/keycloak/themes/aquacloud
USER keycloak

# The environment variables and startup command are handled by docker-compose
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]