#include "cIndexer.h"
#include <Python.h>
#include <cstring>
#include <string>
#include <vector>
#include <queue>
#include <algorithm>
#include <regex>
#include <sstream>

#if _WIN32
#include "windows/dirent.h"
#else
#include <dirent.h>
#endif

static std::vector<std::string> Scan(const std::string &root, const std::string &file_pattern, const std::string &dir_pattern) {
	std::queue<std::string> paths;
	std::vector<std::string> files;
	std::regex file_filter(file_pattern);
	std::regex dir_filter(dir_pattern);
	paths.push(root);
	struct dirent *entry;

	while (!paths.empty()) {
		std::string path = paths.front();
		paths.pop();

		DIR *dir = opendir(path.c_str());
		if (dir) {
			while ((entry = readdir(dir)) != NULL) {
				const char *file_name = entry->d_name;
				if (strcmp(file_name, ".") == 0 || strcmp(file_name, "..") == 0)
					continue;
				const std::string full_path = path + "/" + file_name;
				if (entry->d_type == DT_DIR) {
					if (!regex_search(full_path, dir_filter))
						paths.push(full_path);
				} else {
					if (!regex_match(file_name, file_filter)) {
						int sub_path_size = full_path.length() - root.length();
						files.push_back(full_path.substr(root.length() + 1, sub_path_size));
					}
				}
			}
			closedir(dir);
		}
	}
	return files;
}

static PyObject *Scan(PyObject *self, PyObject *args) {
	const char *root;
	char *file_pattern = "^$";
	char *dir_pattern = "^$";
	if (!PyArg_ParseTuple(args, "s|ss", &root, &file_pattern, &dir_pattern)) return NULL;

	std::vector<std::string> files;
	files = Scan(root, file_pattern, dir_pattern);
	std::sort(files.begin(), files.end());
	std::ostringstream result;
	for (size_t i = 0; i < files.size(); ++ i) {
		result << files[i] << "\n";
	}
	return Py_BuildValue("s", result.str().c_str());
}

static PyMethodDef cIndexerMethods[] = {
	{"scan", Scan, METH_VARARGS, "indexer for ctrlp"},
	{NULL, NULL, 0, NULL},
};

#ifndef IS_PY3K
PyMODINIT_FUNC
initcIndexer(void) {
	(void)Py_InitModule("cIndexer", cIndexerMethods);
}
#else
static struct PyModuleDef cIndexerModule = {
	PyModuleDef_HEAD_INIT,
	"cIndexer",
	NULL,
	-1,
	cIndexerMethods,
};

PyMODINIT_FUNC
PyInit_cIndexer() {
	return PyModule_Create(&cIndexerModule);
}
#endif
