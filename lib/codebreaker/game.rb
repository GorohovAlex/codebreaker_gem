module Codebreaker
  class Game < BaseClass
    include InitDifficulties

    CODE_LENGTH = 4
    CODE_NUMBERS = ('1'..'6').freeze

    attr_reader :statistic, :difficulties, :difficulty, :errors, :game_stage
    attr_accessor :user, :hint_code

    def initialize
      @errors = {}
      @statistic = Statistic.new
      @difficulties = init_difficulties
      @difficulty = nil
    end

    def match_code_valid_length?(match_code)
      return true if validate_length?(match_code, CODE_LENGTH..CODE_LENGTH)

      (@errors[:match_code] = 'error_match_code_length') && false
    end

    def validate_match_code_number_range?(match_code)
      return true if validate_number_range?(match_code, CODE_NUMBERS)

      (@errors[:match_code] = 'error_match_code_number') && false
    end

    def difficulty=(difficulty)
      @difficulty = @difficulties.select { |value| value.name == difficulty }.first
    end

    def game_start
      generate_secret_code
      generate_hints
      @game_stage = GameStage.new(match_code_length: CODE_LENGTH, attempts: @difficulty.attempts)
    end

    def game_step(match_codes)
      return unless match_code_valid?(match_codes)

      @game_stage.step(@compare_codes.compare(match_codes))
      @game_stage.compare_result
    end

    def registration(username)
      @user = User.new(username)
      { status: @user.valid?, value: @user.errors.empty? ? @user.username : @user.errors[:user] }
    end

    def hint_show
      return if @hint_code.empty?

      @game_stage.hint_used += 1
      @hint_code.shift
    end

    def statistic_save
      @statistic.statistic_add_item(name: user.username, difficulty: @difficulty, game_stage: @game_stage)
      @statistic.statistic_save
    end

    private

    def match_code_valid?(match_code)
      return unless match_code_valid_length?(match_code)
      return unless validate_match_code_number_range?(match_code)

      true
    end

    def difficulty_valid?
      return true unless @difficulty.nil?

      @errors[:difficulty] = 'difficulty_change_error'
      false
    end

    def generate_number
      Array.new(CODE_LENGTH) { CODE_NUMBERS.to_a.sample }
    end

    def generate_hints
      @hint_code = @secret_code.nil? ? [] : @secret_code.sample(@difficulty.hints)
    end

    def generate_secret_code
      @secret_code = generate_number
      @compare_codes = CompareCodes.new(@secret_code)
    end

    def validate
      difficulty_valid?
    end
  end
end
