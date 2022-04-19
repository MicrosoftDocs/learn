XADD media.photos.genthumb * location sd7f9sd7.png width 300 height 300

XADD media.photos.genthumb 1596514316945-2 location xczv897.png filter grayscale

XLEN media.photos.genthumb

XRANGE media.photos.genthumb 1596514316945-2 1609476184275-0

XRANGE media.photos.genthumb - +

XRANGE media.photos.genthumb - 1596514316945-2

XRANGE media.photos.genthumb 1596514316945-2 +

XREVRANGE media.photos.genthumb - +

XREVRANGE media.photos.genthumb - 1596514316945-2

XREVRANGE media.photos.genthumb 1596514316945-2 +

XREAD STREAMS media.photos.genthumb 0

XREAD STREAMS media.photos.genthumb 1639714145947-2

XREAD STREAMS media.photos.genthumb $

XREAD STREAMS media.photos.genthumb media.photos.delete 0 0

XDEL media.photos.genthumb 1596514316945-2

DEL media.photos.genthumb