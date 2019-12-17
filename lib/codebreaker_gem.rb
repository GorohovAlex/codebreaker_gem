require 'codebreaker_gem/version'
require 'pry'

require_relative 'codebreaker_gem/difficulty.rb'
require_relative 'codebreaker_gem/game_stage.rb'
require_relative 'codebreaker_gem/validator.rb'
require_relative 'codebreaker_gem/base_class.rb'
require_relative 'codebreaker_gem/user.rb'
require_relative 'codebreaker_gem/init_difficulties.rb'

module Codebreaker
  class CodebreakerGem < CodebreakerGem::BaseClass
    include InitDifficulties

    CODE_LENGTH = 4
    CODE_NUMBERS = ('0'..'6').freeze

    attr_reader :user_code, :difficulty, :game_stage, :difficulty_change, :errors
    attr_accessor :user

    def initialize
      @user_code = []
      @errors = {}
      @difficulty = init_difficulties
    end

    def user_code=(new_user_code)
      @user_code = new_user_code
      user_code_valid?
      @user_code_positions = get_code_positions(@user_code)
    end

    def user_code_valid?
      return unless user_code_valid_length?
      return unless validate_user_code_number_range?

      true
    end

    def user_code_valid_length?
      return true if validate_length?(@user_code, CODE_LENGTH..CODE_LENGTH)

      @errors[:user_code] = 'error_user_code_length'
      false
    end

    def validate_user_code_number_range?
      return true if validate_number_range?(@user_code, CODE_NUMBERS)

      @errors[:user_code] = 'error_user_code_number'
      false
    end

    def difficulty_change=(difficulty)
      @difficulty_change = @difficulty.detect { |value| value.name == difficulty }
      generate_hints unless @difficulty_change.nil?
    end

    def game_start
      generate_secret_code
      @game_stage = GameStage.new(CODE_LENGTH, @difficulty_change.attempts)
      @game_stage
    end

    def game_step(user_code_new)
      self.user_code = user_code_new
      return unless user_code_valid?

      @game_stage.step(compare_codes)
      @game_stage.compare_result
    end

    def registration(username)
      @user = User.new(username)
      { status: @user.valid?, value: @user.username }
    end

    def hint_show
      return if @hint_code.empty?

      @game_stage.hint_used += 1
      @hint_code.shift
    end

    private

    def compare_codes
      crossing_values = @secret_code & @user_code
      crossing_values.each_with_object([]) { |value, cross_result| cross_result << get_cross_value(value) }
                     .flatten
                     .sort_by { |item| item ? 0 : 1 }
    end

    def generate_number(min_value: CODE_NUMBERS.min, max_value: CODE_NUMBERS.max, length: CODE_LENGTH)
      Array.new(length) { rand(min_value.to_i..max_value.to_i).to_s }
    end

    def generate_secret_code
      @secret_code = generate_number
      @secret_code_positions = get_code_positions(@secret_code)
      generate_hints
    end

    def generate_hints
      @hint_code = @secret_code.nil? ? [] : @secret_code.sample(@difficulty_change.hints)
    end

    def get_cross_value(value)
      guess_position(value) + guess_value(value)
    end

    def guess_position(value)
      crossing_positions = @user_code_positions[value] & @secret_code_positions[value]
      crossing_positions.empty? ? [] : Array.new(crossing_positions.size, true)
    end

    def guess_value(value)
      crossing_positions = @user_code_positions[value] & @secret_code_positions[value]

      user_code_positions = crossing_code_position(value, @user_code_positions, crossing_positions)
      secret_code_positions = crossing_code_position(value, @secret_code_positions, crossing_positions)

      size_no_cross_code = [secret_code_positions[value].size, user_code_positions[value].size].min
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
