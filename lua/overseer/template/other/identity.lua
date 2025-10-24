return {
  name = "Run Identity",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "Identity",
      cwd = "/Users/Alexander/intigriti/identity/Intigriti.Identity.Application",
    }
  end,
}
