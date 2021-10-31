(setq
 doom-theme 'doom-city-lights
 doom-font (font-spec :family "Operator Mono Book" :size 16)
 doom-variable-pitch-font (font-spec :family "Roboto Slab"))

(setq display-line-numbers-type nil)

(setq org-directory "~/Documents/Delta/")

(advice-add 'org-refile :after 'org-save-all-org-buffers)

(after! org
  (setq org-agenda-files (mapcar
                          ;; concatenate the path of my org directory to make defining paths easier
                          (lambda (suffix) (concat org-directory suffix ".org"))
                          (list "inbox" "agenda" "sprint" "backlog" "later"))
        org-todo-keywords '((sequence "IDEA(i)" "PROJECT(p)" "TODO(t)" "NEXT(n)" "WAIT(w)" "BLOCKED(b)" "|" "DONE(d@/!)" "CANCEL(c@/!)"))
        org-todo-keyword-faces '(("IDEA" . "#EBBF83") ("PROJECT" . "#70E1E8") ("TODO" . "#EBBF83") ("NEXT" . "#8BD49C") ("BLOCKED" . "#D98E48") ("WAIT" . "#41505E") ("CANCEL" . "#D95468"))
        org-ellipsis " ▼"
        org-agenda-start-with-log-mode t
        org-log-done 'time
        org-log-into-drawer t
        org-refile-targets org-agenda-files
        org-refile-use-outline-path t
        org-outline-path-complete-in-steps nil
        org-refile-allow-creating-parent-nodes t
        org-capture-templates
          `(("i" "Inbox" entry (file "inbox.org")
             ,(concat "* IDEA %?\n" "/Entered on/ %U"))
            ("@" "Inbox [mu4e]" entry (file "inbox.org")
             ,(concat "* TODO Process \"%a\" %?\n" "/Entered on/ %U"))
            ("m" "Meeting" entry (file+headline "agenda.org" "Future")
             ,(concat "* %? :meeting:\n" "<%<%Y-%m-%d %a %H:00>>"))
            ("n" "Note" entry (file "notes.org")
             ,(concat "* Note (%a)\n" "/Entered on/ %U\n" "\n" "%?")))))

(use-package! org-superstar
  :custom
  (org-superstar-headline-bullets-list '("●" "◎" "○")))

(use-package! org-roam
  :custom
  (org-roam-directory (concat org-directory "Spells")))

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

;; (setq user-full-name "Stephen Bolton"
;;       user-mail-address "stephen@bitsonthemind.com")

(auth-source-pass-enable)
(setq auth-sources '(password-store))

(use-package! mu4e
  :config
  ;; (setq message-send-mail-function 'smtpmail-send-it)
  (setq mu4e-change-filenames-when-moving t)
  ;; Refresh mail every 10 mins
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -c ~/.config/mbsync/.mbsyncrc -a")
  (setq mu4e-root-maildir "~/.local/share/Mail")
  (setq mu4e-context-policy 'ask)
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
               (user-full-name "Stephen Bolton")
               (smtpmail-default-smtp-server . "smtp.gmail.com")
               (smtpmail-smtp-user . "stephen@genesisblock.com")
               (smtpmail-smtp-server . "smtp.gmail.com")
               (smtpmail-smtp-service . 465)
               (smtpmail-stream-type . ssl)
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
               (smtpmail-default-smtp-server . "smtp.fastmail.com")
               (smtpmail-smtp-server . "smtp.fastmail.com")
               (smtpmail-smtp-user . "stephen@bitsonthemind.com")
               (smtpmail-smtp-service . 465)
               (smtpmail-stream-type . ssl)
               (mu4e-drafts-folder . "/BOTM/Drafts")
               (mu4e-sent-folder . "/BOTM/Sent")
               (mu4e-trash-folder . "/BOTM/Trash")
               (mu4e-refile-folder . "/BOTM/Archive"))))))
