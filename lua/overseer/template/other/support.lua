return {
  name = "Run Support",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "Support.API",
      cwd = "/Users/Alexander/intigriti/support/Intigriti.Support.Api",
    }
  end,
}
