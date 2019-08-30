require 'spec_helper'

RSpec.describe Respec::File do
  describe '#specable?' do
    context 'when file is added' do
      it 'returns true' do
        path = 'app/models/foo.rb'
        file = Respec::File.new(path: path, status_code: 'A')

        result = file.specable?

        expect(result).to eq(true)
      end
    end

    context 'when file is modified' do
      it 'returns true' do
        path = 'app/models/foo.rb'
        file = Respec::File.new(path: path, status_code: 'M')

        result = file.specable?

        expect(result).to eq(true)
      end
    end

    context 'when file is untracked' do
      it 'returns true' do
        path = 'app/models/foo.rb'
        file = Respec::File.new(path: path, status_code: '??')

        result = file.specable?

        expect(result).to eq(true)
      end
    end

    context 'when file is updated' do
      it 'returns true' do
        path = 'app/models/foo.rb'
        file = Respec::File.new(path: path, status_code: 'U')

        result = file.specable?

        expect(result).to eq(true)
      end
    end

    context 'when status is something else' do
      it 'returns false' do
        path = 'app/models/foo.rb'
        file = Respec::File.new(path: path, status_code: 'D')

        result = file.specable?

        expect(result).to eq(false)
      end
    end
  end

  describe '#spec_to_run' do
    context 'when file is added' do
      it 'tries to find a corresponding spec file' do
        path = 'app/models/foo.rb'
        file = Respec::File.new(path: path, status_code: 'A')
        allow(Respec::SpecFinder).to receive(:find)

        file.spec_to_run

        expect(Respec::SpecFinder).to have_received(:find).with(path)
      end
    end

    context 'when file is modified' do
      it 'tries to find a corresponding spec file' do
        path = 'app/models/foo.rb'
        file = Respec::File.new(path: path, status_code: 'M')
        allow(Respec::SpecFinder).to receive(:find)

        file.spec_to_run

        expect(Respec::SpecFinder).to have_received(:find).with(path)
      end
    end

    context 'when file is untracked' do
      it 'tries to find a corresponding spec file' do
        path = 'app/models/foo.rb'
        file = Respec::File.new(path: path, status_code: '??')
        allow(Respec::SpecFinder).to receive(:find)

        file.spec_to_run

        expect(Respec::SpecFinder).to have_received(:find).with(path)
      end
    end

    context 'when file is updated' do
      it 'tries to find a corresponding spec file' do
        path = 'app/models/foo.rb'
        file = Respec::File.new(path: path, status_code: 'U')
        allow(Respec::SpecFinder).to receive(:find)

        file.spec_to_run

        expect(Respec::SpecFinder).to have_received(:find).with(path)
      end
    end

    context 'when status is something else' do
      it 'returns nil' do
        path = 'app/models/foo.rb'
        file = Respec::File.new(path: path, status_code: 'D')
        allow(Respec::SpecFinder).to receive(:find)

        file.spec_to_run

        expect(Respec::SpecFinder).not_to have_received(:find)
      end
    end
  end

  describe '#status' do
    it "returns the file's Git status" do
      file = Respec::File.new(path: 'app/models/foo.rb', status_code: 'M')

      expect(file.status).to eq(:modified)
    end
  end
end
