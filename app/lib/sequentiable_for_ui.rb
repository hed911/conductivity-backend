module SequentiableForUi
  def find_continuous_paths
    @vertical_path_indexes = []
    @horizontal_path_indexes = []
    find_paths(@values)
    find_paths(@values.transpose, transposed: true)
  end

  def has_continuous_paths?
    @vertical_path_indexes.present? || @horizontal_path_indexes.present?
  end

  private

  def find_paths(values, opts = { transposed: false })
    variable = opts[:transposed] ? @vertical_path_indexes : @horizontal_path_indexes
    values.each_with_index { |array, i| variable << i if array.uniq == [1] }
  end
end
