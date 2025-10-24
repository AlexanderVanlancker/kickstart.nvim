return {
  name = "Run StatsSyncer",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "StatsSyncer",
      cwd = "/Users/Alexander/intigriti/core/StatsSyncer/Intigriti.StatsSyncer",
    }
  end,
}
