FROM jenkins:1.609.1
MAINTAINER Nick Griffin, <nicholas.griffin>

ENV GERRIT_HOST_NAME gerrit
ENV GERRIT_PORT 8080
ENV GERRIT_JENKINS_USERNAME jenkins
ENV GERRIT_JENKINS_PASSWORD jenkins


# Copy in configuration files
COPY resources/plugins.txt /usr/share/jenkins/ref/
COPY resources/init.groovy.d/ /usr/share/jenkins/ref/init.groovy.d/
COPY resources/scripts/ /usr/share/jenkins/ref/adop_scripts/
COPY resources/jobs/ /usr/share/jenkins/ref/jobs/
COPY resources/scriptler/ /usr/share/jenkins/ref/scriptler/scripts/
COPY resources/views/ /usr/share/jenkins/ref/init.groovy.d/
COPY resources/m2/ /usr/share/jenkins/ref/.m2
COPY resources/entrypoint.sh /entrypoint.sh

# Reprotect
USER 0
RUN chmod +x -R /usr/share/jenkins/ref/adop_scripts/ && chmod +x /entrypoint.sh
#USER jenkins

# Environment variables
ENV ADOP_LDAP_ENABLED=true ADOP_SONAR_ENABLED=true ADOP_ANT_ENABLED=true ADOP_MAVEN_ENABLED=true ADOP_NODEJS_ENABLED=true ADOP_GERRIT_ENABLED=true

RUN chown -R 1000:1000 /var/jenkins_home
RUN chmod +x -R /usr/local/bin && chmod +x /var/log/copy_reference_file.log
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

ENTRYPOINT ["/entrypoint.sh"]
