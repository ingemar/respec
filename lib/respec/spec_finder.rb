require 'pathname'

module Respec
  class SpecFinder
    APP_DIRS = %w[
      app
      lib
    ].freeze
    EXCLUDED_SPEC_DIRS = %w[
      cypress
      factories
      fixtures
      support
    ].freeze

    class FileMissingErrror < StandardError; end

    attr_reader :path

    def self.find(path)
      new(path).specfile
    end

    def initialize(path)
      @path = Pathname.new(path)
    end

    def specfile
      candidate.to_s.tap do |path|
        raise FileMissingErrror unless ::File.exist?(path)
      end
    rescue FileMissingErrror
      nil
    end

    private

    def appfile?
      path.to_s =~ /\Aapp/
    end

    def appfile_candidate
      path
        .sub(/\Aapp/, 'spec')
        .sub(
          filename,
          "#{filename('.rb')}_spec.rb",
        )
    end

    def candidate
      if specfile?
        path
      elsif appfile?
        appfile_candidate
      elsif libfile?
        libfile_candidate
      end
    end

    def libfile?
      path.to_s =~ /\Alib/
    end

    def libfile_candidate
      path
        .to_s
        .insert(0, 'spec/')
        .sub(
          filename,
          "#{filename('.rb')}_spec.rb",
        )
    end

    def filename(extension = '')
      path.basename(extension).to_s
    end

    def specfile?
      path.to_s =~ /\Aspec/ && path.to_s !~ /#{EXCLUDED_SPEC_DIRS.join('|')}/
    end
  end
end
