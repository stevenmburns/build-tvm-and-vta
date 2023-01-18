# build-tvm-and-vta

```
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install pytest pytest-xdist pytest-depends pytest-testmon pytest-forked
pip install numpy scipy requests mxnet "Pillow<7" matplotlib 

git clone https://github.com/pasqoc/incubator-tvm.git
cd incubator-tvm/

git checkout il_contrib_0421
cd -

git clone https://github.com/pasqoc/incubator-tvm-vta.git
cd incubator-tvm-vta/
git checkout il_contrib_0421
cd -

cd incubator-tvm/
git submodule update --init --recursive

make -j `nproc`
make chisel

export TVM_HOME $PWD
mkdir -p verif/work
cd verif

export PYTHONPATH=$TVM_HOME/python:$TVM_HOME/vta/python

pytest --targets tsim -k test_deploy_classification[resnet18_v2-tsim]
```
# To run with Docker container

Start the container using
```
docker run -it stevenmburns/tvm
```
Then run:
```
source $venv/bin/activate
cd /incubator-tvm
export PYTHONPATH=`realpath ./python`:`realpath ./vta/python`
mkdir -p verif/work
cd verif
pytest --targets tsim -k test_deploy_classification[resnet18_v2-tsim]
```
or, on one line:
```
docker run -it stevenmburns/tvm /bin/bash -c "source /opt/venv/bin/activate && cd /incubator-tvm && export PYTHONPATH=/incubator-tvm/python:/incubator-tvm/vta/python && mkdir -p verif/work && cd verif && pytest --targets tsim -k test_deploy_classification[resnet18_v2-tsim]"
```

# To build the containers

```
docker build -t tvm_base -f Dockerfile_base .
docker build -t tvm -f Dockerfile .
```
