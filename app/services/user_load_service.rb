
require 'csv'

class UserLoadService

	def import file

	  	@file = file
	 	CSV.foreach(@file.path, headers: true) do |row|
	 		r = row.to_hash 		
	 		user = User.create 	email_address: r['email_address'],
		 	 					first_name: r['first_name'],
		 	 					last_name: r['last_name']	
		 	
		 	if r['reporting_to_email_address'].present? 
		 		add_boss user, r['reporting_to_email_address']
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
	 				r = row.to_hash 		
	 				if r['email_address'] == reporting_to_email_address
	 					boss = User.create 	email_address: r['email_address'],
		 	 								first_name: r['first_name'],
		 	 								last_name: r['last_name']	
						
						# Setup the relationship to this boss
						created_worker.reports_to_user = boss
		 				created_worker.save

		 				# Check if the boss has a boss and recurse
						if r['reporting_to_email_address'].present? 
		 						add_boss boss, r['reporting_to_email_address']
		 				end
		 			end
		 		end	
		 	end	

	  	end

end
