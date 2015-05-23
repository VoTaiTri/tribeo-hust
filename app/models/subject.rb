class Subject < ActiveRecord::Base
  TYPE_NAME = [['Tất cả', ''], ['Lớp LT+BT', 'normal'], ['Lớp đồ án', 'project']]

  has_many :subject_users
  has_many :lecturers, through: :subject_users, source: :user, foreign_key: :subject_id
  has_many :courses, dependent: :destroy

  validates :name, presence: true, length: {maximum: 255}
  validates :tc, presence: true
  # validates :lt, numericality: {only_integer: true}
  # validates :bt, numericality: {only_integer: true}
  validates :subjectID, presence: true, uniqueness: true
  validates :species, presence: true

  scope :search_by, ->(name, type) {where("name LIKE ? AND species LIKE ?", "%#{name}%", "%#{type}%")}
  
end
