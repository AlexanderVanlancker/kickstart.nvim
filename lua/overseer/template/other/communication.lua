return {
  name = "Run Communication",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "Communication",
      cwd = "/Users/Alexander/intigriti/utils/Communication/Intigriti.Communication",
    }
  end,
}
