module BooksHelper
	def isCorrectISBNBook?(book)
		Rails.logger.info book.isbn
		if book.title == ""
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
		require 'json'
		interpark_doc =
		Nokogiri::XML(open('http://book.interpark.com/api/search.api?key=BB76C57E2E5D09210AD11705A6102C4A9F469F0EA24C2BAF365CCF8A0DF81BCB&query='+
					isbn + '&queryType=isbn'))
		openlibrary_doc =
		JSON.load(open('https://openlibrary.org/api/books?bibkeys=ISBN:'+ 
					isbn + '&format=json&jscmd=data'))["ISBN:" + isbn]
		book_data = {}
		book_data["isbn"] = isbn
		if interpark_doc.xpath("//item/title").text != ''
			book_data["title"] = interpark_doc.xpath("//item/title").text

			book_data["category"] = interpark_doc.xpath("//item/categoryName").text
			book_data["publisher"] = interpark_doc.xpath("//item/publisher").text
			book_data["returned"] = true
			book_data["author"] = interpark_doc.xpath("//item/author").text
			book_data["cover_url"] = interpark_doc.xpath("//item[1]/coverLargeUrl").text
			book_data["description"] = interpark_doc.xpath("//item/description").text
		elsif openlibrary_doc != nil
			book_data["title"] = openlibrary_doc["title"]

			book_data["category"] = "외국도서"
			book_data["publisher"] = openlibrary_doc["publishers"][0]["name"]
			book_data["returned"] = true
			book_data["author"] = openlibrary_doc["authors"][0]["name"]
			book_data["cover_url"] = openlibrary_doc["cover"]["medium"]
			book_data["description"] = ""
		else
			return nil
		end
		return book_data
	end
end
