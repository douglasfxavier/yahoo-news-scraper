class News

	attr_reader :index
	attr_reader :headline
	attr_reader :lead
	
	def initialize (index, headline, lead)
		@index = index
		@headline = headline
		@lead = lead
	end
	
	def to_s
			puts "Notícia n.º #{@index}"
			puts "----------------------------------------------------------------------------"
			puts  "#{@headline}".upcase
			puts "----------------------------------------------------------------------------"
			puts @lead
			puts "\n\n\n"
	end
	
	def to_csv_line    		
		column_separator = "|"
		return  "#{@index} #{column_separator} #{@headline} #{column_separator} #{@lead} #{column_separator}"
	end
end