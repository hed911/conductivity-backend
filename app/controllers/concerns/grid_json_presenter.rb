module GridJsonPresenter
  extend ActiveSupport::Concern
  
  private

  def render_paths
    render json: {
      payload: {
        vertical_path_indexes: @grid.vertical_path_indexes,
        horizontal_path_indexes: @grid.horizontal_path_indexes,
        has_paths: @grid.has_continuous_paths?
      }
    }
  end

  def render_grids
    render json: { payload: @records.map { |r| format_record(r) } }
  end

  def render_grid
    render json: { payload: format_record(@record) }
  end

  def render_clear_summary
    render json: { payload: { deleted_records: @count } }.to_json
  end

  def format_record(record)
    { 
      id: record.id,
      values: record.values,
      timestamp: record.timestamp,
      vertical_path_indexes: record.grid.vertical_path_indexes,
      horizontal_path_indexes: record.grid.horizontal_path_indexes
    }
  end
end