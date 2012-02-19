;; -*- coding: utf-8 -*-

;; `load-path' is a list of directories where Emacs Lisp libraries
;; (`.el' and `.elc' files) are installed.
;;
;; `exec-path' is different: it is a list of directories where
;; executable programs are installed.
;;
;; Shouldn't be `exec-path' and `PATH' achieve the same goal under
;; Emacs?
;;
;; No. `exec-path' is used by Emacs to search for programs it runs
;; directly.  But `M-x grep' does not run `grep.exe' directly; it runs
;; the shell passing it a command that invokes `grep'. So it's the
;; shell that needs to find `grep.exe', and it uses PATH, of course,
;; not `exec-path'.
;;
;; So the right thing to do when you install a new program, in order
;; for Emacs to find it, is *both* to update `exec-path' *and* update
;; `PATH'. This is because some Emacs features invoke programs
;; directly, while others do that through the shell or some other
;; intermediary programs.
(defun wttr/prepend-to-exec-path (path)
  "prepand the path to the emacs intenral `exec-path' and \"PATH\" env variable.
Return the updated `exec-path'"
  (setenv "PATH" (concat (expand-file-name path)
                         path-separator
                         (getenv "PATH")))
  (setq exec-path
        (cons (expand-file-name path)
              exec-path)))


;; as the (add-to-list 'load-path ...) will always check if the
;; added path already exists, that's expansive to CPU and not so much neccesary.
(defun wttr/prepend-to-load-path (path)
  "prepand the PATH to the head of the `load-path', return updated load-path."
  (setq load-path (cons path load-path)))


(defun wttr/delete-trailing-whitespace-when-save ()
  (add-hook 'local-write-file-hooks
            (lambda ()
              (save-excursion
                (delete-trailing-whitespace)))))


;; some const variable
(defconst wttr/os:win32p (eq system-type 'windows-nt)
  "if current environment is win32 system")

(defconst wttr/host:MSWSp (string-equal system-name "WINTERTTR-WS")
  "if the currrent host is Microsoft workstation")

(defconst wttr/host:HOMEp (string-equal system-name "WINTERTTR-PC")
  "if the current host is home laptop")

(provide 'wttr-utils)
