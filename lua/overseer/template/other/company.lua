return {
  name = "Run Company",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "Company.API",
      cwd = "/Users/Alexander/intigriti/company/Intigriti.Company.Api",
    }
  end,
}
