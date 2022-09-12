class TestController < ApplicationController
  def index
    tests = ["test", "desu"]
    render json: tests
  end
end
