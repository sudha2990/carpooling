class Car < ActiveRecord::Base
	belongs_to :user
	has_many :rides
	has_many :travellers
	validates_presence_of :seat, :car_type, :brand
	has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
  	validates :seat, :numericality => { :greater_than_or_equal_to => 0 }
end
