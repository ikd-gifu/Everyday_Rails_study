require 'rails_helper'
# 遅延ステータス
describe "late status" do
  # 締め切り日が過ぎていれば遅延していること
  it "is late when the due date is past today" do
    project = FactoryBot.create(:project, :due_yesterday)
    # project = FactoryBot.create(:project_due_yesterday)
    expect(project).to be_late
  end
  
  # 締め切り日が今日ならスケジュール通りであること
  it "is on time when the due date is today" do
    project = FactoryBot.create(:project, :due_today)
    # project = FactoryBot.create(:project_due_today)
    expect(project).to_not be_late
  end
  
  # 締め切り日が未来ならスケジュール通りであること
  it "is late when the due date is in the future" do
    project = FactoryBot.create(:project, :due_tomorrow)
    # project = FactoryBot.create(:project_due_tomorrow)
    expect(project).to_not be_late
  end
end