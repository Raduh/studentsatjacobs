class UsersController < ApplicationController
  include UsersHelper

  def auth
  end

  def doAuth
      @usr = params[:ldapUser]
      @pass = params[:ldapPass]

      if isUserLegit?(@usr, @pass)
          flash[:success] = "You're logged in"
          cookies[:logged_in] = @usr
          render 'auth'
      else
          flash[:danger] = "You seem to be wrong"
          render 'auth'
      end
  end


end
