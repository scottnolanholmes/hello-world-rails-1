class HelloWorld < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :country,  presence: true, inclusion: { in: SETTING[:country].keys }, uniqueness: true
  validates :hello,    presence: true
  validates :priority, presence: true, numericality: { only_integer: true }, length: { maximum: 196 }, uniqueness: true
end
