class FactoryGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      if has_rspec?
        m.insert_rspec_helper_include
        m.directory File.join('spec/factories', class_path)
        m.template 'factory.rb',  File.join('spec/factories', class_path, "#{file_name}_factory.rb")
      else
        m.insert_test_helper_require
        m.directory File.join('test/factories', class_path)
        m.template 'factory.rb',  File.join('test/factories', class_path, "#{file_name}_factory.rb")
      end
    end
  end

  def factory_line(attribute)
    "#{file_name}.#{attribute.name} '#{attribute.default}'"
  end

  def has_rspec?
    options[:rspec] || (File.exist?('spec') && File.directory?('spec'))
  end

  def insert_rspec_helper_include
    gsub_test_helper(
        'spec/spec_helper.rb',
        "Spec::Runner.configure do |config|",
        "  config.include FactoryGirlOnRails\n")
  end

  def insert_test_helper_require
    gsub_test_helper(
        "test/test_helper.rb",
        'require File.expand_path(File.dirname(__FILE__) + "/../config/environment")',
        "require 'factory_girl_on_rails'\n")
  end

  def gsub_test_helper(path, match_value, include_value)
    regexp = /(#{Regexp.escape(match_value)})/mi
    content = File.read(path)
    if (content.match(include_value) == nil)
      content = content.gsub(regexp) { |match| "#{match}\n#{include_value}" }
      File.open(path, 'wb') { |file| file.write(content) }
    end
  end

  protected
    def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on("--spec", "Place factory in the RAILS_ROOT/spec/factories directory.(Check for RAILS_ROOT/spec by default)") { |v| options[:rspec] = v }
    end

    def banner
      "Usage: #{$0} #{spec.name} FactoryName [field:type, field:type]"
    end
end
