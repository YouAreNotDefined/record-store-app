class Record < ApplicationRecord
  belongs_to :user

  has_many :record_libraries, dependent: :destroy
  has_many :libraries, through: :record_libraries

  validates :title, :year, presence: true
end
