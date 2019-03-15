#!/bin/bash
#SCRIPT will check if there is some offline nodes
clear
echo "Checking nodes..."
echo ""
sleep 1
cd ~
ALIASES="$(find /root/.transcendence_* -maxdepth 0 -type d | cut -c22-)"
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}$0 must be run as root.${NC}"
   exit 1
fi
echo $ALIASES > temp1
cat temp1 | grep -o '[^ |]*' > temp2
CN="$(cat temp2 | wc -l)"
rm temp1
let LOOP=0
x=0
while [  $LOOP -lt $CN ]; do
LOOP=$((LOOP+1))
CURRENT="$(sed -n "${LOOP}p" temp2)"
OFFSET="$(sh /root/bin/transcendence-cli_${CURRENT}.sh masternode status | grep  "message")"
if [[ $OFFSET != *[!\ ]* ]]
then
((x++))
echo -e "${GREEN}${CURRENT}${NC}"
echo ""
fi
done
rm temp2
if [ $x -gt 0 ]; then
  echo "Found Errors in $x nodes"
  echo -ne '\007'
else
  echo "All nodes OK"
fi

echo ""
echo "If you find any value in this script, you can donate some TELOS"
echo "My TELOS address:   GTvVmn5Yvuzg9CyyiYRmJ57mMVDG21PUnt"
echo ""
echo ""
