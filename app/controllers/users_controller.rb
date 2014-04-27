class UsersController < ApplicationController
  include UsersHelper


  def write
      @usr = cookies[:logged_in]
  end

  def auth
  end

  def doAuth
      @usr = params[:ldapUser]
      @pass = params[:ldapPass]
      returnCode = testCredentials(@usr, @pass)
      if (returnCode == 0) 
          flash[:success] = "You're logged in"
          cookies[:logged_in] = @usr
          redirect_to write_path
      elsif (returnCode == 1) 
          flash.now[:danger] = "You seem to be wrong"
          render '_auth'
      else 
          flash.now[:danger] = "Sorry, only for Jacobs"
      end
  end


end
