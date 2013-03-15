include_recipe "rbenv::system"

template "/etc/gemrc" do
  source "gemrc.erb"
  mode 0644
end

# Copy the /etc/gemrc file to wherever the current rbenv installation will find
# it. In most cases, this will simply be /etc/gemrc. However, this is needed
# for Ruby 1.9 installed via rbenv, which doesn't seem to look at /etc/gemrc, but
# only some nested directory inside the rbenv folders.
ruby_block "rbenv-gemrcs" do
  block do
    Dir.glob("#{node[:rbenv][:root_path]}/versions/*").each do |version_prefix|
      version_etc = "#{version_prefix}/etc"
      version_gemrc = "#{version_etc}/gemrc"

      ::FileUtils.mkdir(version_etc) unless(::File.directory?(version_etc))
      ::FileUtils.chmod(0755, version_etc)

      ::FileUtils.ln_s("/etc/gemrc", version_gemrc) unless(::File.exists?(version_gemrc))
    end
  end
end

rbenv_gem "rubygems-update" do
  version node[:rubygems][:version]
end

execute "#{node[:rbenv][:root_path]}/shims/update_rubygems" do
  not_if do
    `#{node[:languages][:ruby][:gem_bin]} -v`.strip == node[:rubygems][:version]
  end
end
