class Pageviews < ActiveRecord::Base
  #google analytics api shenanigans
  require 'google/api_client'
  require 'date'
  include ReportingHelper

  def self.getviews post
  	client, analytics, parameters = ReportingHelper.initclient
    result   = client.execute(:api_method => analytics.management.profiles.list, parameters: parameters)
    profiles = result.data.items

    parameters = {
      'ids'         => PROFILE,
      'start-date'  => (Date.today - 30).strftime("%Y-%m-%d"),
      'end-date'    => Date.today.strftime("%Y-%m-%d"),
      'metrics'     => "ga:pageviews",
      'dimensions'  => "ga:date",
      'filters'     => "ga:pagePath=~/#{post}"
    }
    result = client.execute(:api_method => analytics.data.ga.get, :parameters => parameters)
    interim = result.data.rows.map{|hit| hit[1].to_i}.join(', ')

  end

end
