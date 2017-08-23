FROM vantienvnn/laravel5-docker-build:latest

# Apply Nginx configuration
RUN apt-get update \
    && apt-get install postgresql postgresql-contrib \
    && apt-get remove nodejs -y
    && touch /init-start.sh && rm -f /init-start.sh \
    && chsh -s /bin/bash jenkins

# run install nodejs 7
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - \
    && apt-get install -y nodejs

ADD config/init-start.sh /init-start.sh
RUN chmod +x /init-start.sh
# Default command
ENTRYPOINT ["/init-start.sh"]
