require 'erb'
# require 'fileutils'

# starling_plugin_folder = Dir.getwd + "/vendor/plugins/simplified_starling"

starling_config = Dir.getwd + "/config/starling.yml"
starling_config_template = Dir.getwd + "/vendor/plugins/simplified_starling/files/starling.yml.erb"

unless File.exist?(starling_config)

  pwd = Dir.getwd
  template = File.read(starling_config_template)
  result = ERB.new(template).result(binding)

  starling_config_file = File.open(starling_config, 'w+')
  starling_config_file.puts result
  starling_config_file.close

  puts "=> Copied starling configuration file."

else

  puts "=> Starling configuration file already exists."

end