#
# Cookbook Name:: rbenv
# Recipe:: setup
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
git '/root/.rbenv' do
  repository 'https://github.com/sstephenson/rbenv.git'
  reference 'master'
  user 'root'
  group 'rbenv'
  action :sync
  notifies :create, 'directory[/root/.rbenv/plugins]'
end

directory '/root/.rbenv/plugins' do
  owner 'root'
  group 'rbenv'
  mode 02775
  action :create
  recursive true
  notifies :sync, 'git[/root/.rbenv/plugins/ruby-build]'
end

git '/root/.rbenv/plugins/ruby-build' do
  repository 'https://github.com/sstephenson/ruby-build.git'
  reference 'master'
  user 'root'
  group 'rbenv'
  action :sync
  notifies :sync, 'git[/root/.rbenv/plugins/rbenv-gemset]'
end

git '/root/.rbenv/plugins/rbenv-gemset' do
  repository 'git://github.com/jamis/rbenv-gemset.git'
  reference 'master'
  user 'root'
  group 'rbenv'
  action :sync
  notifies :run, 'bash[set permission to .rbenv]'
end

bash 'set permission to .rbenv' do
   user 'root'
   code <<-EOH
     chgrp -R rbenv /root/.rbenv
     chmod -R g+rwxXs /root/.rbenv/
   EOH
   notifies :run, 'bash[install ruby-build]'
end

bash 'install ruby-build' do
  user 'root'
  cwd '/root/.rbenv/plugins/ruby-build/'
  code <<-EOH
    ./install.sh  
  EOH
end

bash 'insert line rbenv PATH' do
  user 'root'
  code <<-EOH
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /root/.bashrc
    echo 'eval "$(rbenv init -)"' >> /root/.bashrc
  EOH
  not_if 'grep rbenv /root/.bashrc'
end

# [gemsetを使う]
# $ rbenv gemset [ruby_version] test
# $ rbenv gemset list
# コード:
# 2.2.2:
#   test


# [デフォルトバージョン指定]
# $ rbenv versions
# $ rbenv global 1.9.3-p286 
# $ rbenv rehash
# $ ruby -v

# [適用したローカルバージョンを解除する]
# $ rbenv local --unset

# [システムのデフォルトに戻す]
# $ rbenv global system

# [以下のエラーが出る場合]
# 引用:
# rbenv/libexec/rbenv-version-file-read: line 23: /dev/fd/62: No such file or directory

# $ ln -s /proc/self/fd /dev/fd
