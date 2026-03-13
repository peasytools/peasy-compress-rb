# frozen_string_literal: true

require "zlib"
require "stringio"
require "base64"

module PeasyCompress
  module_function

  def gzip(data)
    io = StringIO.new
    io.set_encoding("BINARY")
    gz = Zlib::GzipWriter.new(io)
    gz.write(data)
    gz.close
    io.string
  end

  def gunzip(data)
    io = StringIO.new(data)
    Zlib::GzipReader.new(io).read
  end

  def deflate(data, level: Zlib::DEFAULT_COMPRESSION)
    Zlib::Deflate.deflate(data, level)
  end

  def inflate(data)
    Zlib::Inflate.inflate(data)
  end

  def compress_ratio(original_size, compressed_size)
    return 0.0 if original_size.zero?
    ((1.0 - compressed_size.to_f / original_size) * 100).round(1)
  end

  def gzip_base64(data)
    Base64.strict_encode64(gzip(data))
  end

  def gunzip_base64(data)
    gunzip(Base64.strict_decode64(data))
  end
end
