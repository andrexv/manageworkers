class Worker < ActiveRecord::Base
   validates :name, presence: true
   validates :email, presence: true, uniqueness: true, 
             format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, message: 'Email must be valid'}
   validates :mobile_number, presence: true, numericality: true
   validates :landline_number, presence: true, numericality: true
   validates :twitter, presence: true, length: { maximum: 15},
             format: { with: /^\w+$/,
             message: 'Please, write a valid Twitter name.' }
   validates :facebook, presence: true,
             format: { with: /((http|https):\/\/)?(www.)?facebook.com\/\w+/,
             message: 'Please, write a valid Facebook address.' }
             
   has_and_belongs_to_many :teams  
   before_save :load_twitter_image
   
   def load_twitter_image
     begin
        self.tw_avatar = Twitter.user(twitter).profile_image_url
     rescue 
        errors.add(:twitter, "Please, verify the twitter Username.")
     end
   end


end
