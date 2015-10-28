#include <Python.h>
#include <vector>
#include <string>

static std::vector<std::string> Scan(const std::string &root, const std::string &pattern = "^$");
static PyObject *Scan(PyObject *self, PyObject *args);
