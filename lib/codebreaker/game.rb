module Codebreaker
  class CodebreakerGem < BaseClass
    include InitDifficulties

    CODE_LENGTH = 4
    CODE_NUMBERS = ('1'..'6').freeze

    attr_reader :statistic, :difficulty, :game_stage, :difficulty_change, :errors
    attr_accessor :user, :hint_code

    def initialize
      @errors = {}
      @statistic = Statistic.new
      @difficulty = init_difficulties
    end

    def user_code_valid_length?(user_code)
      return true if validate_length?(user_code, CODE_LENGTH..CODE_LENGTH)

      false || @errors[:user_code] = 'error_user_code_length'
    end

    def validate_user_code_number_range?(user_code)
      return true if validate_number_range?(user_code, CODE_NUMBERS)

      false || @errors[:user_code] = 'error_user_code_number'
    end

    def difficulty_change=(difficulty)
      @difficulty_change = @difficulty.detect { |value| value.name == difficulty }
    end

    def game_start
      generate_secret_code
      generate_hints unless @difficulty_change.nil?
      @game_stage = GameStage.new(user_code_length: CODE_LENGTH, attempts: @difficulty_change.attempts)
    end

    def game_step(user_code)
      return unless user_code_valid?(user_code)

      @user_code_positions = get_code_positions(user_code)
      @game_stage.step(compare_codes(user_code))
      @game_stage.compare_result
    end

    def registration(username)
      @user = User.new(username)
      { status: @user.valid?, value: @user.errors.empty? ? @user.username : @user.errors.first }
    end

    def hint_show
      return if @hint_code.empty?

      @game_stage.hint_used += 1
      @hint_code.shift
    end

    def statistic_save
      @statistic.statistic_add_item(name: user.username, difficulty: difficulty_change, game_stage: game_stage)
      @statistic.statistic_save
    end

    private

    def user_code_valid?(user_code)
      return unless user_code_valid_length?(user_code)
      return unless validate_user_code_number_range?(user_code)

      true
    end

    def difficulty_valid?
      return true unless @difficulty_change.nil? || @difficulty_change.empty?

      @errors[:difficulty] = 'difficulty_change_error'
      false
    end

    def compare_codes(user_code)
      crossing_values = @secret_code & user_code
      crossing_values.each_with_object([]) { |value, cross_result| cross_result << get_cross_value(value) }
                     .flatten.sort_by { |item| item ? 0 : 1 }
    end

    def generate_number
      Array.new(CODE_LENGTH) { CODE_NUMBERS.to_a.sample }
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

    def validate?
      @errors = {}
      difficulty_valid?
    end
  end
end
