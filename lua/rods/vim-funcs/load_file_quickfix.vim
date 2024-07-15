" https://www.reddit.com/r/vim/comments/9iwr41/store_quickfix_list_as_a_file_and_load_it
" if exists('g:loaded_hqf')
"     finish
" endif
" let g:loaded_hqf = 1

" function! s:load_file(type, bang, file) abort
"     let l:efm = &l:efm
"     let &l:errorformat = "%-G%f:%l: All of '%#%.depend'%.%#,%f%.%l col %c%. %m"
"     let l:cmd = a:bang ? 'getfile' : 'file'
"     exec a:type.l:cmd.' '.a:file
"     let &l:efm = l:efm
" endfunction

" command! -complete=file -nargs=1 -bang Csavef call <SID>load_file('c', <bang>0, <f-args>)
" command! -complete=file -nargs=1 -bang Cloadf call <SID>load_file('l', <bang>0, <f-args>)

" https://www.reddit.com/r/vim/comments/9iwr41/comment/e6n0qmi
function! s:qf_to_filename(qf) abort
  for i in range(len(a:qf.items))
    let d = a:qf.items[i]
    if bufexists(d.bufnr)
      let d.filename = fnamemodify(bufname(d.bufnr), ':p')
    endif
    silent! call remove(d, 'bufnr')
    let a:qf.items[i] = d
  endfor
  return a:qf
endfunction
command! -bar -nargs=1 -complete=file QFWrite call writefile([json_encode(s:qf_to_filename(getqflist({'all': 1})))], <f-args>)
command! -bar -nargs=1 -complete=file QFLoad call setqflist([], ' ', json_decode(get(readfile(<f-args>), 0, '')))

" https://stackoverflow.com/a/28617831/6785523
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END
