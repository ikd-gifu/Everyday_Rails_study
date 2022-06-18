require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
 describe "# update" do
   # 認可されたユーザーとして
   context "as an authorized user" do
     before do
       @user = FactoryBot.create(:user)
       @project = FactoryBot.create(:project, owner:@user)
     end
   
     # プロジェクトを更新できること
     it "updates a project" do
       project_params = FactoryBot.attributes_for(:project,
          name: "New Project Name")
         sign_in @user
         patch :update, params: { id: @project.id, project: project_params }
         expect(@project.reload.name).to eq "New Project Name"
       end
     end
   end
   
   # 認可されていないユーザーとして
   context "as an unauthorized user" do
     before do
       @user = FactoryBot.create(:user)
       other_user = FactoryBot.create(:user)
       @project = FactoryBot.create(:project,
         owner: other_user,
         name: "Same Old Name")
     end
   
     # プロジェクトを更新できないこと
     it "does not update the project" do
       project_params = FactoryBot.attributes_for(:project,
        name: "New Name")
       sign_in @user
       patch :update, params: { id: @project.id, project: project_params }
       expect(@project.reload.name).to eq "Same Old Name"
     end
   
     # ダッシュボードへリダイレクトすること
     it "redirects to the dashboard" do
       project_params = FactoryBot.attributes_for(:project)
       sign_in @user
       patch :update, params: { id: @project.id, project: project_params }
       expect( response). to redirect_to root_path
     end
    end
   
   # ゲストユーザーのテストは省略 ...

 end
