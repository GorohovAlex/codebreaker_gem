module Codebreaker
  class GameStage
    attr_reader :step_number, :endgame, :attempts, :compare_result, :win
    attr_accessor :hint_used

    def initialize(match_code_length:, attempts:)
      @step_number = 1
      @endgame = false
      @attempts = attempts
      @compare_result = []
      @match_code_length = match_code_length
      @hint_used = 0
    end

    def step(compare_result)
      @compare_result = compare_result
      @step_number += 1
      @win = @compare_result.length == @match_code_length && @compare_result.all?
      @endgame = true if @step_number > @attempts || @win
    end
  end
end
