class BaseClass
  include Validator

  def valid?
    validate
    @errors.empty?
  end

  private

  def validate
    raise NotImplementedError
  end
end
