return {
  name = "Run Web Support",
  builder = function(params)
    return {
      cmd = { "npm" },
      args = { "run", "start:support" },
      name = "Web Support",
      cwd = "/Users/Alexander/intigriti/web/client-apps",
    }
  end,
}
