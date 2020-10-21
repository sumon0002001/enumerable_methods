# Using enumerable module
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

  def my_all?
    condition = true
    if block_given?
      my_each do |item|
        if (yield item) == false
          condition = false
          break
        end
        condition
      end
    end
    condition
  end

  def my_any?
    condition = false
    if block_given?
      my_each do |item|
        if (yield item) == true
          condition = true
          break
        end
        condition
      end
    end
    condition
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

  def my_map (parameter = nil)
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
end

a = [0]
p (a.inject(1) { |product, n| product * n })

