# imod-container
A container for IMOD (5.1.2 with CUDA 12) 

## How to use 

Please checkout the latest releases at [https://quay.io/repository/rosalindfranklininstitute/imod-container](https://quay.io/repository/rosalindfranklininstitute/imod-container):


To use with apptainer please use the following command to launch 3dmod:

```
apptainer exec --nv docker://quay.io/rosalindfranklininstitute/imod-container 3dmod
```

To use with apptainer please use the following command to launch etomo:

```
apptainer exec --nv docker://quay.io/rosalindfranklininstitute/imod-container etomo
```

To use with apptainer please use the following command to launch bash:

```
apptainer exec --nv docker://quay.io/rosalindfranklininstitute/imod-container bash
```

To use with docker please use the following command:

```
docker run quay.io/rosalindfranklininstitute/imod-container
```
