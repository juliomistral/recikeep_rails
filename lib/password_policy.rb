class PasswordPolicy
  def self.secure_user(user, clear_password)
    self.generate_salt_for_user(user)
    user.password_hash = BCrypt::Engine.hash_secret(clear_password, user.password_salt)
  end

  def self.generate_salt_for_user(user)
    salt = user.password_salt
    if salt == nil
      user.password_salt = BCrypt::Engine.generate_salt
    end
  end

  def self.passwords_match?(user, clear_password)
    hashed = BCrypt::Engine.hash_secret(clear_password, user.password_salt)
    return user.password_hash == hashed
  end
end