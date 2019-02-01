class Feedback < ApplicationRecord
  validates :name, presence: true
  validates :feedback, presence: true
end
