class EmailerMailer < ApplicationMailer
	# @user=session[:user]

	def payment_details(details,amount)
		@name=details[:first_name]
		@amount=number_to_indian_currency(amount)
		mail(to: $em1,
    	subject: 'Payment Successful..!')
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
