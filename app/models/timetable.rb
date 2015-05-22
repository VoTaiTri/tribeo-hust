class Timetable < ActiveRecord::Base
  DAYNAMES = [['Thứ hai', '2'], ['Thứ ba', '3'], ['Thứ tư', '4'], ['Thứ năm', '5'], ['Thứ sáu', '6']]
  TIME_START =  [['06:45','06:45'], ['07:35','07:35'], ['08:30','08:30'], ['09:20','09:20'], ['10:15','10:15'], ['11:05','11:05'],
                 ['12:30','12:30'], ['13:20','13:20'], ['14:15','14:15'], ['15:05','15:05'], ['16:00','16:00'], ['16:50','16:50'],]
  TIME_FINISH = [['07:30','07:30'], ['08:20','08:20'], ['09:15','09:15'], ['10:05','10:05'], ['11:00','11:00'], ['11:50','11:50'],
                 ['13:15','13:15'], ['14:05','14:05'], ['15:00','15:00'], ['15:50','15:50'], ['16:45','16:45'],['17:35','17:35'],]

  # attr_accessor :skip_create_room_validation, :skip_update_room_validation
                 
  belongs_to :course

  validates_presence_of :day, :start_time, :finish_time, :room,
                        message: I18n.t('activerecord.errors.models.blank')
  validate :valid_time, :valid_part
  validate :valid_room_create, on: :create
  validate :valid_room_update, on: :update
    
  scope :with_room, ->room {where("room = ?", "#{room}")}
  scope :with_day, ->day {where("day = ?", "#{day}")}
  query = "(start_time <= :start_time AND finish_time >= :finish_time)
          OR (start_time > :start_time AND start_time < :finish_time)
          OR (finish_time > :start_time AND finish_time < :finish_time)"
  scope :filte_timer, ->(start, finish) {where(query, start_time: start, finish_time: finish)}

  private
  def valid_room_create
    if Timetable.with_room(room).with_day(day).filte_timer(start_time, finish_time).count > 0
      errors.add "", "Thời gian, địa điểm học bị trùng"
    end
  end

  def valid_room_update
    if Timetable.with_room(room).with_day(day).filte_timer(start_time, finish_time).count > 1
      errors.add "", "Thời gian, địa điểm học bị trùng"
    end
  end

  def valid_time
    if !start_time.blank? && !finish_time.blank? && start_time >= finish_time
      errors.add "Thời gian bắt đầu", " phải trước thời gian kết thúc"
    end
  end

  def valid_part
    if !start_time.blank? && !finish_time.blank? && start_time <= "11:05" && finish_time >= "13:15"
      errors.add "", "Thời gian học phải trong cùng buổi sáng hoặc buổi chiều"
    end
  end
end
