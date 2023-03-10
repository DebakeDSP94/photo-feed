require "dotenv/load"
require "flickr"

flickr_api_key = ENV["FLICKR_API_KEY"]
flickr_shared_secret = ENV["FLICKR_SHARED_SECRET"]
flickr = Flickr.new flickr_api_key, flickr_shared_secret

# This is the URL Flickr will redirect your users to once they agree to access
@callback_url = "http://localhost:3000/auth_controller/callback"

# Users should hit this method to get the link which sends them to flickr
def auth
  flickr = Flickr.new API_KEY, SHARED_SECRET
  token = flickr.get_request_token(oauth_callback: URI.escape(@callback_url))
  # You'll need to store the token somewhere for when the user is returned to the callback method
  # I stick mine in memcache with their session key as the cache key

  @auth_url = flickr.get_authorize_url(token["oauth_token"], perms: "delete")
  # Stick @auth_url in your template for users to click
end

# Your users browser will be redirected here from Flickr (see @callback_url above)
def callback
  flickr = Flickr.new

  request_token = # Retrieve from cache or session etc - see above
    oauth_token = params[:oauth_token]
  oauth_verifier = params[:oauth_verifier]

  raw_token =
    flickr.get_access_token(
      request_token["oauth_token"],
      request_token["oauth_token_secret"],
      oauth_verifier
    )
  # raw_token is a hash like this {"user_nsid"=>"92023420%40N00", "oauth_token_secret"=>"XXXXXX", "username"=>"boncey", "fullname"=>"Darren%20Greaves", "oauth_token"=>"XXXXXX"}
  # Use URI.unescape on the nsid and name parameters

  oauth_token = raw_token["oauth_token"]
  oauth_token_secret = raw_token["oauth_token_secret"]

  # Store the oauth_token and oauth_token_secret in session or database
  #   and attach to a Flickr instance before calling any methods requiring authentication

  # Attach the tokens to your flickr instance - you can now make authenticated calls with the flickr object
  flickr.access_token = oauth_token
  flickr.access_secret = oauth_token_secret
end
