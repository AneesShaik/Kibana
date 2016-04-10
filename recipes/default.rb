#
# Cookbook Name:: Kibana
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
script "download and install_Kibana public signing key" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch 
  EOH
end

script "creating kibana repo" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  cd /etc/yum.repos.d/
  touch kibana.repo
  cat <<EOT  >> kibana.repo
[kibana-4.5]
name=Kibana repository for 4.5.x packages
baseurl=http://packages.elastic.co/kibana/4.5/centos
gpgcheck=1
gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1
  EOH
end

script "install_Kibana" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  yum install kibana -y
  EOH
end

service "kibana" do
	action [:enable, :start]
end
