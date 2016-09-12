class SugoiHttpTesterRails::RequestGroupsController < ApplicationController
  def show
    @project = SugoiHttpTesterRails::Project.find(params[:project_id])
    @testing_host = SugoiHttpTesterRails::TestingHost.find(params[:testing_host_id])
    @request_group = SugoiHttpTesterRails::RequestGroup.find(params[:id])
    @success_requests =      @request_group.requests.where(status_code: 200..299).limit(10)
    @redirect_requests =     @request_group.requests.where(status_code: 300..399).limit(10)
    @client_error_requests = @request_group.requests.where(status_code: 400..499).limit(10)
    @server_error_requests = @request_group.requests.where(status_code: 500..599)
  end

  def create
    project = SugoiHttpTesterRails::Project.find(params[:project_id])
    testing_host = SugoiHttpTesterRails::TestingHost.find(params[:testing_host_id])
    template_request_group = SugoiHttpTesterRails::TemplateRequestGroup.find(params[:template_request_group_id])
    request_group = testing_host.request_groups.create!
    request_group.run_http_test_with_delay!(template_request_group: template_request_group)
    redirect_to project_testing_host_request_group_path(project, testing_host, request_group), notice: 'テスト中です'
  end
end
