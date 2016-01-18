class UsersController < ApplicationController

  layout 'application'
  def show
  	@user = User.find(current_user.id)
	@curr_checkouts = current_user.checkouts.find_all_by_returned(false)
	@prev_checkouts = current_user.checkouts.find_all_by_returned(true)

  end

  def index
    if !current_user.is_admin 
      redirect_to :controller => 'books', :action => 'lend_return'
    else
  	  @users = User.all
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def rank
    @users = User.order(:point => :desc).take(5)
  end

  def lend_user
    @checkouts = Checkout.find_all_by_returned(false)
    @books = {}
    @users = @checkouts.map{ |c| c.user }
    @users.each do |u|
      @books[u] = u.checkouts.select{|c| c.returned == false}.map { |c| c.book }
    end
  end

  def late_user
    @checkouts = Checkout.find_all_by_returned(false)
    @checkouts = @checkouts.select{|c| c.duedate < Time.now+9.hours }
    @books = {}
    @users = @checkouts.map{ |c| c.user }
    @users.each do |u|
      @books[u] = u.checkouts.select{|c| c.returned == false}.map { |c| c.book }
    end
  end
  def prolong
    @checkout = Checkout.find(params[:id])

    if @checkout.prolongcount >= 2
      render :json => {status: "error"}
    else
      @checkout.duedate = @checkout.duedate+7.day
      @checkout.prolongcount = @checkout.prolongcount+1
      @checkout.save
      render :json => {status: "OK"}
      #render :json => @checkout.to_json
    end
  end

end
