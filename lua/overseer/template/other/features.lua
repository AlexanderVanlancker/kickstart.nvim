return {
  name = "Run Features",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "Features",
      cwd = "/Users/Alexander/intigriti/utils/Features/Intigriti.Features.Api",
    }
  end,
}
