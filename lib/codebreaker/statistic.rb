module Codebreaker
  class Statistic
    include YamlFile

    STAT_HEADER_LIST = %w[rating name difficulty attempts_total attempts_used hints_total hints_used date_saved].freeze
    STAT_FILE_PATH = 'statistic.yml'.freeze
    DATETIME_FORMAT = "%Y.%m.%d - %H:%M:%S".freeze

    attr_reader :statistic, :headings, :statistic_items
    def initialize
      @headings = STAT_HEADER_LIST
      @statistic_items = []
    end

    def statistic_get
      statistic_load
      statistic_sort
      @statistic_items.each_with_index.map do |stat, index|
        [index.next, stat[:name], stat[:difficulty], stat[:attempts_total],
         stat[:attempts_used], stat[:hints_total], stat[:hints_used]]
      end
    end

    def statistic_add_item(name:, difficulty:, game_stage:)
      @statistic_items << { name: name,
                            difficulty: difficulty.name,
                            attempts_total: game_stage.attempts,
                            attempts_used: game_stage.step_number,
                            hints_total: difficulty.hints,
                            hints_used: game_stage.hint_used,
                            date_saved: Time.now.strftime(DATETIME_FORMAT) }
    end

    def statistic_save
      YamlFile.save(STAT_FILE_PATH, @statistic_items)
    end

    private

    def statistic_load
      return unless File.file?(STAT_FILE_PATH) && File.size(STAT_FILE_PATH).positive?

      @statistic_items = YamlFile.load(STAT_FILE_PATH)
    end

    def statistic_sort
      @statistic_items.sort_by! do |stat|
        [stat[:attempts_total] + stat[:hints_total],
         stat[:attempts_used], stat[:hints_used]]
      end
    end
  end
end
