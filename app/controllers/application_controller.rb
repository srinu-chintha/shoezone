class ApplicationController < ActionController::Base
	#before_action :authenticate_user!
	def after_sign_in_path_for(user)
		if $flag==0
	    	home_index_path
	    else
	    	"/carts/#{$present_cart}"
	    end
	end

	def after_sign_out_path_for(scope)
	    user_session_path
	end
	def current_cart
		begin
			Cart.find(session[:cart_id])
		rescue  ActiveRecord::RecordNotFound
			cart=Cart.create
			session[:cart_id]=cart.id
			cart
		end
	end
end
