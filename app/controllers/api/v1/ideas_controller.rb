module Api
  module V1
    class IdeasController < ApplicationController
      def index
        if params[:category_name]
          category = Category.find_by(name: params[:category_name])
          return render status: 404 unless category

          ideas = category.ideas
        else
          ideas = Idea.all.eager_load(:category)
        end
        data = ideas.map { |idea| { id: idea.id, category: idea.category.name, body: idea.body } }
        render json: { data: data }
      end

      def create
        ActiveRecord::Base.transaction do
          category = Category.find_by(name: params[:category_name]) || Category.create!(name: params[:category_name])
          category.ideas.create!(body: params[:body])
        end
        render status: 201
      rescue ActiveRecord::RecordInvalid
        render status: 422
      end
    end
  end
end
