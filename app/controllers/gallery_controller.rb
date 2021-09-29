class GalleryController < ApplicationController
  def index
  	@shoe=Store.all
  end

  def search
  	keyword="%"+params[:search].to_s+"%"
  	@shoe = Store.find_by_sql ["Select * from stores WHERE name like ? or brand like ? or color like ? or description like ?",keyword,keyword,keyword,keyword]
  	
  end

  def purchase_complete
  end

  def checkout

  	require 'active_merchant'

	# Use the TrustCommerce test servers
	ActiveMerchant::Billing::Base.mode = :test

	gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
	            :login => 'TestMerchant',
	            :password => 'password')

	# ActiveMerchant accepts all amounts as Integer values in cents
	amount = session[:amount].to_i  # $10.00
	# The card verification value is also known as CVV2, CVC2, or CID
	credit_card = ActiveMerchant::Billing::CreditCard.new(
	                :first_name         => params[:first_name],
                    :last_name          => params[:last_name],
                    :number             => params[:number],
                    :month              => params[:month],
                    :year               => params[:year],
                    :verification_value => params[:verification_value])

	# Validating the card automatically detects the card type
	if credit_card.validate.empty?
	  # Capture $10 from the credit card
	  response = gateway.purchase(amount, credit_card)

	  if response.success?
	  	EmailerMailer.payment_details(params,amount).deliver
	  	redirect_to gallery_purchase_complete_path
	    flash[:notice]="Successfully charged Rs. #{number_to_indian_currency(amount.to_f)} to the credit card #{credit_card.display_number}"
	  else
	  	raise StandardError, response.message
	  	
	  	render gallery_checkout_path
	  end
	end


  end
  def number_to_indian_currency(number)
	  if number.present?
	    string = number.to_s.split('.')
	    number = string[0].gsub(/(\d+)(\d{3})$/){ p = $2;"#{$1.reverse.gsub(/(\d{2})/,'\1,').reverse},#{p}"}
	    number = number.gsub(/^,/, '') + '.' + string[1] if string[1] # remove leading comma
	    number = number[1..-1] if number[0] == 44
	  end
	  "₹ #{number}"
	end
end
