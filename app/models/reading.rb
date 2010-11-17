class Reading < ActiveRecord::Base
	attr_accessible :data
  cattr_reader :per_page
  @@per_page = 10

	belongs_to :sensor

	validates :data, :presence => true

	default_scope :order => 'readings.created_at ASC'
end
