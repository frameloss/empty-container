# empty-container
The smallest possible docker container, before adding files filesystem is only about 345 bytes (yes, bytes.)

Update April 2020: This was _originally_ done to store configs in a container mounted via volumes into another container to help with version-control, when a process had to be running in a container. I think it was originally written around 2014 while Docker was still very young. Since then Docker has added the ability to create shared volumes https://docs.docker.com/storage/volumes/ and a bunch of other storage options, so I'm not sure if this is still relevant but leaving for historical purposes. It may still be useful for cases where something needs to be running for switching namespaces (for example having a static compiled binary nsenter the container's filesystem from the host).


 - add files into ./share/
 - build
 - Profit?

Nothing much to it, uses a single syscall (pause) written in assembly. No memory footprint to speak of.

```
    mov    rax,34 ; pause()
        syscall
```

## Running

From source:

```
git clone https://github.com/frameloss/empty-container
cd empty-container
# cp whatever share/
docker build -t empty-container .
docker run -d --net=none --restart=always --name=storage emtpy-container
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
