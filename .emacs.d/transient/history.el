((magit-am
  ("--3way" "--committer-date-is-author-date"))
 (magit-commit nil
	       ("--allow-empty"))
 (magit-dispatch nil)
 (magit-ediff nil)
 (magit-fetch nil)
 (magit-merge nil
	      ("--strategy=recursive"))
 (magit-merge:--strategy "recursive")
 (magit-patch-apply
  ("--index")
  nil)
 (magit-pull
  ("--force")
  ("--rebase"))
 (magit-push nil)
 (magit-rebase
  ("--rebase-merges=rebase-cousins" "--autostash"))
 (magit-reset nil)
 (transient:magit-rebase:--rebase-merges=))
