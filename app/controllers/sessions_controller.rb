class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_email(our_session[:email])
    if user && user.authenticate(our_session[:password])
      redirect_to user

    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end

  private
    def our_session
      params[:session]
    end

end
