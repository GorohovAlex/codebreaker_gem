module CodebreakerGem
  module Validator
    def validate_number_range?(number, range)
      range.to_a.include?(number)
    end

    def validate_length?(text, range)
      range.include?(text.length)
    end
  end
end
