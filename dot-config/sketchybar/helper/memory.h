#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <mach/mach.h>
#include <mach/mach_host.h>
#include <stdbool.h>
#include <sys/sysctl.h>

#define MAX_TOPMEM_LEN 28

static const char TOPMEM[] = { "/bin/ps -Aceo pid,pmem,comm -m" }; 
static const char MEM_FILTER_PATTERN[] = { "com.apple." };

struct memory {
  host_t host;
  mach_msg_type_number_t count;
  vm_statistics64_data_t vm_stats;
  uint64_t total_memory;
  
  char command[256];
};

static inline void memory_init(struct memory* mem) {
  mem->host = mach_host_self();
  mem->count = HOST_VM_INFO64_COUNT;
  
  // Get total physical memory
  int mib[2] = {CTL_HW, HW_MEMSIZE};
  size_t length = sizeof(uint64_t);
  sysctl(mib, 2, &mem->total_memory, &length, NULL, 0);
  
  snprintf(mem->command, 256, "");
}

static inline void memory_update(struct memory* mem) {
  kern_return_t error = host_statistics64(mem->host,
                                          HOST_VM_INFO64,
                                          (host_info64_t)&mem->vm_stats,
                                          &mem->count);

  if (error != KERN_SUCCESS) {
    printf("Error: Could not read memory statistics.\n");
    return;
  }

  // Calculate memory usage
  uint64_t used_memory = ((uint64_t)mem->vm_stats.active_count +
                          (uint64_t)mem->vm_stats.wire_count) * vm_page_size;
  
  uint64_t app_memory = (uint64_t)mem->vm_stats.internal_page_count * vm_page_size;
  uint64_t compressed = (uint64_t)mem->vm_stats.compressor_page_count * vm_page_size;
  
  double used_perc = (double)used_memory / (double)mem->total_memory;
  double app_perc = (double)app_memory / (double)mem->total_memory;
  double compressed_perc = (double)compressed / (double)mem->total_memory;
  double total_perc = used_perc + compressed_perc;

  // Get top memory process
  FILE* file;
  char line[1024];

  file = popen(TOPMEM, "r");
  if (!file) {
    printf("Error: TOPMEM command errored out...\n");
    return;
  }

  fgets(line, sizeof(line), file);
  fgets(line, sizeof(line), file);

  char* start = strstr(line, MEM_FILTER_PATTERN);
  char topproc[MAX_TOPMEM_LEN + 4];
  uint32_t caret = 0;
  for (int i = 0; i < sizeof(line); i++) {
    if (start && i == start - line) {
      i+=9;
      continue;
    }

    if (caret >= MAX_TOPMEM_LEN && caret <= MAX_TOPMEM_LEN + 2) {
      topproc[caret++] = '.';
      continue;
    }
    if (caret > MAX_TOPMEM_LEN + 2) break;
    topproc[caret++] = line[i];
    if (line[i] == '\0') break;
  }

  topproc[MAX_TOPMEM_LEN + 3] = '\0';

  pclose(file);

  // Color coding based on memory pressure
  char color[16];
  if (total_perc >= .85) {
    snprintf(color, 16, "%s", getenv("RED"));
  } else if (total_perc >= .70) {
    snprintf(color, 16, "%s", getenv("ORANGE"));
  } else if (total_perc >= .50) {
    snprintf(color, 16, "%s", getenv("YELLOW"));
  } else {
    snprintf(color, 16, "%s", getenv("LABEL_COLOR"));
  }

  snprintf(mem->command, 256, "--push memory.used %.2f "
                              "--push memory.compressed %.2f "
                              "--set memory.top label='%s' "
                              "--set memory.percent label=%.0f%% label.color=%s ",
                              used_perc,
                              compressed_perc,
                              topproc,
                              total_perc * 100.,
                              color);
}
