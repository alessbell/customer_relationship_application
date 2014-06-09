class Rolodex
	attr_accessor :id
	attr_reader :contacts
	def initialize
		@id = 1000
		@contacts = []
		@attribute_methods = [:first_name, :last_name, :email, :note, :id]
	end

	def add_new_contact(contact)
		contact.id = @id
		@contacts << contact
		@id += 1
	end

	def find_by_id(id)
		@contacts.find { |contact| contact.id == id }
	end

	def search(attribute_index, search_term)
		selection = @attribute_methods[attribute_index - 1]
		results = []
		@contacts.each {|contact| results << contact if contact.public_send(selection) == search_term }
		results
	end

	def spew_contacts
		@contacts
	end

	def spew_attributes(attribute_index)
		selection = @attribute_methods[attribute_index - 1]
		results = []
		@contacts.each {|contact| results << contact.public_send(selection)}
		results 
	end

	def modify(contact, attribute_index, new_value)
		selection = [:first_name=, :last_name=, :email=, :note=, :id=][attribute_index -1]
		contact.public_send(selection, new_value)
	end

	def delete(contact)
		@contacts.delete(contact)
	end
end