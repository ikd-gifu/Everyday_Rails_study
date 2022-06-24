require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
 describe "# destroy" do
  # 認可されたユーザーとして
  context "as an authorized user" do
   before do
    @user = FactoryBot.create(:user)
    @project = FactoryBot.create(:project, owner:@user)
   end
   
   # プロジェクトを削除できること
   it "deletes a project" do
    sign_in @user
    expect {
    delete :destroy, params: { id: @project.id }
    }.to change(@user.projects, :count).by(-1)
   end
  end
  
  # 認可されていないユーザーとして
  context "as an unauthorized user" do
   before do
    @user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user)
    @project = FactoryBot.create(:project,
    owner: other_user) 
   end
   
   # プロジェクトを削除できないこと
   it "does not delete the project" do
    sign_in @user
    expect {
    delete :destroy, params: { id: @project.id }
    }.to_not change( Project, :count)
   end
   
   # ダッシュボードにリダイレクトすること
   it "redirects to the dashboard" do
   sign_in @user
   delete :destroy, params: { id: @project.id }
   expect( response).to redirect_to root_path
   end
  end
  
  # ゲストとして
  context "as a guest" do
   before do
    @project = FactoryBot.create(:project)
   end
   # 302 レスポンスを返すこと
   it "returns a 302 response" do
    delete :destroy, params: { id: @project.id }
    expect(response).to have_http_status "302"
   end
   
   
   # サインイン画面にリダイレクトすること
   it "redirects to the sign-in page" do
    delete :destroy, params: { id: @project.id }
    expect( response).to redirect_to "/users/sign_in"
   end
   
   
   # プロジェクトを削除できないこと
   it "does not delete the project" do
    expect {
    delete :destroy, params: { id: @project.id }
    }.to_not change( Project, :count)
   end
  end
 end
end
