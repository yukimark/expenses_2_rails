require 'swagger_helper'

RSpec.describe 'api/test', type: :request do
  # rswag
  path '/api/test/index' do
    get 'テストというmessageが返ってくる' do
      produces 'appilication/json'

      response '200', '成功' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string }
               },
               required: %w[status message]

        run_test!
      end
    end
  end

  # rspec
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
