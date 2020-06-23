#Galaxy - SNVPhyl
#
# VERSION       1.0

FROM bgruening/galaxy-stable:19.05

MAINTAINER Aaron Petkau, aaron.petkau@gmail.com

ENV GALAXY_CONFIG_BRAND SNVPhyl v1.2.0 (Galaxy 19.05)

WORKDIR /galaxy-central

ENV GALAXY_CONFIG_TOOL_SHEDS_CONFIG_FILE /etc/galaxy/tool_sheds_conf.xml
ADD ./galaxy/tool_sheds_conf.xml /etc/galaxy/tool_sheds_conf.xml

ADD ./galaxy/tool_sheds_conf.xml /home/galaxy/tool_sheds_conf.xml

# workaround for a Docker AUFS bug: https://github.com/docker/docker/issues/783#issuecomment-56013588
#RUN mkdir /etc/ssl/private-copy; mv /etc/ssl/private/* /etc/ssl/private-copy/; rm -r /etc/ssl/private; mv /etc/ssl/private-copy /etc/ssl/private; chmod -R 0700 /etc/ssl/private; chown -R postgres /etc/ssl/private

# Turn on faster workflow scheduling
#RUN sed -i -e 's/^#force_beta_workflow_scheduled_for_collections=False/force_beta_workflow_scheduled_for_collections=True/' /etc/galaxy/galaxy.ini

# RUN sed -i -e 's/^#allow_library_path_paste.*/allow_library_path_paste = True/' /etc/galaxy/galaxy.yml && \
#    sed -i -e 's/ --share//' /etc/galaxy/job_conf.xml

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
