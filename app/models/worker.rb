class Worker < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :mobile_number,
                  :landline_number, :twitter, :facebook, :office_phone, :office_address, :home_address, :teams, :gender
  
   validates :name, presence: true
   validates :email, presence: true, uniqueness: true, 
             format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, message: 'email must be valid'}
   validates :mobile_number, presence: true, numericality: true
   validates :landline_number, presence: true, numericality: true
   validates :twitter, presence: true, length: { maximum: 15},
             format: { with: /^\w+$/,
             message: 'write a valid Twitter name.' }
   validates :facebook, presence: true,
             format: { with: /((http|https):\/\/)?(www.)?facebook.com\/\w+/,
             message: 'write a valid Facebook address.' }

             
   has_and_belongs_to_many :teams  
   before_save :load_twitter_image
   
   def load_twitter_image
     begin
        self.tw_avatar = Twitter.user(twitter).profile_image_url
     rescue 
        errors.add(:twitter, "verify the twitter Username.")
        return false
     end
   end
   
   def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
     data = access_token.extra.raw_info     
     info = access_token.info
     if user = Worker.where(:email => data.email).first
        user.gender = data.gender
        user.hometown = data.hometown.name
        user.location = data.location.name
        user.fb_id = data.id
        user.fb_nickname = info.nickname
        user.fb_image = info.image
       user 
     end
   end
   
end
