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

      response '200', '成功' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 data: { type: :hash }
               },
               required: %w[status data]

        let(:user) { { email: 'test@gmail.com', password: 'password' } }

        run_test!
      end
    end
  end
end
