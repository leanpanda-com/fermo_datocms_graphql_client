defmodule Fermo.DatoCMS.GraphQLClient do
  alias DatoCMS.GraphQLClient.Backends.StandardClient
  alias DatoCMS.GraphQLClient.QueryMonitor
  alias Fermo.Live.Dependencies
  alias Fermo.Live.SocketRegistry

  def configure(opts \\ []) do
    StandardClient.configure(opts)
  end

  def query_for_path!(path, query, params \\ %{}) do
    if StandardClient.live? do
      {:ok, body} = QueryMonitor.subscribe!(query, params, fn ->
        handle_reload(path)
      end)

      body
    else
      StandardClient.query!(query, params)
    end
  end

  defp handle_reload(path) do
    # If one of the paths was `nil`, we need to reload the Fermo config
    # TODO: handle case where path is a list and includes `nil`
    if !path do
      {:ok} = Dependencies.reinitialize()
    end
    {:ok} = SocketRegistry.reload(path)
  end
end
