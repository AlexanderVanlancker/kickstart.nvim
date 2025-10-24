return {
  name = "Run Web Researcher",
  builder = function(params)
    return {
      cmd = { "npm" },
      args = { "run", "start:researcher" },
      name = "Web Researcher",
      cwd = "/Users/Alexander/intigriti/web/client-apps",
    }
  end,
}
