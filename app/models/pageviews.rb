class Pageviews < ActiveRecord::Base
  #google analytics api shenanigans
  require 'google/api_client'
  require 'date'
  include ReportingHelper

  def self.getviews post
    client, analytics, parameters = ReportingHelper.initclient

    parameters = {
      'ids'         => PROFILE,
      'start-date'  => (Date.today - 30).strftime("%Y-%m-%d"),
      'end-date'    => Date.today.strftime("%Y-%m-%d"),
      'metrics'     => "ga:pageviews",
      'dimensions'  => "ga:date",
      'filters'     => "ga:pagePath=~/#{post}"
    }

    result = client.execute(:api_method => analytics.data.ga.get, :parameters => parameters)
    result.data.rows.map{|hit| hit[1].to_i}.join(', ')
    #profiles = result.data.items
    # cache_key = post
    # Rails.cache.fetch('google_analytics_api/#{cache_key}', expires_in: 2.minutes) do
    #   result = client.execute(:api_method => analytics.data.ga.get, :parameters => parameters)
    #   result.data.rows.map{|hit| hit[1].to_i}.join(', ')

    # end
  end

  # get just the total of the pageviews
  def self.getTotalPageviews resultset
    result_array = resultset.split(',').map{|x| x.to_i}
    result_array.inject(:+)
  end

  # sort a two-dimensional array descending
  #todo: add a param for direction
  def self.sortArray arr, index
    arr.sort do |a, b|
      b[index] <=> a[index]
    end
  end
end
