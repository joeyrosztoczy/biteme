defmodule BitemeWeb.Router do
  use BitemeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BitemeWeb do
    pipe_through :api

    resources "/urls", UrlController, only: [:create, :show, :delete]
  end
end
