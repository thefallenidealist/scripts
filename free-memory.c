// Createad 200601
// rewrote sh version to C to use less CPU when used in tint2 taskbar
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>		// exit()

#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/vmmeter.h>
#include <vm/vm_param.h>

int64_t get_sysctl(int mib1, int mib2)
{
	int mib[2];
	int64_t value;

	mib[0] = mib1;
	mib[1] = mib2;

	size_t len = sizeof(value);
	if (sysctl(mib, 2, &value, &len, NULL, 0) < 0)
	{
		printf("error, mib[%d, %d]\n", mib[0], mib[1]);
		exit(-1);
	}

	return value;
}

int main()
{
	int64_t  phy_mem  = get_sysctl(CTL_HW, HW_PHYSMEM);
	int     page_size = get_sysctl(CTL_HW, HW_PAGESIZE);

	struct vmtotal vm_info;
	int mib[2];
	mib[0] = CTL_VM;
	mib[1] = VM_TOTAL;
	size_t len = sizeof(vm_info);
	if (sysctl(mib, 2, &vm_info, &len, NULL, 0) == -1)
	{
		printf("error on line: %d\n", __LINE__);
		return(-2);
	}

	uint16_t phy_mb = phy_mem/1024/1024;
	uint16_t vm_free_mb   = vm_info.t_free * page_size / 1024 / 1024;
	uint8_t free_percent = (vm_free_mb * 100 / phy_mb);

	printf("RAM: %d%%\n", free_percent);
	printf("%d MB\n", vm_free_mb);

	return 0;
}
