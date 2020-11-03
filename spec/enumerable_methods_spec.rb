# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../enumerable_methods'

RSpec.describe 'An ideal Enumerable Module' do
  let(:numerical_array) { [1, 2, 3, 4, 5] }
  let(:range) { (1..5) }
  let(:results) { [] }
  let(:results_hash) { {} }
  let(:string_array) { ['the', 'string', 'item', ''] }
  let(:hash) { { key: 'value', one: '1', two: '2' } }

  describe '#my_each' do
    it 'The array does not change' do
      expect(numerical_array.my_each { |item| item + 5 }).to eq(numerical_array)
    end

    it 'The methods receives a range' do
      expect(range.my_each { |item| item + 5 }).to eq(range)
    end

    it 'The methods receives a Hash' do
      expect(hash.my_each { |item| item }).to eq(hash)
    end

    it 'When no block is given it is an instance of an Enumerator class' do
      expect(numerical_array.my_each).to be_an(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'The array does not change' do
      numerical_array.my_each_with_index { |_item, index| results.push(index) }
      expect(results).to eq([0, 1, 2, 3, 4])
    end

    it 'We can use index and item' do
      numerical_array.my_each_with_index do |item, index|
        results_hash[index] = item
      end

      expect(results_hash).to eq({ 0 => 1, 1 => 2, 2 => 3, 3 => 4, 4 => 5 })
    end

    it 'The methods receives a Hash' do
      expect(hash.my_each_with_index { |item| item }).to eq(hash)
    end

    it 'The methods receives a range' do
      expect(range.my_each_with_index { |item| item }).to eq(range)
    end

    it 'When no block is given it is an instance of an Enumerator class' do
      expect(numerical_array.my_each_with_index).to be_an(Enumerator)
    end
  end

  describe 'my_select' do
    it 'Selects a value base on the argument' do
      expect(numerical_array.my_select(&:even?)).to eq([2, 4])
    end

    it 'Selects a value base on the argument using range' do
      expect(range.my_select(&:even?)).to eq([2, 4])
    end

    it 'Select items base on given block' do
      expect(range.my_select { |item| item > 1 }).to eq([2, 3, 4, 5])
    end

    it 'When no block is given it is an instance of an Enumerator class' do
      expect(numerical_array.my_select).to be_an(Enumerator)
    end
  end

  describe 'my_all?' do
    it 'Returns true if all items meet the block condition' do
      expect(numerical_array.my_all? { |item| item.instance_of? Integer })
        .to eq(true)
    end

    it 'Returns false if one item or more does not meet the block condition' do
      expect(numerical_array.my_all? { |item| item.instance_of? String })
        .to eq(false)
    end
  end
end
# rubocop:enable Metrics/BlockLength
