return {
  name = "Run Web Company",
  builder = function(params)
    return {
      cmd = { "npm" },
      args = { "run", "start:company" },
      name = "Web Company",
      cwd = "/Users/Alexander/intigriti/web/client-apps",
    }
  end,
}
