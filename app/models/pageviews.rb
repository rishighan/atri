#reporting model
class Pageviews
  extend Legato::Model


  user = Legato::User.new(access_token)
  profile = user.profiles.first

  metrics :pageviews, :uniquePageviews
  dimensions :pagePathLevel1


  filter(:by_index_in_path_level_1) {|page_path_level1| contains(:pagePathLevel1, 'index')}

  def self.query(profile, start_date, end_date)
    Pageviews.results(profile,
                      :start_date => start_date,
                      :end_date => end_date
    )
    # Just for reference, sorting descending by pageviews is done by:   :sort => '-pageviews'
  end

  def self.query_index(profile, start_date, end_date)
    Pageviews.by_index_in_path_level_1.results(profile,
                                               :start_date => start_date,
                                               :end_date => end_date
    )
  end
end