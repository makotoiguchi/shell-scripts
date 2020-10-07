#!/bin/bash

##################################################
# Functions
##################################################

fucntion recreateFolder {
   rm -rf $1
   echo "Create folder $1"
   mkdir $1
}


##################################################
# Main Script
##################################################

if [ $# -gt 1 ]
then
   echo -e "usage:"
   echo -e "   ./data_collect.sh"
   exit 1
fi

echo 
echo "--------------------------------------------------------------------------------"
echo "Start collecting data..."

dataPath=/tmp/data
recreateFolder $dataPath

echo ""

echo "Get Linux status"
echo "- cpuinfo"
cat /proc/cpuinfo    > $dataPath/server_cpuinfo.txt
echo "- meminfo"
cat /proc/meminfo    > $dataPath/server_meminfo.txt
echo "- top"
top -n 3 -b -d 3     > $dataPath/server_top.txt
echo "- iostat"
iostat -mx 5 3       > $dataPath/server_iostat.txt
echo "- df"
df -h                > $dataPath/server_df.txt
echo "- ps"
ps -aef              > $dataPath/server_ps_full.txt
echo "- lsof"
lsof -P              > $dataPath/server_lsof.txt
echo "- dmesg"
dmesg                > $dataPath/server_dmesg.txt
echo "- listening sockets"
ss -nltp             > $dataPath/server_listening_ports.txt
echo "- ulimit"
ulimit -a            > $dataPath/server_ulimit.txt

echo ""

echo "VMWare tools"
echo "# hosttime: print the host time"                          >  $dataPath/server_vmwaretools.txt 2>&1
vmware-toolbox-cmd stat hosttime                                >> $dataPath/server_vmwaretools.txt 2>&1
echo "# speed: print the CPU speed in MHz"                      >> $dataPath/server_vmwaretools.txt 2>&1
vmware-toolbox-cmd stat speed                                   >> $dataPath/server_vmwaretools.txt 2>&1
echo "# sessionid: print the current session id"                >> $dataPath/server_vmwaretools.txt 2>&1
vmware-toolbox-cmd stat sessionid                               >> $dataPath/server_vmwaretools.txt 2>&1
echo "# balloon: print memory ballooning information"           >> $dataPath/server_vmwaretools.txt 2>&1
vmware-toolbox-cmd stat balloon                                 >> $dataPath/server_vmwaretools.txt 2>&1
echo "# swap: print memory swapping information"                >> $dataPath/server_vmwaretools.txt 2>&1
vmware-toolbox-cmd stat swap                                    >> $dataPath/server_vmwaretools.txt 2>&1
echo "# memlimit: print memory limit information"               >> $dataPath/server_vmwaretools.txt 2>&1
vmware-toolbox-cmd stat memlimit                                >> $dataPath/server_vmwaretools.txt 2>&1
echo "# memres: print memory reservation information"           >> $dataPath/server_vmwaretools.txt 2>&1
vmware-toolbox-cmd stat memres                                  >> $dataPath/server_vmwaretools.txt 2>&1
echo "# cpures: print CPU reservation information"              >> $dataPath/server_vmwaretools.txt 2>&1
vmware-toolbox-cmd stat cpures                                  >> $dataPath/server_vmwaretools.txt 2>&1
echo "# cpulimit: print CPU limit information"                  >> $dataPath/server_vmwaretools.txt 2>&1
vmware-toolbox-cmd stat cpulimit                                >> $dataPath/server_vmwaretools.txt 2>&1

echo ""

echo "--------------------------------------------------------------------------------"
echo "Creating tar file(s)"
cd /tmp
tarfile=data_`hostname`_`date +%Y%m%d%H%M%S`.tar.gz
tar -czvf $tarfile data/


chmod 777 /tmp/data*.tar.gz


echo "--------------------------------------------------------------------------------"
echo "Data stored at: /tmp/data"
echo "Tar file at: /tmp/$tarfile"
