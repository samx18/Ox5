class Contact < ActiveRecord::Base 
	has_no_table
	column :email, :string
	validates_presence_of :email
	validates :email, email_format: { message: "doesn't look like an email address" }
	def update_spreadsheet
		connection = GoogleDrive.login(ENV["GMAIL_USERNAME"], ENV["GMAIL_PASSWORD"])
		ss = connection.spreadsheet_by_title('Oxign-PreLaunch-SignUp')
		if ss.nil?
			ss = connection.create_spreadsheet('Oxign-PreLaunch-SignUp') 
		end
		ws = ss.worksheets[0] 
		last_row = 1 + ws.num_rows 
		ws[last_row, 1] = Time.new 
		ws[last_row, 2] = self.email
		ws.save
	end
end