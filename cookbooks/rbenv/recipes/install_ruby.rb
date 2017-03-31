#
# Cookbook Name:: rbenv
# Recipe:: install
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash 'install ruby' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    source /root/.bashrc
    rbenv install "#{node['rbenv']['ruby_version']}"
  EOH
  not_if "/root/.rbenv/bin/rbenv versions|egrep '^ +#{node['rbenv']['ruby_version']}$'"
end

bash 'active ruby' do
  user 'root'
  code <<-EOH
    rbenv global node['rbenv']['ruby_version']
  EOH
end
