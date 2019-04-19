augroup vimwiki
au! BufRead ~/vimwiki/index.wiki !git --work-tree ~/vimwiki/ --git-dir ~/vimwiki/.git pull
au! BufWritePost ~/vimwiki/* !git --work-tree ~/vimwiki/ --git-dir ~/vimwiki/.git add .;git --work-tree ~/vimwiki/ --git-dir ~/vimwiki/.git commit -m "Auto commit + push.";git --work-tree ~/vimwiki/ --git-dir ~/vimwiki/.git push
augroup END
