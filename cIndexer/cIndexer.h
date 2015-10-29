#include <Python.h>
#include <vector>
#include <string>

static std::vector<std::string> Scan(const std::string &directory, const std::string &pattern = "^$");
static PyObject *Scan(PyObject *self, PyObject *args);
