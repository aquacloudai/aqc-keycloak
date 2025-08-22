# Use the official Keycloak image
FROM quay.io/keycloak/keycloak:latest

# Copy your custom theme into the container
COPY keycloak-themes/your-org-theme /opt/keycloak/themes/your-org-theme

# Optional: Set permissions (if needed)
USER root
RUN chown -R keycloak:keycloak /opt/keycloak/themes/your-org-theme
USER keycloak

# Optional: Environment variables for production
ENV KC_DB=postgres
ENV KC_DB_URL=<your-db-url>
ENV KC_DB_USERNAME=<your-db-user>
ENV KC_DB_PASSWORD=<your-db-password>
ENV KC_HOSTNAME=<your-hostname>

# For production, use start instead of start-dev
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized"]