return {
  name = "Run Researcher Websockets",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "Websockets.Researcher",
      cwd = "/Users/Alexander/intigriti/core/Websocket/Intigriti.Websockets.Researcher",
    }
  end,
}
