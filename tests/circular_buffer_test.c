#include <setjmp.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>

#include "circular_buffer.h"
#include <cmocka.h>

static circular_buffer_t buffer = {0};
static const uint8_t test_size = 90;

static int init_circular_buffer(void **state) {
  circ_buffer_init(&buffer, sizeof(int));
}

static void buffer_write_test(void **state) {
  (void)state;

  uint32_t size_before = buffer.write_ptr - buffer.read_ptr;
  uint8_t values[test_size];

  for (uint8_t i = 0; i < test_size; i++) {
    values[i] = i;
  }

  circ_buffer_push(&buffer, values, test_size);

  for (uint8_t i = 0; i < test_size; i++) {
    assert_int_equal(buffer.buffer[i], values[i]);
  }

  uint32_t size_after = buffer.write_ptr - buffer.read_ptr;
  assert_int_equal(size_after, size_before + test_size);
}

static void buffer_read_test(void **state) {
  (void)state;

  uint32_t size_before = buffer.write_ptr - buffer.read_ptr;
  uint8_t values[test_size];

  circ_buffer_pop(&buffer, values, test_size);

  for (uint8_t i = 0; i < test_size; i++) {
    assert_int_equal(i, values[i]);
  }

  uint32_t size_after = buffer.write_ptr - buffer.read_ptr;
  assert_int_equal(size_after, size_before - test_size);
}

int main(void) {
  const struct CMUnitTest tests[] = {
      cmocka_unit_test(buffer_write_test),
      cmocka_unit_test(buffer_read_test),
  };

  return cmocka_run_group_tests(tests, init_circular_buffer, NULL);
}
