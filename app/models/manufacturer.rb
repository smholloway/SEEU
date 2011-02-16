class Manufacturer < ActiveRecord::Base
  has_many :models, :dependent => :destroy
end
