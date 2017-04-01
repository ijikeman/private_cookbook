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
    chmod -R g-s /root/.rbenv
    rbenv install "#{node['rbenv']['ruby_version']}"
  EOH
  not_if "source /root/.bashrc; rbenv versions|egrep '#{node['rbenv']['ruby_version']}'"
end

bash 'active ruby' do
  user 'root'
  code <<-EOH
    source /root/.bashrc
    rbenv global "#{node['rbenv']['ruby_version']}"
  EOH
end

bash 'install bundle' do
  user 'root'
  code <<-EOH
    source /root/.bashrc
    gem install bundler
  EOH
end
