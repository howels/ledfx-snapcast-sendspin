export LEDFX_RELEASE=v2.1.2
#podman build -f Dockerfile -t ledfx-snapcast:v2.0.111 --platform linux/amd64 --manifest image-multiarch
podman build -f Dockerfile -t ledfx-snapcast:${LEDFX_RELEASE} --platform linux/arm64 --manifest image-multiarch --build-arg LEDFX_RELEASE=${LEDFX_RELEASE}
podman save localhost/ledfx-snapcast:${LEDFX_RELEASE} --output ./ledfx-snapcast-arm64-${LEDFX_RELEASE}.tar

## To import into RKE2 something like the below:
# sudo /var/lib/rancher/rke2/data/v1.31.6-rke2r1-c71286a0c950/bin/ctr -n k8s.io --address /run/k3s/containerd/containerd.sock images import ledfx-snapcast-arm64-${LEDFX_RELEASE}.tar

## scale down and up:
##  kubectl -n ledfx scale deploy ledfx-snapcast-deployment --replicas=0
##  kubectl -n ledfx scale deploy ledfx-snapcast-deployment --replicas=1
