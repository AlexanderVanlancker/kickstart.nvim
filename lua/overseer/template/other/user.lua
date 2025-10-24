return {
  name = "Run User",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "User",
      cwd = "/Users/Alexander/intigriti/user/Intigriti.User.API",
    }
  end,
}
