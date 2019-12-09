#!/usr/bin/env python

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import os
import sys

import argparse
import logging


def _run_cmd(cmd, test=False):
  print('#' * 80)
  print(cmd)
  print('#' * 80)
  if not test:
    os.system(cmd)


class App(object):

  def run(self, args):
    name = os.path.basename(args[0])
    parser = self.create_parser(name)
    opts = parser.parse_args(args[1:])
    return self.main(name, opts)

  def create_parser(self, name):
    p = argparse.ArgumentParser(
      prog=name,
      formatter_class=argparse.ArgumentDefaultsHelpFormatter,
      description='Replaces pattern in all files recursively.')
    p.add_argument(
      'pattern',
      help='From pattern.')
    p.add_argument(
      'repl',
      help='To pattern.')
    p.add_argument(
      '-g', '--file_glob',
      default='*',
      help='File glob.')
    p.add_argument(
      '-f', '--file_type',
      help='File type.')
    p.add_argument(
      '-d', '--directory',
      default='.',
      help='File glob.')
    p.add_argument(
      '-t', '--test',
      action='store_true',
      help='Test without executing.')
    p.add_argument(
      '--verbose',
      action='store_true',
      help='More detailed log messages.')
    p.add_argument(
      '--log_file',
      help='Write log messages to file.')
    return p

  def main(self, name, opts):
    logging.basicConfig(filename=opts.log_file,
                        level=logging.DEBUG if opts.verbose else logging.INFO,
                        format='%(levelname)s (%(asctime)s): %(message)s')
    if opts.verbose:
      logging.debug(opts)

    file_glob = opts.file_glob
    if opts.file_type:
      file_glob = '%s.%s' % (file_glob, opts.file_type)

    cmd = [
      f'find {opts.directory} -name "{file_glob}" -o -type f '
      f' | xargs -Ix sed -i "s/{opts.pattern}/{opts.repl}/g" x'
    ]
    cmd = ' '.join(cmd)
    _run_cmd(cmd, test=opts.test)


    return 0


if __name__ == '__main__':
  app = App()
  app.run(sys.argv)
