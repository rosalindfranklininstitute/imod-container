# imod-container

A container for IMOD (5.1.2 with CUDA 12) 

## How to use 

Please check out the latest releases at [https://quay.io/repository/rosalindfranklininstitute/imod-container](https://quay.io/repository/rosalindfranklininstitute/imod-container):

Due to background processes, within the graphical user interface (GUI) of some programs, the best way to use IMOD with this container is to use the following command: 

To use with Apptainer, please use the following command:

```
apptainer shell --nv docker://quay.io/rosalindfranklininstitute/imod-container
```

or 

```
apptainer exec --nv docker://quay.io/rosalindfranklininstitute/imod-container bash
```

Once inside the container, the list of IMOD packages available can be found with 

```
ls $IMOD_DIR/bin
```

All of the packages that are shown via `ls $IMOD_DIR/bin` are available from the command line and can be run by typing their name, i.e., `3dmod` will launch 3dmod and `etomo` will launch etomo.

