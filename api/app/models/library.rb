class Library < ApplicationRecord
  belongs_to :user

  has_many :records, through: :record_libraries
  has_many :record_libraries
  accepts_nested_attributes_for :record_libraries

  validates :name, :content, presence: true
end
