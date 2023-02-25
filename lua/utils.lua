local M = {}

function M.mapping_keys(maps)
  for _, v in pairs(maps) do
    local mode = v.mode or "n"
    vim.keymap.set(mode, v[1], v[2], { desc = v.desc })
  end
end

function M.delete_keys(maps)
  for _, v in pairs(maps) do
    local mode = v.mode or "n"
    vim.keymap.del(mode, v[1])
  end
end

return M
