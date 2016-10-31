# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Spbtv::Postgres::AddColumnWithDefault do
  subject(:cop) { described_class.new }

  before do
    inspect_source(cop, source)
  end

  context 'with default' do
    let(:source) { 'add_column :users, :name, :string, null: false, default: "Peter"' }

    it 'reports an offense' do
      msg = 'Do not add a column with a default value.'
      expect(cop.offenses.size).to eq(1)
      expect(cop.messages).to contain_exactly(msg)
    end
  end

  context 'without default' do
    let(:source) { 'add_column :users, :name, :string, null: false' }

    it 'does not report an offense' do
      expect(cop.offenses.size).to eq(0)
      expect(cop.messages).to be_empty
    end
  end
end
