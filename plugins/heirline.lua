return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"
    opts.statusline[3] = status.component.file_info { filetype = {}, filename = false }
    opts.statusline[1] = status.component.mode { mode_text = { padding = { left = 1, right = 1 } } } -- add the mode text
    opts.statusline[12] = nil -- remove the 2nd mode indicator on the right
    return opts
  end,
}
