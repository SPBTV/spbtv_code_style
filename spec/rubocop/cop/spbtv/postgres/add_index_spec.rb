# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Spbtv::Postgres::AddIndex do
  subject(:cop) { described_class.new }
  let(:msg) { 'Do not add an index.' }

  before do
    inspect_source(cop, source)
  end

  context 'concurrently without disable_ddl_transaction!' do
    let(:source) do
      <<-SQL
        class AddIndexToAsksActive < ActiveRecord::Migration
          def change
            add_index :asks, :active, algorithm: :concurrently
          end
        end
      SQL
    end

    it 'reports an offense' do
      expect(cop.offenses.size).to eq(1)
      expect(cop.messages).to contain_exactly(msg)
    end
  end

  context 'not concurrently without disable_ddl_transaction!' do
    let(:source) do
      <<-SQL
        class AddIndexToAsksActive < ActiveRecord::Migration
          def change
            add_index :asks, :active
          end
        end
      SQL
    end

    it 'reports an offense' do
      expect(cop.offenses.size).to eq(1)
      expect(cop.messages).to contain_exactly(msg)
    end
  end

  context 'concurrently with disable_ddl_transaction!' do
    let(:source) do
      <<-SQL
        class AddIndexToAsksActive < ActiveRecord::Migration
          disable_ddl_transaction!
          def change
            add_index :asks, :active, algorithm: :concurrently
          end
        end
      SQL
    end

    it 'does not report an offense' do
      expect(cop.offenses.size).to eq(0)
      expect(cop.messages).to be_empty
    end
  end

  context 'not concurrently with disable_ddl_transaction!' do
    let(:source) do
      <<-SQL
        class AddIndexToAsksActive < ActiveRecord::Migration
          disable_ddl_transaction!

          def change
            add_index :asks, :active
          end
        end
      SQL
    end

    it 'reports an offense' do
      expect(cop.offenses.size).to eq(1)
      expect(cop.messages).to contain_exactly(msg)
    end
  end
end
