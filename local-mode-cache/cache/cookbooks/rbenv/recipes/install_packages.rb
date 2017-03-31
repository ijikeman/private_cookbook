#
# Cookbook Name:: rbenv
# Recipe:: install_packages
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node['rbenv']['build_packages'].each do |pkg_name|
  package pkg_name do
    action :install
  end
end

package 'libyaml-devel' do
  action :nothing
  options '--enablerepo=epel'
end
