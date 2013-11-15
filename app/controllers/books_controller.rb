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
    respond_to do |format|
      format.html { render :layout => 'main' }
    end
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

  def lend_return
    @books = Book.find_all_by_isbn(book_params[:isbn])

    if @books.count == 0
      @bookNotExist = true
    elsif @books.count == 1
      @isOnlyBook = true
      @bookNotExist = false
    else
      @isOnlyBook = false
      @bookNotExist = false
    end

    @checkouts = Checkout.all
    @checkouts = @checkouts.select {|c| c.user_id == current_user.id and c.book.isbn == book_params[:isbn] and c.returned == false}

    if @checkouts.count == 0 
      @lendBook = true
      @returnBook = false
    else
      @lendBook = false
      @returnBook = true
    end
    
    if @lendBook
      @books = @books.select {|b| b.returned == true}  
      if @books.count == 0
        @isPossible = false
      else
        @isPossible = true
        @book = @books[0]
      end
    else
      @checkout = @checkouts[0]
      @book = @checkout.book
    end

    if @lendBook and not @isPossible and not @bookNotExist # 대신 반납하는 경우
      @lendBook = false
      @returnBook = true
      @book = Book.find_all_by_isbn(book_params[:isbn])
      @book = @book[0]
      @checkout = @book.checkouts.last

      @returnOthersBook = true
      @other_user = @checkout.user
    end
    Rails.logger.info @bookNotExist
    Rails.logger.info @lendBook
    Rails.logger.info @returnBook
    Rails.logger.info @isPossible
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
