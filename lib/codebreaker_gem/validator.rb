module Validator
  def validate_number?(number)
    number.to_i.to_s == number
  end

  def validate_number_range?(number, range)
    range.to_a.include?(number.to_i)
  end

  def validate_length_range?(text, range)
    range.include?(text.length)
  end
end