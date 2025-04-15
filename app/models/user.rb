class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders

  validates :name, presence: true

  before_create :generate_auth_token

  def generate_auth_token
    self.auth_token = SecureRandom.hex(10)
  end

end
