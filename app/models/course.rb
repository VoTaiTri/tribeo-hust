class Course < ActiveRecord::Base
  belongs_to :subject

  validates :courseID, presence: true
  validates :term, presence: true
  validates :subject, presence: true

end
