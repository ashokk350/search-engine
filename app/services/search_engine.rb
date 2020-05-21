class SearchEngine
  def initialize
    @pages = []
    @queries = []
    @final_output = []
  end

  def prepare_input(file_data)
    file_data.split("\n").each do |line|
      if line.slice!(0,2) == "P "
        line = line.split(' ')
        @pages << line.each_with_index.inject({}) { |result, pair| result.merge!(pair.first.downcase => pair.last) }
      else
        @queries << line
      end
    end
  end

  def execute(file_data)
    prepare_input(file_data)
    @queries.each.with_index(1) do |query, query_index|
      output = {}
      @pages.each.with_index(1) do |page, index|
        result = calculate_strength_ratings(query, page)
        output = merge_result_to_output(index, result, output)
      end
      print_output(query_index, output)
    end

    @final_output
  end

  def calculate_strength_ratings(query, page)
    n = 8
    result = 0

    query.split(' ').each do |word|
      if page[word.downcase]
        result += (n * (8 - page[word.downcase]))
      end
      n -= 1
    end
    result
  end

  def merge_result_to_output(index, result, output)
    unless result.zero?
      if output[result]
        output[result] << "P#{index}"
      else
        output.merge!(result => ["P#{index}"])
      end
    end
    output
  end

  def print_output(query_index, output)
    result = []
    output.keys.sort.reverse.each do |key|
      output[key].each do |page_number|
        break if result.length >= 5
        result << page_number
      end
    end
    @final_output << result
    @final_output
  end
end