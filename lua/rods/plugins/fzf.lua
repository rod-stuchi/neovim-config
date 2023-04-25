return {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    init = function()
        vim.cmd([[
        " - Popup window (center of the screen)
        " let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7 } }
        " - Popup window (anchored to the bottom of the current window)
        let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7, 'relative': v:true, 'yoffset': 1.0 } }

        " [Buffers] Jump to the existing window if possible
        let g:fzf_buffers_jump = 1

        " [Commands] --expect expression for directly executing the command
        let g:fzf_commands_expect = 'alt-enter,ctrl-x'
        let g:fzf_preview_window = ['right:55%:hidden', 'ctrl-/']


        " An action can be a reference to a function that processes selected lines
        function! s:build_quickfix_list(lines)
          call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
          copen
          cc
        endfunction

        let g:fzf_action = {
          \ 'ctrl-q': function('s:build_quickfix_list'),
          \ 'ctrl-t': 'tab split',
          \ 'ctrl-x': 'split',
          \ 'ctrl-v': 'vsplit' }


        " -change for Files
        command! -bang -nargs=? -complete=dir Files
          \ call fzf#vim#files(<q-args>,
          \ fzf#vim#with_preview({'options': [
          \   '--info=inline',
          \   '--bind=ctrl-d:preview-page-down,ctrl-u:preview-page-up',
          \   '--bind=alt-j:preview-down,alt-k:preview-up',
          \   '--bind=tab:toggle-out,shift-tab:toggle-in',
          \   '--header=Preview:: ctrl+(d|u): page-down|up; alt+(j|u): down|up',
          \ ]})
          \, <bang>0)


        " -maps for commands and path completion
        nmap <leader><tab> <plug>(fzf-maps-n)
        xmap <leader><tab> <plug>(fzf-maps-x)
        omap <leader><tab> <plug>(fzf-maps-o)


        " -relative "../.." path completation
        inoremap <expr> <c-x><c-r> fzf#vim#complete("fd <Bar> xargs realpath --relative-to " . expand("%:h"))


        " -default path completation
        inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')


        " complete lines in all project
        inoremap <expr> <c-x><c-k> fzf#vim#complete(fzf#wrap({
          \ 'prefix': '^.*$',
          \ 'source': 'rg -n ^ --color always',
          \ 'options': '--ansi --delimiter : --nth 3..',
          \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))


        " -custom RG command
        function! RipgrepFzf(query, fullscreen)
          let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
          let initial_command = printf(command_fmt, shellescape(a:query))
          let reload_command = printf(command_fmt, '{q}')
          let spec = {'options': ['--disabled', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
          let spec = fzf#vim#with_preview(spec, 'right', 'ctrl-/')
          call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
        endfunction
        command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)


        " -not been used
        function! s:fzf_neighbouring_files()
          let current_file =expand("%")
          let cwd = fnamemodify(current_file, ':p:h')
          " let command = 'rg --column --line-number --no-heading --color=always --max-depth 0 --smart-case %s --full-path ' . cwd
          let command = 'rg --files --no-follow  ' . cwd . ''

          call fzf#run({
                \ 'source': command,
                \ 'sink':   'e',
                \ 'options': '-m -x +s',
                \ 'window':  'enew' })
        endfunction
        command! FZFNeigh call s:fzf_neighbouring_files()

        ]])
    end,
}
