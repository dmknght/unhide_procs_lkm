# unhide_procs_lkm
Unhide procs lkm is a tool to detect hidden processes on Linux system. Unlike the other tools that brute force pid numbers (from 1 to 4194304), this tool gets the actual pids of running processes in the system, and them check if they are being hidden in procfs. This tool has some advantages:
- Super fast. Worst case is `n * n` times of check loop, n is the number of running processes on the system. Worst case of normal brute force tools is `4194304 * n`. 
- More accurate: The normal brute force tools check if dir exists in procfs but not showing in walkDir. This method is easy to be compromised since rootkits can update the hooks to gives false information when it hides processes.

**Please note that there's a small chance that a running proccess stops when the tool runs thereforce false positives could happen. However, the tool is very fast so it's very hard to happen. Also this tool can be improved to send the detected hidden pids to the kernel and then check if it's still running, and get the actual information of pids from kernel**

Disadvantages:
- It's a LKM tool. User must compile on the machine then use `insmod`. It could have kernel compatible problem.
- This tool is a quick-made tool. It could lack of some features or have some bugs
- The tool was written in C and Nim. The Nim code was used for easier-to-maintain and less-pain-in-the-arse-when-code. However, Nim's garbage collector causes crashes when it's used as the backend code and combine with C (and Vala). I used `gc:none` to disable the garbage colletor. However, I'm not 100% sure it won't crash on the other machines.

# How to build
1. `git clone https://github.com/dmknght/unhide_procs_lkm`
2. `cd unhide_procs_lkm/src/`
3. `make`

# How to install
1. Add kernel module `sudo insmod unhide_proc.ko`
2. Run the client `./client`


This project was tested on Linux kernel 5.18 against Diamorphine rootkit.
