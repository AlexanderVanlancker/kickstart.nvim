return {
  name = "Run all others",
  builder = function()
    return {
      name = "Others",
      strategy = {
        "orchestrator",
        tasks = {
          {
            { "Run BFF" },
            { "Run Configuration" },
            { "Run Communication" },
            { "Run Company" },
            { "Run Encryption" },
            { "Run Features" },
            { "Run Files" },
            { "Run Identity" },
            { "Run Support" },
            { "Run User" },
            { "Run Researcher Profile" },
            { "Run Leaderboard API" },
          },
        },
      },
    }
  end,
}
