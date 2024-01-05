class ApplicationController < ActionController::Base
  error_types = [
    InvalidData,
    InvalidSize,
    ActiveRecord::RecordNotFound,
    ActiveRecord::RecordInvalid,
    JSON::ParserError
  ]
  rescue_from *error_types, with: :custom_error_handling
  before_action :set_errors

  def set_errors
    @errors = []
  end

  def custom_error_handling(exception)
    @errors << exception.message
    @error_string = @errors.join('\n')
    Rails.logger.error "[INVALID_RECORD] Exception #{exception.class}: #{exception.message}"
    render json: { errors: @errors }.to_json, status: :bad_request
  end
end
