class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :cars
  has_many :rides
  validates_presence_of :first_name, :last_name, :location

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def full_name
  	self.first_name + " " + self.last_name
  end

  def is_owner? (ride)
    ride.user_id == self.id    
  end
end
