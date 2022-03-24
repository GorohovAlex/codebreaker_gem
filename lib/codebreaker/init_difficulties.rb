module Codebreaker
  module InitDifficulties
    def init_difficulties
      [
        Difficulty.new(name: 'Easy', attempts: 15, hints: 2, level: 0),
        Difficulty.new(name: 'Medium', attempts: 10, hints: 1, level: 1),
        Difficulty.new(name: 'Hell', attempts: 5, hints: 1, level: 2)
      ]
    end
  end
end
