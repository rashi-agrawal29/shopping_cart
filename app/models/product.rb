class Product < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :line_items, dependent: :destroy
end
