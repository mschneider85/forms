class JSONWithIndifferentAccess < HashWithIndifferentAccess
  def self.dump(obj)
    obj
  end

  def self.load(raw_hash)
    new(raw_hash || {})
  end
end
