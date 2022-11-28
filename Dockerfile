FROM mariadb:10.4

RUN touch /tmp/.wsrep-new-cluster && chown -R mysql:mysql /tmp/.wsrep-new-cluster
COPY galera.cnf /etc/mysql/conf.d/01-galera.cnf
COPY DockerEntrypoint.sh /DockerEntrypoint.sh

USER mysql:mysql
CMD /DockerEntrypoint.sh

