#require 'rqrcode'

#qrcode = RQRCode::QRCode.new("http://github.com/")
#
## NOTE: showing with default options specified explicitly
#svg = qrcode.as_svg(
#  offset: 0,
#  color: '000',
#  shape_rendering: 'crispEdges',
#  module_size: 6,
#  standalone: true
#)


qr = RQRCode::QRCode.new('http://kyan.com', size: 4, level: :h)

puts qr.to_s
