module CodebreakerGem
  module Validator
    def validate_number_range?(number, range)
      (number.join.chars - range.to_a) == []
    end

    def validate_length?(text, range)
      range.include?(text.length)
    end
  end
end
