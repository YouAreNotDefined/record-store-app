class Record < ApplicationRecord
  belongs_to :user

  has_many :libraries, through: :record_libraries
  has_many :record_libraries

  validates :title, :year, presence: true
end
