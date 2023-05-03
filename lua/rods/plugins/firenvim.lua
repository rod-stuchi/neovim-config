return {
    "glacambre/firenvim",
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    build = function()
        require("lazy").load({ plugins = "firenvim", wait = true })
        vim.fn["firenvim#install"](0)
    end,

    config = function()
        vim.cmd([[
          function! OnUIEnter(event) abort
            if 'Firenvim' ==# get(get(nvim_get_chan_info(a:event.chan), 'client', {}), 'name', '')
              set laststatus=0
              set spell spelllang=en_us,pt
              " set lines=15
              " set columns=300
              autocmd BufRead,BufNewFile * start
            endif
          endfunction
          autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
        ]])
    end,
}
