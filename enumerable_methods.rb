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

  def my_all?(args)
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
    i = 0
    until i == size || condition == false
      if self[i] != args
        condition = false
      end
      i += 1
    end
    condition
  end
end

p ([].all?)
