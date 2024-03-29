module Codebreaker
  class User < BaseClass
    USERNAME_LENGTH_RANGE = (3..20).freeze

    attr_reader :username, :errors

    def initialize(username_new)
      @username = username_new
      @errors = {}
    end

    private

    def validate
      @errors[:user] = 'error_name_length' unless validate_length?(@username, USERNAME_LENGTH_RANGE)
    end
  end
end
