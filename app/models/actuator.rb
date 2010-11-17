class Actuator < ActiveRecord::Base
	has_one :command, :dependent => :destroy, :autosave => true
  cattr_reader :per_page
  @@per_page = 20

	after_create :create_command

	private
		def create_command
			Command.create(:actuator => self)
		end
end
