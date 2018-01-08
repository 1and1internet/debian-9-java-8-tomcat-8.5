FROM 1and1internet/debian-9-java-8:latest

COPY files /

ARG TOMCAT_VER=8.5.24

RUN apt-get update \
    && apt-get install -y wget \
    && cd /opt \
    && wget http://mirror.ox.ac.uk/sites/rsync.apache.org/tomcat/tomcat-8/v${TOMCAT_VER}/bin/apache-tomcat-${TOMCAT_VER}.tar.gz \
    && tar zxvf apache-tomcat-${TOMCAT_VER}.tar.gz \
    && rm -rf apache-tomcat-${TOMCAT_VER}.tar.gz \
    && ln -sf /opt/apache-tomcat-${TOMCAT_VER} /usr/share/tomcat \
    && chmod +x /usr/share/tomcat/bin/*.sh /usr/local/bin/* \
    && dpkg -i /opt/tomcat8_${TOMCAT_VER}_all.deb \
    && apt-get remove wget \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && chmod -R 777 /usr/share/tomcat /opt/tomcat

ENV TC_MGR_GUI_USER=tcmgrgui \
    TC_MGR_GUI_PASS=tcmgrguipass \
    TC_MGR_SCRIPT_USER=tcmgrscript \
    TC_MGR_SCRIPT_PASS=tcmgrscriptpass \
    TC_MGR_JMX_USER=tcmgrjmx \
    TC_MGR_JMX_PASS=tcmgrjmxpass \
    TC_MGR_STATUS_USER=tcmgrstatus \
    TC_MGR_STATUS_PASS=tcmgrstatuspass \
    TC_ADMIN_GUI_USER=tcadminmgrgui \
    TC_ADMIN_GUI_PASS=tcadminmgrguipass \
    TC_ADMIN_SCRIPT_USER=tcadminmgrscript \
    TC_ADMIN_SCRIPT_PASS=tcadminmgrscriptpass \
    CATALINA_BASE=/var/www
