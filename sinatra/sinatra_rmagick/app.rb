require "rubygems"
require "sinatra"
require "RMagick"

get "/" do
  content_type "text/plain"

  img = Magick::ImageList.new("imagemagick.jpg")
  cropped = img.crop(50, 15, 150, 165)
  cropped.write("thumb.jpg")

  thumb = Magick::Image::read("thumb.jpg").first
  if thumb.format == "JPEG" && thumb.columns == 150 && thumb.rows == 165
    "hello from imagemagick"
  end
end
