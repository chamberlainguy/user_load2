class UsersController < ApplicationController
  	
  def index
  	@users = User.all
  end

  def import
  	UserLoadService.new.import params[:file]
  	redirect_to root_url, notice: "New User data imported!"
  end

end
