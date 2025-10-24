return {
  name = "Run full web",
  builder = function()
    return {
      name = "Web",
      strategy = {
        "orchestrator",
        tasks = {
          {
            { "Run Web Company" },
            { "Run Web Researcher" },
            { "Run Web Support" },
          },
        },
      },
    }
  end,
}
