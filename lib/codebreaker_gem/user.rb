class User < BaseClass
  attr_reader :username

  def initialize(username_new)
    @username = username_new
    @errors = []
  end

  private

  def validate
    @errors << 'error_name_length' unless validate_length?(@username, USERNAME_LENGTH_RANGE)
  end
end
