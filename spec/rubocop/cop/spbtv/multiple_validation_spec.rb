# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Spbtv::MultipleValidation do
  subject(:cop) { described_class.new }

  it 'accepts single attribute validations' do
    inspect_source(cop, 'validates :name')
    expect(cop.offenses).to be_empty
  end

  it 'accepts single attribute validations with options' do
    inspect_source(cop, 'validates :name, presence: true')
    expect(cop.offenses).to be_empty
  end

  it 'autocorrect multiple attributes validation' do
    new_source = autocorrect_source(cop, 'validates :name, :age, presence: true')
    expect(new_source).to eq("validates :age, presence: true\nvalidates :name, presence: true")
  end
end
