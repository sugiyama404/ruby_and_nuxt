require 'rails_helper'

RSpec.describe "Api::Todos", type: :request do
  describe "POST /api/todos" do
    it "check creat method" do
      valid_params = { content: "test_api" }
      expect { post "/api/todos", params: valid_params.to_json, headers: { "Content-Type" => "application/json" }}.to change(Todo, :count).by(+1)
      expect(response.status).to eq(201)
    end
  end
  describe "GET /api/todos" do
    it "check index method" do
      get '/api/todos'
      expect(response.status).to eq(200)
    end
  end
  #describe "GET /api/todos?id=x" do
  #  it "check show method" do
  #  end
  #end
  #describe "PUT /api/todos/x" do
  #  it "check update method" do
  #    todo = FactoryBot.create(:todo)
  #  end
  #end
  #describe "DELETE /api/todos/x" do
  #  it "check delete method" do
  #  end
  #end
end
