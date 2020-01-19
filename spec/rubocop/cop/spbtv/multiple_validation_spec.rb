# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Spbtv::MultipleValidation do
  subject(:cop) { described_class.new }

  before { inspect_source(source) }

  describe 'accepts single attribute validations' do
    let(:source) { 'validates :name' }

    it { expect_no_offenses(source) }
  end

  describe 'accepts single attribute validations with options' do
    let(:source) { 'validates :name, presence: true' }

    it { expect_no_offenses('validates :name, presence: true') }
  end

  describe 'autocorrect multiple attributes validation' do
    let(:source) { 'validates :name, :age, presence: true' }
    let(:correction) { "validates :age, presence: true\nvalidates :name, presence: true" }

    specify do
      new_source = autocorrect_source(source)
      expect(new_source).to eq(correction)
    end
  end
end
