import gleam/erlang/process
import gleam/io
import gleam/otp/actor
import gleam/otp/static_supervisor
import gleam/otp/supervision

const interval_milliseconds = 5000

pub fn greeting() -> String {
  "Hello from Gleam!"
}

fn start_worker() -> Result(actor.Started(Nil), actor.StartError) {
  let init = fn(subject) {
    let selector = process.new_selector() |> process.select(subject)
    process.send(subject, Nil)

    actor.initialised(subject)
    |> actor.selecting(selector)
    |> Ok
  }

  let handle_message = fn(subject, _message) {
    io.println(greeting())
    process.send_after(subject, interval_milliseconds, Nil)
    actor.continue(subject)
  }

  actor.new_with_initialiser(50, init)
  |> actor.on_message(handle_message)
  |> actor.start
}

pub fn start(_type, _args) -> Result(process.Pid, actor.StartError) {
  let worker = supervision.worker(start_worker)

  case
    static_supervisor.new(static_supervisor.OneForOne)
    |> static_supervisor.add(worker)
    |> static_supervisor.start
  {
    Ok(supervisor) -> Ok(supervisor.pid)
    Error(error) -> Error(error)
  }
}
