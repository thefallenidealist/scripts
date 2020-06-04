// 181209 shell version created
// 200603 rewritten in C to use less CPU when used in tint2 taskbar
// For use with panel such as tint2

#define NO_MAIN	// don't use main() from included .c

#include "./cpu-temperature.c"
#include "./load-average.c"

int main()
{
	int temperature = get_temperature();
	double current_load_average = get_load_average();

	printf("%d°C\n", temperature);
	printf("A:%.2f\n", current_load_average);
}
