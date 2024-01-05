class GridEvaluation < ApplicationRecord
  include TimestampConverter
  serialize :values, JSON

  after_save :update_grid_instance
  validate :validate_grid_data

  def grid
    @grid ||= Grid.new(values)
  end

  def values=(value)
    update_grid_instance value
  rescue InvalidSize, InvalidData => e
    Rails.logger.error "[update_grid_instance] Exception #{e.class}: #{e.message}"
  ensure
    self[:values] = value
  end

  private

  def update_grid_instance(new_values = values)
    @grid = Grid.new(new_values)
  end

  def validate_grid_data
    Grid.new(values)
  rescue InvalidSize, InvalidData => e
    Rails.logger.error "[update_grid_instance] Exception #{e.class}: #{e.message}"
    errors.add(:values, 'Invalid grid data')
  end
end
