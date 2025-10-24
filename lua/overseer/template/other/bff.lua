return {
  name = "Run BFF",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "BFF",
      cwd = "/Users/Alexander/intigriti/bff/Intigriti.BFF.Proxy",
    }
  end,
}
