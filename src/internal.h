#ifndef internal_H_
#define internal_H_

#include <stdint.h>

#include <trace/trace.h>

typedef uint32_t dtc_id_t;

typedef struct LTr_dtc_frame_t {
  dtc_id_t id;
  char *message;
  uint32_t message_len;
} LTr_dtc_frame_t;

#endif // internal_H_
