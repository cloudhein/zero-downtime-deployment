terraform { 
  cloud { 
    
    organization = "github-action-org" 

    workspaces { 
      name = "zero-downtime-workspace" 
    } 
  } 
}