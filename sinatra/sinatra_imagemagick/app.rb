require "rubygems"
require "sinatra"
require "RMagick"
require "mini_magick"

get "/" do
  content_type "text/plain"

  image = MiniMagick::Image.open("imagemagick.jpg")
  image.resize("100x100!")

  return "minimagick failed" unless image[:width] == 100 && image[:height] == 100

  img = Magick::ImageList.new("imagemagick.jpg")
  cropped = img.crop(50, 15, 150, 165)
  cropped.write("thumb.jpg")

  thumb = Magick::Image::read("thumb.jpg").first
  if thumb.format == "JPEG" && thumb.columns == 150 && thumb.rows == 165
    "hello from imagemagick"
  end
end
