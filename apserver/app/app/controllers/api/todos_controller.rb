class Api::TodosController < ApplicationController
    def index
        @todos = Todo.all
        render status: 200, json: @todos
    end
end

