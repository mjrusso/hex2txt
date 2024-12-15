dev: replapp

test:
    mix test

lint:
    mix format --check-formatted

build:
    mix compile --warnings-as-errors --force

compile: build

ci:
    mix ci

setup:
    mix setup

clean:
    mix clean
    mix deps.clean --unused mix
    mix phx.digest.clean

clean-all:
    mix deps.clean --all --force
    mix clean --all --force
    phx.digest.clean
    mix local.hex --force
    mix local.rebar --force
    mix deps.get

# Start the Phoenix webserver, enabling the node to accept connections from
# other nodes (including those nodes run by Livebook).
runapp:
    elixir --name $NODE_NAME@127.0.0.1 --cookie $NODE_COOKIE -S mix phx.server

# Like `runapp`, but also starts an IEx instance.
replapp:
    iex --name $NODE_NAME@127.0.0.1 --cookie $NODE_COOKIE -S mix phx.server

# Start an IEx instance that connects to a node started with `runapp` or
# `replapp`. (`iexc` is short for "IEx connect".)
iexc:
    iex --cookie "$NODE_COOKIE" --remsh "$NODE_NAME@127.0.0.1"

print-versions: print-erlang-version print-elixir-version print-node-version

print-erlang-version:
    erl -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), "releases", erlang:system_info(otp_release), "OTP_VERSION"])), io:fwrite(Version), halt().' -noshell

print-elixir-version:
    elixir -e 'IO.puts(System.version)'

print-node-version:
    node -e 'console.log(process.version.replace(/^v/,""))'
