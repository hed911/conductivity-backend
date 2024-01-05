module TimestampConverter
  extend ActiveSupport::Concern

  def timestamp
    created_at&.to_time&.iso8601
  end
end
