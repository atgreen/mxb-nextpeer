;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: MXB-NEXTPEER; Base: 10 -*-

;;; Copyright (C) 2017  Anthony Green <green@moxielogic.com>

;;; mxb-nextpeer is free software; you can redistribute it and/or
;;; modify it under the terms of the GNU Affero General Public License
;;; as published by the Free Software Foundation; either version 3, or
;;; (at your option) any later version.
;;;
;;; mxb-nextpeer is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; Affero General Public License for more details.
;;;
;;; You should have received a copy of the GNU Affero General Public
;;; License along with mxb-nextpeer; see the file LICENSE.  If not see
;;; <http://www.gnu.org/licenses/>.

;;;; package.lisp

(asdf:defsystem #:mxb-nextpeer
  :description "a bitcoin node IP plant"
  :author "Anthony Green <green@moxielogic.com>"
           :version "0"
  :serial t
  :components ((:file "package")
	       (:file "mxb-nextpeer"))
  :depends-on (:hunchentoot :drakma :babel :cl-json))


