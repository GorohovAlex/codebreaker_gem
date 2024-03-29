module Codebreaker
  class GameStage < BaseClass
    attr_reader :step_number, :endgame, :attempts, :compare_result, :win
    attr_accessor :hint_used

    def initialize(attempts:)
      @attempts = attempts
      @compare_result = []
      @endgame = false
      @hint_used = 0
      @step_number = 0
    end

    def step(compare_result)
      @compare_result = compare_result
      @step_number += 1
      @win = @compare_result.length == Game::CODE_LENGTH && @compare_result.all?
      @endgame = true if !valide_allow_step? || @win
    end

    def valide_allow_step?
      @attempts >= @step_number
    end
  end
end
