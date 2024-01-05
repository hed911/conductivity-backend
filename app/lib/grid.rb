require 'matrix'
class Grid
  include Sequentiable
  include SequentiableForUi
  attr_accessor :vertical_path_indexes, :horizontal_path_indexes

  def initialize(values)
    @values = values
    @length = values.length

    raise(InvalidSize, 'Array should be squared') unless square_matrix?
    raise InvalidData unless valid_data?
  end

  private

  def square_matrix?
    Matrix[*@values].square?
  end

  def valid_data?
    unique_values = @values.flatten.uniq.sort
    unique_values.length <= 2 && unique_values.all? { |v| [0, 1].include?(v) }
  end
end
