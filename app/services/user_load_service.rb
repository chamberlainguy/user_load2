
require 'csv'

class UserLoadService

	def import file

	  	@file = file
	 	CSV.foreach(@file.path, headers: true) do |row|
	 		
	 		user = User.create 	email_address: row['email_address'],
		 	 					first_name: row['first_name'],
		 	 					last_name: row['last_name']	
		 	
		 	if row['reporting_to_email_address'].present? 
		 		add_boss user, row['reporting_to_email_address']
		 	end
	 	end 

	end

  	private

	  	def add_boss created_worker, reporting_to_email_address

	  		boss = User.find_by email_address: reporting_to_email_address
	 		if boss
	 			# Setup the relationship to this boss
	 			created_worker.reports_to_user = boss
		 		created_worker.save
		 	else
		 		# Check CSV file for boss
		 		CSV.foreach(@file.path, headers: true) do |row|
	 					
	 				if row['email_address'] == reporting_to_email_address
	 					boss = User.create 	email_address: row['email_address'],
		 	 								first_name: row['first_name'],
		 	 								last_name: row['last_name']	
						
						# Setup the relationship to this boss
						created_worker.reports_to_user = boss
		 				created_worker.save

		 				# Check if the boss has a boss and recurse
						if row['reporting_to_email_address'].present? 
		 						add_boss boss, row['reporting_to_email_address']
		 				end
		 				return
		 			end
		 		end	
		 	end	

	  	end

end
