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