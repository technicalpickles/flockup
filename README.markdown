# Environments
## Development

Make sure to have simplified_starling running:

    rake simplified_starling:start


## Production

### SSH

    # Append this to ~/.ssh/config
    Host flockup
    Hostname 72.14.181.9
    User root

 Now you can just:
 
    ssh flockup


### Deployment:

    rake vlad:update vlad:migrations vlad:start_app

Be sure to run rake simplified_starling:restart

# Misc

## Image sources

public/images/flock1.jpg -> http://www.flickr.com/photos/ibananti/339974471/

## Google AJAX API

http://twitterflocks.r08.railsrumble.com/
  ABQIAAAAnU3EOq-B5533f3b2eBAXGBSEp8BOg1rUkDTow5kM6RSzgz617RTATaAzS3n7Xg-xd2JQaTjcmZIVDw

http://localhost:3000/
  ABQIAAAAnU3EOq-B5533f3b2eBAXGBTJQa0g3IQ9GZqIMmInSLzwtGDKaBRHDbLdyiSs-Jt4IElvjXki41bG-Q

