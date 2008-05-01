class OnlineResource < ActiveRecord::Base
  validates_presence_of     :ref_id, :ref_class, :user_id, :resource_type, :url
  validates_format_of       :url, :with => /^http(s)?:\/\/[\w\-\.]+\.[\w\-\.\/]+$/

  before_validation :normalize_url

  def normalize_url
    return unless self.url
    unless self.url =~ /http(s)?:\/\/.+\..+/
      self.url = "http://" + self.url
    end
  end
end
