import sys
from jdcal import gcal2jd

Y, M, D, h, m, s  = int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4]), int(sys.argv[5]), int(sys.argv[6])

print(sum(gcal2jd(Y, M, D,), ((h+((m+(s/60))/60))/24)))

