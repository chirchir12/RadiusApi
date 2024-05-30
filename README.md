# RadiusApi

## Description

This server helps network admins to configure and centralize authentication and authorization for any network setup. It runs on top of Freeradius server which is a high performance and highly configurable multi-protocol policy server. Users will be able to login using provided username/mac and password mac. Mac address must be added/attached to users before their can access the network. there are two types of users , admin and guests. we made assumptions to use mikrotik Router as the NAS
RadiusApi exposes APIs to do the following

1. add/edit/delete NAS
2. add/edit/delete users
3. add/edit/delete user devices
4. add users to a network |> will add all his/her devices
5. remove user from network |> will remove all his/her devices
6. add device to a network
7. remove device from a network

To start your RadiusApi server:

- Run `mix deps.get` to install dependencies
- Run `cp env.example .env` to copy configuration files
- Run `source .env` to export configuration to the current terminal session
- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## todo

1. authentication and authorization
2. captive page

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
