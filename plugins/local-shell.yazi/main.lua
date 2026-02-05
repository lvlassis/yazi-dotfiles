function debug(text)
  ya.notify {
    -- Title.
    title = "Debug",
    -- Content.
    content = text,
    -- Timeout.
    timeout = 1.5,
  }
end

local function prompt()
  local value, event = ya.input {
    title = "Local Shell:",
    pos = { "top-center", y=3, w=40 }
  }
  if event == 1 then
    return value
  end
  return nil
end

local function entry(self)
  local cmd_path = os.getenv("YAZI_POST_CMDS")
  local cmd_file = io.open(cmd_path, "w")

  local value = prompt()
  if not value then
    cmd_file:close()
    return
  end

  cmd_file:write(value)
  cmd_file:write("\ny")
  cmd_file:close()

  ya.emit("quit", {})

  debug("Runned")
end

return {
    entry = entry,
}
