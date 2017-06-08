module ColumnAccessors
  def self.included(klass)
    klass.send :include, InstanceMethods
    klass.extend ClassMethods
  end

  module InstanceMethods
    def attributes
      {}.tap do |attribute|
        self.class.columns.each do |column|
          attribute[column] = send(column)
        end
      end
    end
  end

  module ClassMethods
    def columns
      @columns ||= []
    end

    def column(name, type)
      columns << name
      define_method(name) do
        instance_variable_get("@#{name}")
      end

      define_method("#{name}=") do |value|
        instance_variable_set("@#{name}", self.class.coercion(type).call(value))
      end
    end

    def coercion(type)
      case type
      when :boolean
        ->(value) { value.to_s.in?(%w(1 true)) }
      when :integer
        ->(value) { value.to_i }
      when :string
        ->(value) { value.to_s }
      end
    end
  end
end
