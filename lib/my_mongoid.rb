require "active_support/core_ext"
require "active_model"

require "my_mongoid/version"
require "my_mongoid/document"

module MyMongoid
  extend self
   def models
    @models ||= []
  end

  def register_model(model)
    models.push(model) unless models.include?(model)
  end

  class DuplicateFieldError < StandardError
  end

  class UnknownAttributeError < StandardError
  end
end
