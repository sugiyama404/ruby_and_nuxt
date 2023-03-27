require 'rails_helper'

RSpec.describe "Api::Todos", type: :request do
  describe "POST /api/todos" do
    it "check creat method" do
      valid_params = { content: "test_api" }
      header_params = { "Content-Type" => "application/json" }
      expect { post "/api/todos", params: valid_params.to_json, headers: header_params}.to change(Todo, :count).by(+1)
      expect(response.status).to eq(201)
    end
  end
  describe "GET /api/todos" do
    it "check index method" do
      FactoryBot.create(:todo)
      get '/api/todos'
      expect(response.status).to eq(200)
    end
  end
  describe "GET /api/todos/x" do
    it "check show method" do
      FactoryBot.create(:todo)
      todo = Todo.all.order(id: "DESC").limit(1)
      get "/api/todos/#{todo.ids[0]}"
      expect(response.status).to eq(200)
    end
  end
  describe "PUT /api/todos/x" do
    it "check update method" do
      todo = Todo.all.order(id: "DESC").limit(1)
      valid_params = { content: "update_api" }
      header_params = { "Content-Type" => "application/json" }
      put "/api/todos/#{todo.ids[0]}", params: valid_params.to_json, headers: header_params
      expect(response.status).to eq(202)
    end
  end
  describe "DELETE /api/todos/x" do
    it "check delete method" do
      FactoryBot.create(:todo)
      todo = Todo.all.order(id: "DESC").limit(1)
      delete "/api/todos/#{todo.ids[0]}"
      expect(response.status).to eq(202)
    end
  end
end
