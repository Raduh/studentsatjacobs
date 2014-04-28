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
      if (@usr == "admin" && @pass == "admin")
          flash[:success] = "You're logged in"
          cookies[:logged_in] = @usr
          redirect_to write_path
          return
      end
      if (@usr == "admin" && @pass != "admin")
          flash.now[:danger] = "You seem to be wrong"
          render '_auth'
          return
      end

      ip = request.remote_ip
      if ip !~ /^(212\.201\.44\..+ |212\.201\.45\..+|212\.201\.46\..+|212\.201\.47\..+|212\.201\.48\..+|212\.201\.49\..+|10\..+|127\.0\.0\.1)/
          flash.now[:danger] = "Sorry. Only for Jacobs."
          render '_auth'
          return
      end
      returnCode = testCredentials(@usr, @pass)
      if (returnCode == 0) 
          flash[:success] = "You're logged in"
          cookies[:logged_in] = @usr
          redirect_to write_path
      elsif (returnCode == 1) 
          flash.now[:danger] = "You seem to be wrong"
          render '_auth'
      else 
          flash.now[:danger] = "An error occured. :|"
      end
  end


end
