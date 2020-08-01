#!/usr/bin/env python

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
      description='Replaces or deletes patterns in all files recursively.')
    p.add_argument(
      'patterns',
      nargs='+',
      help='from (to) pattern')
    p.add_argument(
      '-f', '--file_type',
      help='File type.')
    p.add_argument(
      '-g', '--file_glob',
      help='A glob, e.g. "*csv" for filtering files.')
    p.add_argument(
      '-p', '--path',
      default='.',
      help='')
    p.add_argument(
      '-s', '--sep',
      default='/',
      help='Separator in sed expression')
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

    cmd = []
    cmd.append(f'rg -l "{opts.patterns[0]}" {opts.path}')
    if opts.file_type:
      cmd.append(f'-t {opts.file_type}')
    if opts.file_glob:
      cmd.append(f'-g {opts.file_glob}')

    if len(opts.patterns) == 1:
      sed = f'{opts.sep}{opts.patterns[0]}{opts.sep} d'
    elif len(opts.patterns) == 2:
      sed = f's{opts.sep}{opts.patterns[0]}{opts.sep}{opts.patterns[1]}/g'
    else:
      raise ValueError('One (delete) or two (replace) patterns required!')
    cmd.append(f' | xargs -I@%@ sed -i "{sed}" @%@')
    cmd = ' '.join(cmd)
    _run_cmd(cmd, test=opts.test)


    return 0


if __name__ == '__main__':
  app = App()
  app.run(sys.argv)
