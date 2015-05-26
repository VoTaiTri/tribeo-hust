class Course < ActiveRecord::Base
  NEW_OUTTIME = (Time.now - 3.days).strftime("%Y-%m-%d")
  RE_OUTTIME = (Time.now - 2.days).strftime("%Y-%m-%d")

  belongs_to :subject
  belongs_to :user

  has_many :timetables, dependent: :destroy

  validates_presence_of :courseID, :term, :subject, :enroll, :max_enroll, :timetables,
              message: I18n.t('activerecord.errors.models.blank')
  validates_uniqueness_of :courseID, message: I18n.t('activerecord.errors.models.taken')
  validates_numericality_of :term, greater_than_or_equal_to: Term.first.current,
                            message: " lớn hơn hoặc bằng " + Term.first.current.to_s
  validate :valid_enroll

  scope :teach_by, ->user_id {where(user_id: user_id)}
  scope :need_assign,-> {where("user_confirm = 'rejected' OR division_state= 'spending'")}
  scope :assigned_to, ->user_id {where("user_id= ? AND division_state= 'ongoing' AND user_confirm= 'waiting'", "#{user_id}")}
  scope :accepted_by, ->user_id {where("user_id= ? AND division_state= 'done' AND user_confirm= 'accepted'", "#{user_id}")}
  scope :rejected_by, -> {where("division_state= 'ongoing' AND user_confirm= 'rejected'")}
  scope :search_by, ->(name, term) {joins(:subject).where("subjects.name LIKE ? AND courses.term = ?", "%#{name}%", "#{term}")}
  scope :current_term, ->term {where("term = ?", "#{term}")}
  query_new = "(division_state= 'ongoing' AND term = :term AND (user_rejected IS NULL) AND updated_at LIKE :new_outime)"
  query_re =  "(division_state= 'ongoing' AND term = :term AND user_rejected LIKE '%%' AND updated_at LIKE :re_outime)"
  scope :outtime_assign, ->term {where(query_new + " OR " + query_re, term: term, new_outime: "%#{NEW_OUTTIME}%", re_outime: "%#{RE_OUTTIME}%")}
  
  accepts_nested_attributes_for :timetables, reject_if: :all_blank, allow_destroy: true

  private
  def valid_enroll
    if !enroll.blank? && !max_enroll.blank? && enroll > max_enroll
      errors.add "Số lượng đăng ký", " phải nhỏ hơn số lượng đăng ký tối đa."
    end
  end
end
