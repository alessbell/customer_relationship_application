require_relative 'contact'
require_relative 'rolodex'

class CRM
	attr_reader :name, :id, :first_name, :last_name, :email, :notes

	def self.run(name)
		crm = new(name)
		crm.main_menu
	end

	def initialize(name)
		@name = name
		@attributes = ["First Name", "Last Name", "Email", "Note", "ID"]
		@rolodex = Rolodex.new
		@rolodex.add_new_contact(Contact.new("Alessia", "Bellisario", "a@abc.com", "Hey there"))
		@rolodex.add_new_contact(Contact.new("Martina", "Bellisario", "m@nbc.com", "O hai"))
		@rolodex.add_new_contact(Contact.new("Luca", "Bellisario", "l@buzzfeed.com", "Hola"))
		@rolodex.add_new_contact(Contact.new("Barack", "Obama", "president@ofamerica.com", "Howdy"))
		puts "Welcome to #{name}"
		main_menu
	end

	def print_main_menu
		spacer
		puts "[1] Add a new contact"
		puts "[2] Modify an existing contact"
		puts "[3] Delete a contact"
		puts "[4] Display all the contacts"
		puts "[5] Display an attribute"
		puts "[6] Exit"
		puts "Enter a number: "
	end

	def main_menu
		print_main_menu
		user_selected = gets.to_i
		call_option(user_selected)
	end

	def spacer
		puts "-~-~-~-~-~-~-~-~-~-~-~-"
	end

	def call_option(user_selected)
		case user_selected
		when 1 then add_new_contact
		when 2 then modify_existing_contact
		when 3 then delete_contact
		when 4 then display_all_contacts
		when 5 then display_attribute
		when 6 then
			puts "Stay classy, Toronto."
			return
		else
			puts "Invalid option. Please try again."
		end
	end

	def print_attribute_list
		spacer
		@attributes.each_with_index { |attribute, index| puts "[#{index + 1}] #{attribute}"}
		spacer
	end

	def add_new_contact
		prompt(@attributes[0])
		first_name = gets.chomp

		prompt(@attributes[1])
		last_name = gets.chomp

		prompt(@attributes[2])
		email = gets.chomp

		prompt(@attributes[3])
		notes = gets.chomp
		@rolodex.add_new_contact(Contact.new(first_name, last_name, email, notes))
		main_menu
	end

	def search_contacts
		print_attribute_list
		puts "Please select which attribute you would like to search by:"
		attribute_index = gets.chomp.to_i
		prompt(@attributes[attribute_index -1])
		search_term = gets.chomp
		results = @rolodex.search(attribute_index, search_term)
		if @rolodex.contacts.empty?
			empty_error
		elsif results.empty?
			puts "Your search returned no results. Press enter to return to the Main Menu"
			gets.chomp
		elsif results.size == 1
			contact_card(results)
			return results[0]
			main_menu
		else
			list_results(results)
			puts "Please select the contact:"
			selection = gets.chomp.to_i
			contact_selection = []
			contact_selection << results[selection - 1]
			contact_card(contact_selection)
			return contact_selection[0]
			main_menu
		end
	end

	def attribute_format(array)
		if array.empty?			
			empty_error
		else
			array.each_with_index do |attribute, index|
				puts "[#{index}]  | #{attribute}|"
		end
	end

	def clear_term
		puts "\e[H\e[2J"
	end

	def contact_card(array)
		array.each do |contact|
				puts "#{@attributes[0]}: #{contact.first_name}"
				puts "#{@attributes[1]}: #{contact.last_name}"
				puts "#{@attributes[2]}: #{contact.email}"
				puts "#{@attributes[3]}: #{contact.notes}"
				puts "#{@attributes[4]}: #{contact.id}"
		end
	end

	def prompt(attribute)
		puts "Please enter the #{attribute}:"
	end

	def display_all_contacts
		# @rolodex.display_all_contacts
		# "#{first_name} #{last_name}, email: #{email}. Notes: #{notes}"
			# array.each_with_index do |match, index|
				# puts "[#{index + 1}]  |First Name: #{match.first_name} | Last Name: #{match.last_name} | Email Address: #{match.email} | Notes: #{match.note} | ID: #{match.id}"
			results = @rolodex.spew_contacts
			results.empty? ? empty_error : contact_card(results)
			main_menu
		end
	end

	def display_attribute
		# puts "Select an attribute: "
		# puts "[1] First name"
		# puts "[2] Last name"
		# puts "[3] Email address"
		# puts "[4] Note"
		# puts "[5] Id"
		# att_select = gets.chomp
		# @contacts.each do |x|
		# 	case att_select
		# 	when "1"
		# 		puts x.first_name
		# 	when "2"
		# 		puts x.last_name
		# 	when "3"
		# 		puts x.email
		# 	when "4"
		# 		puts x.notes
		# 	when "5"
		# 		puts x.id
		# 	end
		print_attribute_list
		puts "Select the attribute would you like to display:"
		attribute_index = gets.chomp.to_i
		results = @rolodex.spew_attributes(attribute_index)
		spacer
		attribute_format(results)
	end

	def empty_error
		puts "#{@name} is currently empty. Please add a contact and try again!"
		main_menu
	end

	def delete_contact
		contact = search_contacts
		# filter("delete")
		@rolodex.delete(contact)
		# confirmation("deleted")
		main_menu
	end

	def modify_existing_contact
		clear_term
		contact = search_contacts
		print_attribute_list
		puts "Please select the attribute you would like to modify"
		attribute_index = gets.chomp.to_i
		puts "Please enter the modified attribute:"
		new_value = gets.chomp
		# filter("modify")
		@rolodex.modify(contact, attribute_index, new_value)
		# confirmation("modified")
		main_menu
	end
end

CRM.run("Bitmaker Labs CRM")



# crm = CRM.new("Bitmaker Labs CRM")
# crm.main_menu