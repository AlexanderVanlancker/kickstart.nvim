return {
  name = "Run Researcher DataSyncer",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "DataSyncer.Researcher",
      cwd = "/Users/Alexander/intigriti/core/DataSyncer.Researcher/Intigriti.DataSyncer.Researcher",
    }
  end,
}
