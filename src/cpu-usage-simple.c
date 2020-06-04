// 200603 created
// rewrote sh version to C to use less CPU when used in tint2 taskbar
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>		// strtol()
#include <sys/sysctl.h>
#include <sys/param.h>
#include <sys/resource.h>
#include <sys/sysctl.h>
#include <unistd.h>	// sleep()

/*
 * kern.cp_time
 * Aggregated CPU state counters for
 * - user
 * - nice
 * - system
 * - interrupt
 * - idle
 * kern.cp_times - as kern.cp_time but for each core
 *
 * CPU utilization = user + nice + system + interrupt
 */
#define CP_USER   0
#define CP_NICE   1
#define CP_SYS    2
#define CP_INTR   3
#define CP_IDLE   4
#define CPUSTATES 5

double get_cpu_utilization()
{
	// implementation stolen from: https://stackoverflow.com/questions/5329149/using-system-calls-from-c-how-do-i-get-the-utilization-of-the-cpus
	long cur[CPUSTATES];
	static long last[CPUSTATES] = {};
	size_t len = sizeof(cur);
	double utilization;

	if(sysctlbyname("kern.cp_time", &cur, &len, NULL, 0) != 0)
	{
		printf ("Error reading kern.cp_times sysctl\n");
		return -1;
	}

	long sum = 0;
	for (int state = 0; state<CPUSTATES; state++)
	// for (int state = CP_IDLE; state<CPUSTATES; state++) // XXX
	{
		long tmp = cur[state];
		cur[state] -= last[state];
		last[state] = tmp;
		sum += cur[state];
	}

	utilization = 100.0L - (100.0L * cur[CP_IDLE] / (sum ? (double) sum : 1.0L));

	return utilization;
}

#ifndef NO_MAIN
int main()
{
	while (1)
	{
		double utilization = get_cpu_utilization();
		printf("CPU: %.1f%%\n", utilization);
		sleep(1);
	}

	return 0;
}
#endif // NO_MAIN
