require 'spec_helper'

describe Worker do
  before(:each) do
    VCR.use_cassette('twitter') do
       @valid_user = Twitter.user("rbates")
    end
    @valid_params = { name:           'User 1',
                     email:           'user@email.com',
                     mobile_number:   '30020002000',
                     landline_number: '3000000',
                     twitter:         'rbates',
                     facebook:        'www.facebook.com/user1',
                     password:        '111111' }
  end
  
  it "should verify the presence of a name" do
      Worker.create(@valid_params.merge(name: "")).should raise_error
  end
  it "should verify the presence and format of an email" do
     Worker.create(@valid_params.merge(email: "")).should raise_error
     Worker.create(@valid_params.merge(email: "aaaaaaa")).should raise_error
     Worker.create(@valid_params.merge(email: "aaaa.com")).should raise_error
     Worker.create(@valid_params.merge(email: "@asdasd.com")).should raise_error
  end
  it "should verify the presence and numericality of a mobile_number" do 
     Worker.create(@valid_params.merge(mobile_number: "")).should raise_error
     Worker.create(@valid_params.merge(mobile_number: "+123123123")).should raise_error
     Worker.create(@valid_params.merge(mobile_number: "a123123123")).should raise_error
  end
  it "should verify the presence and numericality of a landline_number" do 
     Worker.create(@valid_params.merge(mobile_number: "")).should raise_error
     Worker.create(@valid_params.merge(mobile_number: "+123123123")).should raise_error
     Worker.create(@valid_params.merge(mobile_number: "a123123123")).should raise_error
  end
  it "should verify the presence, length and validate the twitter username" do
     Worker.create(@valid_params.merge(twitter: "")).should raise_error
     Worker.create(@valid_params.merge(twitter: "rbates1231231231231231232")).should raise_error
     Worker.create(@valid_params.merge(twitter: "rbates123123123")).should raise_error
end
  it "should verify the presence and format of the facebook URL" do
     Worker.create(@valid_params.merge(facebook: "")).should raise_error
     Worker.create(@valid_params.merge(facebook: "www.facebook.com")).should raise_error
     Worker.create(@valid_params.merge(facebook: "www.aaa.com")).should raise_error
  end
end