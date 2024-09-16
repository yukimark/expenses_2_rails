class Api::TestController < ApplicationController
  def index
    render json: { status: 'SUCCESS', message: 'テスト' }
  end
end
