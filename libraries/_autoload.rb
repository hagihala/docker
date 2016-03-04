begin
  gem 'docker-api', '= 1.28.0'
rescue LoadError
  run_context = Chef::RunContext.new(Chef::Node.new, {}, Chef::EventDispatch::Dispatcher.new)

  require 'chef/resource/chef_gem'

  whyrun_config = Chef::Config[:why_run]
  begin
    Chef::Config[:why_run] = false
    docker = Chef::Resource::ChefGem.new('docker-api', run_context)
    docker.version '= 1.28.0'
    docker.run_action(:install)
  ensure
    Chef::Config[:why_run] = whyrun_config
  end
end
