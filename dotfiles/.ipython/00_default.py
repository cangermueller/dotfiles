import os
import os.path as pt
import re
from string import ascii_lowercase as letters

import numpy as np
import pandas as pd

pr = 3
lw = 100
np.set_printoptions(linewidth=lw, precision=pr)
#  pd.set_option('display.width', lw)
#  pd.set_option('display.precision', pr + 1)

def test_df(dim=(5, 3), dtype=int, minval=0, maxval=5, columns=None):
    if columns is None:
        columns = list(letters[:dim[1]])
    if dtype == int:
        d = np.random.randint(
          minval, maxval, dim[0] * dim[1]).reshape(dim[0], -1)
    else:
        d = rand(dim[0], dim[1])
    d = pd.DataFrame(d, columns=columns)
    return d


def test_series(size=5, minval=0, maxval=10):
  return pd.Series(np.random.randint(minval, maxval, size))


rand = np.random.rand

def irand(shape=(4, 3), minval=0, maxval=10):
  return np.random.randint(minval, maxval, shape)


def tfi():
  import tensorflow as tf
  global tf


def logsoff():
  from absl import logging
  logging.set_verbosity(logging.FATAL)


def tfrand(shape=(4, 3), **kwargs):
  return tf.random.uniform(shape, **kwargs)


def tfirand(shape=(4, 3), minval=0, maxval=10):
  return tf.random.uniform(shape, minval=minval, maxval=maxval, dtype=tf.int32)
