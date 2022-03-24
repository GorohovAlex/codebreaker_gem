module Codebreaker
  class BaseClass
    include Validator

    def valid?
      @errors = {}
      validate
      @errors.empty?
    end

    private

    def validate
      raise NotImplementedError
    end
  end
end
