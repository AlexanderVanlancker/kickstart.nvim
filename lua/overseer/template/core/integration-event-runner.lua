return {
  name = "Run IntegrationEventRunner",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "IntegrationEventRunner",
      cwd = "/Users/Alexander/intigriti/core/IntegrationEventRunner/Intigriti.IntegrationEvent.Runner",
    }
  end,
}
