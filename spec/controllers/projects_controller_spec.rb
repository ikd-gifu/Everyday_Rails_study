require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe "# create" do
   # 認証済みのユーザーとして context "as an authenticated user" do
   before do
    @user = FactoryBot.create(:user)
   end
   
   # プロジェクトを追加できること
   it "adds a project" do
     project_params = FactoryBot.attributes_for(:project)
       sign_in @user
       expect {
        post :create, params: { project: project_params }
       }.to change(@user.projects, :count). by(1)
     end
   end
   
   # ゲストとして
   context "as a guest" do
     # 302 レスポンスを返すこと
     it "returns a 302 response" do
       project_params = FactoryBot.attributes_for(:project)
       post :create, params: { project: project_params }
       expect(response).to have_http_status "302"
     end
   
     # サインイン画面にリダイレクトすること
     it "redirects to the sign-in page" do
       project_params = FactoryBot.attributes_for(:project)
       post :create, params: { project:project_params }
       expect( response). to redirect_to "/users/sign_in"
     end
   end
end

