FROM tvm_base as tvm

ENV venv=/opt/venv

RUN git clone https://github.com/pasqoc/incubator-tvm.git && \
    cd incubator-tvm/ && \
    git checkout il_contrib_0421 && \
    cd - && \
    git clone https://github.com/pasqoc/incubator-tvm-vta.git && \
    cd incubator-tvm-vta/ && \
    git checkout il_contrib_0421 && \
    cd -

RUN cd incubator-tvm/ && \
    git submodule update --init --recursive

RUN apt-get update && apt-get install -yq llvm-9-dev && apt-get clean

RUN cd incubator-tvm/ && \
    /bin/bash -c "source $venv/bin/activate && make -j `nproc` && make chisel"
