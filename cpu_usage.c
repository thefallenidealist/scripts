// 181110 created
// 200603 rewritten sh version to C to use less CPU when used in tint2 taskbar
// - in sync with information shown in top(1)
// - uses sysctl kern.cp_time (one statistics for all CPU cores)
// - utilization must be calculated by hand every N time slices - TMP file used for storing old values between calculations
// - this program is called from tint2 panel every 1 second
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>		// strtol()
#include <sys/sysctl.h>
#include <sys/param.h>
#include <sys/resource.h>
#include <sys/sysctl.h>
#include <unistd.h>	// sleep()

#define DEBUG 0
#define ANSI_COLOR_YELLOW			"\x1b[33m"
#define ANSI_COLOR_RESET			"\x1b[0m"
#define dprintf(fmt, ...) \
do { if (DEBUG) printf(ANSI_COLOR_YELLOW "DBG INFO %s:%d %s(): " \
		ANSI_COLOR_RESET fmt, __FILE__, __LINE__, __func__,\
		##__VA_ARGS__); } while (0)

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
#define TMP_FILE	"/tmp/cpu_usage"

bool file_exists(void);
void write_old(long str[]);
void read_file(void);

long cur[CPUSTATES];
long last[CPUSTATES] = {};

bool file_exists(void)
{
	if (access(TMP_FILE, F_OK) != -1)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

void read_file(void)
{
	dprintf("Reading previous state from file\n");

	FILE *fp;
	fp = fopen(TMP_FILE, "r");

	for (int state = 0; state<CPUSTATES; state++)
	{
		char c;
		char current_line[20] = {0};
		int i = 0;

		while ((c = fgetc(fp)) != '\n')
		{
			current_line[i++] = c;
		}

		dprintf("current line str: %s\n", current_line);
		long current_line_int = strtol(current_line, NULL, 10);	// NULL - crash on fail
		dprintf("last[%d] = current_line_int(%ld str:%s)\n", state, current_line_int, current_line);

		last[state] = current_line_int;
	}
	fclose(fp);
}

void write_old(long str[])
{
	FILE *fp;
	fp = fopen(TMP_FILE, "w");

	for (int state = 0; state<CPUSTATES; state++)
	{
		dprintf("writing to file  str[%d] = %ld\n", state, str[state]);
		fprintf(fp, "%ld\n", str[state]);
	}
	fclose(fp);
}

double get_cpu_utilization()
{
	// implementation stolen from: https://stackoverflow.com/questions/5329149/using-system-calls-from-c-how-do-i-get-the-utilization-of-the-cpus
	size_t len = sizeof(cur);
	double utilization = 0.0;

	if(sysctlbyname("kern.cp_time", &cur, &len, NULL, 0) != 0)
	{
		printf ("Error reading kern.cp_times sysctl\n");
		return -1;
	}

	if (file_exists())
	{
		read_file();
		write_old(cur);

		long sum = 0;
		for (int state = 0; state<CPUSTATES; state++)
		{
			long tmp = cur[state];
			dprintf("will write cur[4]: %ld tmp: %ld\n", cur[CP_IDLE], tmp);
			// write_old2(tmp);	/// INFO radi donekle

			cur[state] -= last[state];
			last[state] = tmp;
			sum += cur[state];
		}
		utilization = 100.0L - (100.0L * cur[CP_IDLE] / (sum ? (double) sum : 1.0L));
		dprintf("----> calculated utilisation: %.1f cur[CP_IDLE]: %ld last[CP_IDLE]: %ld\n", utilization, cur[CP_IDLE], last[CP_IDLE]);
		return utilization;
	}
	else
	{
		printf("should create new file\n");
		write_old(cur);
		return 0.0;	// return 0%, will be calculated on next iteration
	}

	return utilization;
}

#ifndef NO_MAIN
int main()
{
	double utilization = get_cpu_utilization();
	printf("CPU: %.1f%%\n", utilization);

	return 0;
}
#endif // NO_MAIN
