local directionsMap = {
  vertical = "vsplit",
  horizontal = "split",
}
local buffers = {}

return function(cmd, cfg)
  if cfg.direction == "float" then
    local bufnr = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_open_win(bufnr, true, {
      row = math.ceil(vim.o.lines - cfg.height) / 2 - 1,
      col = math.ceil(vim.o.columns - cfg.width) / 2 - 1,
      relative = "editor",
      width = cfg.width,
      height = cfg.height,
      style = "minimal",
      border = "single",
    })
    return vim.cmd("term " .. cmd)
  end
  local split = directionsMap[cfg.direction]
  if cfg.direction == "vertical" and cfg.width then
    split = cfg.width .. split
  end
  if cfg.direction == "horizontal" and cfg.height then
    split = cfg.height .. split
  end
  if cfg.keep_one then
    for pos, bufnr in ipairs(buffers) do
      if vim.fn.bufexists(bufnr) > 0 then
        vim.api.nvim_buf_delete(bufnr, { force = true })
        table.remove(buffers, pos)
      end
    end
  end
  vim.cmd("botright " .. split .. " | term " .. cmd)
  table.insert(buffers, vim.api.nvim_get_current_buf())
  if cfg.stopinsert or cfg.go_back then
    vim.cmd "stopinsert!"
    vim.cmd "normal! G"
  end
  if cfg.go_back then
    vim.cmd "wincmd p"
  end
end
