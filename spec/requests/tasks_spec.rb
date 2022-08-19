require 'rails_helper'


describe 'GET /tasks' do
  it '全てのタスク取得する' do
    FactoryBot.create_list(:task, 10)

    get '/tasks'
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)
    # 正しい数のデータが返されたか確認する。
    expect(json.length).to eq(10)
  end
end

describe 'GET /tasks/:id' do
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

describe 'Post /tasks' do
  it '新しいタスクを作成する' do
    valid_params = { name: "test", is_done: false}

    #データが作成されていることを確認
    expect { post '/tasks', params: valid_params }.to change(Task, :count).by(+1)
    expect(response.status).to eq(204)
  end
end

describe "PUT /tasks/:id" do
  it 'ユーザーが更新されること' do
    task = create(:task)
    task_update_params = {
      name: "更新です"
    }
    put "/tasks/#{task.id}", params: task_update_params

    expect(response.status).to eq(204)
    expect(task.reload.name).to eq(task_update_params[:name])
  end
end

describe 'Delete /tasks/:id' do
  it 'taskを削除する' do
    task = create(:task)
    #データが削除されている事を確認
    expect { delete "/tasks/#{task.id}" }.to change(Task, :count).by(-1)
    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)
  end
end
