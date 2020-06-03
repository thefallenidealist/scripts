// 181110 Created sh version
// 200603 rewrote sh version to C to use less CPU when used in tint2 taskbar
// Display current CPU frequency
#include <stdio.h>
#include <sys/sysctl.h>

int get_cpu_freq()
{
	int value;
	size_t len = sizeof(value);

	if (sysctlbyname("dev.cpu.0.freq", &value, &len, NULL, 0) != 0)
	{
		printf("error retriving sysctl\n");
		return -1;
	}

	return value;
}

#ifndef NO_MAIN
int main()
{
	int cpu_freq = get_cpu_freq();
	printf("%d Mhz\n", cpu_freq);

	return 0;
}
#endif // NO_MAIN
