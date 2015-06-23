class Pageviews < ActiveRecord::Base
  #google analytics api shenanigans
  require 'google/api_client'
  require 'date'
  require 'yaml'

  API_VERSION = 'v3'
  CACHED_API_FILE = "analytics-#{API_VERSION}.cache"

  ## Read app credentials from a file
  opts = YAML.load_file("config/ga_config.yml")

  ## Update these to match your own apps credentials in the ga_config.yml file
  service_account_email = opts['service_account_email']  # Email of service account
  key_file = opts['key_file']                            # File containing your private key
  key_secret = opts['key_secret']                        # Password to unlock private key
  @profileID = opts['profileID'].to_s                    # Analytics profile ID.


  @client = Google::APIClient.new(
  :application_name => opts['application_name'],
  :application_version => opts['application_version'])

  ## Load our credentials for the service account
  key = Google::APIClient::KeyUtils.load_from_pkcs12(key_file, key_secret)

  @client.authorization = Signet::OAuth2::Client.new(
    :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
    :audience => 'https://accounts.google.com/o/oauth2/token',
    :scope => 'https://www.googleapis.com/auth/analytics.readonly',
    :issuer => service_account_email,
    :signing_key => key)

  ## Request a token for our service account
  @client.authorization.fetch_access_token!

  @analytics = nil
  ## Load cached discovered API, if it exists. This prevents retrieving the
  ## discovery document on every run, saving a round-trip to the discovery service.
  if File.exists? CACHED_API_FILE
    File.open(CACHED_API_FILE) do |file|
      @analytics = Marshal.load(file)
    end
  else
    @analytics = @client.discovered_api('analytics', API_VERSION)
    File.open(CACHED_API_FILE, 'w') do |file|
      Marshal.dump(@analytics, file)
    end
  end

  def self.getviews post
    query_data = @client.execute(:api_method => @analytics.data.ga.get, :parameters => {

      'ids'         => 'ga:'+ @profileID,
      'start-date'  => (Date.today - 30).strftime("%Y-%m-%d"),
      'end-date'    => Date.today.strftime("%Y-%m-%d"),
      'metrics'     => "ga:pageviews",
      'dimensions'  => "ga:date",
      'filters'     => "ga:pagePath=~/#{post}"
    })

    # result = client.execute(:api_method => analytics.data.ga.get, :parameters => parameters)
    query_data.data.rows.map{|hit| hit[1].to_i}.join(', ')

  end

  # get just the total of the pageviews
  def self.getTotalPageviews resultset
    result_array = resultset.split(',').map{|x| x.to_i}
    result_array.inject(:+)
  end

  # sort a two-dimensional array descending
  #todo: add a param for direction
  def self.sortArray arr
    arr.sort do |a, b|
      b[2] <=> a[2]
    end
  end

end
