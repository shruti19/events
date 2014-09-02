class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  has_many :attendees
	has_many :events, through: :attendees
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true


  def name
    "#{first_name} #{last_name}"
  end

end
