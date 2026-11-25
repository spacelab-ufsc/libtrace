#ifndef libtrace_H_
#define libtrace_H_

typedef void (*write_handler_t)(void *);
typedef void (*read_handler_t)(void *);
typedef void (*erase_handler_t)(void *);

typedef struct LTr_config_t {
  write_handler_t
      write_handler; /*function pointer for writing the desired media*/
  read_handler_t
      read_handler; /*function pounter for reading the desired media*/
  erase_handler_t erase_handler; /*function pointer for erasing section of the
                                    desired media*/
} LTr_config_t;

/**
 * \brief Initializes the library with the desired configs.
 *
 * \param[in] config is the configuration struct to initialize.
 *
 * \returns the status/error code.
 */
int ltr_init(const LTr_config_t *config);

#endif // libtrace_H_
