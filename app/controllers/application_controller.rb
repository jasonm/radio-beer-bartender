class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate

  protected

  def authenticate
    if Rails.env.production? && ENV['HTTP_AUTH_USER'] && ENV['HTTP_AUTH_PASSWORD']
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['HTTP_AUTH_USER'] && password == ENV['HTTP_AUTH_PASSWORD']
      end
    else
      true
    end
  end
end
