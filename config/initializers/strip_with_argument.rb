class String
  old_strip = instance_method(:strip)

  define_method(:strip) do |param = nil|
    param ? remove(/(^(#{param})*)|(\.*(#{param})*$)/) : old_strip.bind(self).call
  end
end
