#
# Cookbook Name:: rubygems
# Recipe:: server
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#

include_recipe "rbenv::global_version"

rbenv_gem "builder" do
  ruby_version node[:rbenv][:install_global_version]
end
