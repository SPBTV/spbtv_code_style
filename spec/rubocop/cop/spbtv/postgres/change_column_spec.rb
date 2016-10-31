# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Spbtv::Postgres::ChangeColumn do
  subject(:cop) { described_class.new }

  before do
    inspect_source(cop, source)
  end

  context 'changes column' do
    let(:msg) { 'Do not change column.' }
    let(:source) { 'change_column :suppliers, :name, :string, limit: 80' }

    it 'reports an offense' do
      expect(cop.offenses.size).to eq(1)
      expect(cop.messages).to contain_exactly(msg)
    end
  end

  context 'does not changes column ' do
    let(:source) { 'add_column :users, :name, :string, null: true, default: "Peter"' }

    it 'does not report an offense' do
      expect(cop.offenses.size).to eq(0)
      expect(cop.messages).to be_empty
    end
  end
end
