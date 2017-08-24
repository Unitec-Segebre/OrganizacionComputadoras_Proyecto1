#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Invalid arguments. Usage $0 <mem file> <output bit file>"
	exit 1
fi

DATA2MEM="./Xilinx.Tool-x86_64.AppImage data2mem"
PROMGEN="./Xilinx.Tool-x86_64.AppImage promgen"
OUTPUT_BITFILE=$2
INPUT_BITFILE=MIPS32SOC.bit
BMM_FILE=mips32soc_vgacolor.bmm
MEM_FILE=$1
BASEFILENAME=${OUTPUT_BITFILE/.bit/}
echo $BASEFILENAME

rm -f $BASEFILENAME.*

echo Building bit file $OUTPUT_BITFILE ...
$DATA2MEM -bm $BMM_FILE -bt $INPUT_BITFILE -bd $MEM_FILE -o b $OUTPUT_BITFILE

echo Building binary configuration file ...
$PROMGEN -u 0 $OUTPUT_BITFILE -b -p bin -w

mv $BASEFILENAME.bin ../src/
