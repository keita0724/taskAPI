require 'rails_helper'

describe 'IdeaAPI' do
  describe '#index' do
    it '全てのアイデアを取得する' do
      FactoryBot.create_list(:idea, 10)

      get '/api/v1/ideas'
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json['data'].length).to eq(10)
    end

    it '登録カテゴリーのアイデアを取得する' do
      ideas = FactoryBot.create_list(:idea, 10)

      get "/api/v1/ideas?category_name=#{ideas[0].category.name}"
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json['data'].length).to eq(ideas[0].category.ideas.count)
    end

    it '未登録カテゴリーのアイデアを取得する' do
      FactoryBot.create_list(:idea, 10)

      get "/api/v1/ideas?category_name=#{Faker::Lorem.word}"

      expect(response.status).to eq(404)
    end
  end

  describe '#create' do
    it 'すでにカテゴリーが存在するアイデアを登録する' do
      category = FactoryBot.create(:category)
      valid_parmas = { category_name: category.name, body: Faker::Lorem.sentence }

      expect { post '/api/v1/ideas', params: valid_parmas }.to change(Idea, :count).by(1)
      expect(response.status).to eq(201)
    end

    it 'カテゴリーが存在しないアイデアを登録する' do
      valid_parmas = { category_name: Faker::Lorem.word, body: Faker::Lorem.sentence }

      expect do
        post '/api/v1/ideas', params: valid_parmas
      end.to change(Category, :count).by(1).and change(Idea, :count).by(1)
    end
  end
end
