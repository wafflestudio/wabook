class BooksController < ApplicationController
  include ApplicationHelper
  include BooksHelper
  
  def index
	redirect_to :action => "pagination", :current_page => 1
  end

  def create
	if isRegistered?(params[:isbn])
		redirect_to :action => "new", :isRegisterd=> true
	else
		@book = Book.new(getBookFromISBN(params[:isbn]))
		@book.save
		redirect_to books_path
	end
  end

  def edit
  end

  def show
  end

  def delete
  end

  def update
  end

  def destory
  end

  def new
  	@newbook = Book.new
  end

  def pagination
    require 'nokogiri' 
    require 'open-uri' 
    rowsPerPage = 10;
    @current_page = params[:current_page]
    @books = Book.page(@current_page).per(rowsPerPage)
    @totalCnt = Book.all.count
    @totalPageList = getTotalPageList(@totalCnt, rowsPerPage)
    @books.each do |book|
      doc = Nokogiri::XML(open('http://book.interpark.com/api/search.api?key=BB76C57E2E5D09210AD11705A6102C4A9F469F0EA24C2BAF365CCF8A0DF81BCB&query=' + book.isbn + '&queryType=isbn'))  
      book.data = {cover: doc.xpath("//item[1]/coverLargeUrl").text, 
        description: doc.xpath("//item/description").text }
    end 
  end
end
