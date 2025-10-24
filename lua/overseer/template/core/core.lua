return {
  name = "Run full Core",
  builder = function()
    return {
      name = "Core",
      strategy = {
        "orchestrator",
        tasks = {
          {
            { "Run Core.API" },
            { "Run Company Websockets" },
            { "Run Company DataSyncer" },
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
