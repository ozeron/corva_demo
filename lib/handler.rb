# frozen_string_literal: true

def handle_request(body, request_id)
  timestamp = body.fetch(:timestamp)
  data = body.fetch(:data)
  part1 = data.find { |e| e.fetch(:title) == 'Part 1' }
  part2 = data.find { |e| e.fetch(:title) == 'Part 2' }
  values = pairwise_difference(part1.fetch(:values), part2.fetch(:values))
  {
    request_id: request_id,
    result: { title: 'Result', values: values },
    timestamp: timestamp
  }
end

def pairwise_difference(list_a, list_b)
  # after perfomance testing this method is faster than #zip
  list_a.map.with_index { |el, index| el - list_b[index] }
end
