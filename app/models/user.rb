class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subject_users
  has_many :technicals, through: :subject_users, source: :subject, foreign_key: :user_id

  validates :name, presence: true, length: {maximum: 100}
  validates :role, presence: true, length: {maximum: 50}

  mount_uploader :avatar, AvatarUploader

  scope :search_by, ->name {where('name LIKE ?', "%#{name}%")}

  accepts_nested_attributes_for :technicals

  def is_admin?
    role == "admin"
  end
end