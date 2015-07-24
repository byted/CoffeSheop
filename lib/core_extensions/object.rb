# lib/core_extensions/string.rb

class String
  def numeric?
    self.is_a?(Numeric) or (self.is_a?(String) and Float(self)) ? true : false
		rescue false
	end
end

Object.send(:include, CoreExtensions::Object)