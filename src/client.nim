import os
import strutils
import posix


type
  PidInfo = object
    pid: Pid
    comm: cstring

proc pid_is_in_procfs(pid: string): bool =
  for kind, path in walkDir("/proc/"):
    if kind == pcDir and path.endsWith(pid):
      return true
  return false


proc find_hidden_proc(proc_info: PidInfo) {.exportc.} =
  if not pid_is_in_procfs($proc_info.pid):
    echo "Hidden pid ", $proc_info.pid, " name: ", proc_info.comm
