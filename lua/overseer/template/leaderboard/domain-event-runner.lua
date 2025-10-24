return {
  name = "Run Leaderboard Domain Event Runner",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "Leaderboard.DomainEventRunner",
      cwd = "/Users/Alexander/intigriti/leaderboard/Intigriti.Leaderboard.DomainEvent.Runner",
    }
  end,
}
