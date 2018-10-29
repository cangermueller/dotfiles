#!/usr/bin/env python

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import json
import os
import subprocess as sp
import sys

import argparse
import logging
import pandas as pd


def run_cmd(cmd, test=False, rv=False):
  logging.info(cmd)
  if test:
    return 0
  if rv:
    rv = sp.Popen(cmd, shell=True, cwd=os.getcwd(), stdout=sp.PIPE)
    rv = rv.stdout.read()
    if not isinstance(rv, str):
      rv = rv.decode()
  else:
    return os.system(cmd)
  return rv


def list_pip(pip='pip', outdated=False):
  cols = ['name', 'version']
  if outdated:
    cols.append('latest_version')
  out = dict()
  args = ['--format=json']
  if outdated:
    args.insert(0, '--outdated')
  rv = run_cmd('%s list %s' % (pip, ' '.join(args)), test=False, rv=True)
  for value in json.loads(rv):
    for col in cols:
      out.setdefault(col, []).append(value[col])
  out = pd.DataFrame(out, columns=cols)
  return out


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
      description='Updates PIP packages.')
    p.add_argument(
      'names',
      nargs='*',
      help='Name of packages to be updated.')

    p.add_argument(
      '-l', '--list',
      action='store_true',
      help='List installed packages.')
    p.add_argument(
      '-o', '--outdated',
      action='store_true',
      help='List outdated packages.')

    p.add_argument(
      '-i', '--install',
      action='store_true',
      help='Install or upgrade packages.')
    p.add_argument(
      '-u', '--update',
      action='store_true',
      help='Update all outdated packages.')
    p.add_argument(
      '-r', '--remove',
      action='store_true',
      help='Removes packages.')
    p.add_argument(
      '-s', '--search',
      action='store_true',
      help='Search for package.')

    p.add_argument(
      '-U', '--user',
      action='store_true',
      help='Run as current user instead of sudo.')
    p.add_argument(
      '-e', '--exclude',
      nargs='+',
      default=['pip', 'prompt-toolkit'],
      help='Packages to be excluded.')

    p.add_argument(
      '-2', '--pip2',
      action='store_true',
      help='Use pip2.')
    p.add_argument(
      '-3', '--pip3',
      action='store_true',
      help='Use pip3.')

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

    pip = 'pip2'
    if opts.pip2:
      pip = 'pip2'
    elif opts.pip3:
      pip = 'pip3'
    if not opts.user:
      pip = 'sudo %s' % pip

    if (opts.install or opts.remove or opts.search) and not opts.names:
      return 1

    if opts.outdated or opts.update:
      lst = list_pip(pip, True)
      lst = lst.loc[lst['version'] != lst['latest_version']]
      # Never update pip with pip; use apt!
      exclude = ['pip']
      if opts.exclude:
        exclude.extend(opts.exclude)
      exclude = sorted(set([x.lower() for x in exclude]))
      lst = lst.loc[~lst['name'].str.lower().isin(exclude)]

      print(lst.to_string())
      if opts.update:
        for name in lst['name'].tolist():
          cmd = '%s install -U %s' % (pip, name)
          run_cmd(cmd, opts.test)

    elif opts.install or opts.remove or opts.search:
      if not opts.names:
        logging.error('No package name specified!')
      if opts.install:
        cmd = 'install -U'
      elif opts.remove:
        cmd = 'uninstall'
      else:
        cmd = 'search'
      names = opts.names
      if not opts.search:
        names = [' '.join(names)]
      for name in names:
        run_cmd('%s %s %s' % (pip, cmd, name), opts.test)

    else:
      lst = list_pip(pip)
      print(lst.to_string())

    return 0


if __name__ == '__main__':
  app = App()
  app.run(sys.argv)
