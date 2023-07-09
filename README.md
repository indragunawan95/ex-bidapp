# Exbidapp
This is a simple bid application.

## Roadmap

- [x] Docker Compose Setup
- [x] Product CRUD
- [x] Bid CRUD
- [x] Github Action CI
- [ ] Github Action CD
- [ ] Authentication
- [ ] Authorization
- [ ] Product Image using S3 or Equivalent

# How to start
To start your Phoenix server:
  * Run `docker compose up -d` to run posgres conatiner
  * Run `source env.sh` to source your env to the terminal. Example of the env provided in `env-sample.sh`
  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


# Business Domain

## Product
This where all product management happen.

## Bid
This where all bid management happen.