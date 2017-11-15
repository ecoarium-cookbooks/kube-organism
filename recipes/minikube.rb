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

template "#{$WORKSPACE_SETTINGS[:paths][:project][:workspace][:settings][:organisms][:home]}/kube/shell/lib/organism.bash" do
  source "organism.bash.erb"
  owner ENV['USER']
end
