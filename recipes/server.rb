#
# Cookbook Name:: rubygems
# Recipe:: server
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#

include_recipe "rvm::install"

rvm_gem "builder"
