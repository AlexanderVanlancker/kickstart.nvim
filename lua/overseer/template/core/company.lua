return {
  name = "Run Company Side",
  builder = function()
    return {
      name = "Company Side",
      strategy = {
        "orchestrator",
        tasks = {
          {
            { "Run Core.API" },
            { "Run Company DataSyncer" },
            { "Run Company Websockets" },
            { "Run StatsSyncer" },
            { "Run IntegrationEventRunner" },
            { "Run DomainEventRunner" },
          },
        },
      },
    }
  end,
}
