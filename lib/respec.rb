require 'English'
require 'respec/file'
require 'respec/git'
require 'respec/spec_finder'

module Respec
  def self.run!
    if specs.any?
      puts "\nRespec running:"
      specs.each do |path|
        puts "  #{path}"
      end

      puts "\nBooting... 🚀"

      system "bundle exec rspec #{specs.join(' ')}"
    else
      puts 'Huh? There was nothing to do.'
    end

    $CHILD_STATUS.success? ? exit(0) : exit(1)
  end

  private

  def self.specs
    Git.status.filter_map(&:spec_to_run).uniq
  end
  private_class_method :specs
end
