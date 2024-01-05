require 'rails_helper'

RSpec.describe GridEvaluation, type: :model do
  it 'should prevent save an invalid grid' do
    grid_evaluation = GridEvaluation.new(values: [[1, 9], [1, 0]])
    expect(grid_evaluation.valid?).to be_falsey
  end

  it 'should create a new instance of the inner Grid after saving' do
    grid_evaluation = GridEvaluation.new(values: [[1, 1], [1, 0]])
    old_object_id = grid_evaluation.grid.object_id
    grid_evaluation.values = [[0, 0], [1, 0]]
    grid_evaluation.save
    expect(old_object_id).not_to eq grid_evaluation.grid.object_id
  end
end
