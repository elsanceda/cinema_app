class User < ApplicationRecord
    before_save :downcase_email
    validates :full_name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: true
    validates :mobile_number, presence: true, length: { maximum: 20 }, uniqueness: true
    has_secure_password
    VALID_PASSWORD_REGEX = /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]/
    password_format = "must include an uppercase letter, a lowercase letter, and a digit"
    validates :password, presence: true, length: { minimum: 8 }, 
                         format: { with: VALID_PASSWORD_REGEX, 
                                   message: password_format },
                                   allow_nil: true
    
    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    private

        # Converts email to all lowercase.
        def downcase_email
            self.email = email.downcase
        end
end
