require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet_blacksmith/rake_tasks'

PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "pkg/**/*.pp"]
PuppetLint.configuration.log_format = '%{path} - %{check} - %{KIND}: %{message} on line %{line}'
puppet_forge = "https://forge.puppet.com"

desc "Manual command to lint fix"
task :gen_lint_line do
  require 'find'
  pp_file_paths = []
  Find.find('manifests/') do |path|
      pp_file_paths << path if path =~ /.*\.pp$/
  end
  puts "puppet-lint --fix #{pp_file_paths.join(' ')}"
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |task|
  # These make the rubocop experience maybe slightly less terrible
  task.options = ['-D', '-S', '-E']
end

desc "Installs deps using puppet forge and metadata"
task :spec_prep_customized do
  metadata_hsh = JSON.parse(File.read('metadata.json'))
  metadata_hsh['dependencies'].each do |dep|
    cmd = "puppet module install --version '#{dep['version_requirement']}'" \
      " --module_repository #{puppet_forge}" \
      " --ignore-dependencies" \
      " --force" \
      " --module_working_dir spec/fixtures/module-working-dir" \
      " --target-dir spec/fixtures/modules #{dep['name']}"
    puts %x{#{cmd}}
  end
end

Rake::Task['spec_prep'].enhance(['spec_prep_customized'])
desc "Removes deps from metadata"
task :spec_clean_customized do
  at_exit do
    puts 'after'
    metadata_hsh = JSON.parse(File.read('metadata.json'))
    metadata_hsh['dependencies'].each do |dep|
      cmd = "rm -rfv spec/fixtures/modules/#{dep['name'].split('-')[1]}"
      puts %x{#{cmd}}
    end
  end
end
Rake::Task['spec_clean'].enhance(['spec_clean_customized'])

