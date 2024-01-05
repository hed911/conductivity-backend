class InvalidSize < StandardError
  def initialize(msg='Grid size is not valid')
    super
  end
end
