ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

LABEL \
    io.hass.name="Obico ML" \
    io.hass.description="Home Assistant Community Add-on: Obico ML" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    io.hass.base.version=${BUILD_VERSION} \
    io.hass.base.name="obico-ml" \
    maintainer="Poltavtcev" \
    org.opencontainers.image.title="Obico ML" \
    org.opencontainers.image.description="Home Assistant Community Add-on: Obico ML" \
    org.opencontainers.image.source="https://github.com/Poltavtcev/hassio-koinsight" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

# Expose port and run the server
EXPOSE 3333
CMD ["bash", "-c", "gunicorn --bind 0.0.0.0:3333 --workers 1 --timeout 120 wsgi"]