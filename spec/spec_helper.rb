require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-utils'
require 'rspec-puppet-facts'
include RspecPuppetFacts

RSpec.configure do |c|
  default_facts = {
    puppetversion: Puppet.version,
    facterversion: Facter.version
  }
  default_facts.merge!(YAML.load(File.read(File.expand_path('../default_facts.yml', __FILE__)))) if File.exist?(File.expand_path('../default_facts.yml', __FILE__))
  c.default_facts = default_facts

  c.before :all do
    Puppet::Util::Log.newdestination(:console)
    Puppet::Util::Log.level = if ENV['DEBUG']
                                :debug
                              elsif ENV['INFO']
                                :info
                              else
                                :err
                              end

    # work around https://tickets.puppetlabs.com/browse/PUP-1547
    # ensure that there's at least one provider available by emulating that any command exists
    require 'puppet/confine/exists'
    Puppet::Confine::Exists.any_instance.stubs(which: '')
    # avoid "Only root can execute commands as other users"
    Puppet.features.stubs(root?: true)
  end
end

module RSpec::Puppet
  module Support
    def build_catalog(*args)
      @@cache = {}
      @@cache[args] = build_catalog_without_cache(*args)
    end
  end
end
