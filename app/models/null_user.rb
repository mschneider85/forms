class NullUser
  def anonymous?
    true
  end

  def id
    nil
  end

  def admin?
    false
  end

  def member?
    false
  end
end
