class Order < ApplicationRecord
  belongs_to :user
  # has_and_belongs_to_many :users

  

  validates :meal, presence: true
  validates :resturant, presence: true

  after_initialize :set_defaults
  
   mount_uploader :image, ImageUploader
 
  def set_defaults
    self.status ||= "w"
  end

  has_many :invited_to_orders, dependent: :destroy
  has_many :order_details, dependent: :destroy
end
