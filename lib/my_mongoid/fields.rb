module MyMongoid
  class Field
    attr_accessor :name, :options

    def initialize(name, options={})
      @name = name
      @options = options
    end
  end

  module Document
    module Fields
      extend ActiveSupport::Concern
      included do
        class_attribute :fields

        self.fields = {}

        field :_id, :as => :id

      end
      module ClassMethods
        def field(name,options=nil)
          named = name.to_s
          raise DuplicateFieldError if self.fields.has_key?(named)
          self.fields[named] = Field.new(named,options)

          define_method(named) do
            read_attribute(named)
          end

          define_method("#{named}=") do |value|
            write_attribute(named, value)
          end
          
          if options
            options.each_pair do |key,value|
              if key == :as
                valued = value.to_s
                define_method(valued) do
                  read_attribute(valued)
                end

                define_method("#{valued}=") do |v|
                  write_attribute(valued, v)
                end
              end
            end
          end
          # module_eval %{  
          #   def #{named}   
          #     read_attribute(#{named})
          #   end  
              
          #   def #{named}= value  
          #     write_attribute(#{named}, value)
          #   end
          #   }
        end
      end
    end
  end
end
