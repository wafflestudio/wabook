class BooksController < ApplicationController
  include ApplicationHelper
  include BooksHelper
  
  layout "application"

  def index
	redirect_to pagination_path(:current_page => 1)
  end

  def new
  	@book = Book.new
	@isRegistered = params[:isRegistered]
	@incorrectISBN = params[:incorrectISBN]
  end

  def create
  	@book = Book.new(book_params)
	@incorrectISBN = !isCorrectISBN?(book_params[:isbn])
	@isRegistered = isRegistered?(book_params[:isbn])

	if @incorrectISBN
		render :action => "new", :incorrectISBN => true
	elsif @isRegistered
		render :action => "new", :isRegistered=> true
	else
		@book = Book.new(getBookFromISBN(book_params[:isbn]))
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


  def pagination
    require 'nokogiri' 
    require 'open-uri' 
    rowsPerPage = 10;
    @current_page = params[:current_page]

	if @current_page.to_i < 1
		@current_page = 1.to_s
	end

    @books = Book.page(@current_page).per(rowsPerPage)
    @totalCnt = Book.all.count
    @totalPageList = getTotalPageList(@totalCnt, rowsPerPage)
    @books.each do |book|
      doc = Nokogiri::XML(open('http://book.interpark.com/api/search.api?key=BB76C57E2E5D09210AD11705A6102C4A9F469F0EA24C2BAF365CCF8A0DF81BCB&query=' + book.isbn + '&queryType=isbn'))  
      book.data = {cover: doc.xpath("//item[1]/coverLargeUrl").text, 
        description: doc.xpath("//item/description").text }
    end
  end
  
  private
  def book_params
  	params.require(:book).permit(:isbn)
  end
end 
