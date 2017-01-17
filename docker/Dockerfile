#Galaxy - SNVPhyl
#
# VERSION       1.0

FROM bgruening/galaxy-stable:16.10

MAINTAINER Aaron Petkau, aaron.petkau@gmail.com

ENV GALAXY_CONFIG_BRAND SNVPhyl v1.0.1

WORKDIR /galaxy-central

ENV GALAXY_CONFIG_TOOL_SHEDS_CONFIG_FILE /etc/galaxy/tool_sheds_conf.xml
ADD ./galaxy/tool_sheds_conf.xml /etc/galaxy/tool_sheds_conf.xml

ADD ./galaxy/install_workflow_wrapper.sh /usr/bin/install-workflow
RUN chmod +x /usr/bin/install-workflow
ADD ./galaxy/snvphyl-workflow-1.0.1.ga /tmp/snvphyl-workflow-1.0.1.ga
ADD ./galaxy/snvphyl-workflow-1.0.1-invalid-positions.ga /tmp/snvphyl-workflow-1.0.1-invalid-positions.ga
ADD ./galaxy/snvphyl-workflow-1.0.1-single-end-invalid-positions.ga /tmp/snvphyl-workflow-1.0.1-single-end-invalid-positions.ga
ADD ./galaxy/snvphyl-workflow-1.0.1-single-end.ga /tmp/snvphyl-workflow-1.0.1-single-end.ga

# workaround for a Docker AUFS bug: https://github.com/docker/docker/issues/783#issuecomment-56013588
RUN mkdir /etc/ssl/private-copy; mv /etc/ssl/private/* /etc/ssl/private-copy/; rm -r /etc/ssl/private; mv /etc/ssl/private-copy /etc/ssl/private; chmod -R 0700 /etc/ssl/private; chown -R postgres /etc/ssl/private

# Turn on faster workflow scheduling
RUN sed -i -e 's/^#force_beta_workflow_scheduled_for_collections=False/force_beta_workflow_scheduled_for_collections=True/' /etc/galaxy/galaxy.ini

# Install SNVPhyl
RUN install-repository \
    "-r 267ceafb2707 --url http://jupiter:9009 -o nml --name suite_snvphyl_1_0_1 --panel-section-id SNVPhyl" && \
    install-workflow \
    "/tmp/snvphyl-workflow-1.0.1.ga" "/tmp/snvphyl-workflow-1.0.1-invalid-positions.ga" "/tmp/snvphyl-workflow-1.0.1-single-end.ga" "/tmp/snvphyl-workflow-1.0.1-single-end-invalid-positions.ga" && \
    rm /tmp/snvphyl-workflow*.ga && \
    find /galaxy-central/tool_deps/ -iname '.git' | xargs -I {} rm -rf {}

# Mark folders as imported from the host.
VOLUME ["/export/", "/data/", "/var/lib/docker"]

# Expose port 80 (webserver), 21 (FTP server), 8800 (Proxy)
EXPOSE :80
EXPOSE :21
EXPOSE :8800

# Autostart script that is invoked during container start
CMD ["/usr/bin/startup"]
