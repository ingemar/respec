module Respec
  class File
    SPECABLE = %i[
      added
      modified
      untracked
      updated
    ].freeze
    STATUSES = {
      '??' => :untracked,
      'A'  => :added,
      'AM' => :modified,
      'C'  => :copied,
      'D'  => :deleted,
      'M'  => :modified,
      'MM' => :modified,
      'R'  => :renamed,
      'U'  => :updated,
    }.freeze

    attr_reader :path, :status_code

    def initialize(path:, status_code:)
      @path = path
      @status_code = status_code
    end

    def specable?
      SPECABLE.include?(status)
    end

    def spec_to_run
      SpecFinder.find(path) if specable?
    end

    def status
      STATUSES[status_code]
    end
  end
end
