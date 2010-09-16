class Actuator < ActiveRecord::Base
	has_one :command, :dependent => :destroy, :autosave => true

	after_create :create_command

	private
		def create_command
			Command.create(:actuator => self)
		end
end
