class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end
			
	def create
		@contact = Contact.new(secure_params) 
		if @contact.valid?
			@contact.update_spreadsheet
			flash[:notice] = 'You have been added'
			redirect_to root_path 		
		else
			flash[:alert] = 'Not a valid email'
			redirect_to root_path
		end 
	end

	private

		def secure_params
			params.require(:contact).permit(:email)
		end

end