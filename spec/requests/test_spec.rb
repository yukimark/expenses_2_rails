require 'rails_helper'

RSpec.describe 'Tests', type: :request do
  describe 'GET /index' do
    before do
      get '/api/test/index'
    end

    it '成功レスポンスが返ってくる' do
      expect(response.status).to eq(200)
    end

    it 'レスポンスjsonのmessageがテスト' do
      json = JSON.parse(response.body)
      expect(json['message']).to eq('テスト')
    end
  end
end
