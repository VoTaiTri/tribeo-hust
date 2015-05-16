class Course < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user

  validates :courseID, presence: true
  validates :term, presence: true
  validates :subject, presence: true

  scope :teach_by, ->user_id {where("user_id = ?", "#{user_id}")}
end
