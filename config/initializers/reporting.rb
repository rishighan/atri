#reporting api
require 'legato'

#oauth stuff
LEGATO_OAUTH_CLIENT_ID='142715827895-sgn9om8q2js5anj06tsknkrffaik94lc.apps.googleusercontent.com'
LEGATO_OAUTH_SECRET_KEY='aklF7ux-PziH0rs-qAl5FTxK'
LEGATO_OAUTH_AUTH_CODE='4/TK4A3TvHtGOokCOamOGB0VheR18DsB9coKH3_l_ctdA.0k4kUVpGjlYRgtL038sCVnsHSjlnlwI'
LEGATO_ACCESS_TOKEN = 'ya29.IgE2lVYKfqKqmPwNrQ9acBzT6QDhWSokFwaxw9a1i04KdzOspqfmvK54k-WxubfzeVTwgPO645LToA'

# client = OAuth2::Client.new(LEGATO_OAUTH_CLIENT_ID,LEGATO_OAUTH_SECRET_KEY, {
#   :authorize_url => 'https://accounts.google.com/o/oauth2/auth',
#   :token_url => 'https://accounts.google.com/o/oauth2/token'
# })

# client.auth_code.authorize_url({
#   :scope => 'https://www.googleapis.com/auth/analytics.readonly',
#   :redirect_uri => 'http://rishighan.com',
#   :access_type => 'offline'
# })
# access_token = OAuth2::AccessToken.from_hash client, {:access_token => LEGATO_ACCESS_TOKEN}
#user = Legato::User.new(LEGATO_ACCESS_TOKEN)

#response_json = access_token.get('https://www.googleapis.com/analytics/v3/management/accounts').body