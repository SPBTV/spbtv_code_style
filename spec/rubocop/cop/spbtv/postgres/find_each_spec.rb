# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Spbtv::Postgres::FindEach do
  subject(:cop) { described_class.new }

  before do
    inspect_source(cop, source)
  end

  context 'find_each is used' do
    let(:msg) { 'Do not use find_each, as the keys are non-integer. Use each_instance instead.' }
    let(:source) { 'SomeModel.where(field: value).find_each {|instance| instance.do_something}' }

    it 'reports an offense' do
      expect(cop.offenses.size).to eq(1)
      expect(cop.messages).to contain_exactly(msg)
    end
  end

  context 'find_each is not used ' do
    let(:source) { 'SomeModel.where(field: value).each_instance {|instance| instance.do_something}' }

    it 'does not report an offense' do
      expect(cop.offenses.size).to eq(0)
      expect(cop.messages).to be_empty
    end
  end
end
