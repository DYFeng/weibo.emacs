;; Copyright (C) 2011 Austin<austiny.cn@gmail.com>
          
;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(defconst weibo-post-buffer-name "*weibo-update*")
(defconst weibo-post-mode-name "发表微博")

(define-derived-mode weibo-post-mode fundamental-mode weibo-post-mode-name
  "Major mode for posting weibo message"
  (local-set-key "\C-c\C-c" 'weibo-send-post)
  (local-set-key "\C-c\C-d" 'weibo-discard-post))

(defvar weibo-post-data nil)
(defvar weibo-post-send-func nil)

(defun weibo-create-post (initial-text mode-text
				       post-send-func
				       &rest data)
  (interactive)
  (select-window (split-window-vertically -8))
  (switch-to-buffer (generate-new-buffer weibo-post-buffer-name))
  (weibo-post-mode)
  (set (make-local-variable 'weibo-post-send-func) post-send-func)
  (set (make-local-variable 'weibo-post-data) data)
  (when mode-text (setq mode-name mode-text))
  (insert (concat initial-text))
  (goto-char (point-min)))

(defun weibo-discard-post ()
  (interactive)
  (kill-buffer)
  (delete-window))

(defun weibo-send-post ()
  (interactive)
  (apply weibo-post-send-func (cons (buffer-string) weibo-post-data)))

(provide 'weibo-post)