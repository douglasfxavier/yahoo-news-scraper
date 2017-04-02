require_relative 'News'
require 'nokogiri'
require 'open-uri'
require 'openssl'


OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG = 1

	@arquivo_saida = File.open("News.csv", 'w')
	@arquivo_saida.puts "index|headline|lead"
	

def get_news (url)

	doc = Nokogiri::HTML(open(url))

	test_result_page = File.open("test_page.html", "w")
	test_result_page.write(doc.to_s)

	index = 0

	doc.xpath('.//ul[@id="Stream"]/li').each do |li|

		#Iterando sobre as notícias
		headline = li.xpath('.//h3/a//text()')
		next if headline.empty?
		lead  = li.xpath('.//div/p/text()')
		index += 1
		single_news = News.new(index,headline,lead)

		#Gravando em arquivo_saida
		@arquivo_saida.write single_news.to_csv_line
		@arquivo_saida.puts @string
		
		#Imprimindo dados na tela
		single_news.to_s			

	end
end

begin
	url = "https://br.yahoo.com/"
	puts "\n\n\nNOTÍCIAS DO DIA #{Time.now.strftime("%d/%m/%Y")} no site #{url}\n\n\n"
	get_news(url)
end
	
	


