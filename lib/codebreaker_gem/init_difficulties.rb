module InitDifficulties
  def init_difficulties
    difficulty = []
    difficulty << Difficulty.new(name: 'Easy', attempts: 15, hints: 2, level: 0)
    difficulty << Difficulty.new(name: 'Medium', attempts: 10, hints: 1, level: 1)
    difficulty << Difficulty.new(name: 'Hell', attempts: 5, hints: 1, level: 2)
  end
end
