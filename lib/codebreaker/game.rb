module Codebreaker
  class Game < BaseClass
    include InitDifficulties

    CODE_LENGTH = 4
    CODE_NUMBERS = ('1'..'6').freeze

    attr_reader :statistic, :difficulties, :difficulty, :errors #:game_stage
    attr_accessor :user, :hint_code

    def initialize
      @errors = {}
      @statistic = Statistic.new
      @difficulties = init_difficulties
    end

    def user_code_valid_length?(user_code)
      return true if validate_length?(user_code, CODE_LENGTH..CODE_LENGTH)

      @errors[:user_code] = 'error_user_code_length'
      false
    end

    def validate_user_code_number_range?(user_code)
      return true if validate_number_range?(user_code, CODE_NUMBERS)

      @errors[:user_code] = 'error_user_code_number'
      false
    end

    def difficulty=(difficulty)
      @difficulty = @difficulties.detect { |value| value.name == difficulty }
    end

    def game_start
      generate_secret_code
      generate_hints unless @difficulty.nil?
      @game_stage = GameStage.new(user_code_length: CODE_LENGTH, attempts: @difficulty.attempts)
    end

    def game_step(match_codes)
      return unless user_code_valid?(match_codes)

      @user_code_positions = get_code_positions(match_codes)
      @game_stage.step(compare_codes(match_codes))
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
      @statistic.statistic_add_item(name: user.username, difficulty: @difficulty, game_stage: @game_stage)
      @statistic.statistic_save
    end

    private

    def user_code_valid?(user_code)
      return unless user_code_valid_length?(user_code)
      return unless validate_user_code_number_range?(user_code)

      true
    end

    def difficulty_valid?
      return true unless @difficulty.nil? || @difficulty.empty?

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
      @secret_code_positions = get_code_positions(@secret_code)
      generate_hints
    end

    def validate
      @errors = {}
      difficulty_valid?
    end
  end
end
