require 'rails_helper'

RSpec.describe GridsController, type: :controller do
  describe 'GET index' do
    it 'should return empty when there are no grids in database' do
      get :index
      parsed_response = JSON.parse response.body
      expect(response.status).to eq 200
      expect(parsed_response['payload']).to eq []
    end

    it 'should return grids in database including the fields: id, values and timestamp' do
      GridEvaluation.create(values: [[1, 0], [0, 1]])
      last = GridEvaluation.create(values: [[0, 1], [1, 0]])

      get :index
      parsed_response = JSON.parse response.body

      expect(response.status).to eq 200
      expect(parsed_response['payload'].count).to eq 2
      expect(parsed_response['payload'][0]['id']).to eq last.id
      expect(parsed_response['payload'][0]['values']).to eq last.values
      expect(parsed_response['payload'][0]['timestamp']).to eq last.timestamp
    end
  end

  describe 'GET find_paths' do
    it 'should return errors in payload when values param is not valid' do
      get :find_paths, params: { values: '[[1, 9], [0, 1]]' }
      parsed_response = JSON.parse response.body
      expect(response.status).to eq 400
      expect(parsed_response['errors']).to eq ['Grid content not valid']
    end

    it 'should return calculate result for a grid with paths' do
      get :find_paths, params: { values: '[[1, 0], [1, 0]]' }
      parsed_response = JSON.parse response.body

      expect(response.status).to eq 200
      expect(parsed_response['payload']['vertical_path_indexes']).to eq [0]
      expect(parsed_response['payload']['horizontal_path_indexes']).to eq []
      expect(parsed_response['payload']['has_paths']).to be_truthy
    end
  end

  describe 'POST create' do
    it 'should return errors in payload when values param is not valid' do
      post :create, params: { values: '[[1, 9], [0, 1]]' }
      parsed_response = JSON.parse response.body
      expect(response.status).to eq 400
      expect(parsed_response['errors']).to eq ['Validation failed: Values Invalid grid data']
    end

    it 'should create a new record for valid params' do
      post :create, params: { values: '[[1, 1], [0, 1]]' }
      parsed_response = JSON.parse response.body
      expect(response.status).to eq 200
      expect(parsed_response['payload']['values']).to eq [[1, 1], [0, 1]]
    end
  end

  describe 'POST clear' do
    it 'should remove all records in the GridEvaluation model' do
      GridEvaluation.create(values: [[1, 0], [0, 1]])
      GridEvaluation.create(values: [[0, 1], [1, 0]])

      delete :clear
      parsed_response = JSON.parse response.body

      expect(response.status).to eq 200
      expect(parsed_response['payload']['deleted_records']).to eq 2
      expect(GridEvaluation.count).to eq 0
    end
  end
end