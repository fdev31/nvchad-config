local mapKey = vim.keymap.set

-- neovide {{{
if vim.g.neovide then
  mapKey("!", "<S-Insert>", "<C-R>+") -- allow Shit+Insert on the prompt

  vim.g.neovide_transparency = 0.95
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_scale_factor = 0.8
  -- Dynamic Scale
  local _scaleChange = function (fac)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * fac
  end
  mapKey("n", "<C-=>", '', {silent = true, callback=function() _scaleChange(1.2) end})
  mapKey("n", "<C-->", '', {silent = true, callback=function() _scaleChange(1/1.2) end})
else
 vim.api.nvim_set_hl(0, 'Normal', {ctermbg=nil, bg=nil, guibg=nil })
end
-- }}}
local autocmd = vim.api.nvim_create_autocmd

vim.g.vscode_snippets_path = "~/.config/Code/User/snippets/"

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
-- File types {{{
local function set_spell()
  vim.opt_local.spell = true
  vim.opt_local.spelllang = 'en_us'
end

autocmd({'BufNewFile','BufRead'}, {
    pattern = '*.rst',
    callback = set_spell,
  })

autocmd({'BufNewFile','BufRead'}, {
    pattern='*.wiki',
    callback = function()
      set_spell()
      vim.bo.filetype = 'confluencewiki'
      vim.bo.makeprg = 'br updes %'
    end,
  })
-- }}}

vim.g.codeium_manual = true
vim.g.mapleader = "²"

vim.cmd.command 'SynID  echo synIDattr(synID(line("."), col("."), 1), "name")'

vim.opt.fdm="marker"
vim.opt.guifont="Fira Code,Noto Color Emoji:h10:#e-subpixelantialias"
vim.opt.sw=4
vim.opt.ts=4
