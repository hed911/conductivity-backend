module Sequentiable
  def has_continuous_path?
    has_path?(@values) || has_path?(@values.transpose)
  end

  private

  def has_path?(values)
    values.any? { |array| array.uniq == [1] }
  end
end
