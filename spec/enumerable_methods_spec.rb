require_relative '../enumerable_methods'

RSpec.describe 'An ideal Enumerable Module' do
  let(:numerical_array) { [1, 2, 3, 4, 5] }
  let(:range) { (1..5) }
  let(:results) { [] }
  let(:my_proc) { proc { |item| item * 2 } }
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

  describe 'my_any?' do
    it 'Returns true if any of the items meet the block condition' do
      expect(numerical_array.my_any? { |item| item > 3 })
        .to eq(true)
    end

    it 'Returns false if none of the items meet the block condition' do
      expect(numerical_array.my_any? { |item| item > 5 })
        .to eq(false)
    end
  end

  describe 'my_none?' do
    it 'Returns true if none of the items meet the block condition' do
      expect(numerical_array.my_none? { |item| item > 6 })
        .to eq(true)
    end

    it 'Returns false if all of the items meet the block condition' do
      expect(numerical_array.my_none? { |item| item < 6 })
        .to eq(false)
    end
  end

  describe 'my_count' do
    it 'Returns the number of items in the array that meet the block condition' do
      expect(numerical_array.my_count { |item| item > 6 })
        .to eq(0)
    end

    it 'Returns the number of items in the range that meet the block condition' do
      expect(range.my_count { |item| item < 5 })
        .to eq(4)
    end

    it 'Returns the number of items in the hash that meet the block condition' do
      expect(hash.my_count)
        .to eq(3)
    end

    it 'Returns the number of items in the hash that meet the parameters' do
      expect(string_array.my_count('item'))
        .to eq(1)
    end
  end

  describe '#my_map' do
    it 'Creating another array' do
      expect(numerical_array.my_map { |item| item + 1 }).to eq([2, 3, 4, 5, 6])
    end

    it 'The methods receives a range and creates a new array' do
      expect(range.my_map { |item| item + 1 }).to eq([2, 3, 4, 5, 6])
    end

    it 'The methods receives a proc block as a parameter' do
      expect(numerical_array.my_map(&my_proc)).to eq([2, 4, 6, 8, 10])
    end

    it 'When no block is given it is an instance of an Enumerator class' do
      expect(numerical_array.my_map).to be_an(Enumerator)
    end
  end

  describe '#my_inject' do
    it 'Sums up all the items inside the array' do
      expect(numerical_array.my_inject(:+)).to eq(15)
    end

    it 'Sums all items of the range with the condition given in the block' do
      expect(range.my_inject { |item, n| item + n }).to eq(15)
    end

    it 'The methods receives two arguments and return the result' do
      expect(numerical_array.my_inject(1, :*)).to eq(120)
    end

    it 'The methods receives a zero value as a parameter' do
      expect(numerical_array.my_inject(0, :*)).to eq(0)
    end
  end
end
