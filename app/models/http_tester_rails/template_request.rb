class HttpTesterRails::TemplateRequest < ActiveRecord::Base
  include HttpTesterRails::HttpMethodModule

  enum device_type: %i(pc sp)

  belongs_to :template_request_group
end
