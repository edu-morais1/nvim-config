-- Fix for nvim-dap initialization error with Java extra
-- The Java extra tries to require dap before it's loaded
return {
  "mfussenegger/nvim-dap",
  lazy = true, -- Load lazily
  config = function()
    local dap = require("dap")
    -- Configure Java debugging (from LazyVim java.lua)
    dap.configurations.java = {
      {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote",
        hostName = "127.0.0.1",
        port = 5005,
      },
    }
  end,
}
