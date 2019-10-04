require 'spec_helper'
require 'handler'

describe '#handle_request' do
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
      request_id: request_id,
      timestamp: timestamp,
      result: { title: 'Result', values: [-6, 0, 4, 3, -7, 5] }
    }
  end
  it 'return expected data' do
    expect(handle_request(body, request_id)).to eq(response)
  end
end

describe '#pairwise_difference' do
  context 'simple example' do
    let(:a) { [0, 3, 5, 6, 2, 9] }
    let(:b) { [6, 3, 1, 3, 9, 4]  }
    let(:result) { [-6, 0, 4, 3, -7, 5] }
    it 'returns difference' do
      expect(pairwise_difference(a, b)).to eq(result)
    end
  end

  context 'empty example' do
    let(:a) { [] }
    let(:b) { [] }
    let(:result) { [] }
    it 'returns difference' do
      expect(pairwise_difference(a, b)).to eq(result)
    end
  end

  context 'big example' do
    let(:a) { Array.new(100_000) { rand(100) } }
    let(:b) { a.clone }
    it 'returns zeros' do
      expect(pairwise_difference(a, b).all?(&:zero?)).to be true
    end
  end
end
