require 'test/unit'
require 'fileutils'
require 'rqrencoder'
require 'rqrencoder-magick'

class TestGenerator < Test::Unit::TestCase
	def setup
		FileUtils.mkdir_p("tmp")
	end

	def test_default_save
		simple_save_test("tmp/test1.png")
	end

	def test_save_pdf
		simple_save_test("tmp/test2.pdf")
	end

	def test_save_svg
		filename = "tmp/test3.svg"
		File.delete(filename) if File.exists?(filename)
		make_qrcode.save_svg(filename)
		assert(File.exists?(filename))
	end

	def test_save_ps
		simple_save_test("tmp/test4.ps")
	end

	private
	def make_qrcode
		 RQREncoder::QREncoder.new.encode("FOO BAR")
	end

	def simple_save_test(filename)
		File.delete(filename) if File.exists?(filename)
		make_qrcode.save(filename)
		assert(File.exists?(filename))
	end
end
