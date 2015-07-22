;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; etags support

;; Etags recompilation on save
(defun string/starts-with (s begins)
      "Return non-nil if string S starts with BEGINS."
      (cond ((>= (length s) (length begins))
             (string-equal (substring s 0 (length begins)) begins))
            (t nil)))

(defun chomp-end (str)
      "Chomp tailing whitespace from STR."
      (replace-regexp-in-string (rx (* (any " \t\n")) eos)
                                ""
                                str))
(defun git-basedir ()
  (let* ((filename (buffer-file-name))
         (cmd (format "echo $(cd $(dirname %s) && git rev-parse --show-toplevel)" filename))
         (output (shell-command-to-string cmd)))
    (if (string/starts-with output "fatal:")
        nil
      (chomp-end output))))

(defun mode->find-args ()
  (cond
   ((string= major-mode "emacs-lisp-mode")
    "-name \"*.el\"")
   ((string= major-mode "python-mode")
    "-name \"*.py\"")
   (t
    ;; "-name \".git\" -prune -o"
    nil
    )))

(defconst global-find-prefix "-name \".#*\" -prune -o -name \".git\" -prune -o -name \"build\" -prune -o ")

(defun refresh-ctags ()
  (let ((base-dir (git-basedir))
        (mode-find-args (mode->find-args)))
    (if (and base-dir mode-find-args)
        (let ((mode-args (concat global-find-prefix mode-find-args)))
          (call-process-shell-command
           (format
            "echo 'Updating tags...' && cd %s && find . %s -print | etags - "
            base-dir
            mode-args)
           nil
           "*Danger Messages*"
           nil))
      nil)))

(add-hook 'before-save-hook 'refresh-ctags)
(setq tags-revert-without-query 1)
;; Usage: M-.

(provide 'etags-danger)
