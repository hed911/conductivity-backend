class GridsController < ApplicationController
  include ControllerUtils
  include GridJsonPresenter
  skip_before_action :verify_authenticity_token

  def find_paths
    @grid = Grid.new JSON.parse(permitted_params[:values])
    @grid.find_continuous_paths
    render_paths
  end

  def index
    @records = klass
                .order(created_at: :desc)
                .paginate(page: index_params[:page] || 1, per_page: index_params[:size] || 10)
    
    @records.each { |r| r.grid.find_continuous_paths }
    render_grids
  end

  def create
    values = JSON.parse(permitted_params[:values])
    @record = klass.create!(values:)
    @record.grid.find_continuous_paths
    render_grid
  end

  def clear
    @count = klass.count
    klass.destroy_all
    render_clear_summary
  end

  private

  def klass
    GridEvaluation
  end

  def params_list
    %i[id values]
  end

  def index_params
    params.permit %i[page size]
  end
end