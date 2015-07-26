#!/system/bin/sh

# Tweaks
echo "140"	> /proc/sys/vm/swappiness
echo "35"	> /proc/sys/vm/vfs_cache_pressure
echo "500"	> /proc/sys/vm/dirty_writeback_centisecs
echo "1000"	> /proc/sys/vm/dirty_expire_centisecs
echo "25"	> /sys/module/zswap/parameters/max_pool_percent

#set bigger swap area of 1.8gb
swapoff /dev/block/vnswap0
echo "1932525568" > /sys/block/vnswap0/disksize
mkswap /dev/block/vnswap0
swapon /dev/block/vnswap0

#  Start SuperSU daemon
#  Wait for 5 seconds from boot before starting the SuperSU daemon
sleep 5
/system/xbin/daemonsu --auto-daemon &

# Interactive tuning
# Wait 10 seconds total from boot
sleep 5

#set apollo interactive governor
echo "25000 1296000:10000 1400000:5000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
echo "95" 	> /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
echo "90" 	> /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
echo "15000"	> /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
echo "35000"	> /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
echo "3000"	> /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack

#set atlas interactive governor
echo "25000 1500000:15000 1800000:10000 2000000:5000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
echo "95" 	> /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
echo "90" 	> /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
echo "15000"	> /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
echo "35000"	> /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
echo "3000"	> /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack

