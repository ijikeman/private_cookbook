#
# Cookbook Name:: rbenv
# Recipe:: initial
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
group 'rbenv' do
  action :create
  gid 1000
end
