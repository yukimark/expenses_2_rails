require 'swagger_helper'

RSpec.describe 'api/auth/registrations', type: :request do
  # rswag
  path '/api/auth' do
    post 'ユーザー作成' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      request_body_example value: {
        email: 'test@gmail.com',
        password: 'password'
      }, name: 'Example User Profile', summary: 'An example of the request body'

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 status: { type: :string, example: 'success' },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer, example: 6 },
                     provider: { type: :string, example: 'email' },
                     uid: { type: :string, example: 'test@gmail.com' },
                     allow_password_change: { type: :boolean, example: false },
                     name: { type: :string, nullable: true, example: nil },
                     email: { type: :string, example: 'test@gmail.com' },
                     created_at: { type: :string, format: 'date-time', example: '2024-09-20T10:29:35.440Z' },
                     updated_at: { type: :string, format: 'date-time', example: '2024-09-20T10:29:35.497Z' }
                   },
                   required: %w[id provider uid email created_at updated_at]
                 }
               },
               required: %w[status data]
        let(:user) { { email: 'test@gmail.com', password: 'password' } }

        run_test!
      end

      response '422', 'Unprocessable Content(メールアドレスが所定の形式を満たしていないとき)' do
        schema type: :object,
               properties: {
                 status: { type: :string, example: 'error' },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :string, nullable: true, example: nil },
                     provider: { type: :string, example: 'email' },
                     uid: { type: :string, nullable: true, example: '' },
                     allow_password_change: { type: :boolean, example: false },
                     name: { type: :string, nullable: true, example: nil },
                     email: { type: :string, example: 'test' },
                     created_at: { type: :string, nullable: true, example: nil },
                     updated_at: { type: :string, nullable: true, example: nil }
                   },
                   required: %w[email provider]
                 },
                 errors: {
                   type: :object,
                   properties: {
                     email: {
                       type: :array,
                       items: { type: :string, example: 'is not an email' }
                     },
                     full_messages: {
                       type: :array,
                       items: { type: :string, example: 'Email is not an email' }
                     }
                   }
                 }
               },
               required: %w[status data errors]
        let(:user) { { email: 'test', password: 'password' } }

        run_test!
      end
    end
  end

  # rspec
  describe 'post /api/auth' do
    
  end
end
