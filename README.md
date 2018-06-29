# How to run
Switch Your Mates is run in two components.
First, we have the face recognition container and second, we have the Rails app.

## Setup docker
In a new tab:
```sh
docker pull bamos/openface
docker run -p 9000:9000 -p 8000:8000 -t -i bamos/openface /bin/bash
```

This will setup a new docker instance, to close the instance hit `Ctrl-c`.

## Setup Rails app
In a new tab:
```sh
cd switch_your_mates
ruby setup.rb
```

The `setup.rb` script hooks up your live docker instance to the rails app and copied across the `swap` and `mix` python scripts that do the face swap logic!

## Running
```sh
bundle exec rails server
```

Verify the deployment by navigating to your server address in your preferred browser and start switching faces!

```sh
http://localhost:3000
```

License
----

MIT

**Free Software, Hell Yeah!**
