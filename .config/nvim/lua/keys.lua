--========================================
--                Remaps
--========================================

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

vim.keymap.set('n', ';', '$')

-- map Ctrl+b to call BC() which pipes the current line or selection to BC
vim.keymap.set('v', '+', ':BC<CR>', { remap=false })
vim.keymap.set('n', '+', '<S-V>:BC<CR>', { remap=false })

-- TODO: Need to fix this mapping; doesn't currently work
-- map control-backspace to delete the previous word
vim.keymap.set('!', '<C-BS>', '<C-w>', { remap=false })
vim.keymap.set('!', '<C-h>', '<C-w>', { remap=false })

-- Search for visually selected text
vim.keymap.set('v', '//', 'y/<C-r>"<CR>', { remap=false })

--========================================
--                Leader Maps
--========================================

-- Open init.lua
vim.keymap.set('n', '<Leader>v', ':e $MYVIMRC<CR>', { remap=false })
vim.keymap.set('n', '<Leader>j', ':lua vim.diagnostic.open_float()<CR>', { remap=false })

-- Telescope mappings
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { remap=false })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { remap=false })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { remap=false })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { remap=false })

-- Telescope colorschemes
vim.keymap.set('n', '<Leader>pp', ":lua require'telescope.builtin'.colorscheme{}<cr>", { remap=false })

-- Vimspector
vim.cmd([[
nmap <F9> <cmd>call vimspector#Launch()<cr>
nmap <F5> <cmd>call vimspector#StepOver()<cr>
nmap <F8> <cmd>call vimspector#Reset()<cr>
nmap <F11> <cmd>call vimspector#StepOver()<cr>")
nmap <F12> <cmd>call vimspector#StepOut()<cr>")
nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]])
vim.keymap.set('n', "Db", ":call vimspector#ToggleBreakpoint()<cr>")
vim.keymap.set('n', "Dw", ":call vimspector#AddWatch()<cr>")
vim.keymap.set('n', "De", ":call vimspector#Evaluate()<cr>")
