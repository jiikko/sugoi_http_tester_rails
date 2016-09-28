class SugoiHttpTesterRails::Project < ActiveRecord::Base
  has_many :testing_hosts, dependent: :destroy
  has_many :template_request_groups, dependent: :destroy

  # 1つ実行単位
  # 300の中に500系があればテスト中止する
  COUNT_OF_TEST_GROUP = 300

  def import_from(file)
    tester = SugoiHttpRequestTester.new(
      host: nil,
      limit: 1000000000, # 適当
      logs_path: file.path,
    )
    tester.line_parse_block = ->(line){
      /({.*})/ =~ line
      json = JSON.parse($1)
      { method: json['mt'], user_agent: json['ua'], path: json['pt'] }
    }
    tester.import_logs!
    list = tester.export_request_list!(export_format: :array)
    created_hash = {}
    request_group = template_request_groups.create!
    list.each do |hash|
      # 作成済みのレコードをオンメモリでチェックする
      if created_hash[hash[:path]] && created_hash[hash[:path]][hash[:device_type]]
        next
      end
      created_hash[hash[:path]] || (created_hash[hash[:path]] = {})
      created_hash[hash[:path]][hash[:device_type]] = true
      request_group.template_requests.create!(
        device_type: hash[:device_type],
        http_method: SugoiHttpTesterRails::TemplateRequest::HTTP_METHOD_TABLE[hash[:method]] || next, # 知らないメソッドがきたらnext
        path: hash[:path],
      )
    end
  end
end
