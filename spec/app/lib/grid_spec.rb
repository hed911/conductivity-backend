require 'rails_helper'

RSpec.describe Grid, type: :model do

  describe 'creating an object' do
    it 'should raise an exception when values array is not square' do
      values = [
        [1, 0, 1],
        [0, 0, 0]
      ]
      expect { Grid.new(values) }.to raise_error(InvalidSize)
    end

    it 'should raise an exception when values content is not zero or one' do
      values = [
        [1, 0, 1],
        [0, 0, 0],
        [0, 0, 9] # bad value
      ]
      expect { Grid.new(values) }.to raise_error(InvalidData)
    end
  end

  describe 'continuous_path?' do
    it 'should be false for an empty array' do
      expect(Grid.new([]).has_continuous_path?).to be_falsey
    end

    it 'should be true for example #1' do
      values = [
        [1, 1, 1, 0],
        [1, 1, 0, 0],
        [1, 1, 0, 1],
        [1, 0, 0, 1],
      ]
      expect(Grid.new(values).has_continuous_path?).to be_truthy
    end

    it 'should be false for example #2' do
      values = [
        [1, 1, 1, 0],
        [1, 1, 0, 0],
        [0, 1, 0, 1],
        [1, 0, 0, 1]
      ]
      expect(Grid.new(values).has_continuous_path?).to be_falsey
    end

    it 'should be true for example #3' do
      values = [
        [1, 0, 1, 0, 1],
        [1, 1, 1, 1, 1],
        [0, 1, 0, 1, 0], 
        [1, 1, 1, 1, 1], 
        [1, 0, 1, 0, 1]
      ]
      expect(Grid.new(values).has_continuous_path?).to be_truthy
    end
  end

  describe 'find_continuous_paths' do
    it 'should return empty results' do
      grid = Grid.new([])
      grid.find_continuous_paths
      expect(grid.horizontal_path_indexes).to eq []
      expect(grid.vertical_path_indexes).to eq []
    end

    it 'should be true for example #1' do
      values = [
        [1, 1, 1, 0],
        [1, 1, 0, 0],
        [1, 1, 0, 1],
        [1, 0, 0, 1],
      ]
      grid = Grid.new(values)
      grid.find_continuous_paths
      expect(grid.horizontal_path_indexes).to eq []
      expect(grid.vertical_path_indexes).to eq [0]
      expect(grid.has_continuous_paths?).to be_truthy
    end

    it 'should be false for example #2' do
      values = [
        [1, 1, 1, 0],
        [1, 1, 0, 0],
        [0, 1, 0, 1],
        [1, 0, 0, 1]
      ]
      grid = Grid.new(values)
      grid.find_continuous_paths
      expect(grid.horizontal_path_indexes).to eq []
      expect(grid.vertical_path_indexes).to eq []
      expect(grid.has_continuous_paths?).to be_falsey
    end

    it 'should be true for example #3' do
      values = [
        [1, 0, 1, 0, 1],
        [1, 1, 1, 1, 1],
        [0, 1, 0, 1, 0], 
        [1, 1, 1, 1, 1], 
        [1, 0, 1, 0, 1]
      ]
      grid = Grid.new(values)
      grid.find_continuous_paths
      expect(grid.horizontal_path_indexes).to eq [1, 3]
      expect(grid.vertical_path_indexes).to eq []
      expect(grid.has_continuous_paths?).to be_truthy
    end
  end
end
