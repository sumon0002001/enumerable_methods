# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Style/FrozenStringLiteralComment

module Enumerable
  def my_each
    i = 0
    until i == size
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    until i == size
      yield self[i], i
      i += 1
    end
    self
  end

  def my_select
    array = []
    my_each { |item| array << item if yield item }
    array
  end

  def my_all?(argument = nil)
    if block_given?
      my_each { |item| return false if yield(item) == false }
      true
    elsif argument.nil?
      my_each { |item| return false if item.nil? || item == false }
    elsif !argument.nil? && argument.is_a?(Class)
      my_each { |item| return false unless [item.class, item.class.superclass].include?(argument) }
    elsif argument.class == Regexp
      my_each { |item| return false unless argument.match(item) }
    else my_each { |item| return false if item != argument }
    end
    true
  end

  def my_any?(argument = nil)
    if block_given?
      my_each { |item| return true if yield(item) }
      return false
    end
    argument.nil? ? argument.class.to_s : my_any? { |item| item }

    if argument.class.to_s == 'Class'
      my_each { |item| return true if item.is_a? argument }
    elsif argument.class.to_s == 'Regexp'
      my_each { |item| return true if item =~ argument }
    elsif argument.nil?
      my_each { |item| return true if item }
    else
      my_each { |item| return true if item == argument }
    end
    false
  end

  def my_none?
    condition = true
    if block_given?
      my_each do |item|
        if (yield item) == false
          condition = false
          break
        end
      end
      !condition
    end
    condition
  end

  def my_count(argument = nil)
    count = 0
    if block_given? || !argument.nil?
      block_given? ? my_each { |item| count += 1 if yield(item) } : my_each { |item| count += 1 if argument == item }
    else
      object = self
      count = object.size
    end
    count
  end

  def my_map(parameter = nil)
    return to_enum(:my_map) unless block_given?

    array = []
    if parameter.nil?
      my_each { |item| array << yield(item) }
    else
      my_each { |item| array << parameter.call(item) }
    end
    array
  end

  def my_inject
    return to_enum(:my_inject) unless block_given?

    result = nil
    my_each { |item| result = result.nil? ? item : yield(result, item) }
    result
  end

  def multiply_els(items)
    items.my_inject { |result, item| result * item }
  end
end

# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Style/FrozenStringLiteralComment
