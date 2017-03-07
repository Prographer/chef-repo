#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "yum update" do
  action :nothing
end
#Package 설치
%w{initscripts openssh-server openssh-clients tar}.each do |pkg|
    package pkg do
        action :install
    end
end

#Java 설치
bash 'java_install' do
  code <<-EOF
    curl -LO 'http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.rpm' -H 'Cookie: oraclelicense=accept-securebackup-cookie'
    rpm -i jdk-8u111-linux-x64.rpm
    rm jdk-8u111-linux-x64.rpm
    rm /usr/bin/java && ln -s /usr/java/default/bin/java /usr/bin/java
    EOF
end

# hadoop 설치
bash 'hadoop_install' do
  code <<-EOF
    curl -L http://apache.tt.co.kr/hadoop/common/hadoop-#{node['hadoop.version']}/hadoop-#{node['hadoop.version']}.tar.gz | tar -xz -C /usr/local/
    ln -s /usr/local/hadoop-#{node['hadoop.version']} /usr/local/hadoop
    mkdir -p /usr/local/hadoop/logs
    EOF
end

ENV['JAVA_HOME'] = '/usr/java/default'

ENV['HADOOP_HOME']          = '/usr/local/hadoop'
ENV['HADOOP_PREFIX']        = '/usr/local/hadoop'
ENV['HADOOP_COMMON_HOME']   = '/usr/local/hadoop'
ENV['HADOOP_HDFS_HOME']     = '/usr/local/hadoop'
ENV['HADOOP_MAPRED_HOME']   = '/usr/local/hadoop'
ENV['HADOOP_YARN_HOME']     = '/usr/local/hadoop'
ENV['HADOOP_CONF_DIR']      = '/usr/local/hadoop/etc/hadoop'
ENV['YARN_CONF_DIR']        = "#{ENV['HADOOP_PREFIX']}/etc/hadoop"

ENV['PATH'] = "#{ENV['PATH']}:#{ENV['JAVA_HOME']}/bin:#{ENV['HADOOP_PREFIX']}/bin:#{ENV['HADOOP_PREFIX']}/sbin"

bash 'hadoop_env_setting' do
    code <<-EOF
        sed -i "/^export JAVA_HOME/ s:.*:export JAVA_HOME=#{ENV['JAVA_HOME']}\nexport HADOOP_PREFIX=#{ENV['HADOOP_PREFIX']}\n:" #{ENV['HADOOP_CONF_DIR']}/hadoop-env.sh
        sed -i "/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=#{ENV['HADOOP_CONF_DIR']}:" #{ENV['HADOOP_CONF_DIR']}/hadoop-env.sh
    EOF
end
