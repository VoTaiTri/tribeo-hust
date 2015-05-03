class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: {maximum: 100}
  validates :role, presence: true, length: {maximum: 50}

  def is_admin?
    role == "admin"
  end
end