;;; molecule-mode.el --- Molecule major mode

;;  Emacs-Molecule: A Package for Molecule in Emacs.
;;
;;  Copyright (C) 2020 Boyu Yang <yangby@cryptape.com>
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Affero General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Affero General Public License for more details.
;;
;;   You should have received a copy of the GNU Affero General Public License
;;   along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(defvar molecule-mode-indent 4
  "*Indentation offset for Malecule major mode.")

(defvar molecule-mode-syntax-table
  (let ((molecule-syntax-table (make-syntax-table)))
    (modify-syntax-entry ?/ ". 124" molecule-syntax-table)
    (modify-syntax-entry ?* ". 23b" molecule-syntax-table)
    (modify-syntax-entry ?\n ">" molecule-syntax-table)
    (modify-syntax-entry ?< "(>" molecule-syntax-table)
    (modify-syntax-entry ?> ")<" molecule-syntax-table)
    molecule-syntax-table)
  "*Syntax table for Malecule major mode.")

(defvar molecule-font-lock-keywords
  (let* (
         (x-keywords '("import"))
         (x-types '("array" "struct" "vector" "table" "option" "union"))
         (x-constants '("byte"))

         (x-keywords-regexp (regexp-opt x-keywords 'words))
         (x-types-regexp (regexp-opt x-types 'words))
         (x-constants-regexp (regexp-opt x-constants 'words)))

    `(
      (,x-keywords-regexp . font-lock-keyword-face)
      (,x-types-regexp . font-lock-type-face)
      (,x-constants-regexp . font-lock-constant-face)
      )))

;;;###autoload
(define-derived-mode molecule-mode fundamental-mode "Molecule"
  "Major mode for editing Molecule schema files"
  :syntax-table molecule-mode-syntax-table
  (setq-local font-lock-defaults '((molecule-font-lock-keywords)))
  (setq-local indent-line-function 'molecule-indent-line))

(defun molecule-indent-line ()
  "Indent current line of Molecule major mode."
  (interactive)
  (let ((actual-indent 0))
    (save-excursion
      (beginning-of-line)
      (condition-case nil
          (while t
            (backward-up-list 1)
            (when (looking-at "[[{<(]")
              (setq actual-indent (+ actual-indent molecule-mode-indent))))
        (error nil)))
    (save-excursion
      (back-to-indentation)
      (when (and (looking-at "[]}>)]") (>= actual-indent molecule-mode-indent))
        (setq actual-indent (- actual-indent molecule-mode-indent))))
    (indent-line-to actual-indent)))

(provide 'molecule-mode)

;;; molecule-mode.el ends here
