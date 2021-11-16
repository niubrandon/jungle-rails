class User < ActiveRecord::Base

  has_secure_password
#email must be unique, not case sensitive
#password must have a minimum length when a user account is being created
  validates :first_name, presence: true
  validates :last_name, presence: true 
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  #validates :password, presence: true
  validates :password_confirmation, presence: true
  validates_length_of :password, minimum: 7, too_short: 'Please enter at least 7 characters'

  def self.authenticate_with_credentials(e, p)
    @users = User.all
    puts `users infor #{@users.inspect}`
    @users.each do |u| 
      if u.email.downcase == e.strip.downcase && u.authenticate(p)
        return u
      end
    end
   return false
  end

end


