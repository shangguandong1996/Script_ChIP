# The script of ChIP-Seq

> This just my own drfat script. If you have any questions, welcome to put a issue.

When you analysis ChIP_Seq using these code, you have to firstly mkdir a directory and then mkdir a directory named `rawdata` in the directory .

```bash
# Here I mkdir -p test/rawdata
$ tree test
test
└── rawdata

1 directory, 0 files

```

Then you can put your data into the `rawdata`

```bash
# Here I simulate the data and suffix you need
$ touch {A,B}_{1,2}.fq.gz

$ ll
total 0
-rw-r--r--. 1 sgd bioinfo 0 Jun 11 10:45 A_1.fq.gz
-rw-r--r--. 1 sgd bioinfo 0 Jun 11 10:45 A_2.fq.gz
-rw-r--r--. 1 sgd bioinfo 0 Jun 11 10:45 B_1.fq.gz
-rw-r--r--. 1 sgd bioinfo 0 Jun 11 10:45 B_2.fq.gz
```

After preparing your data, you can use the below code in turn

- Chip_Seq_01_QC.sh
- Chip_Seq_02_align.sh
- Chip_Seq_03_call_broadpeak.sh or Chip_Seq_03_callpeak.sh (Actually, it does not work very well because of the complexity of file naming about IP and input)
- Chip_Seq_04_bamtobw.sh
- Chip_Seq_05_deeptools_plot.sh

A example

```bash
nohup ./Chip_Seq_01_QC.sh ~/project/test >> ~/project/test/log_file 2>&1 &
```

