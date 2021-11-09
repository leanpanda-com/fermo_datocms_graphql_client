# Fermo.DatoCMS.GraphqlClient

This library is used in Fermo projects that use the
DatoCMS GraphQL content delivery API to enable
real-time updates in Fermo's live mode.

# Development

You can test out queries in iex as follows:

```elixir
import Fermo.DatoCMS.GraphQLClient
DatoCMS.GraphQLClient.Backends.StandardClient.configure()
query!("{ ...some GraphQL query }")
```
