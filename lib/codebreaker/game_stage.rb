module Codebreaker
  class GameStage < BaseClass
    attr_reader :step_number, :endgame, :attempts, :compare_result, :win
    attr_accessor :hint_used

    def initialize(attempts:)
      @step_number = 1
      @endgame = false
      @attempts = attempts
      @compare_result = []
      @hint_used = 0
    end

    def step(compare_result)
      @compare_result = compare_result
      @step_number += 1
      @win = @compare_result.length == Game::CODE_LENGTH && @compare_result.all?
      @endgame = true if !valide_allow_step? || @win
    end

    def valide_allow_step?
      return true if @attempts >= @step_number
      
      @errors[:game_stage] = 'allow_step_error'
      false
    end
  end
end
