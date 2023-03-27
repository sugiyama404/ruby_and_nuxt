require 'rails_helper'

RSpec.describe Todo, type: :model do
  it "create recode" do
    todo = FactoryBot.create(:todo)
    expect(todo).to be_valid
  end
end
