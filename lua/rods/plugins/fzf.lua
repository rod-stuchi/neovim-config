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

        " let $BAT_STYLE = 'header-filename,numbers,grid'

        " -change for Files
        command! -bang -nargs=? -complete=dir Files
          \ call fzf#vim#files(<q-args>,
          \ fzf#vim#with_preview({'options': [
          \   '--info=inline',
          \   '--bind=ctrl-d:preview-page-down,ctrl-u:preview-page-up',
          \   '--bind=alt-j:preview-down,alt-k:preview-up',
          \   '--bind=tab:toggle-out,shift-tab:toggle-in',
          \   '--bind=ctrl-n:half-page-down,ctrl-p:half-page-up',
          \   '--header=List: ctrl-(x|v|t)=split/vsplit/tab ctrl-(n|p)=half-page-down/up, Preview: ctrl-(d|u)=page-down/up alt-(j|u)=down/up',
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


        " -custom ripgrep command
        function! RipgrepFzf(query, fullscreen, rgword)
          let c = 'rg --column --line-number --no-heading --color=always --smart-case ' . a:rgword . ' -- %s || true'
          let cmd = printf(c, shellescape(a:query))
          let reload_cmd = printf(c, '{q}')
          let opt = [
            \ '--disabled',
            \ '--bind=ctrl-d:preview-page-down,ctrl-u:preview-page-up',
            \ '--bind=alt-j:preview-down,alt-k:preview-up',
            \ '--bind=tab:toggle-out,shift-tab:toggle-in',
            \ '--bind=ctrl-n:half-page-down,ctrl-p:half-page-up',
            \ '--header=List: ctrl-(x|v|t)=split/vsplit/tab ctrl-(n|p)=half-page-down/up, Preview: ctrl-(d|u)=page-down/up alt-(j|u)=down/up',
            \ '--bind=change:reload:'.reload_cmd,
            \ '--query',
            \ a:query,
          \]
          call fzf#vim#grep(cmd, 1, fzf#vim#with_preview({'options': opt}), a:fullscreen)
        endfunction
        command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0, "")
        command! -nargs=* -bang RGw call RipgrepFzf(<q-args>, <bang>0, "--word-regexp")


        " -custom fd command
        function! FdFzf(fullscreen, fdargs)
          " let cmd = 'fd . -tf --max-depth=1 --color=never'
          let c = 'fd . -tf %s --color=never | rg -v %s | sed "1i 󱇧 %s"'
          let cmd = printf(c, a:fdargs, expand("%:t"), expand("%:t"))
          let opt = [
            \ '--info=inline',
            \ '--bind=ctrl-d:preview-page-down,ctrl-u:preview-page-up',
            \ '--bind=alt-j:preview-down,alt-k:preview-up',
            \ '--bind=tab:toggle-out,shift-tab:toggle-in',
            \ '--bind=ctrl-n:half-page-down,ctrl-p:half-page-up',
            \ '--header=List: ctrl-(x|v|t)=split/vsplit/tab ctrl-(n|p)=half-page-down/up, Preview: ctrl-(d|u)=page-down/up alt-(j|u)=down/up',
            \ '--multi',
            \ '--header-lines=1',
            \ '--no-sort',
            \ printf('--prompt=%s/', expand("%:h")),
            \]


          call fzf#run(fzf#vim#with_preview(fzf#wrap({
            \ 'source': cmd,
            \ 'options': opt,
            \ 'dir': expand('%:h')
            \})), a:fullscreen)
        endfunction
        command! -nargs=* -bang FdOne call FdFzf(<bang>0, "--max-depth=1")
        command! -nargs=* -bang FdAll call FdFzf(<bang>0, "")

        ]])
	end,
}
