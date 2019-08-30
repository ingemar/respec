require 'spec_helper'

RSpec.describe Respec::Git do
  describe '.status' do
    it 'parses given raw git status and returns a collection of `Respec::File`s' do
      raw_git_status_text = " M app/models/foo.rb\n?? lib/foo.rb\n"
      allow(Respec::File).to receive(:new).twice.and_call_original

      result = Respec::Git.status(raw_git_status_text)

      expect(result[0]).to be_a(Respec::File)
      expect(result[1]).to be_a(Respec::File)
      expect(Respec::File).to have_received(:new).with(
        status_code: 'M',
        path: 'app/models/foo.rb',
      )
      expect(Respec::File).to have_received(:new).with(
        status_code: '??',
        path: 'lib/foo.rb',
      )
    end
  end
end
