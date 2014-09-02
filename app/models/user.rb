class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  has_many :attendees, dependent: :destroy
	has_many :events, through: :attendees
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, :email, :gender, presence: true
  validates :password, :password_confirmation, presence: true, on: :create
  validates :gender, inclusion: {in: ["male", "female"]}

  def name
    "#{first_name} #{last_name}"
  end

end
