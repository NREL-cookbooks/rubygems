#
# Cookbook Name:: rubygems
# Recipe:: server
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#

include_recipe "rbenv::system"

rbenv_gem "builder"
