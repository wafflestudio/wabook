class UsersController < ApplicationController
  def show
  	@user = User.find(current_user.id)
	@curr_checkouts = current_user.checkouts.find_all_by_returned(false)
	@prev_checkouts = current_user.checkouts.find_all_by_returned(true)

  end

  def edit
  end

  def update
  end

  def destroy
  end
end
