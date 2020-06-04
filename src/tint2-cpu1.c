// 181209 shell version created
// 200603 rewritten in C
// Show current CPU utilization and current frequency
// For use with panel such as tint2

#define NO_MAIN	// don't use main() from included .c

#include "./cpu-usage.c"
#include "./cpu-freq.c"

int main()
{
	// get_cpu_utilisation_sh();	// temporaty sh version
	double cpu_utilization = get_cpu_utilization();
	int cpu_freq = get_cpu_freq();

	printf("CPU: %3.0f%%\n", cpu_utilization);
	printf("%4d Mhz\n", cpu_freq);
}
