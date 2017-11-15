#
# Cookbook Name:: kube-organism
# Recipe:: default
#

include_recipe 'kube::minikube'

target_directory = "#{$WORKSPACE_SETTINGS[:paths][:project][:workspace][:settings][:organisms][:home]}/kube/shell/lib"

while target_directory != $WORKSPACE_SETTINGS[:paths][:project][:workspace][:settings][:organisms][:home]
  directory target_directory do
    recursive true
    owner ENV['USER']
  end
  target_directory = File.dirname(target_directory)
end

template "#{node[:nexus][:conf_dir]}/nexus.properties" do
  source "nexus.properties.erb"
  owner node[:nexus][:user]
  group node[:nexus][:group]
  notifies :restart, "service[#{node[:nexus][:app]}]"
end
