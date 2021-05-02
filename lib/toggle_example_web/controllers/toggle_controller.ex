defmodule ToggleExampleWeb.ToggleController do
  use ToggleExampleWeb, :controller
  import ToggleExample.ToggleList, [:t_HARDCODED]

  require Logger

  alias ToggleExample.Toggles
  alias ToggleExample.Toggles.Toggle

  # num ambiente de produção o deploy seria necessário
  # mas para um ambiente de dev pode ser ok
  # contudo para ambiente de testes não vai ser ideal
  def hardcoded(conn, _params) do
    router_toggle(:hard, t_HARDCODED(), conn)
  end

  # necessita de variável de ambiente no momento de
  # executar o servidor. Isso significa que uma mudança
  # de toggle necessita de um deploy do sistema
  # para testes seria necessário criar um stub para
  # o aplication.get_env em cada cenário, sendo possível
  # ter dinamicidade
  def env_var(conn, _params) do
    router_toggle(:env, env_var_1(), conn)
  end

  #necessita de uma fonte externa para gerenciar as
  #toggles. Traz o benefício de não precisar de deploy
  #para alteração do valor.
  #para teste apenas necessário fazer stub da fonte de toggles
  def external_service(conn, _params) do
    #o nome da toggle pode ser um arquivo separado
    router_toggle(:external, external_service_toggle("TOGGLE_1"), conn)
  end

  #da mesma forma que de serviço externo, não necessita de deploy
  def database(conn, _params) do
    with %Toggle{value: value} <- Toggles.get_toggle_by_name("TOGGLE_1") do
      router_toggle(:database, value, conn)
    else
      _ -> default_response(conn)
    end
  end

  #toggle true
  defp router_toggle(:hard, true, conn), do: response_toggle_on(conn)
  defp router_toggle(:env, true, conn), do: response_toggle_on(conn)
  defp router_toggle(:external, true, conn), do: response_toggle_on(conn)
  defp router_toggle(:database, true, conn), do: response_toggle_on(conn)

  #toggle false
  defp router_toggle(:hard, false, conn), do: default_response(conn)
  defp router_toggle(:env, false, conn), do: default_response(conn)
  defp router_toggle(:external, false, conn), do: default_response(conn)
  defp router_toggle(:database, false, conn), do: default_response(conn)

  defp response_toggle_on(conn) do
    conn
    |> put_status(:ok)
    |> json(%{message: ">>>> CAIRÃO LADRÃO! 🦸🏻, ROUBOU MEU CORAÇÃO 💚 🤏🏻 !! ¡¡¡ 🟢 TA ON 🔛 🚦¡¡¡<<<<"})
  end

  defp default_response(conn) do
    conn
    |> put_status(:ok)
    |> json(%{message: ":::::::::: 🔵 comportamento padrão 🔵 || -- 🔴 TOGGLE OFF 🔴 🤡 💤 ::::::::::"})
  end

  defp env_var_1 do
    Application.get_env(:toggle_example, :toggles)[:env_var_toggle_1]
  end

  defp external_service_toggle(toggle_name) do
    url = "https://gist.githubusercontent.com/raigons/2e97d2083bcaafec713673e1446b80ed/raw"

    {:ok, %SimpleHttp.Response{body: body}} = SimpleHttp.get(url)

    {:ok, toggles} = Jason.decode(body)

    Logger.warn("toggles=#{body}")

    toggle_value(toggles, toggle_name)
  end

  defp toggle_value(toggles, toggle_name) do
    toggles
    |> Enum.reduce(%{}, fn toggle, acc ->
      [{key, value}] = Map.to_list(toggle)
      Map.put(acc, key, value)
    end)
    |> Map.fetch(toggle_name)
    |> case do
      {:ok, value} -> value
      _ -> false
    end
  end
end
