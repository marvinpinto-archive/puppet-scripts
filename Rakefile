# Some very basic puppet linting
require 'puppet-lint/tasks/puppet-lint'

# Basic puppet syntax checking
require 'puppet-syntax/tasks/puppet-syntax'

# Basic erb validation
require 'erb'
require 'open3'

# # Use the future parser since we're on puppet > 3.2
# PuppetSyntax.future_parser = true

# Run the syntax as well as lint tests
task :test => [
  :syntax,
  :lint,
  :erb,
]

# Ignore any modules added in as git submodules
PuppetLint.configuration.ignore_paths = [
  "modules/apt/**/*.pp",
  "modules/ntp/**/*.pp",
  "modules/stdlib/**/*.pp",
  "modules/timezone/**/*.pp",
  "modules/supervisor/**/*.pp",
  "modules/firewall/**/*.pp",
  "modules/dns/**/*.pp",
  "modules/concat/**/*.pp",
]

# Disable the documentation check, for now
PuppetLint.configuration.send("disable_documentation")

desc "Validate manifests, templates, and ruby files in lib."
task :erb do
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end
end
