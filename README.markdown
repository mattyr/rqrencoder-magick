# RQREncoder-Magick

## An image file generator for QRCodes using RMagick

## Install

Install with Rubygems:

    gem install rqrencoder-magick

## Usage

Create a QRCode using the (required) rqrencoder gem (http://github.com/mattyr/rqrencoder)

This gem extends the QRCode class to have "draw" and "save" functions

    >> require 'rqrencoder-magick'
    => true
    >> encoder = RQREncoder::QREncoder.new
    => #<RQREncoder::QREncoder>
    >> qrcode = encoder.encode("HELLO")
    => #<RQREncoder::QRCode:0x0000010203b7b0>
    >> qrcode.save("myqrcode.gif")
    => myqrcodegif  290x290 PseudoClass 2c 16-bit

## Notes

I had difficulties with the output of RMagick (ImageMagick)'s svg format, so there are two additional "special" functions, draw_svg and save_svg as workarounds.

## Author

Matt Robinson
