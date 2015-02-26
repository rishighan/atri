#reporting api
require 'legato'

#oauth stuff
LEGATO_OAUTH_CLIENT_ID='142715827895-sgn9om8q2js5anj06tsknkrffaik94lc.apps.googleusercontent.com'
LEGATO_OAUTH_SECRET_KEY='aklF7ux-PziH0rs-qAl5FTxK'
LEGATO_OAUTH_AUTH_CODE='4/rvyhkjLy497LGeOIXbomu_GbVeF75MY7nyAJL9LRRfA.8nRc_-hDiaweJvIeHux6iLaPQ1KBlwI'
LEGATO_ACCESS_TOKEN = 'ya29.IgE2lVYKfqKqmPwNrQ9acBzT6QDhWSokFwaxw9a1i04KdzOspqfmvK54k-WxubfzeVTwgPO645LToA'

client = OAuth2::Client.new(LEGATO_OAUTH_CLIENT_ID, LEGATO_OAUTH_SECRET_KEY, {
  :authorize_url => 'https://accounts.google.com/o/oauth2/auth',
  :token_url => 'https://accounts.google.com/o/oauth2/token'
})
client.auth_code.authorize_url({
  :scope => 'https://www.googleapis.com/auth/analytics.readonly',
  :redirect_uri => 'http://localhost',
  :access_type => 'offline'
})

access_token = client.auth_code.get_token(LEGATO_OAUTH_AUTH_CODE, :redirect_uri => 'http://localhost')