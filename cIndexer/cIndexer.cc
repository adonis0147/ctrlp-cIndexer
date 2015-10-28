#include "cIndexer.h"
#include <Python.h>
#include <cstring>
#include <string>
#include <vector>
#include <queue>
#include <algorithm>
#include <regex>

#ifdef __unix__
#include <dirent.h>
#define ISDIR(type) (type == DT_DIR)
#elif __WIN32
#include "dirent.h"
#define ISDIR(type) (S_ISDIR(type))
#endif

static std::vector<std::string> Scan(const std::string &root, const std::string &pattern) {
  std::queue<std::string> paths;
  std::vector<std::string> files;
  std::regex filter(pattern);
  paths.push(root);
  struct dirent *entry;

  while (!paths.empty()) {
    const std::string path = paths.front();
    paths.pop();

    DIR *dir = opendir(path.c_str());
    if (dir) {
      while ((entry = readdir(dir)) != NULL) {
        const char *file_name = entry->d_name;
        if (strcmp(file_name, ".") == 0 || strcmp(file_name, "..") == 0)
          continue;
        if (file_name[0] == '.')
          continue;
        const std::string full_path = path + "/" + file_name;
        if (ISDIR(entry->d_type)) {
          paths.push(full_path);
        } else {
          if (!regex_match(full_path, filter)) {
            int sub_path_size = full_path.length() - root.length();
            files.push_back(full_path.substr(root.length() + 1, sub_path_size));
          }
        }
      }
    }
    closedir(dir);
  }
  return files;
}

static PyObject *Scan(PyObject *self, PyObject *args) {
  const char *root;
  char *pattern = NULL;
  if (!PyArg_ParseTuple(args, "s|s", &root, &pattern)) return NULL;

  std::vector<std::string> files;
  if (pattern)
    files = Scan(root, pattern);
  else
    files = Scan(root);
  std::sort(files.begin(), files.end());
  PyObject *result = PyList_New(files.size());
  for (size_t i = 0; i < files.size(); ++ i) {
    PyList_SetItem(result, i, Py_BuildValue("s", files[i].c_str()));
  }
  return result;
}

static PyMethodDef cIndexerMethods[] = {
  {"scan", Scan, METH_KEYWORDS, "indexer for ctrlp"},
  {NULL, NULL, 0, NULL},
};

PyMODINIT_FUNC
initcIndexer(void) {
  (void)Py_InitModule("cIndexer", cIndexerMethods);
}

