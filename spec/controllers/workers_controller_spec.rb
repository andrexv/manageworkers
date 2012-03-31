require 'spec_helper'

describe WorkersController do
  include Devise::TestHelpers

  before(:each) do
    @valid_params = { name:           'User 1',
                     email:           'user@email.com',
                     mobile_number:   '30020002000',
                     landline_number: '3000000',
                     twitter:         'rbates',
                     facebook:        'www.facebook.com/user1',
                     password:        '111111' }
    VCR.use_cassette('twitter') do
       @valid_user = Twitter.user("rbates")
       @worker = Worker.create!(@valid_params)      
    end
  end
  describe "GET index" do
    it "redirects to worker show if logged" do
      sign_in_worker @worker
      get :index
      response.should redirect_to(worker_url(@worker))
    end
    it "redirects to sign in page if not logged" do
      get :index
      response.should redirect_to(new_worker_session_url)
    end
  end

 describe "GET show" do
   it "assigns the requested worker as @worker" do
     sign_in_worker @worker
     get :show, {:id => @worker.to_param}
     assigns(:worker).should eq(@worker)
   end
 end

 describe "GET edit" do
   it "assigns the requested worker as @worker" do
     sign_in_worker @worker
     get :edit, {:id => @worker.to_param}
     assigns(:worker).should eq(@worker)
   end
 end

 describe "PUT update" do
   describe "with valid params" do
     it "updates the requested worker" do
       sign_in_worker @worker
       Worker.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
       put :update, {:id => @worker.to_param, :worker => {'these' => 'params'}}
     end

     it "assigns the requested worker as @worker" do
       sign_in_worker @worker
       put :update, {:id => @worker.to_param, :worker => @valid_params}
       assigns(:worker).should eq(@worker)
     end
   end

  describe "with invalid params" do
    it "assigns the worker as @worker" do
      sign_in_worker @worker
      Worker.any_instance.stub(:save).and_return(false)
      put :update, {:id => @worker.to_param, :worker => {}}
      assigns(:worker).should eq(@worker)
    end

    it "re-renders the 'edit' template" do
      sign_in_worker @worker
      Worker.any_instance.stub(:save).and_return(false)
      put :update, {:id => @worker.to_param, :worker => {}}
      response.should render_template("edit")
    end
  end
end

end
