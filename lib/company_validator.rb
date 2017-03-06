class CompanyValidator < ActiveModel::EachValidator
  @@default_options = {}

REGEXP = %r{
(^([A-Z]|\d+)([a-z])+)+ # start with Uppper case char or digits, followed by lowercase chars
(\s([A-Z])[a-z]+)?*$  # zero or more groups starting with space and upper case chars followed by lowecase chars
}x

# REGEXP = /(([A-Z]|\d+)([a-z])+)( ([A-Z])([a-z]|\d)+)*/

  def self.valid?(value, options = {})
    !!value.match(REGEXP)
  end

  def self.default_options
    @@default_options
  end

  def validate_each(record, attribute, value)
    options = @@default_options.merge(self.options)

    unless self.class.valid?(value, self.options)
      record.errors.add(attribute, options[:message] || "Valid name needs to be title cased eg: Tile Case Name | eg2: 23corp Cbd)")
    end
  end
end
