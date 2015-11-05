class SessionsController < ApplicationController
  include SessionsHelper
  def new

  end

  def create
    user = User.find_by_email(our_session[:email])
    if user && user.authenticate(our_session[:password])
      log_in(user)

      our_session[:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user

    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end


  private

    def our_session
      params[:session]
    end


end
