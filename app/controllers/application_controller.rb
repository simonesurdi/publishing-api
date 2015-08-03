class ApplicationController < ActionController::Base

private

  def base_path
    "/#{params[:base_path]}"
  end

  def parse_content_item
    @content_item = JSON.parse(request.body.read).deep_symbolize_keys
  rescue JSON::ParserError
    head :bad_request
  end

  attr_reader :content_item
end