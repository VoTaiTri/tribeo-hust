class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  DEGREE = [['Ths', 'Ths'], ['TS', 'TS'], ['PGS/TS', 'PGS/TS'], ['PGS', 'PGS'], ['GS', 'GS']]       
  DAYNAMES = [['Thứ hai', '2'], ['Thứ ba', '3'], ['Thứ tư', '4'], ['Thứ năm', '5'], ['Thứ sáu', '6']]

  has_many :subject_users
  has_many :technicals, through: :subject_users, source: :subject, foreign_key: :user_id
  has_many :courses

  validates :name, presence: true, length: {maximum: 100}
  validates :role, presence: true, length: {maximum: 50}

  mount_uploader :avatar, AvatarUploader

  scope :search_by, ->name {where('name LIKE ?', "%#{name}%")}
  scope :teaching, ->subject_id {joins(:subject_users).where("subject_id = ?", "#{subject_id}")}
  scope :un_rejected, ->user_ids {where.not(id: user_ids)}
  accepts_nested_attributes_for :technicals

  def is_admin?
    role == "admin"
  end

  def is_lecturer?
    role == "normal"
  end
end
