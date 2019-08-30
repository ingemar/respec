require 'spec_helper'

RSpec.describe Respec::SpecFinder do
  describe '.find' do
    it 'creates a new instance and calls `#specfile`' do
      finder = instance_double('Respec::Specfinder', specfile: 'spec/lib/foo.rb')
      allow(Respec::SpecFinder).to receive(:new).and_return(finder)

      result = Respec::SpecFinder.find('lib/foo.rb')

      expect(Respec::SpecFinder).to have_received(:new).with('lib/foo.rb')
      expect(result).to eq('spec/lib/foo.rb')
    end
  end

  describe '#specfile' do
    context 'when app file' do
      it 'retuns path to corresponding spec file' do
        path = 'app/models/foo.rb'
        expected = 'spec/models/foo_spec.rb'
        allow(::File).to receive(:exist?).with(expected).and_return(true)

        result = Respec::SpecFinder.new(path).specfile

        expect(result).to eq(expected)
      end
    end

    context 'when lib file' do
      it 'retuns path to corresponding spec file' do
        path = 'lib/foo.rb'
        expected = 'spec/lib/foo_spec.rb'
        allow(::File).to receive(:exist?).with(expected).and_return(true)

        result = Respec::SpecFinder.new(path).specfile

        expect(result).to eq(expected)
      end
    end

    context 'when spec file' do
      it "returns it's own path" do
        path = 'spec/models/foo_spec.rb'
        allow(::File).to receive(:exist?).with(path).and_return(true)

        result = Respec::SpecFinder.new(path).specfile

        expect(result).to eq(path)
      end
    end

    context 'when spec support file"' do
      it 'returns nothing' do
        path = 'spec/support/foo.rb'

        result = Respec::SpecFinder.new(path).specfile

        expect(result).to eq(nil)
      end
    end

    context 'when factory file' do
      it 'returns nothing' do
        path = 'spec/factories/foo.rb'

        result = Respec::SpecFinder.new(path).specfile

        expect(result).to eq(nil)
      end
    end

    context 'when fixture file' do
      it 'returns nothing' do
        path = 'spec/fixture/foo.rb'

        result = Respec::SpecFinder.new(path).specfile

        expect(result).to eq(nil)
      end
    end

    context 'when config file' do
      it 'returns nothing' do
        path = 'config/foo.rb'

        result = Respec::SpecFinder.new(path).specfile

        expect(result).to eq(nil)
      end
    end

    context "when file doesn't exist" do
      it 'return nil' do
        path = 'app/models/foo.rb'

        result = Respec::SpecFinder.new(path).specfile

        expect(result).to eq(nil)
      end
    end
  end
end
