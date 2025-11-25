return {
  name = "Run Researcher Profile",
  builder = function(params)
    return {
      cmd = { "dotnet" },
      args = { "run" },
      name = "Researcher Profile",
      cwd = "/Users/Alexander/intigriti/researcher-profile/Intigriti.ResearcherProfile.API",
    }
  end,
}
