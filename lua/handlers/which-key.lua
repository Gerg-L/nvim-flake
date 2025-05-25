local state = require("lz.n.handler.state").new()

local M = {
  spec_field = "wk",
  add = function(plugin)
    if not plugin.wk then
      return
    end
    state.insert(plugin)
    package.loaded["which-key"].add(plugin.wk)
  end,
  del = state.del,
  lookup = state.lookup_plugin,
}

return M
