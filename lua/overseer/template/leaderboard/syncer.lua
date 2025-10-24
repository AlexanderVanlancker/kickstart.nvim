return {
  name = "Run Leaderboard Syncer",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "Leaderboard Syncer",
      cwd = "/Users/Alexander/intigriti/leaderboard/Intigriti.Leaderboard.DataSyncer",
    }
  end,
}
