class Rule < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10

  def self.fix
    @sanitized = self.gsub(/\n/, " ").gsub(/\r/, " ")
    return @sanitized
  end

  def sanitize(rule)
    rule.gsub(/\r\n/, " ").gsub(/\n/, " ").gsub(/\r/, " ").gsub(/\t/, " ")
  end

  private

    def model_checker
      return true
    end

    def run
      yield
    end
end
