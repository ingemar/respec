module Respec
  class Git
    def self.status(raw_git_status_text = `git status --porcelain=v1`)
      parse(raw_git_status_text).map do |status_code, path|
        Respec::File.new(status_code: status_code, path: path)
      end
    end

    private

    def self.parse(raw_git_status_text)
      raw_git_status_text.split("\n").map { |line| line.split(' ') }
    end
    private_class_method :parse
  end
end
