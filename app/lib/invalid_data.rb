class InvalidData < StandardError
  def initialize(msg='Grid content not valid')
    super
  end
end
