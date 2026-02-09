# roblox-server-core
Server-side framework for Roblox experiences — handles data saving, developer product safety, and compliance with Roblox publishing requirements.


/ReplicatedStorage
    ├── Request50Gems (RemoteEvent)      # Handles purchase request for 50 Gems
    ├── Request1000Candy (RemoteEvent)   # Handles purchase request for 1000 Candy
    ├── UpdateCandy (RemoteEvent)        # Syncs Candy values with clients
    └── UpdateGems (RemoteEvent)         # Syncs Gem values with clients

/ServerScriptService
    ├── Data
    │   ├── DataInit.lua                 # Initializes player data on join
    │   ├── DataManager.lua              # Core data persistence logic
    │   ├── ProductManager.lua           # Handles developer product purchases
    │   │   └── Products.lua             # Defines product configurations
    │   └── Template.lua                 # Default data template
    │
    └── Libraries
        └── ProfileStore.lua             # External library for robust DataStore handling

/StarterGui
    └── ShopGUI
        └── PurchaseHandler.lua          # Client-side purchase requests
