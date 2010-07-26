#!/usr/bin/env python2.4
"""Module for reading gshhs binary coastline formats"""

from pylab import *
import struct
from scipy import *

class gshhs:
    def _get_header(self):
        nb_i = struct.calcsize('i') # 4 bytes in 'int'
        nb_h = struct.calcsize('h') # 2 bytes in 'short int'
        hdr_len = nb_i*8 + nb_h*2
        bhdr = self.f.read(hdr_len)
        if not bhdr:
            return None
        hdr = {}; n=0
        # integer header information (big-endien)
        hdr['id']     = struct.unpack('>i',bhdr[n:n+nb_i])[0];        n += nb_i
        hdr['n']      = struct.unpack('>i',bhdr[n:n+nb_i])[0];        n += nb_i
        hdr['level']  = struct.unpack('>i',bhdr[n:n+nb_i])[0];        n += nb_i
        hdr['west']   = struct.unpack('>i',bhdr[n:n+nb_i])[0]*1.0e-6; n += nb_i
        hdr['east']   = struct.unpack('>i',bhdr[n:n+nb_i])[0]*1.0e-6; n += nb_i
        hdr['south']  = struct.unpack('>i',bhdr[n:n+nb_i])[0]*1.0e-6; n += nb_i
        hdr['north']  = struct.unpack('>i',bhdr[n:n+nb_i])[0]*1.0e-6; n += nb_i
        hdr['area']   = struct.unpack('>i',bhdr[n:n+nb_i])[0];        n += nb_i
        # short integer header information
        hdr['grenwich']  = struct.unpack('>h',bhdr[n:n+nb_h])[0];     n += nb_h
        hdr['source']    = struct.unpack('>h',bhdr[n:n+nb_h])[0];
        return hdr
    
    def _get_poly(self,n):
        n_i4 = struct.calcsize('i')
        bdata = self.f.read(2*n_i4*n)
        # unpack big-endien micro degrees
        data = array(struct.unpack('>'+str(2*n)+'i',bdata)[:])
        lon = array(data[::2]*1.0e-6)
        lat = array(data[1::2]*1.0e-6)
        # Clip data to window
        lon = clip(lon,self.window[0]%360,self.window[1]%360)
        lat = clip(lat,self.window[2],self.window[3])
        # shrink corners to a single point
        b = array([0.5, 0.5])
        idx = ( ((lon==self.window[0]%360)&(lat==self.window[2]))  # South-west corner
              | ((lon==self.window[1]%360)&(lat==self.window[2]))  # South-east corner
              | ((lon==self.window[0]%360)&(lat==self.window[3]))  # North-west corner
              | ((lon==self.window[1]%360)&(lat==self.window[3])) )# North-east corner
        idx=conv(idx,b,1)
        lon=lon[idx<1]; lat=lat[idx<1]
         # Only keep first and last points in series of identical values
        b = array([0.25, 0.5, 0.25])
        idx = ( (lon==self.window[0]%360)
              | (lon==self.window[1]%360)
              | (lat==self.window[2])
              | (lon==self.window[3]) )
        idx = conv(idx,b,1)
        # Keep corner points
        idx[((lon==self.window[0]%360)&(lat==self.window[2]))
            | ((lon==self.window[1]%360)&(lat==self.window[2]))
            | ((lon==self.window[0]%360)&(lat==self.window[3]))
            | ((lon==self.window[1]%360)&(lat==self.window[3]))] = 0
        lon=lon[idx<1]; lat=lat[idx<1]
        return (lon,lat)
           
    def __init__(self,resolution='i',window=[-95., -87., 28., 31.0],
                  data_dir='/Users/rob/python/gshhs/',area_clip=0.):
        self.window = window
        self.mean_lon = (window[0]+window[1])/2.0
        self.mean_lat = (window[2]+window[3])/2.0
        corr = 0.
        if self.mean_lon < 0: corr = -360.
        self.aspect = array([window[1]-window[0],window[3]-window[2]])*\
                       array([cos(self.mean_lat*pi/180.),1])
        self.aspect=self.aspect[:]/self.aspect[0]
        self.f = open(data_dir + '/' + 'gshhs_' + resolution + '.b','rb')
        self.lon=[]; self.lat=[];
        self.area=[]; self.level=[]; self.grenwich=[]
        hdr = gshhs._get_header(self)
        while hdr:
            if (hdr['east']%360>window[0]%360 and hdr['west']%360<window[1]%360 and 
                hdr['north']>window[2] and hdr['south']<window[3] and 
                hdr['area']>area_clip):
                self.area.append(hdr['area'])
                self.level.append(hdr['level'])
                self.grenwich.append(hdr['grenwich'])
                lon,lat = self._get_poly(hdr['n'])
                lon += corr
                self.lon.append(lon)
                self.lat.append(lat)
            else:
                self.f.seek(2*4*hdr['n'],1)
            hdr = gshhs._get_header(self)
        self.f.close()
            
    def plot(self,ax=None,land_color=(0.4,0.8,0.5),water_color='w'):
        if not ax:
            ax = gca()
        interact = matplotlib.is_interactive()
        matplotlib.interactive(False)
        for n in range(len(self.lon)):
            if self.level[n] == 1:
                col = land_color
            else:
                col = water_color
            if (self.grenwich[n]==0):
                fill(self.lon[n][:],self.lat[n][:],facecolor=col)
        axis(self.window)
        xticks = arange(ceil(self.window[0]),floor(self.window[1])+1)
        ax.set_xticks(xticks)
        yticks =  arange(ceil(self.window[2]),floor(self.window[3])+1)
        ax.set_yticks(yticks)
        xlab = []
        for x in xticks:
            if x < 0:
                xlab.append(u'%g\N{DEGREE SIGN}W'%abs(x))
            else:
                xlab.append(u'%g\N{DEGREE SIGN}E'%x)
        ax.set_xticklabels(xlab)
        ylab = []
        for y in yticks:
            if y < 0:
                ylab.append(u'%g\N{DEGREE SIGN}S'%abs(y))
            else:
                ylab.append(u'%g\N{DEGREE SIGN}N'%y)
        ax.set_yticklabels(ylab)
        if interact:
            show()
        matplotlib.interactive(interact)

if __name__ == '__main__':
    from pylab import *
    import time
    window=[-95.25, -86.75, 27.25, 30.75]
    t1 = time.clock()
    m = gshhs(window=window,resolution='h',area_clip=0.)
    t2 = time.clock()
    print 'gshhs time: ' + str(t2-t1) + ' seconds'
    figure(figsize=15*m.aspect)
    axes([0.05, 0.05, 0.9, 0.9])
    m.plot()
    window[0]=window[0]; 
    window[1]=window[1]; 
    axis(window)
    t3 = time.clock()
    print 'plot time: ' + str(t3-t2) + ' seconds'
    show()
    t4 = time.clock()
    print 'show time: ' + str(t4-t3) + ' seconds'

    print 'Total time: ' + str(t4-t1) + ' seconds'
