import os
import os.path as pt
import re
import numpy as np
from numpy.random import rand
from string import ascii_lowercase as letters

pr = 3
lw = 100
np.set_printoptions(linewidth=lw, precision=pr)
#  pd.set_option('display.width', lw)
#  pd.set_option('display.precision', pr + 1)

def test_df(dim=(5, 3), dtype=int, min=0, max=5, columns=None):
    import pandas as pd
    if columns is None:
        columns = list(letters[:dim[1]])
    if dtype == int:
        d = np.random.randint(min, max, dim[0] * dim[1]).reshape(dim[0], -1)
    else:
        d = rand(dim[0], dim[1])
    d = pd.DataFrame(d, columns=columns)
    return d


# Disable auto-close brackets
from notebook.services.config import ConfigManager
c = ConfigManager()
c.update('notebook', {"CodeCell": {"cm_config": {"autoCloseBrackets": False}}})
