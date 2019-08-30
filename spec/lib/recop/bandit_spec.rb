require 'spec_helper'

RSpec.describe Recop::Bandit do
  describe '.find' do
    it 'creates a new instance and calls `#specfile`' do
      finder = instance_double('Recop::Bandit', wanted: 'spec/lib/foo.rb')
      allow(Recop::Bandit).to receive(:new).and_return(finder)

      result = Recop::Bandit.find('lib/foo.rb')

      expect(Recop::Bandit).to have_received(:new).with('lib/foo.rb')
      expect(result).to eq('spec/lib/foo.rb')
    end
  end

  # describe '#wanted?' do
  #   context 'when app file' do
  #     it 'retuns path to corresponding spec file' do
  #       path = 'app/models/foo.rb'
  #       expected = 'spec/models/foo_spec.rb'
  #
  #       result = Recop::Bandit.new(path).wanted?
  #
  #       expect(result).to eq(path)
  #     end
  #   end
  #
  #   context 'when config initializer file' do
  #     it 'retuns path to corresponding spec file' do
  #       path = 'config/initializers/init.rb'
  #
  #       result = Recop::Bandit.new(path).wanted?
  #
  #       expect(result).to eq(path)
  #     end
  #   end
  #
  #   context 'when lib file' do
  #     it 'retuns path to corresponding spec file' do
  #       path = 'lib/foo.rb'
  #
  #       result = Recop::Bandit.new(path).wanted?
  #
  #       expect(result).to eq(path)
  #     end
  #   end
  #
  #   context 'when spec file' do
  #     it 'retuns path to corresponding spec file' do
  #       path = 'spec/models/foo.rb'
  #
  #       result = Recop::Bandit.new(path).wanted?
  #
  #       expect(result).to eq(path)
  #     end
  #   end
  #
  #   context 'when other file' do
  #     it 'returns nothing' do
  #       path = 'db/schema.rb'
  #
  #       result = Recop::Bandit.new(path).wanted?
  #
  #       expect(result).to eq(nil)
  #     end
  #   end
  #
  #   context 'when not a ruby file' do
  #     it 'returns nothing' do
  #       path = 'spec/fixture/foo.xml'
  #
  #       result = Recop::Bandit.new(path).wanted?
  #
  #       expect(result).to eq(nil)
  #     end
  #   end
  # end

  describe '#wanted' do
    context 'when app file' do
      it "returns it's path" do
        path = 'app/models/foo.rb'

        result = Recop::Bandit.new(path).wanted

        expect(result).to eq(path)
      end
    end

    context 'when lib file' do
      it "returns it's path" do
        path = 'lib/foo.rb'

        result = Recop::Bandit.new(path).wanted

        expect(result).to eq(path)
      end
    end

    context 'when spec file' do
      it "returns it's path" do
        path = 'spec/models/foo_spec.rb'

        result = Recop::Bandit.new(path).wanted

        expect(result).to eq(path)
      end
    end

    context 'when not a ruby' do
      it 'returns nothing' do
        path = 'spec/fixture/foo.xml'

        result = Recop::Bandit.new(path).wanted

        expect(result).to eq(nil)
      end
    end

    context 'when config initializer file' do
      it "returns it's path" do
        path = 'config/initializers/init.rb'

        result = Recop::Bandit.new(path).wanted

        expect(result).to eq(path)
      end
    end
  end
end
