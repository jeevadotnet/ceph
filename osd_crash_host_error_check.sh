# loop through the list of crashed devices and extract the OSD devices
for DISK in $(ceph crash ls | grep osd | awk '{print $2}'); do
  # extract the hostname where the OSD device is located
  HOST=$(ceph device ls | grep "$DISK" | grep 'cephosd:sd' | awk '{print $2}' | cut -d ':' -f1)
  # run the dmesg command to check for critical events on the host
  ssh "$HOST" "sudo dmesg -T | grep 'critical'"
done
