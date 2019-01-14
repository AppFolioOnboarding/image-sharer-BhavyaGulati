class HttpUrlValidator < ActiveModel::EachValidator
  def self.compliant?(value)
    uri = URI.parse(value)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    record.errors.add(attribute, 'is not a valid HTTP URL') if value.blank? || !self.class.compliant?(value)
  end
end

class Image < ApplicationRecord
  validates :url, http_url: true
end
