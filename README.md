# Markr
## Stile Education Code Challenge

Markr is an API that receives XML from test marking machines, records the marks in a database, and reports statistics of all results for agiven test in JSON format. It seeks to implement the requirements as specified in SPEC.md.

It is written in Ruby on Rails 6.x and Ruby 3.0.x, importing as few features as possible. Notes about decisions made during development can be found in NOTES.md.

## Developing Markr

The Markr development environment is built and run using [`docker-compose`](https://docs.docker.com/compose/compose-file/). The usual commands work from the project root directory, but you'll need to build and bundle before running the server.


### Build

There's a [Dockerfile](https://docs.docker.com/engine/reference/builder/) to build the `markr:latest` image:

```
docker-compose build
```

### Bundle

There's a [volume](https://docs.docker.com/storage/volumes/) called `markr_gems` set up to act as a cache for ruby gems, so you'll need to bundle before you run the server:

```
docker-compose run --rm app bundle install
```

### Run

The compose file runs the Markr service on port 3000 (the default for rails apps), and the other services that support it:

```
docker-compose up -d
```

Rails reinterprets and reloads source files as they change, so development should be mostly seemless with the service running, however if you need to restart the service (e.g. after gem/config changes), you can do so:

```
docker-compose restart app
```

### Databases

We use a postgres container with insanely lax security for the development and test databases; once the environment is running, you'll need to create these databases:

```
docker-compose run exec rails db:create
```

Run migrations in the way you'd expect, too:

```
docker-compose exec app rails db:migrate
```


### Shutdown
Don't forget to clean up before you leave:

```
docker-compose down
```

### Notes

- [`pry`](https://pry.github.io/) and [`byebug`](https://github.com/deivid-rodriguez/byebug) are available for debugging.
- A REPL can be started on the running app server using:
  ```
  docker-compose exec app pry
  ```
