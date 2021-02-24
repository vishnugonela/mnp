FROM centos:7
RUN yum install httpd -y
RUN service httpd start

