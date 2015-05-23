class Term < ActiveRecord::Base
  validates :current, presence: true
end
