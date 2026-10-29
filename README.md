# imod-container

Container images for [IMOD](https://bio3d.colorado.edu/imod/), a set of image processing, modelling and display programs for tomographic reconstruction and 3D reconstruction of microscopy data, including `3dmod` and `etomo`.

- User documentation for container: [rosalindfranklininstitute.github.io/volume-em-container-documentation](https://rosalindfranklininstitute.github.io/volume-em-container-documentation/software/imod/)
- IMOD user manual: [bio3d.colorado.edu/imod/doc/guide.html](https://bio3d.colorado.edu/imod/doc/guide.html)

Images are published at [quay.io/rosalindfranklininstitute/imod-container](https://quay.io/repository/rosalindfranklininstitute/imod-container).

If you notice a problem or have a suggestion for the container builds, please [open an issue](https://github.com/rosalindfranklininstitute/imod-container/issues).

## Tags
Images are tagged according to the IMOD release and CUDA version, e.g., `imod-container:5.1.13-cuda12.0`. Tags with a `-vgl` suffix include VirtualGL, for hardware-accelerated 3D rendering on a remote host (with `vglrun`): 

| Tag | Contents |
| --- | --- |
| `<imod>-cuda<cuda>` | IMOD |
| `<imod>-cuda<cuda>-vgl` | IMOD plus VirtualGL |
| `latest`, `latest-vgl` | The release most recently marked as latest |

## Building a new IMOD version

1. Go to the [IMOD download page](https://bio3d.colorado.edu/imod/download.html) and find the desired RHEL installer. Its filename holds the IMOD plus CUDA version strings, e.g. `imod_5.1.13_RHEL8-64_CUDA12.0.sh` corresponds to IMOD `5.1.13` and CUDA `12.0`.
2. In this repository go to **Actions**, choose **Build IMOD container images and publish to Quay.io**, then **Run workflow**, and enter the IMOD and CUDA versions and the full installer URL (e.g. <https://bio3d.colorado.edu/imod/AMD64-RHEL5/imod_5.1.13_RHEL8-64_CUDA12.0.sh>). Optionally tick **latest** if you want the images to be tagged with `latest` and `latest-vgl`. A VirtualGL version may also be specified.
3. Run the workflow. The IMOD and IMOD plus VirtualGL images will be built and pushed to Quay.io. 

### Other maintainence
Occasionally, action versions in the GitHub workflow may need updating.


## Image verification and metadata

Images are signed in the build workflow using [cosign](https://docs.sigstore.dev/cosign/) keyless signing. To verify the `5.1.13-cuda12.0` tag, for example:
```bash
cosign verify quay.io/rosalindfranklininstitute/imod-container:5.1.13-cuda12.0 \
  --certificate-identity https://github.com/rosalindfranklininstitute/imod-container/.github/workflows/build-publish.yml@refs/heads/main \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com
```
Note a signature shows who built the image, not that the IMOD installer or Ubuntu packages are trustworthy.

Each image also carries build provenance and a software bill of materials (SBOM), which you can be read with:
```
docker buildx imagetools inspect quay.io/rosalindfranklininstitute/imod-container:5.1.13-cuda12.0 --format '{{ json .Provenance }}'
docker buildx imagetools inspect quay.io/rosalindfranklininstitute/imod-container:5.1.13-cuda12.0 --format '{{ json .SBOM }}'
```
