# frozen_string_literal: true
require 'serverspec'

set :backend, :ssh
options = Net::SSH::Config.for(host)
options[:host_name] = ENV['KITCHEN_HOSTNAME']
options[:port]      = ENV['KITCHEN_PORT']
options[:user]      = 'vagrant'
options[:keys]      = [ENV['KITCHEN_SSH_KEY']]
options[:paranoid]  = false

set :host,        options[:host_name]
set :ssh_options, options
set :env, LANG: 'C', LC_ALL: 'C'
set :request_pty, true
