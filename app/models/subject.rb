class Subject < ActiveRecord::Base
  validates :name, presence: true, length: {maximum: 255}

  scope :search_by, ->name {where('name LIKE ?', "%#{name}%")}
end