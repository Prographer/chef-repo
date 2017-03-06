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
%w{initscripts openssh-server openssh-clients}.each do |pkg|
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
    EOF
end

ENV['JAVA_HOME'] = '/usr/java/default'
ENV['PATH'] = "#{ENV['PATH']}:#{ENV['JAVA_HOME']}/bin"

bash 'java_link' do
  code <<-EOF
    rm /usr/bin/java && ln -s $JAVA_HOME/bin/java /usr/bin/java

    echo $JAVA_HOME
    echo $PATH
    
    EOF
end
