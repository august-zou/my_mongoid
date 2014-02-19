require 'my_mongoid/attributes'
require 'my_mongoid/fields'

module MyMongoid    
  module Document
    extend ActiveSupport::Concern

    include Attributes
    include Fields

    included do
      MyMongoid.register_model(self)
    end

    def initialize(attrs={})
      process_attributes(attrs)
    end

    module ClassMethods
      def is_mongoid_model?
        true
      end
    end
  end 
end