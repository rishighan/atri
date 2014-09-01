require 'instagram'


CALLBACK_URL = "http://rishighan.com/photolog"
CLIENT_ID = "9f748070d00748cf8c845f874800ab00"
ACCESS_TOKEN = "4477253.9f74807.ad99d75537254ebea3bef853b31954d1"
RESULTS = 18

Instagram.configure do |config|
  config.client_id = CLIENT_ID
  config.access_token = ACCESS_TOKEN
end



