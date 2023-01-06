# README

This is the flickr photo feed app from The Odin Project.
https://www.theodinproject.com/lessons/ruby-on-rails-flickr-api

It uses the flickr gem for Oauth to access the flickr API. The API key and
secret are stored in a .env file thanks to the dotenv gem. There is an
initializer file, flickr.rb, that runs when the app starts and goes through the
auth process. At which point it is now possible to search for photos. The
assignment was to allow search by user-id. However, I found it difficult to find
user id's other than my own. So, I added a flickr method to search by username,
which then returns a hash containing the user-id, and then do a an api call with
the user-id to retrieve that persons photos. I also added search by tags
functionality. If there is no search performed at all (such as at the start of
the app), it will return recent flickr photos.

- ...
