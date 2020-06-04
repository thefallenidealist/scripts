// 181209 created sh version
// 200603 rewritten in C to use less CPU when used in tint2 taskbar
// Shows load average for last minute
#include <stdio.h>
#include <stdlib.h>	// getloadavg()

// stolen from /usr/src/usr.bin/w/w.c

double get_load_average()
{
	double avenrun[3];
#define	nitems(x)	(sizeof((x)) / sizeof((x)[0]))

	if (getloadavg(avenrun, nitems(avenrun)) == -1)
	{
		printf("error retriving load average\n");
		return -1;
	}

	return avenrun[0];	// return only average for last minute
}

#ifndef NO_MAIN
int main()
{
	double current_load_average = get_load_average();
	printf("%.2f\n", current_load_average);

	return 0;
}
#endif // NO_MAIN
