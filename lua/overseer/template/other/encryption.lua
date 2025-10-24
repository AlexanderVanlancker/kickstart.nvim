return {
  name = "Run Encryption",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "Encryption",
      cwd = "/Users/Alexander/intigriti/utils/Encryption/Intigriti.Encryption",
    }
  end,
}
