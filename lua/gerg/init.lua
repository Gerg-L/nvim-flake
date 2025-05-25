AddKeyOpts = function(keys, opts)
  return vim.tbl_map(function(key)
    if type(key[#key]) == "table" then
      key[#key] = vim.tbl_deep_extend("keep", key[#key], opts)
    end
    return key
  end, keys)
end

require("gerg.misc")
