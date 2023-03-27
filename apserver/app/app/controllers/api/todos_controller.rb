class Api::TodosController < ApplicationController
    before_action :set_todo, only: [:show, :update, :destroy]
    def index
        @todos = Todo.all
        render status: :ok, json: @todos #200
    end
    def show
        render status: :ok, json: @todo
    end
    def create
        todo = Todo.new(todo_params)
        if todo.save
          render status: :created #201
        else
          render status: :unprocessable_entity #422
        end
    end
    def update
        if @todo.update(todo_params)
            render status: :accepted #202
        else
            render status: :unprocessable_entity
        end
    end
    def destroy
        @todo.destroy
        render status: :accepted #202
    end

    private
    def set_todo
        @todo = Todo.find(params[:id])
    end
    def todo_params
        params.require(:todo).permit(:content)
    end
end
