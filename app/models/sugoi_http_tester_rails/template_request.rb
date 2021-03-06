class SugoiHttpTesterRails::TemplateRequest < ActiveRecord::Base
  include SugoiHttpTesterRails::HttpMethodModule

  enum device_type: %i(pc sp)

  belongs_to :template_request_group

  scope :search, ->(keyword) { where('path like ?', "#{sanitize_sql_like(keyword)}%") }
end
