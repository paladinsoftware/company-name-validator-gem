class CompanyValidator < ActiveModel::EachValidator
  @@default_options = {}

  REGEXP = %r{
  (([[:upper:]]|\d)([[:lower:]]|\d)+) # start with Uppper case char or digit, followed by digits or lowercase chars
  ( ([[:upper:]])([[:lower:]]|\d)+)*  # zero or more groups starting with space and upper case chars followed by lowecase chars
  }x

  def self.valid?(value)
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
