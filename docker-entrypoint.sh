#the ip for the current instance
machineIP=$(ifconfig eth0 | grep -w 'inet' | awk '{print $2}' | tr ":" "\n" | tail -1)
echo This machine IP : $machineIP

#Building the Seed node list
joinServer='-join '
 counter=0
 proplist=''

dnsname='tasks.'$SERVICE_NAME

until [ $counter -ge $MIN_QUORUM ]; do
 echo "Will wait till minimum number of nodes are up."
 counter=0
 proplist=''
 for consul in $(dig +short $dnsname)
  do
      if [ "$machineIP" != "$consul" ]; then
        echo $consul
      fi
      prop=$joinServer$consul
      proplist=$proplist' '$prop
     counter=$(($counter+1))
  done
 sleep 2
done


#Form the execution command by combining multiple seed node information
execcommand='./consul agent -data-dir=consul_data -server -advertise='$machineIP' -bootstrap-expect='$MIN_QUORUM' '$proplist' -client=0.0.0.0 -node-id='$(uuidgen)' -node='$(hostname)' -ui'

#start consul
eval $execcommand