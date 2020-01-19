# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Spbtv::Postgres::AddColumnWithNotNull do
  subject(:cop) { described_class.new }

  before { inspect_source(source) }

  context 'with null: false' do
    let(:msg) { 'Do not add a NOT NULL column.' }
    let(:source) { 'add_column :users, :name, :string, null: false, default: "Peter"' }

    it 'reports an offense' do
      expect(cop.offenses.size).to eq(1)
      expect(cop.messages).to contain_exactly(msg)
    end
  end

  context 'with null: true' do
    let(:source) { 'add_column :users, :name, :string, null: true, default: "Peter"' }

    it 'does not report an offense' do
      expect(cop.offenses.size).to eq(0)
      expect(cop.messages).to be_empty
    end
  end

  context 'without null:' do
    let(:source) { 'add_column :users, :name, :string, default: "Peter"' }

    it 'does not report an offense' do
      expect(cop.offenses.size).to eq(0)
      expect(cop.messages).to be_empty
    end
  end
end
