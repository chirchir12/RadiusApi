# RadiusApi

## Description

This server helps network admins to configure and centralize authentication and authorization for any network setup. It runs on top of Freeradius server which is a high performance and highly configurable multi-protocol policy server.
RadiusApi exposes APIs to do the following

1. add/edit/delete NAS
2. add/edit/delete users
3. add/edit/delete network policies

To start your RadiusApi server:

- Run `mix deps.get` to install dependencies
- Run `cp env.example .env` to copy configuration files
- Run `source .env` to export configuration to the current terminal session
- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
