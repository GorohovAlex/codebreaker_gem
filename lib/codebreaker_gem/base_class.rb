module CodebreakerGem
  class BaseClass
    include CodebreakerGem::Validator

    def valid?
      validate
      @errors.empty?
    end

    private

    def validate
      raise NotImplementedError
    end
  end
end
