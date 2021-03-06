; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)


;; backup in one place. flat, no tree structure
;; (setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
                                        ; (setq auto-save-file-name-transforms '(("" . "~/.emacs.d/autosave")))
  
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))
(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "autosaves") t)))
(setq auto-save-list-file-prefix
      (concat user-emacs-directory "autosaves"))

(setq-default js-indent-level 2)



; (load-file "~/.emacs.d/yaml-mode.el")
; (require 'yaml-mode)
; (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


(setq-default indent-tabs-mode nil)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; open any file
(define-key global-map (kbd "C-c .") 'find-file-at-point)
(define-key global-map (kbd "C-c o") 'other-window)
(define-key global-map (kbd "C-c /") 'isearch-forward-symbol-at-point)

;; Python Stuff
; (load-file "~/.emacs.d/xclip.el")
(load-file "~/git/blacken/blacken.el")
(add-hook 'python-mode-hook 'blacken-mode)
(add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)                 ; optional
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))



;(load-file "~/.emacs.d/jq-mode.el")
;(autoload 'jq-mode "jq-mode.el"
;    "Major mode for editing jq files" t)
;(add-to-list 'auto-mode-alist '("\\.jq$" . jq-mode))

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (deactivate-mark)  
    (let (beg end)
      (if (region-active-p)
	  (setq beg (region-beginning) end (region-end))
	(setq beg (line-beginning-position) end (line-end-position)))
      (comment-or-uncomment-region beg end))))

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(defun xah-paste-or-paste-previous ()
  "Paste. When called repeatedly, paste previous.
This command calls `yank', and if repeated, call `yank-pop'.

When `universal-argument' is called first with a number arg, paste that many times.

URL `http://ergoemacs.org/emacs/emacs_paste_or_paste_previous.html'
Version 2017-07-25"
  (interactive)
  (progn
    (when (and delete-selection-mode (region-active-p))
      (delete-region (region-beginning) (region-end)))
    (if current-prefix-arg
        (progn
          (dotimes ($i (prefix-numeric-value current-prefix-arg))
            (yank)))
      (if (eq real-last-command this-command)
          (yank-pop 1)
        (yank)))))
;; (defun yank-last (n)
  ;; "Move the current line down by N lines."
  ;; (interactive "P")
  ;; (yank 1))
  ;; (yank-pop 2))

;; (global-set-key (kbd "ESC C-<up>") 'move-line-up)
;; (global-set-key (kbd "ESC C-<down>") 'move-line-down)


(defun up-10 ()
  (interactive)
  forward-line 10
)
  
(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring.
    Ease of use features:
    - Move to start of next line.
    - Appends the copy on sequential calls.
    - Use newline as last char even on the last line of the buffer.
    - If region is active, copy its lines."
  (interactive "p")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (when mark-active
      (if (> (point) (mark))
          (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
        (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
    (if (eq last-command 'copy-line)
        (kill-append (buffer-substring beg end) (< end beg))
      (kill-ring-save beg end)))
  (kill-append "\n" nil)
  (beginning-of-line (or (and arg (1+ arg)) 2))
  (yank)
  (forward-line -1)
  (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
		      default-directory
		    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))


;; optional key binding
;; (global-set-key (kbd "ESC <up>") 'copy-line)


(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-d") 'copy-line)
    (define-key map (kbd "ESC l") (lambda () (interactive) (forward-line -5)) )
    (define-key map (kbd "ESC <up>") (lambda () (interactive) (forward-line -5)) )
    (define-key map (kbd "ESC j") (lambda () (interactive) (forward-line 5)) )
    (define-key map (kbd "ESC <down>") (lambda () (interactive) (forward-line 5)) )
    (define-key map (kbd "C-q") 'comment-or-uncomment-region-or-line)
    (define-key map (kbd "C-l") 'kill-whole-line)
    (define-key map (kbd "C-M-y") `xah-paste-or-paste-previous)
    (define-key map (kbd "C-f") `forward-sexp)
    (define-key map (kbd "C-b") `backward-sexp)
    ;; (define-key map (kbd "C-x C-u") 'undo)
    ;; (define-key map (kbd "C-f") 'copy-file-name-to-clipboard)
    map)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 1)

;(global-set-key (kbd "C-d") 'copy-line)

;(global-set-key (kbd "C-l") 'kill-whole-line)

(define-key global-map "\eO2D" (kbd "S-<left>"))
(define-key global-map "\eO2C" (kbd "S-<right>"))
(define-key global-map "\eO2A" (kbd "S-<up>"))
(define-key global-map "\eO2B" (kbd "S-<down>"))

(define-key global-map "\e[1;10D" (kbd "M-S-<left>"))
(define-key global-map "\e[1;10C" (kbd "M-S-<right>"))
(define-key global-map "\e[1;10A" (kbd "M-S-<up>"))
(define-key global-map "\e[1;10B" (kbd "M-S-<down>"))

(show-paren-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-flake8-maximum-line-length 88)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (gnu-elpa-keyring-update vue-mode py-isort isortify pylint company-tabnine company dockerfile-mode terraform-mode use-package flycheck jedi dumb-jump ##))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-hook 'before-save-hook 'py-isort-before-save)



(use-package company
  :ensure t)
(add-hook 'after-init-hook 'global-company-mode)
(use-package company-tabnine :ensure t)
(add-to-list 'company-backends #'company-tabnine)
;; M-x company-tabnine-install-binary  ;; to install binary
;; Trigger completion immediately.
(setq company-idle-delay 0)
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-complete-selection)))

(defadvice auto-complete-mode (around disable-auto-complete-for-python)
  (unless (eq major-mode 'python-mode) ad-do-it))

(ad-activate 'auto-complete-mode)

(defun vue-mode/init-vue-mode ()
  (use-package vue-mode
               :config
               ;; 0, 1, or 2, representing (respectively) none, low, and high coloring
               (setq mmm-submode-decoration-level 2)))

(add-hook 'mmm-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face nil)))
