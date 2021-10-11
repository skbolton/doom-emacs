(use-package! nano-theme
  :config
  (nano-mode)
  (load-theme 'nano-light t))

(use-package! nano-modeline
  :config
  (nano-modeline-mode))

(setq display-line-numbers-type nil)

(setq org-directory "~/Documents/org/")

(after! org
  (setq org-agenda-files '("~/Documents/org")))

(use-package! org-superstar
  :custom
  (org-superstar-headline-bullets-list '("●" "◎" "○")))

(use-package! org-roam
  :custom
  (org-roam-directory "~/Documents/org/Spells"))

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t)
    (setq org-roam-ui-follow t)
    (setq org-roam-ui-update-on-save t)
    (setq org-roam-ui-open-on-start t)
    (setq org-roam-ui-custom-theme
        '((bg . "#1C1E31")
        (bg-alt . "#100E23")
        (fg . "#CBE3E7")
        (fg-alt . "#8A889D")
        (red . "#F48FB1")
        (orange . "#F2B482")
        (yellow . "#FFE6B3")
        (green . "#A1EFD3")
        (cyan . "#63F2F1")
        (blue . "#91ddff")
        (violet . "#D4BFFF")
        (magenta . "#F02E6E"))))

(setq user-full-name "Stephen Bolton"
      user-mail-address "stephen@bitsonthemind.com")

(use-package! mu4e
  :config
  (setq mu4e-change-filenames-when-moving t)
  ;; Refresh mail every 10 mins
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -c ~/.config/mbsync/.mbsyncrc -a")
  (setq mu4e-root-maildir "~/Mail")
  (setq mu4e-contexts
   (list
    ;; Genesis Block
    (make-mu4e-context
     :name "Genesis Block"
     :match-func
       (lambda (msg)
         (when msg
           (string-prefix-p "/GB" (mu4e-message-field msg :maildir))))
       :vars '((user-mail-address . "stephen@genesisblock.com")
               (user-full-name . "Stephen Bolton")
               (mu4e-drafts-folder . "/GB/Drafts")
               (mu4e-sent-folder . "/GB/Sent")
               (mu4e-refile-folder . "/GB/Archive")
               (mu4e-trash-folder . "/GB/Trash")))
    ;; BOTM
    (make-mu4e-context
     :name "BOTM"
     :match-func
       (lambda (msg)
         (when msg
           (string-prefix-p "/BOTM" (mu4e-message-field msg :maildir))))
       :vars '((user-mail-address . "stephen@bitsonthemind.com")
               (user-full-name . "Stephen Bolton")
               (mu4e-drafts-folder . "/BOTM/Drafts")
               (mu4e-sent-folder . "/BOTM/Sent")
               (mu4e-refile-folder . "/BOTM/Archive"))))))
