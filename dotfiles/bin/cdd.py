#!/usr/bin/env python

import glob
import os
import sys


def main(pattern):
  if os.path.isdir(pattern):
    print(pattern)
    return 0

  dirname, basename = os.path.split(pattern)

  def _glob(base_pattern):
    matches = glob.glob(os.path.join(dirname, base_pattern))
    if matches:
      matches = sorted(matches)[::-1][0]
    return matches

  base_patterns = [f'*{basename}', f'{basename}*', f'*{basename}*']
  for base_pattern in base_patterns:
    target = _glob(base_pattern)
    if target:
      print(target)
      return 0

  print(os.path.abspath(dirname))
  return 1


if __name__ == '__main__':
  pattern = sys.argv[1] if len(sys.argv) > 1 else os.getcwd()
  main(pattern)
