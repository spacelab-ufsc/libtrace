#ifndef circular_buffer_H_
#define circular_buffer_H_

#define MAX_BUFFER_SIZE_BYTE (1024)

#include <stdbool.h>
#include <stdint.h>

/*
 *\brief Structure representing the circular buffer.
 */
typedef struct circular_buffer_t {
  uint8_t buffer[MAX_BUFFER_SIZE_BYTE];
  uint32_t size;

  uint32_t read_ptr;
  uint32_t write_ptr;
} circular_buffer_t;

/*
 * \brief Initializes a circular buffer.
 *
 * \param[in,out] buffer is the buffer to be initialized.
 *
 * \param[in] size_of_data is the length of the data to be stored in the buffer.
 */
void circ_buffer_init(circular_buffer_t *buffer, uint32_t size_of_data);

int circ_buffer_push(circular_buffer_t *buffer, const uint8_t *data,
                     const uint32_t length);

int circ_buffer_pop(circular_buffer_t *buffer, uint8_t *data,
                    const uint32_t length);

void circ_buffer_clear(circular_buffer_t *buffer);

bool circ_buffer_is_empty(circular_buffer_t *buffer);

#endif // circular_buffer_H_
