# BFWindow

**BFWindow** contains the implementation of paper `BFWindow: Speculatively Checking of Data Property Consistency against Buffer Overflow Attacks`.

Instead of messing the server environment, I resolve the tool dependency by manually installing them locally. If you have admin of your Linux, you can just use the `yum` utils to update the libevent/ncurses/texinfo/cmake. For other tools like ocaml, CIL, SimpleScalar and GCC-ARM, they have to be built from the scratch for there are patches of BFW implemantion as mentioned in the paper.

## Environment

+ OS     : Redhat 6.5.1 32-bit
+ GCC    : gcc version 4.4.7 20120313
+ libevent: 2.0.19-stable
+ ncurses: 5.9
+ texinfo: texinfo 4.7
+ cmake  : 3.2.2
+ OCaml  : ocaml 3.12.1, camlgraph 1.8.6, findlib 1.5.5
+ CIL    : 1.7.3 (patched for BFWindow, please refer to `src/packages/cil-1.7.3`)
+ SimpleScalar: simplesim-arm-0.2 (patched for BFWindow, please refer to `src/packages/simplesim-arm-0.2`)
+ crosstool: 0.43 (patched for SimpleScalar/ARM, please refer to `src/packages/crosstool-0.43`)
+ gcc-arm  : gcc-2.95.3,glibc-2.1.3,binutils-2.10(patched for BFWindow and build on crosstool 0.43, please refer to `src/packages/crosstool-0.43/download`)
+ MiBench: mibench 1.0 (patched to remove unsupported system call in simplescalar, please refer to `src/packages/mibench-1.0`)

**Note**: All related source code used for paper `BFWindow: Speculatively Checking of Data Property Consistency against Buffer Overflow Attacks` are backed up and can be retrived from Google Drive with the link: https://drive.google.com/folderview?id=0B3oN82OVo4hofkZOX2s3a0N6WWJ3LXVwN3pSLW1RbWdMOFh0M09MNkdsSXNxWGtFVlp5eTA&usp=sharing.
## Setup

+ Setup target directory
`export BFW_INST=*pathToyourInstalldirectory*

+ libevent Install
```
wget https://github.com/downloads/libevent/libevent/libevent-2.0.19-stable.tar.gz
tar -zxvf libevent-2.0.19-stable.tar.gz && cd libevent-2.0.19-stable
./configure --prefix=$BFW_INST --disable-shared
make && make install && cd ..
export LD_LIBRARY_PATH=$BFW_INST/lib:$LD_LIBRARY_PATH
```
+ ncurse Install
```
wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz
tar -zxvf ncurses-5.9.tar.gz && cd ncurses-5.9
./configure --prefix=$BFW_INST
make && make install && cd ..
```

+ texinfo Install
```
wget http://ftp.gnu.org/gnu/texinfo/texinfo-4.7.tar.bz2
tar -jxvf texinfo-4.7.tar.bz2 && cd texinfo-4.7
./configure  --prefix=$BFW_INST CPPFLAGS="-I$BFW_INST/include" LDFLAGS="-L$BFW_INST/lib"
make && make install && cd ..
export PATH=$BFW_INST/bin:$PATH
```

+ cmake Install
```
wget http://www.cmake.org/files/v3.2/cmake-3.2.3.tar.gz
tar -zxvf cmake-3.2.3.tar.gz && cd cmake-3.2.3
./bootstrap --prefix=$BFW_INST && make && make install && cd ..
```

+ SimpleScalar Install
```
tar -jxvf simple-sim-arm-0.2.tar.bz2 && cd simple-sim-arm-0.2
make config-arm
make
```

+ gcc-arm install
```
tar -jxvf crosstool-0.43.tar.bz2 && cd crosstool-0.43
unset LD_LIBRARY_PATH
./demo-arm-bfw.sh >& r.log &
```

+ OCaml Install
```
wget http://caml.inria.fr/pub/distrib/ocaml-3.12/ocaml-3.12.1.tar.bz2
tar -jxvf ocaml-3.12.1.tar.bz2 && ocaml-3.12.1
./configure -prefix $BFW_INST
make world.opt && make install && cd ..
```

+ CIL Install
  + findlib-1.5.5
    ```
    wget http://download.camlcity.org/download/findlib-1.5.5.tar.gz
    tar -zxvf findlib-1.5.5.tar.gz && cd findlib-1.5.5
    mkdir `ocamlfind printconf destdir` || true
    echo `ocamlfind printconf destdir` >> /slowfs/us01dwt2p320/jlrao/dev/bfw/lib/ocaml/ld.conf
    cd ..
    ```
  + ocamlgraph-1.8.6
  ```
  wget http://ocamlgraph.lri.fr/download/ocamlgraph-1.8.6.tar.gz
  tar -zxvf ocamlgraph-1.8.6.tar.gz && cd ocamlgraph-1.8.6
  ./configure  --prefix=$BFW_INST
  make && make install && make install-findlib && cd ..
  ```
  + cil-1.7.3
  ```
  tar -jxvf cil-1.7.3.tar.bz2 && cd cil-1.7.3
  FORCE_PERL_PREFIX=1 ./configure --prefix=$BFW_INST
  make
  make install
  ```


## Simulation

## Results

## References

## License
This work is free for education purpose. It's welcome to use them in your research or project. I'm happy to get emails for noticing of this work reusages.

## Author

Jinli Rao \<ary.xsnow@gmail.com\>
