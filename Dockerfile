FROM python:3.8-slim-buster

RUN echo "|--> Updating" \
    && apt  update && apt upgrade \
    && apt -y install tini bash git \
    curl ca-certificates gcc \
    wget \ 
    # openblas-dev \
    # freetype jpeg libpng libstdc++ libgomp graphviz font-noto \
    && echo "|--> Cleaning" \
    # && rm /usr/include/xlocale.h \
    && rm -rf /root/.cache \
    && rm -rf /root/.[acpw]* \
    && rm -rf /var/cache/apk/* \
    && echo "|--> Install Python packages" \
    # & python -m ensurepip \
    # && rm -r /usr/lib/python*/ensurepip \
    apt add --no-cache blis \ 
    && pip install -U --no-cache-dir  pip astunparse numpy \
    ninja pyyaml  \
    # mkl \ 
    setuptools cmake \
    cffi typing_extensions \
    future six requests dataclasses \
    torch==1.7.0+cpu -f https://download.pytorch.org/whl/torch_stable.html
    
# RUN mkdir /app
# WORKDIR /app
# RUN wget https://download.pytorch.org/whl/cpu/torch-1.8.0%2Bcpu-cp38-cp38-linux_x86_64.whl
# RUN pip install torch-1.8.0%2Bcpu-cp38-cp38-linux_x86_64.whl
# RUN rm -rf *
# RUN  git clone --recursive https://github.com/pytorch/pytorch
# WORKDIR /app/pytorch
# # if you are updating an existing checkout
# RUN git submodule sync
# RUN git submodule update --init --recursive --jobs 0

ENTRYPOINT ["/sbin/tini", "--"]

