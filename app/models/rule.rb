class Rule < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10

  private

    def fix
      return true
    end

    def model_checker
      return true
    end
end
