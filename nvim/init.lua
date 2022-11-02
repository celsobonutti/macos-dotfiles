vim.g.mapleader = " "
vim.api.nvim_set_option('softtabstop', 0)
vim.api.nvim_set_option('smarttab', true)
vim.api.nvim_set_option('autoindent', true)
vim.api.nvim_set_option('number', true)
vim.api.nvim_set_option('relativenumber', true)
vim.api.nvim_set_option('tabstop', 8)
vim.api.nvim_set_option('expandtab', true)
vim.api.nvim_set_option('shiftwidth', 2)
vim.api.nvim_set_option('ignorecase', true)
vim.api.nvim_set_option('smartcase', true)

vim.api.nvim_set_keymap('', 'q', 'b', { noremap = true, silent = true} )
vim.api.nvim_set_keymap('', 'Q', 'B', { noremap = true, silent = true})
vim.api.nvim_set_keymap('', 'J', '10j', { noremap = true, silent = true})
vim.api.nvim_set_keymap('', 'K', '10k', { noremap = true, silent = true})
vim.api.nvim_set_keymap('', 'L', 'g_', { noremap = true, silent = true})
vim.api.nvim_set_keymap('', 'H', '^', { noremap = true, silent = true})
vim.api.nvim_set_keymap('', '<leader>wl', '<C-W>l', { noremap = true, silent = true})
vim.api.nvim_set_keymap('', '<leader>wh', '<C-W>h', { noremap = true, silent = true})
vim.api.nvim_set_keymap('', '<leader>wk', '<C-W>k', { noremap = true, silent = true})
vim.api.nvim_set_keymap('', '<leader>wj', '<C-W>j', { noremap = true, silent = true})
vim.api.nvim_set_keymap('', '<leader>ws', ':split<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('', '<leader>wv', ':vsplit<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('', '<leader>wq', ':q<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('', '<leader>hrr', ':so ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true})

function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

