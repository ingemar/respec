require 'English'
require 'respec/file'
require 'respec/git'
require 'recop/bandit'

module Recop
  def self.police!
    if bandits.any?
      puts "\nRecop running:"

      bandits.each do |path|
        puts "  #{path}"
      end

      puts "\nBooting... 🚓"

      system 'bundle exec rubocop ' + (ARGV + bandits).join(' ')
    else
      puts 'Huh? There was nothing todo.'
    end

    $CHILD_STATUS.success? ? exit(0) : exit(1)
  end

  private

  def self.bandits
    Respec::Git.status.flat_map do |file|
      Recop::Bandit.find(file.path) if file.specable?
    end.uniq
  end
  private_class_method :bandits
end
