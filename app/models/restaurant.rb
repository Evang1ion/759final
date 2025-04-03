class Restaurant < ApplicationRecord
    has_many :menu_items, dependent: :destroy
  
    validates :name, presence: true
    validates :location, presence: true
  end
  