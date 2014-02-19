module MyMongoid
  module Document
    module Attributes
      extend ActiveSupport::Concern

      def process_attributes(attrs = nil)
        raise ArgumentError.new(attrs) unless attrs.is_a?(Hash)
        @atts = { }
        attrs.each do |key,value|
          raise MyMongoid::UnknownAttributeError unless self.class.fields.include? key.to_s
          self.send "#{key}=", value
        end
      end

      def attributes
        @atts
      end

      def attributes= (attrs = nil)
        process_attributes(attrs)
      end

      def read_attribute(name)
        named = name.to_s
        @atts[named]
      end

      def write_attribute(name, value)
        named = name.to_s
        @atts[named] = value
      end

      def new_record?
        true
      end
    end
  end
end
