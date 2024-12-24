# hex2txt

Convert documentation for [hex.pm packages](https://hex.pm) to [`/llms.txt`
files](https://llmstxt.org).

## Why?

The LLM you're using to help with development might not know about the
libraries you're using. Use `hex2txt` to generate documentation for
inference-time consumption.

If the documentation is too large for your LLM's context window, use the
[`hex2context` Livebook](./notebooks/hex2context.livemd). `hex2context`
performs Retrieval-Augmented Generation, including only the most relevant
subset of documentation for the task-at-hand.

## Try It

### `hex2txt`

See [https://hex2txt.fly.dev](https://hex2txt.fly.dev).

Some examples:

- https://hex2txt.fly.dev/geo/llms.txt
- https://hex2txt.fly.dev/flop_phoenix/llms.txt
- https://hex2txt.fly.dev/phoenix_live_view/llms.txt
- https://hex2txt.fly.dev/elixir/1.18.0-rc.0/llms.txt
- https://hex2txt.fly.dev/ecto_ulid_next/1.0.2/llms.txt
- https://hex2txt.fly.dev/phoenix/1.7.17/llms.txt

### `hex2context`

Run the notebook directly by clicking on this badge:

[![Run in Livebook](https://livebook.dev/badge/v1/blue.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2Fmjrusso%2Fhex2txt%2Fblob%2Fmain%2Fnotebooks%2Fhex2context.livemd)

## License

hex2txt is released under the terms of the [Apache License 2.0](LICENSE).

Copyright (c) 2024, [Michael Russo](https://mjrusso.com).
