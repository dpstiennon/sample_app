class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
    @gravatar_url = get_gravatar_url @user
  end


  private
  def get_gravatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    return gravatar_url
  end

end
