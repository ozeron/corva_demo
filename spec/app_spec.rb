require 'spec_helper'
require 'app'

describe 'sinatra test' do
  let(:timestamp) { 1_493_758_596 }
  let(:body) do
    {
      timestamp: timestamp,
      data: [
        { title: 'Part 1', values: [0, 3, 5, 6, 2, 9] },
        { title: 'Part 2', values: [6, 3, 1, 3, 9, 4] }
      ]
    }
  end
  let(:request_id) { '12_345_678' }
  let(:response) do
    {
      'request_id' => request_id,
      'timestamp' => timestamp,
      'result' => { 'title' => 'Result', 'values' => [-6, 0, 4, 3, -7, 5] }
    }
  end

  it 'should compute correctly' do
    post "/compute/#{request_id}", body.to_json
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)).to eq(response)
  end

  context 'when data format is wrong or error' do
    let(:body) do
      {
        timestamp: timestamp,
        data: [
          { title: 'Part', values: [0, 3, 5, 6, 2, 9] },
          { title: 'Part 2', values: [6, 3, 1, 3, 9, 4] }
        ]
      }
    end
    it 'should return 500' do
      post "/compute/#{request_id}", body.to_json
      expect(last_response.status).to eq(500)
    end
  end
end
