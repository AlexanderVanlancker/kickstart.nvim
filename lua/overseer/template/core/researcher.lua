return {
  name = "Run Researcher Side",
  builder = function()
    return {
      name = "Researcher Side",
      strategy = {
        "orchestrator",
        tasks = {
          {
            { "Run Core.API" },
            { "Run Researcher DataSyncer" },
            { "Run Researcher Websockets" },
            { "Run StatsSyncer" },
            { "Run IntegrationEventRunner" },
            { "Run DomainEventRunner" },
          },
        },
      },
    }
  end,
}
