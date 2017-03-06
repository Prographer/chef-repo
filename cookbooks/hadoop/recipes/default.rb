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
  code <<-EOH
    curl -LO 'http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.rpm' -H 'Cookie: oraclelicense=accept-securebackup-cookie'
    rpm -i jdk-8u111-linux-x64.rpm
    rm jdk-8u111-linux-x64.rpm
    EOH
end
