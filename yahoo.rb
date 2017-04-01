require_relative 'News'
require 'nokogiri'
require 'open-uri'
require 'openssl'


OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG = 1

	@arquivo_saida = File.open("News.csv", 'w')
	

def get_news (url)

	doc = Nokogiri::HTML(open(url))
	@arquivo_saida.puts "index|headline|lead"

	index = 0

	doc.xpath('.//ul[@class = "Bleed Mt-neg-10 Mb-0 ResetChildren Wow-bw Divided-h"]/li').each_with_index do |li,i|
		
		#Iterando sobre as notícias
		headline = li.xpath('.//a[@class = "js-stream-content-link Mend-4"]/text()')
		#next if headline.empty?
		lead  = li.xpath('.//p[@class = "Mb-2"]/text()')
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
	
	


