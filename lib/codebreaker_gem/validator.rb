module Validator
  def validate_number?(number)
    number.to_i.to_s == number
  end

  def validate_number_range?(number, range)
    # return unless validate_number?(number)

    range.to_a.include?(number)
  end

  def validate_length_range?(text, range)
    range.include?(text.length)
  end
end