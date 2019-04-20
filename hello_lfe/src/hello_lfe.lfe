(defmodule hello_lfe
  (behaviour application)
  (export all))

(defun start (type, args)
  (io:format '"Starting application...~n")
  (hello-sup:start_link))

(defun stop (state)
  'ok)

