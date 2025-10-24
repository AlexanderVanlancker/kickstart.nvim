return {
  name = "Run Files",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "Files",
      cwd = "/Users/Alexander/intigriti/utils/Files/Intigriti.Files.Api",
    }
  end,
}
