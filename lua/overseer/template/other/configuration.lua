return {
  name = "Run Configuration",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "Configuration",
      cwd = "/Users/Alexander/intigriti/utils/Configuration/Intigriti.Configuration.Api",
    }
  end,
}
