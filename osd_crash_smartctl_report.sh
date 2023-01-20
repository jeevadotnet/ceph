# used ChatGPT-3 to create inline comments for script
# loop through the list of crashed devices and extract the OSD devices
for DISK in $(ceph crash ls | grep osd | awk '{print $2}'); do
  # extract the hostname where the OSD device is located
  HOST=$(ceph device ls | grep "$DISK" | grep 'cephosd:sd' | awk '{print $2}' | cut -d ':' -f1)
  # extract the disk path for the OSD device
  DISK="/dev/$(ceph device ls | grep "$DISK" | grep 'cephosd:sd' | awk '{print $2}' | cut -d ':' -f2)"
  # run the smartctl command on the OSD device on the host
  ssh "$HOST" "sudo smartctl -a $DISK"
done
