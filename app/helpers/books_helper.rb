module BooksHelper
	def isCorrectISBN?(isbn)
	Rails.logger.info isbn
		book_data = getBookFromISBN(isbn)
		if book_data["title"] == ""
		Rails.logger.info "incorrect!"
			return false
		else
			return true
		end
	end

	def isRegistered?(isbn)
		books = Book.all
		books.each do |b|
			if b.isbn == isbn
				return true
			end
		end
		return false
	end

	def getBookFromISBN(isbn)
		require 'nokogiri'
		require 'open-uri'
		doc =
		Nokogiri::XML(open('http://book.interpark.com/api/search.api?key=BB76C57E2E5D09210AD11705A6102C4A9F469F0EA24C2BAF365CCF8A0DF81BCB&query='+
					isbn + '&queryType=isbn'))

		book_data = {}
		book_data["isbn"] = isbn
		book_data["title"] = doc.xpath("//item/title").text

		book_data["category"] = doc.xpath("//item/categoryName").text
		book_data["publisher"] = doc.xpath("//item/publisher").text
		book_data["returned"] = true
		book_data["author"] = doc.xpath("//item/author").text
		return book_data
	end
end
