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

;; Top level for mxb-nextpeer

(in-package :mxb-nextpeer)

;; Our DNS seed provider
(defvar *dns-seed-provider* "dnsseed.bluematt.me")

;; A random string generator.  We use this to add random padding to
;; our DNS API call in order to avoid possible side channel attacks on
;; the DNS requests.  For details, see
;; https://developers.google.com/speed/public-dns/docs/dns-over-https

(defun random-string (length)
  (let ((chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
        (my-string (make-string length)))
    (dotimes (i length)
      (setf (aref my-string i) (aref chars (random (length chars)))))
    my-string))

;; Our server....

(defvar *hunchentoot-server* nil)

(hunchentoot:define-easy-handler (get-nextpeer :uri "/") ()
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "~A"
	  (cdr
	   (assoc :DATA
		  (cadr
		   (assoc :*ANSWER
			  (json:decode-json-from-string
			   (babel:octets-to-string
			    (drakma:http-request
			     (format nil
				     "https://dns.google.com/resolve?cd=0&name=~A&edns_client_subnet=0.0.0.0/0&random_padding=~A"
				     *dns-seed-provider*
				     (random-string (random 1024))))
			    :encoding :utf-8))))))))

;; Start the web app.

(defun start-mxb-nextpeer (&rest interactive)
  "Start the web application and have the main thread sleep forever,
  unless INTERACTIVE is non-nil."
  (setq *hunchentoot-server* (hunchentoot:start 
			      (make-instance 'hunchentoot:easy-acceptor
					     :port 8080)))
  (loop
     (sleep 4000)))

(defun stop-mxb-nextpeer ()
  "Stop the web application."
  (hunchentoot:stop *hunchentoot-server*))
