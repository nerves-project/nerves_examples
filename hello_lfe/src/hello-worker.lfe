(defmodule hello-worker
  (behaviour gen_server)
  (export (start_link 0) (init 1) (handle_info 2) (terminate 2) (code_change 3)))

(defun start_link ()
  (gen_server:start_link (tuple 'local 'hello-worker) 'hello-worker (list) (list)))

(defun init (args)
  (hello_me)
  (tuple 'ok 'nostate))

(defun handle_info (info state)
  (hello_me)
  (tuple 'noreply state))

(defun terminate (reason state)
  'ok)

(defun code_change (old-vers state extra)
  (tuple 'ok state))

(defun hello_me ()
  (io:format '"Hello!~n")
  (erlang:send_after 5000 (erlang:self) 'hello))
