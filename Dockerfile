ARG LWT_VERSION=25.10.0

FROM php:8.3-apache-bookworm

ARG LWT_VERSION

LABEL org.opencontainers.image.title="Learning With Texts" \
      org.opencontainers.image.description="LWT — language learning through reading, packaged from the SourceForge release" \
      org.opencontainers.image.url="https://sourceforge.net/projects/learning-with-texts/" \
      org.opencontainers.image.version="${LWT_VERSION}"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        unzip \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_mysql mysqli

# Allow .htaccess overrides required by LWT
RUN a2enmod rewrite \
    && printf '<Directory /var/www/html>\n\tOptions Indexes FollowSymLinks\n\tAllowOverride All\n\tRequire all granted\n</Directory>\n' \
       > /etc/apache2/conf-available/lwt.conf \
    && a2enconf lwt

# Download and unpack LWT from SourceForge
RUN curl -fsSL -o /tmp/lwt.zip \
        "https://sourceforge.net/projects/learning-with-texts/files/learning-with-texts-${LWT_VERSION}.zip/download" \
    && unzip -q /tmp/lwt.zip -d /tmp/lwt-extract \
    && TOP=$(find /tmp/lwt-extract -mindepth 1 -maxdepth 1 -type d | head -1) \
    && cp -rT "$TOP" /var/www/html/ \
    && rm -rf /tmp/lwt-extract /tmp/lwt.zip

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh \
    && chown -R www-data:www-data /var/www/html

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
