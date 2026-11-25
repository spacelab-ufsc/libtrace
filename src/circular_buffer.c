#include "circular_buffer.h"

void circ_buffer_init(circular_buffer_t *buffer, uint32_t size_of_data) {
  buffer->size = MAX_BUFFER_SIZE_BYTE / size_of_data;
  buffer->read_ptr = 0;
  buffer->write_ptr = 0;
}

int circ_buffer_push(circular_buffer_t *buffer, const uint8_t *data,
                     const uint32_t length) {
  for (uint32_t i = 0; i < length; i++) {
    /*stop the writing process if next operation would empty the buffer*/
    if ((buffer->write_ptr + 1) == buffer->read_ptr) {
      return -1;
    }

    buffer->buffer[buffer->write_ptr++] = data[i];

    /*rotate the write_ptr around in case of reaching the end*/
    buffer->write_ptr %= buffer->size;
  }

  return 0;
}

int circ_buffer_pop(circular_buffer_t *buffer, uint8_t *data,
                    const uint32_t length) {
  for (uint32_t i = 0; i < length; i++) {
    if (circ_buffer_is_empty(buffer)) {
      return -1;
    }

    data[i] = buffer->buffer[buffer->read_ptr++];

    /*rotate the write_ptr around in case of reaching the end*/
    buffer->read_ptr %= buffer->size;
  }
}

void circ_buffer_clear(circular_buffer_t *buffer) {
  buffer->read_ptr = 0;
  buffer->write_ptr = 0;
}

bool circ_buffer_is_empty(circular_buffer_t *buffer) {
  return (buffer->read_ptr == buffer->write_ptr);
}
