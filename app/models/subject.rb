class Subject < ActiveRecord::Base
  has_many :subject_users
  has_many :lecturers, through: :subject_users, source: :user, foreign_key: :subject_id

  validates :name, presence: true, length: {maximum: 255}

  scope :search_by, ->name {where('name LIKE ?', "%#{name}%")}
end