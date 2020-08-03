#!/usr/bin/env python

import os
import sys


def main(argv):
  if len(argv) > 1:
    path = argv[1]
  else:
    path = os.getcwd()
  print(os.path.realpath(path))
  return 0


if __name__ == '__main__':
  main(sys.argv)
