class CreateGridEvaluations < ActiveRecord::Migration[7.0]
  def change
    create_table :grid_evaluations do |t|
      t.text :values, null: false, default: '[]'
      t.timestamps
    end
  end
end
