# BFWindow

**BFWindow** contains the implementation of paper `BFWindow: Speculatively Checking Data Property Consistency against Buffer Overflow Attacks`.

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

**Note**: Due to the Github project space limitation, all related source code used for paper `BFWindow: Speculatively Checking Data Property Consistency against Buffer Overflow Attacks` are backed up and can be retrived from Google Drive. If you are intrested, please email me with ary.xsnow@gmail.com. 

## Setup

+ Setup target directory
```
export BFW_INST=pathToyourInstalldirectory
```

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
tar -jxvf simple-sim-arm-0.2.tar.bz2 -C $BFW_INST && cd $BFW_INST/simple-sim-arm-0.2
make config-arm
make
```
**NOTE**: Please get the crosstool-0.43.tar.bz2 from the GoogleDrive manually which is equiped with patches.

+ gcc-arm install
```
tar -jxvf crosstool-0.43.tar.bz2 -C $BFW_INST && cd crosstool-0.43
unset LD_LIBRARY_PATH
./demo-arm-bfw.sh >& r.log &
```
  **NOTE**: 
  1. Please get the crosstool-0.43.tar.bz2 from the GoogleDrive manually which is equiped with patches.

  2. The built gcc compiler suit will be located in $BFW_INST/gcc-arm.

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
    **NOTE**: Please get the cil-1.7.3.tar.bz2 from the GoogleDrive manually which is equiped with patches.

## Validation
  + Setup
  
  ```
  export BFW_INST=pathToyourInstalldirectory
  wget setup.sh
  soure $BFW_INST/setup.sh
  ```
  + SimpleScalar/GCC ARM
  ```
  cd $ARMSS_HOME/libbfw/tests
  ./hello.sh
  ```
    **NOTE**: manually check the run_hello.log for the number 5050(5050=sum([0,100])=0+1+...+99+100).
  
  + SimpleScalar/GCC ARM + BFWindow
  ```
  cd $ARMSS_HOME/libbfw/tests
  make -f Makefile.bfw bld
  make -f Makefile.bfw sim
  ```
    **NOTE**: manually check the r.log for the number 5050(5050=sum([0,100])=0+1+...+99+100).

## Simulation

  + Mibench
  ```
  wget mibench.tar.gz
  tar -zxvf mibench.tar.gz && cd mibench/run
  soure $BFW_INST/setup.sh
  ./run_mediabench.pl sim_mibench.cfg > r.log 2>&1 &
  ```
    **NOTE**:
    
      1. The simulation for selected benchmarks are configured in sim_mibench.cfg. Currently it takes several hours. Just have some rest before analyzing the results.
      
      2. The result is automatically collected into `mibench_summary`.

## Results
  The results of paper `BFWindow: Speculatively Checking Data Property Consistency against Buffer Overflow Attacks` are located in src/mibench/run. The result report is src/mibench/run/mibench_summary and the visual diagram is in src/mibench/run/BFWindow_Results.xlsx. Please refer the src/mibench/README for more details.

## Acknowledges
  Thanks to John Wilander for answering questions to RIPE testbed (https://github.com/johnwilander/RIPE/)!

  Thanks to Jane Wu from Synopsys for her valuable suggestions!

## References
  1. CIL: https://github.com/cil-project/
  2. CIL Tutor: https://bitbucket.org/zanderso/cil-template
  3. RIPE: https://github.com/johnwilander/RIPE
  4. SimpleScalar-ARM: http://simplescalar.com/v4test.html
  5. crosstool: http://kegel.com/crosstool

## License
This work is free for education purpose. It's welcome to use them in your research or project. I'm happy to get emails for noticing of this work reusages.

## Author

Jinli Rao <ary.xsnow@gmail.com>

