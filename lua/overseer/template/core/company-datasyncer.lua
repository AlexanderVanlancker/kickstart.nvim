return {
  name = "Run Company DataSyncer",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "DataSyncer.Company",
      cwd = "/Users/Alexander/intigriti/core/DataSyncer.Company/Intigriti.DataSyncer.Company",
    }
  end,
}
