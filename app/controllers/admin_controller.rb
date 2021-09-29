class AdminController < ApplicationController
  def login
  	if request.post?
  		if params[:name]=="admin" && params[:password]=="nimda"
  			session[:admin]="admin"
  			flash[:notice]="welcome Admin"
  			redirect_to stores_path
  		else
  			flash[:notice]="Invalid password or name"
  			redirect_to :action => :login
  		end
  	end
  end
  def logout
  	session[:admin]=nil
    flash[:notice]="You are logged out"
    redirect_to :action => :login
  end
end