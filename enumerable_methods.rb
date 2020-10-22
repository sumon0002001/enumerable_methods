# my_Enumerable
# rubocobStyle/Documentation

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    item = self if instance_of?(Array)
    item = to_a if instance_of?(Range) || Hash

    i = 0
    while i < item.length
      yield(item[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    item = self if instance_of?(Array)
    item = to_a if instance_of?(Range) || Hash
    i = 0

    until i < item.length
      yield(item[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    array = []
    my_each { |item| array << item if yield item }
    array
  end

  def my_all?(argument = nil)
    if block_given?
      my_each { |item| return false if yield(item) == false }
      return true
    elsif argument.nil?
      my_each { |item| return false if item.nil? || item == false }
    elsif !argument.nil? && (argument.is_a? Class)
      my_each { |item| return false unless [item.class, item.class.superclass].include?(argument) }
    elsif argument.class && !argument.nil == Regexp
      my_each { |item| return false unless argument.match(item) }
    else 
      my_each { |item| return false if item != argument }
    end
    true
  end

  def my_any?(argument = nil)
    if block_given?
      my_each { |item| return true if yield(item) }
      return false
    elsif argument.nil?
      my_each { |item| return true if item }
    elsif !argument.nil? && argument.is_a?(Class)
      my_each { |item| return true unless [item.class, item.class.superclass].include?(argument) }
    elsif argument.class && !argument.nil == Regexp
      my_each { |item| return true unless argument.match(item) }
    else
      my_each { |item| return true if item == argument }
    end
    false
  end

  def my_none?(argument = nil, &block)
    !my_any?(argument, &block)
  end

  def my_count(argument = nil)
    count = 0
    if !block_given? && argument.nil?
      count = to_a.length
    elsif block_given?
      my_each { |item| count += 1 if yield(item) }
    else
      count = my_select { |item| item == argument }.length
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

  def my_inject(argument = nil, sym = nil)
    if (!argument.nil? && sym.nil?) && (argument.is_a?(Symbol) || argument.is_a(String))
      sym = argument
      argument = nil
    end
    if !sym.nil? && !block_given
      my_each { |item| argument = argument.nil? ? item : argument.send(sym, item) }
    else
      my_each { |item| argument = argument.nil? ? item : yield(argument, item) }
    end
    argument
  end

  def multiply_els(items)
    items.my_inject { |result, item| result * item }
  end
end
