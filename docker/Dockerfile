#Galaxy - SNVPhyl
FROM bgruening/galaxy-stable:20.05

MAINTAINER Aaron Petkau, aaron.petkau@gmail.com

ENV GALAXY_CONFIG_BRAND SNVPhyl v1.2.0 (Galaxy 20.05)

WORKDIR /galaxy-central

RUN sed -i -e 's/#\( *allow_path_paste:\).*/\1 True/' /etc/galaxy/galaxy.yml

# Install SNVPhyl
ADD ./galaxy/snvphyl-tools.yml $GALAXY_ROOT/snvphyl-tools.yml
RUN install-tools $GALAXY_ROOT/snvphyl-tools.yml \
      && /tool_deps/_conda/bin/conda clean --packages -t -i \
      && rm -rf /tmp/* /root/.cache/ /var/cache/* $GALAXY_ROOT/client/node_modules/ $GALAXY_VIRTUAL_ENV/src/ /home/galaxy/.cache/ /home/galaxy/.npm

# Install workflows
ADD ./galaxy/install-workflows /usr/bin/install-workflows
RUN chmod +x /usr/bin/install-workflows
ADD ./galaxy/snvphyl-workflow-1.2.0.ga /tmp/snvphyl-workflow-1.2.0.ga
ADD ./galaxy/snvphyl-workflow-1.2.0-invalid-positions.ga /tmp/snvphyl-workflow-1.2.0-invalid-positions.ga
ADD ./galaxy/snvphyl-workflow-1.2.0-single-end.ga /tmp/snvphyl-workflow-1.2.0-single-end.ga
ADD ./galaxy/snvphyl-workflow-1.2.0-single-end-invalid-positions.ga /tmp/snvphyl-workflow-1.2.0-single-end-invalid-positions.ga

RUN install-workflows "/tmp/snvphyl-workflow-1.2.0.ga" "/tmp/snvphyl-workflow-1.2.0-invalid-positions.ga" \
                      "/tmp/snvphyl-workflow-1.2.0-single-end.ga" "/tmp/snvphyl-workflow-1.2.0-single-end-invalid-positions.ga"

# Mark folders as imported from the host.
VOLUME ["/export/", "/data/", "/var/lib/docker"]

# Expose port 80 (webserver), 21 (FTP server), 8800 (Proxy)
EXPOSE :80
EXPOSE :21
EXPOSE :8800

# Autostart script that is invoked during container start
CMD ["/usr/bin/startup"]
