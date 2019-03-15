defmodule ExPolygon.Rest.Exchanges do
  @type exchange :: ExPolygon.Exchange.t()
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()

  @path "/v1/meta/exchanges"

  @spec all(api_key) :: {:ok, [exchange]}
  def all(api_key) do
    @path
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response()
  end

  def parse_response({:ok, data}) do
    list =
      data
      |> Enum.map(&Mapail.map_to_struct(&1, ExPolygon.Exchange, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    {:ok, list}
  end
end