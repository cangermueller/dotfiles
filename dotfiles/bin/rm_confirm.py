#!/usr/bin/env python

import sys
import shutil


def ask_confirmation(msg):
  answer = input(msg + ' (y/n) ')
  return answer in ['y', 'yes']


def main(argv):
  for path in argv[1:]:
    if ask_confirmation(f'Delete {path}?'):
      shutil.rmtree(path)


if __name__ == '__main__':
  main(sys.argv)
