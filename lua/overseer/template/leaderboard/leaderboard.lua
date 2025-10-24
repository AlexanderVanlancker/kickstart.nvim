return {
  name = "Run full leaderboard",
  builder = function()
    return {
      name = "Leaderboard",
      strategy = {
        "orchestrator",
        tasks = {
          {
            { "Run Leaderboard API" },
            { "Run Leaderboard Syncer" },
            { "Run Leaderboard Domain Event Runner" },
          },
        },
      },
    }
  end,
}
