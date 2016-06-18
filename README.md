# empty-container
The smallest possible docker container, before adding files filesystem is only about 345 bytes (yes, bytes.)

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

From source:

```
git clone https://github.com/frameloss/empty-container
cd empty-container
# cp whatever share/
docker build -t frameloss/empty-container .
docker run -d --net=none --restart=always --name=storage frameloss/emtpy-container
```

From dockerhub:

```
docker pull frameloss/empty-container
docker run --net=none --restart=always --name=storage -d frameloss/empty-container
```

Use the `--volumes-from=storage` flag to connect it to another container. 

For example:

```
# docker pull frameloss/empty-container
# docker run --net=none --restart=always --name=storage -d frameloss/empty-container
# docker run -ti --rm --volumes-from=storage debian bash
root@8c63ca822900:/# cd /share
root@8c63ca822900:/share# ls -a
.  ..  .empty
root@8c63ca822900:/share# exit
exit
#
```

