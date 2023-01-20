for DISK in $(ceph crash ls | grep osd | awk '{print $2}'); do
  HOST=$(ceph device ls | grep "$DISK" | grep 'cephosd:sd' | awk '{print $2}' | cut -d ':' -f1)
  ssh "$HOST" "sudo dmesg -T | grep 'critical'"
done
