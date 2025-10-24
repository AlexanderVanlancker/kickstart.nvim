return {
  name = "Run DomainEventRunner",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "DomainEventRunner",
      cwd = "/Users/Alexander/intigriti/core/DomainEventRunner/Intigriti.DomainEvent.Runner",
    }
  end,
}
