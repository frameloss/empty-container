# empty-container
The smallest possible docker container.

This was done to store configs in a container mounted via volumes into another container to help with version-control. A process *has* to run in a container, this satisfies that in the most minimal way ... the running process only consumes about 1k, but the container itself will use a few KB of memory.

 - add files into ./share/
 - build
 - Profit?

Nothing much to it, uses a single syscall (pause) written in assembly. No memory footprint to speak of.

```
    mov    rax,34 ; pause()
        syscall
```

Running
======
```
git clone https://github.com/frameloss/empty-container
cd empty-container
# cp whatever share/
docker build -t frameloss/empty-container .
docker run -d --net=none --restart=always --name=storage frameloss/emtpy-container
```

The use the `--volumes-from` flag to connect it to another container.

