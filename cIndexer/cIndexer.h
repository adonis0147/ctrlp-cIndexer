#pragma once
#ifndef CINDEXER_H
#define CINDEXER_H

#ifdef _DEBUG
#undef _DEBUG
#define _DEBUG_WAS_DEFINED
#endif

#include <Python.h>
#include <vector>
#include <string>

static std::vector<std::string> Scan(const std::string &root, const std::string &pattern = "^$");
static PyObject *Scan(PyObject *self, PyObject *args);

#ifdef _DEBUG_WAS_DEFINED
#define _DEBUG
#endif

#endif

