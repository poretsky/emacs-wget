;;; wget-custom.el --- Customizable wget options.

;; Copyright (C) 2001, 2002 Masayuki Ataka <masayuki.ataka@gmail.com>

;; Authors: Masayuki Ataka <masayuki.ataka@gmail.com>
;; Keywords: w3m, WWW, hypermedia

;; This file is a part of emacs-wget.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, you can either send email to this
;; program's maintainer or write to: The Free Software Foundation,
;; Inc.; 59 Temple Place, Suite 330; Boston, MA 02111-1307, USA.


;;; Code:

(defgroup wget nil
  "wget program interface."
  :group 'hypermedia
  :prefix "wget-")


;;;; User Options

(defcustom wget-command "wget"
  "*Program name of `wget'."
  :group 'wget
  :type 'string)

(defcustom wget-default-options nil
  ;; '("-nc" "-c")                      ; <- example.
  "*List of default options of wget."
  :group 'wget
  :type '(repeat
	  (restricted-sexp :tag "Option")))

(defcustom wget-web-page-options
  `(,@wget-default-options
    "-r"				;--recursive: Turn on recursive retrieving.
    "-np")				;--no-parent: Do not ever ascend to the parent directory.
  "*List of options to download all Web pages."
  :group 'wget
  :type '(repeat
	  (restricted-sexp :tag "Web page Option")))

(defcustom wget-ftp-default-options nil
  "*List of default options when download from ftp.
If nil, use `wget-default-options' instead."
  :group 'wget
  :type '(repeat
	  (restricted-sexp :tag "FTP Option")))

;; Download dir

(defcustom wget-download-directory
  "~/download"
  "*Default directory name that retrieved files go.
If nil, always ask download directory."
  :group 'wget
  :type '(choice directory (sexp :tag "Lisp object")))

(defcustom wget-download-directory-filter nil
  "*Function that defines the filtering of download directory."
  :group 'wget
  :type '(radio (const :tag "No filter" nil)
		(const :tag "Filter by regexp"
		       wget-download-dir-filter-regexp)
		(const :tag "Aliases"
		       wget-download-dir-filter-alias)
		(const :tag "Filter by regexp and alias"
		       wget-download-dir-filter-regexp-and-alias)
		(const :tag "Check current dir"
		       wget-download-dir-filter-current-dir)
		(function :tag "Other Function")))

;; Download Log

(defcustom wget-download-log-file nil
  "*Default file name for download log.
If emacs-wget find this file in the download directory,
append download log in format `wget-download-log-format'.

If log file is not found, create or ask creating.
See the variable `wget-create-download-log'."
  :group 'wget
  :type 'file)

(defcustom wget-create-download-log 'always
  "*If non-nil, create or ask creating the log file
when the log file is not found in the download directory.

'always  Always create log file
'ask     Ask creating log file
nil      Do not create log file.

The log file name is defined by variable `wget-download-log-file'."
  :group 'wget
  :type '(choice (const always) (const ask) (const nil)))

(defcustom wget-download-log-format
  "%T\t%U\n"
  "*Format string for `wget-download-log-file'.

%T	Time format string replaced by `wget-download-log-time-format'
%t	Title
%U	URI"
  :group 'wget
  :type 'string)

(defcustom wget-download-log-time-format
  "%Y-%m-%d %H:%M:%S"
  "*Time format string for `wget-download-log-file'.
See the function `format-time-string' for format-string."
  :group 'wget
  :type 'string)

(defcustom wget-add-download-log-eof t
  "*If non-nil, download log is added at the end of file,
else it is added at the beginning of file.
Download log is added to the file `wget-download-log-file'
in the format `wget-download-log-format'."
  :group 'wget
  :type 'boolean)

;; misc

(defcustom wget-executable-file-extension-list nil
  ; '("exe" "sh" "csh" "pl" "rb") 	; <- example
  "*List of file extension that change file permission executable after downloading."
  :group 'wget
  :type '(repeat
	  (restricted-sexp :tag "File extension")))

(defcustom wget-truncate-partial-width-windows t
  "*Non-nil means truncate lines in *wget* buffer less than full frame wide."
  :group 'wget
  :type 'boolean)

(defcustom wget-max-window-height (/ (frame-height) 2)
  "*Max height of *wget* buffer."
  :group 'wget
  :type 'integer)

;; Hooks

(defcustom wget-hook nil
  "*Hook run after calling `wget-uri'."
  :group 'wget
  :type 'hook)

(defcustom wget-after-hook nil
  "*Hook run after finishing downloading file."
  :group 'wget
  :type 'hook)

(defcustom wget-load-hook nil
  "*Hook run after loading Emacs-wget."
  :group 'wget
  :type 'hook)

;; debug etc...

(defcustom wget-debug nil
  "*Non nil means save wget log message in buffer `wget-debug-buffer'."
  :group 'wget
  :type 'boolean)


(provide 'wget-custom)
;;; wget-custom.el ends here
