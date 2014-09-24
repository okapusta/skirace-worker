class Formatter
  takes :json_parser
  def time_format(response)
    parsed_response = json_parser.parse(response)
    
    <<-eos
      #{parsed_response['first_name']} #{parsed_response['last_name']} \n
      time: #{parsed_response['total_time']}
    eos
  end
end