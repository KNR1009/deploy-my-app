require 'rails_helper'

describe 'GET /tasks' do
  it '全てのタスクを取得する' do
    FactoryBot.create_list(:task, 10)

    get '/tasks'
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)
    # 正しい数のデータが返されたか確認する。
    expect(json.length).to eq(10)
  end
end

describe 'GET /tasks/id' do
  it '特定のタスクを取得する' do
    task = create(:task, name: "サンプルタスク")
    get "/tasks/#{task.id}"
    json = JSON.parse(response.body)
    # # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)
    # # 正しい数のデータが返されたか確認する。
    expect(json["name"]).to eq(task["name"])
  end
end