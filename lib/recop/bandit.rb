require 'pathname'

module Recop
  class Bandit
    POLICED_DISTRICTS = %w[
      app
      config/initializers
      lib
      spec
    ].freeze

    attr_reader :path

    def self.find(path)
      new(path).wanted
    end

    def initialize(path)
      @path = Pathname.new(path)
    end

    def wanted
      path.to_s if wanted?
    end

    private

    def wanted?
      path.to_s =~ /\A#{POLICED_DISTRICTS.join('|')}/ && (dir? || rubyfile?)
    end

    def dir?
      path.to_s =~ %r{\/\z}
    end

    def rubyfile?
      path.extname == '.rb'
    end
  end
end
