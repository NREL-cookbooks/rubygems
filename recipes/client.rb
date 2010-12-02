template "/etc/gemrc" do
  source "gemrc.erb"
  mode 0644
end

execute "update rubygems" do
  command "gem install rubygems-update -v #{node[:rubygems][:version]} && update_rubygems"
  not_if { `gem -v`.chomp == node[:rubygems][:version] }
end
