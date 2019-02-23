class Integer
  def combination(k)
    return 1 if k.zero?

    (self - k + 1..self).inject(:*) / k.factorial
  end

  def permutation(k)
    return 1 if k.zero?

    (self - k + 1..self).inject(:*)
  end

  def factorial
    return 1 if self.zero?

    (1..self).inject(:*)
  end

  def divisor_list
    require 'prime'

    return [] if self <= 0
    return [1] if self == 1

    prime_division.map.with_index { |(base, k), i|
      s = i.zero? ? 0 : 1
      (s..k).map { |n| base ** n }
    }.inject { |res, e| res + res.flat_map { |t| e.map { |v| t * v } } }.sort
  end

  def repeated_combination(k)
    (k + self - 1).combination(k)
  end
end
