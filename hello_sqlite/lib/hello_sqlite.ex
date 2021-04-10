defmodule HelloSqlite do
  def save_scheduler_usage do
    HelloSqlite.SchedulerUsagePoller.save_usage()
  end
end
