module Codebreaker
  class Difficulty
    attr_reader :name, :attempts, :hints

    def initialize(name:, attempts:, hints:)
      @name = name
      @attempts = attempts
      @hints = hints
    end
  end
end
