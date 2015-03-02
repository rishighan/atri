#reporting api
require 'legato'
#oauth stuff
LEGATO_OAUTH_CLIENT_ID='142715827895-sgn9om8q2js5anj06tsknkrffaik94lc.apps.googleusercontent.com'
LEGATO_OAUTH_SECRET_KEY='aklF7ux-PziH0rs-qAl5FTxK'
#LEGATO_OAUTH_AUTH_CODE='4/hhaMW_AxaEzRK7rEIiA0ASrgTSPB68tg9hn-SuULPXc.AiDm5_INdkMUJvIeHux6iLZBl3uxlwI'
LEGATO_ACCESS_TOKEN = 'ya29.KgECXsil8U0TVU244ajVhmvOlLGxd09vd14Cps5bFjyU4unLHJx-LB35imgAX-fFHmfz69F0y4nyPQ'

module ReportingHelper

def authify
client = OAuth2::Client.new(LEGATO_OAUTH_CLIENT_ID, LEGATO_OAUTH_SECRET_KEY, {
  :authorize_url => 'https://accounts.google.com/o/oauth2/auth',
  :token_url => 'https://accounts.google.com/o/oauth2/token'
})

client.auth_code.authorize_url({
  :scope => 'https://www.googleapis.com/auth/analytics.readonly',
  :redirect_uri => 'http://localhost',
  :access_type => 'offline'
})
access_token = OAuth2::AccessToken.from_hash client, {:access_token => LEGATO_ACCESS_TOKEN}
#access_token = client.auth_code.get_token(LEGATO_OAUTH_AUTH_CODE, :redirect_uri => 'http://localhost')
user = Legato::User.new(access_token)

profile = user.profiles.first

end


end