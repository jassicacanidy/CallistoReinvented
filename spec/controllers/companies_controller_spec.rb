require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe CompaniesController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {company_name: "Test", company_info: ""}
  }

  let(:invalid_attributes) {
    {company_name: "", company_info: ""}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CompaniesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  SUCCESS = 1
  ERR_COMPANY_EXISTS = -1
  ERR_COMPANY_NAME = -2
  ERR_UNKNOWN_ID = -3
  ERR_BAD_PERMISSIONS = -4

  # Code to make devise user authentication work  
  def sign_in(user = double('user'))
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      # allow(controller).to receive(:user_signed_in).and_return(user_signed_in)
    end
  end

  # def valid_session
    
  # end

  describe "GET index" do
    it "assigns all companies as @companies" do
      company = Company.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:companies)).to eq([company])
    end
  end

  # Test show method
  describe "GET show" do
    it "assigns the requested company as @company" do
      company = Company.create! valid_attributes
      get :show, {:id => company.to_param}, valid_session
      expect(assigns(:company)).to eq(company)
    end
  end

  describe "GET new" do
    it "assigns a new company as @company" do
      get :new, {}, valid_session
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe "GET edit" do
    it "assigns the requested company as @company" do
      company = Company.create! valid_attributes
      get :edit, {:id => company.to_param}, valid_session
      expect(assigns(:company)).to eq(company)
    end
  end



  # Test Companies#add method
  describe "POST add" do
    # # Signs in with "Employer" before each test
    # before(:all) do
    #   @request.env["devise.mapping"] = Devise.mappings[:user]    
    #   user = User.create(email: "testabcd@mail.com", password: 12345678, type: "Employer")
    #   sign_in user
    # end

    # after(:all) do 
    #   sign_out user
    # end

    describe "with valid params" do
      it "creates a new Company" do
        @request.env["devise.mapping"] = Devise.mappings[:user]    
        user = User.create(email: "testabcd@mail.com", password: 12345678, type: "Employer")
        sign_in user
        expect {
          post :add, {company_name: "Test", company_info: ""}, valid_session
        }.to change(Company, :count).by(1)
        sign_out user
      end

      it "assigns a newly created company as @company" do
        @request.env["devise.mapping"] = Devise.mappings[:user]    
        user = User.create(email: "testabcd@mail.com", password: 12345678, type: "Employer")
        sign_in user
        post :add, {company_name: "Test", company_info: ""}, valid_session
        expect(assigns(:company)).to be_a(Company)
        expect(assigns(:company)).to be_persisted
        sign_out user
      end

      # it "redirects to the created company" do
      #   @request.env["devise.mapping"] = Devise.mappings[:user]    
      #   user = User.create(email: "testabcd@mail.com", password: 12345678, type: "Employer")
      #   sign_in user
      #   post :add, {company_name: "Test", company_info: ""}, valid_session
      #   expect(response).to redirect_to(Company.last)
      #   sign_out user
      # end
    end

    describe "with invalid params" do
      it "gives correct error code with blank company name" do
        @request.env["devise.mapping"] = Devise.mappings[:user]    
        user = User.create(email: "testabcd@mail.com", password: 12345678, type: "Employer")
        sign_in user
        post :add, {company_name: "", company_info: ""}, valid_session
        # print "**** " + JSON(response.body) + " ****"
        result = JSON.parse(response.body)
        expect(result["errCode"]).to eq Company::ERR_COMPANY_NAME
        sign_out user
      end

      it "gives correct error code with duplicate company" do
        @request.env["devise.mapping"] = Devise.mappings[:user]    
        user = User.create(email: "testabcd@mail.com", password: 12345678, type: "Employer")
        sign_in user
        post :add, {company_name: "Test", company_info: "v1"}, valid_session
        post :add, {company_name: "Test", company_info: "v2"}, valid_session
        result = JSON.parse(response.body)
        expect(result["errCode"]).to eq Company::ERR_COMPANY_EXISTS
        sign_out user
      end

      # it "re-renders the 'new' template" do
      #   @request.env["devise.mapping"] = Devise.mappings[:user]    
      #   user = User.create(email: "testabcd@mail.com", password: 12345678, type: "Employer")
      #   sign_in user
      #   post :create, {:company => invalid_attributes}, valid_session
      #   expect(response).to render_template("new")
      #   sign_out user
      # end
    end
  end


  after{ Warden.test_reset! }
  # describe "PUT update" do
  #   describe "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested company" do
  #       company = Company.create! valid_attributes
  #       put :update, {:id => company.to_param, :company => new_attributes}, valid_session
  #       company.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "assigns the requested company as @company" do
  #       company = Company.create! valid_attributes
  #       put :update, {:id => company.to_param, :company => valid_attributes}, valid_session
  #       expect(assigns(:company)).to eq(company)
  #     end

  #     it "redirects to the company" do
  #       company = Company.create! valid_attributes
  #       put :update, {:id => company.to_param, :company => valid_attributes}, valid_session
  #       expect(response).to redirect_to(company)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the company as @company" do
  #       company = Company.create! valid_attributes
  #       put :update, {:id => company.to_param, :company => invalid_attributes}, valid_session
  #       expect(assigns(:company)).to eq(company)
  #     end

  #     it "re-renders the 'edit' template" do
  #       company = Company.create! valid_attributes
  #       put :update, {:id => company.to_param, :company => invalid_attributes}, valid_session
  #       expect(response).to render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "destroys the requested company" do
  #     company = Company.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => company.to_param}, valid_session
  #     }.to change(Company, :count).by(-1)
  #   end

  #   it "redirects to the companies list" do
  #     company = Company.create! valid_attributes
  #     delete :destroy, {:id => company.to_param}, valid_session
  #     expect(response).to redirect_to(companies_url)
  #   end
  # end

end
