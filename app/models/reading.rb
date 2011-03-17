class Reading < ActiveRecord::Base
	attr_accessible :data
  cattr_reader :per_page
  @@per_page = 10

	belongs_to :sensor

	validates :data, :presence => true

	default_scope :order => 'readings.created_at DESC'

  #after_save run_rules()

  #def run_rules()
  # Rule.all.each do |r|
  #    code = r.rule
  #    logger.info "Running rule " + code
  #    eval(code)
  #  end
  #end
end
