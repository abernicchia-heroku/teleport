FROM heroku/heroku:24 AS base

USER root

# Remove /bin/sh and link to bash shell if needed
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install teleport
COPY install-teleport.sh /tmp/install-teleport.sh
RUN sh /tmp/install-teleport.sh && rm -f /tmp/install-teleport.sh

# Create and switch to non-root user for security
RUN useradd -m -s /bin/bash teleport

# Final stage
FROM base

USER root

# Copy the start-teleport.sh script
COPY start-teleport.sh /start-teleport.sh
RUN chmod +x /start-teleport.sh

# Copy the teleport-template.yaml file
COPY teleport-template.yaml /teleport-template.yaml

USER teleport

CMD ["/start-teleport.sh"]
