require 'google/api_client'
require 'date'

module ReportingHelper

  SERVICE_ACCOUNT_EMAIL = '142715827895-7j2bdg768lnqkgdmfat8r47fen5qlcpr@developer.gserviceaccount.com'
  KEY_PATH = File.join(Rails.root, '/config/', 'rishighan-e2d48dda2835.p12')
  PROFILE = 'ga:17894417'

  def self.initclient
    client = Google::APIClient.new(:application_name => 'rishighan.com', :application_version => '1')

    key = Google::APIClient::PKCS12.load_key(KEY_PATH, 'notasecret')
    service_account = Google::APIClient::JWTAsserter.new(
      SERVICE_ACCOUNT_EMAIL,
      ['https://www.googleapis.com/auth/analytics.readonly', 'https://www.googleapis.com/auth/prediction'],
    key)
    client.authorization = service_account.authorize
    analytics = client.discovered_api('analytics', 'v3')

    parameters = {
      'accountId' => '~all',
      'webPropertyId' => '~all'
    }

    return client, analytics, parameters
  end

end
