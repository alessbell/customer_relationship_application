class CRM
	attr_reader :name
	def initialize(name)
		@name = name
		@rolodex = Rolodex.new
		puts "Welcome to #{name}"
	end

	def print_main_menu
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

	def call_option(user_selected)
		case user_selected
		when 1 then add_new_contact
		when 2 then modify_existing_contact
		when 3 then delete_contact
		when 4 then display_contacts
		when 5 then display_attribute
		when 6 then
			puts "Goodbye"
			return
		else
			puts "Invalid option. Please try again."
			main_menu
		end
	end

	def add_new_contact
		print "Enter first name: "
		first_name = gets.chomp
		print "Enter last name: "
		last_name = gets.chomp
		print "Enter email address: "
		email = gets.chomp
		print "Enter a note: "
		note = gets.chomp
		rolodex.add_contact(Contact.new(first_name, last_name, email, note))
		main_menu
	end

	def modify_existing_contact
	end
end

class Contact
	attr_accessor :id, :first_name, :last_name, :email, :note

	def initialize(first_name, last_name, email, note)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@note = note
	end
end

class Rolodex
	def initialize
		@id = 1000
		@contact = []
	end

	def add_contact(contact)
		@contacts << contact
		contact.id = @id
		@id += 1
	end
end

crm = CRM.new("Bitmaker Labs CRM")
crm.main_menu