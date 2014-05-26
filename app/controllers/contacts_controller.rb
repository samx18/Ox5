class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end
			
	def create
		@contact = Contact.new(secure_params) 
		if @contact.valid?
			@contact.update_spreadsheet
			flash[:notice] = 'Awesome! We got you on the VIP list for early access.'
			redirect_to root_path 		
		else
			flash[:alert] = 'Oops! Does not look like we can reach you at that address.'
			redirect_to root_path
		end 
	end

	private

		def secure_params
			params.require(:contact).permit(:email)
		end

end