defmodule ToggleExampleWeb.ToggleController do
  use ToggleExampleWeb, :controller
  import ToggleExample.ToggleList, [:t_HARDCODED]

  # num ambiente de produção o deploy seria necessário
  # mas para um ambiente de dev é ok
  def hardcoded(conn, _params) do
    router_toggle(t_HARDCODED(), conn)
  end

  defp router_toggle(true, conn), do: hardcoded_on(conn)
  defp router_toggle(false, conn), do: hardcoded_off(conn)

  defp hardcoded_on(conn) do
    conn
    |> put_status(:ok)
    |> json(%{message: ">>>> CAIRÃO LADRÃO, ROUBOU MEU CORAÇÃO <<<<"})
  end

  defp hardcoded_off(conn) do
    conn
    |> put_status(:ok)
    |> json(%{message: ":::::::::: TOGGLE OFF ::::::::::"})
  end
end
