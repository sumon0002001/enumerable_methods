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
       !condition
      end
    end
    condition
  end
end

p (%w[err hjk].my_none? { |word| word.length.nil? })
