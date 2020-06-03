// 140808 created sh version
// 181110 updated sh version
// 200603 Rewritten in C
// display current CPU temperature
#include <stdio.h>
#include <sys/sysctl.h>

int get_temperature(void)
{
	int value;
	size_t len = sizeof(value);

	if (sysctlbyname("hw.acpi.thermal.tz0.temperature", &value, &len, NULL, 0) != 0)
	{
		printf("error retriving sysctl\n");
		return -1;
	}

	// sysctl | value
	// 50.1°C | 3232
	// 51.1°C | 3242
	// 52.1°C | 3252

	return value/10 - 273;
}

#ifndef NO_MAIN
int main()
{
	int temperature = get_temperature();
	printf("%d°C\n", temperature);
	return 0;
}
#endif // NO_MAIN
