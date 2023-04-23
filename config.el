(setq
 doom-theme 'doom-moonlight
 doom-font (font-spec :family "Iosevka SS08" :size 22 :weight 'semi-light)
 doom-variable-pitch-font (font-spec :family "Iosevka aile"))

(setq display-line-numbers-type 'relative)

(evil-define-key 'normal 'global (kbd ";") 'evil-ex)
(evil-define-key 'normal 'global (kbd ":") 'evil-repeat-find-char)

(setq org-directory "~/Documents/Notes/Logbook/")

(advice-add 'org-refile :after 'org-save-all-org-buffers)

(use-package! org-journal
  :config
  (setq org-journal-dir (concat org-directory "Logs")
        org-journal-date-prefix "#+TITLE: "
        org-journal-time-prefix "* "
        org-journal-date-format "%a, %Y-%m-%d"
        org-journal-file-format "%Y-%m-%d.org"))

(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  (unless (eq org-journal-file-type 'daily)
    (org-narrow-to-subtree))
  (goto-char (point-max)))

(setq org-capture-templates '(("j" "Journal entry" plain (function org-journal-find-location)
                               "** %(format-time-string org-journal-time-format)%^{Title}\n%i%?"
                               :jump-to-captured t :immediate-finish t)))

(after! org
  (setq org-agenda-files (directory-files org-directory 'full (rx ".org" eos))
        org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "BLOCKED(b)" "PR(p)" "|" "DONE(d@/!)" "MERGED(m@/!)" "CANCEL(c@/!)"))
        org-tags-column -77
        org-ellipsis " ▼"
        org-archive-location "~/Documents/Notes/Logbook/archive/%s::datetree/"
        org-agenda-start-with-log-mode t
        org-log-done 'time
        org-log-into-drawer t
        org-refile-targets '((nil :maxlevel . 9)
                             (org-agenda-files :maxlevel . 9))
        org-refile-use-outline-path t
        org-outline-path-complete-in-steps nil
        org-refile-allow-creating-parent-nodes t
        org-agenda-custom-commands
        '(("g" "Get Things Done (GTD)"
                ((agenda ""
                        ((org-agenda-skip-function
                        '(org-agenda-skip-entry-if 'deadline))
                        (org-deadline-warning-days 0)))
                (todo "NEXT"
                        ((org-agenda-skip-function
                        '(org-agenda-skip-entry-if 'deadline))
                        (org-agenda-prefix-format "  %i %-12:c [%e] ")
                        (org-agenda-max-entries 5)
                        (org-agenda-overriding-header "\nTasks\n")))
                (agenda nil
                        ((org-agenda-entry-types '(:deadline))
                        (org-agenda-format-date "")
                        (org-deadline-warning-days 7)
                        (org-agenda-skip-function
                        '(org-agenda-skip-entry-if 'notregexp "\\* NEXT"))
                        (org-agenda-overriding-header "\nDeadlines")))
                (tags-todo "inbox"
                        ((org-agenda-prefix-format "  %?-12t% s")
                        (org-agenda-overriding-header "\nInbox\n")))
                (tags "CLOSED>=\"<today>\""
                                ((org-agenda-overriding-header "\nCompleted today\n"))))))
        org-capture-templates '(("j" "Journal entry" plain (function org-journal-find-location)
                               "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?"
                               :jump-to-captured t :immediate-finish t))))

(use-package! org-superstar
  :custom
  (org-superstar-headline-bullets-list '("◉" "○" "✸" "◆" "▶")))

(use-package! org-roam
  :custom
  (org-roam-directory "~/Documents/Notes/Cortex"))

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
