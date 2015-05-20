class Course < ActiveRecord::Base
  DAYNAMES = [['Thứ hai', '2'], ['Thứ ba', '3'], ['Thứ tư', '4'], ['Thứ năm', '5'], ['Thứ sáu', '6']]

  belongs_to :subject
  belongs_to :user
  has_many :timetables

  validates_presence_of :courseID, :term, :subject, :timetables,
              message: I18n.t('activerecord.errors.models.blank')

  scope :teach_by, ->user_id {where("user_id = ?", "#{user_id}")}

  accepts_nested_attributes_for :timetables, reject_if: :all_blank, allow_destroy: true
end
