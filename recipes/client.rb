template "/etc/gemrc" do
  source "gemrc.erb"
  mode 0644
end

# Copy the /etc/gemrc file to wherever the current RVM installation will find
# it. In most cases, this will simply be /etc/gemrc. However, this is needed
# for Ruby 1.9 installed via RVM, which doesn't seem to look at /etc/gemrc, but
# only some nested directory inside the RVM folders.
ruby_block "rvm-gemrc" do
  block do
    if node[:languages][:ruby][:system_gemrc] != "/etc/gemrc"
      `mkdir -p #{File.dirname(node[:languages][:ruby][:system_gemrc])} && cp -p /etc/gemrc #{node[:languages][:ruby][:system_gemrc]}`
    end
  end
end

rvm_gem "rubygems-update" do
  version node[:rubygems][:version]
  not_if { `/usr/local/bin/rvm default exec gem -v`.chomp == node[:rubygems][:version] }
end

execute "update rubygems" do
  command "/usr/local/bin/rvm default exec update_rubygems"
  not_if { `gem -v`.chomp == node[:rubygems][:version] }
end
