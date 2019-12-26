module Codebreaker
  module CompareCodes
    def compare(secret_code, match_code)
      @secret_code_positions = get_code_positions(secret_code)
      @match_code_positions = get_code_positions(match_code)
      crossing_values = secret_code & match_code
      crossing_values.each_with_object([]) { |value, cross_result| cross_result << get_cross_value(value) }
                     .flatten.sort_by { |item| item ? 0 : 1 }
    end

    def get_cross_value(value)
      guess_position(value) + guess_value(value)
    end

    def guess_position(value)
      crossing_positions = @match_code_positions[value] & @secret_code_positions[value]
      crossing_positions.empty? ? [] : Array.new(crossing_positions.size, true)
    end

    def guess_value(value)
      crossing_positions = @match_code_positions[value] & @secret_code_positions[value]

      match_code_positions = crossing_code_position(value, @match_code_positions, crossing_positions)
      secret_code_positions = crossing_code_position(value, @secret_code_positions, crossing_positions)

      size_no_cross_code = [secret_code_positions[value].size, match_code_positions[value].size].min
      crossing_positions.empty? && size_no_cross_code.zero? ? [] : Array.new(size_no_cross_code, false)
    end

    def crossing_code_position(value, code_array, crossing_positions)
      code_positions = code_array.dup
      code_positions[value] -= crossing_positions
      code_positions
    end

    def get_code_positions(code_array)
      return if code_array.nil? || code_array.empty?

      code_array.each_with_object(Hash.new([])).with_index { |(value, code), index| code[value] += [index] }
    end
  end
end
