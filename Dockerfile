FROM heroku/heroku:24

USER root

# Remove /bin/sh and link to bash shell if needed
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install teleport
COPY install-teleport.sh /tmp/install-teleport.sh
RUN sh /tmp/install-teleport.sh && rm -f /tmp/install-teleport.sh

# Copy the start-teleport.sh script
COPY start-teleport.sh /start-teleport.sh
RUN chmod +x /start-teleport.sh

# Copy the teleport-template.yaml file
COPY teleport-template.yaml /teleport-template.yaml

# Create and switch to non-root user for security
RUN useradd -m -s /bin/bash teleport
USER teleport

# this ARG can be overridden changing the heroku.yml, it must be 'latest' or a dot-separated number (e.g. 2.320.1)
# https://devcenter.heroku.com/articles/build-docker-images-heroku-yml#set-build-time-environment-variables
#ARG RUNNER_VERSION=latest

# Run the image as a non-root user
#RUN adduser -D myuser
#USER myuser

CMD ["/start-teleport.sh"]
