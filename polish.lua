local utils = require "user.utils"

-- Remove whitespace
vim.api.nvim_create_user_command('WhiteSpaceClean', '%s/\\s\\+$//e|nohlsearch', {})
-- Edit snippets
vim.api.nvim_create_user_command("LuaSnipEdit", function()
  require('luasnip.loaders').edit_snippet_files({})
end, { bang = true, desc = "Edit snippets" })
-- Open snippets list
vim.api.nvim_create_user_command("LuaSnipInfo", function()
  require("luasnip.extras.snippet_list").open()
end, { bang = true, desc = "Open snippets list" })
-- Execute python files
vim.api.nvim_create_user_command("ExecutePy", function()
  local filename = vim.fn.expand "%:t"
  if vim.bo.filetype == "python" then
    vim.cmd "silent! write"
    utils.async_run({ "python3", vim.fn.expand "%:p" }, {
      title = "Execute " .. filename
    })
  else
    vim.notify("Cannot execute " .. filename, 3, { title = "Warning" } )
    return nil
  end
end,{ bang = true, desc = "Execute python file" })
-- Copy content from unnamed register " to clipboard
vim.api.nvim_create_user_command("CopyToClipboard", function()
  -- Get the contents of the " register
  local register_content = vim.fn.getreg('"')

  -- Escape special characters in the register content
  local escaped_content = vim.fn.shellescape(register_content)

  -- Construct the command to copy to clipboard using clip.exe
  local command = string.format('echo %s | clip.exe', escaped_content)

  -- Execute the command
  local success = os.execute(command)

  if not success then
    print('Error: Unable to copy to clipboard.')
  end
end, { bang = true, desc = "Copy content to clipboard" })
-- create an augroup to easily manage autocommands
-- vim.api.nvim_create_augroup("autohidetabline", { clear = true })
-- create a new autocmd on the "User" event
-- vim.api.nvim_create_autocmd("User", {
--   desc = "Hide tabline when only one buffer and one tab", -- nice description
--   -- triggered when vim.t.bufs is updated
--   pattern = "AstroBufsUpdated", -- the pattern si the name of our User autocommand events
--   group = "autohidetabline", -- add the autocmd to the newly created augroup
--   callback = function()
--     -- if there is more than one buffer in the tab, show the tabline
--     -- if there are 0 or 1 buffers in the tab, only show the tabline if there is more than one vim tab
--     local new_showtabline = #vim.t.bufs > 1 and 2 or 1
--     -- check if the new value is the same as the current value
--     if new_showtabline ~= vim.opt.showtabline:get() then
--       -- if it is different, then set the new `showtabline` value
--       vim.opt.showtabline = new_showtabline
--     end
--   end,
-- })
