class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  layout "main"
  
  def home
    @user = User.find(current_user.id); 
    @book = Book.new
  end
end
