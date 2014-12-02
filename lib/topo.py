import collections

import matplotlib as mpl
import numpy as np
from scipy import interpolate


snow = "#eeeeee"
mountains = "#aa8052"
hills = "#ccb688"
highlands = "#608350"
midlands = "#506d48"
lowlands = "#405644"
shallowsea = "#66a4c7"
sea = "#3681a5"
deepsea = "#39547c"
land_colors = [snow, mountains, hills,
               highlands, midlands, lowlands,
               shallowsea, sea, deepsea]
land_colors.reverse()
land_cmap = mpl.colors.LinearSegmentedColormap.from_list(
                "land", land_colors, N=16)


def make_land_map(xrange, yrange, seed):
    (xmin, xmax) = xrange
    (ymin, ymax) = yrange
    np.random.seed(seed)
    x, y, z = np.random.random((3, 10))
    # Interpolate these onto a regular grid
    xi, yi = np.mgrid[xmin:xmax:100j, ymin:ymax:100j]
    interpolation = interpolate.Rbf(x, y, z, function="linear")
    zi = 3200 * interpolation(xi, yi) + 1000
    coords = collections.OrderedDict([("x", xi), ("y", yi), ("z", zi)])
    (dy, dx) = np.gradient(-zi.T)
    gradient = collections.OrderedDict([("dy", dy), ("dx", dx)])
    return (coords, gradient)
