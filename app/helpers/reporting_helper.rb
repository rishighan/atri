require 'google/api_client'
require 'date'
require 'yaml'

module ReportingHelper
  SERVICE_ACCOUNT_EMAIL = '142715827895-7j2bdg768lnqkgdmfat8r47fen5qlcpr@developer.gserviceaccount.com'
  KEY_PATH = File.join(Rails.root, '/config/', 'rishighan-e2d48dda2835.p12')
  PROFILE = 'ga:17894417'
  API_VERSION = 'v3'
  CACHED_API_FILE = "analytics-#{API_VERSION}.cache"

  def self.initclient
    @client = Google::APIClient.new(
            :application_name => 'rishighan.com',
            :application_version => '1')

    key = Google::APIClient::PKCS12.load_key(KEY_PATH, 'notasecret')
    service_account = Google::APIClient::JWTAsserter.new(
      SERVICE_ACCOUNT_EMAIL,
      ['https://www.googleapis.com/auth/analytics.readonly', 'https://www.googleapis.com/auth/prediction'],
    key)
    @client.authorization = service_account.authorize
    #analytics = client.discovered_api('analytics', API_VERSION)
    @analytics = nil

    ## Load cached discovered API, if it exists. This prevents retrieving the
    ## discovery document on every run, saving a round-trip to the discovery service.
    if File.exists? CACHED_API_FILE
      File.open(CACHED_API_FILE) do |file|
        @analytics = Marshal.load(file)
      end
    else
      @analytics = client.discovered_api('analytics', API_VERSION)
      File.open(CACHED_API_FILE, 'w') do |file|
        Marshal.dump(@analytics, file)
      end
    end

    parameters = {
      'accountId' => '~all',
      'webPropertyId' => '~all'
    }

    return @client, @analytics, parameters
    # get these values like so: client, analytics, parameters = ReportingHelper.initclient
  end

end
