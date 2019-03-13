CUDA_VERSION=`grep ARG Dockerfile | grep CUDA_VERSION | cut -d '=' -f 2`
TAG="darknet:cuda-$(CUDA_VERSION)"

build:
	docker build -t $(TAG) .

rebuild:
	docker build --no-cache -t $(TAG) .
        
extract-libraries:
	mkdir -p shared-$(DOCKER_TAG) \
	&& docker run --rm -v `pwd`/shared-$(DOCKER_TAG):/shared cuda-$(CUDA_VERSION)-tensorflow-$(TENSORFLOW_VERSION):$(DOCKER_TAG) \
                                        bash -c 'cp /work/tensorflow-1.10.0/bazel-bin/tensorflow/libtensorflow_cc.so /shared && \
                                                         cp /work/tensorflow-1.10.0/bazel-bin/tensorflow/libtensorflow_framework.so /shared'
