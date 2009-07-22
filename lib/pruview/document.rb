module Pruview

  class Document
    
    def initialize(source, target_dir)
      raise Pruview::Exceptions::InvalidError, "Invalid source file: #{source.to_s}" if !File.file?(source)
      raise Pruview::Exceptions::InvalidError, "Invalid target directory: #{target_dir.to_s}" if !File.directory?(target_dir)
      raise Pruview::Exceptions::InvalidError, "Document not supported - file extension: " + file_extension(source) if !format_supported?(source)
      @source = source
      @target_dir = target_dir
      @image = process_image(get_image(source))
      @tempfile = nil
    end
  
    def to_jpg(name, width, height, crop = false)
      scale_img = scale_image(width, height, crop)
      scale_img.combine_options do |img|
        img.format 'jpg'
        img.quality '90'
        img.interlace 'plane'
      end
      target = File.join(@target_dir, name.to_s + '.jpg')
      scale_img.write(target)
      return target
    end
    
  protected
  
    def format_supported?(source)
      file_ext = file_extension(source)
      #return true if file_ext == PSD_EXT  # don't support photoshop for now
      POSTSCRIPT_EXT.each { |extension| return true if file_ext == extension }
      IMAGE_EXT.each { |extension| return true if file_ext == extension }
      return false
    end
    
    def format_postscript?(source)
      file_ext = file_extension(source)
      POSTSCRIPT_EXT.each { |extension| return true if file_ext == extension }
      return false
    end
    
    def file_extension(source_file)
       File.extname(source_file).downcase.chomp  
    end
    
    def get_image(source)
      source = get_postscript_source(source) if format_postscript?(source)
      begin
        return MiniMagick::Image.from_file(source)
      rescue Exception => err
        raise "Error reading source image: #{err.message}"
      end
    end
    
    def get_postscript_source(source)
      begin
        @tempfile = MiniMagick::ImageTempFile.new("pruview.jpg")
        @tempfile.binmode
      ensure
        @tempfile.close
      end
      run_system_command("convert -format jpg \"#{source}[0]\" \"#{@tempfile.path}\"", "Error processing postscript document")
      return @tempfile.path
    end
    
    def process_image(image)
      image.format PROCESS_FORMAT
      set_RGB_colorspace(image)
      image.strip
      return image
    end
    
    def set_RGB_colorspace(image)
      colorspace = run_system_command("identify -format \"%r\" #{image.path}", "Error reading document colorspace")
      puts "Colorspace: #{colorspace}"
      if colorspace =~ /CMYK/
        image.combine_options do |img|
          img.profile File.join(File.dirname(__FILE__), 'USWebCoatedSWOP.icc')
          img.profile File.join(File.dirname(__FILE__), 'sRGB.icm')
          img.colorspace 'sRGB'
        end
      end
    end

    def scale_image(width, height, crop = false)
      begin
        image = MiniMagick::Image.from_file(@image.path)
        crop_image(image, crop)
        image.resize "#{width}x#{height}" if crop || @image[:width].to_i > width || @image[:height] > height 
        return image
      rescue Exception => err
        raise "Error scaling image: #{err.message}"
      end
    end
    
    def crop_image(image, ratio)
      if ratio.kind_of?(Array) && ratio.length == 2
        ratio_width, ratio_height = ratio
        puts "image orig size: #{image[:width].to_i}x#{image[:height].to_i}"
        puts "ratio_width: #{ratio_width}, ratio_height: #{ratio_height}"
        if ratio_width > ratio_height || (ratio_width == ratio_height && image[:height].to_i > image[:width].to_i)
          # calc ratio height from width
          rheight = (image[:width].to_i*(ratio_height.to_f / ratio_width.to_f)).round
          puts "rheight: #{rheight}"
          # shave off height
          shave_off = ((image[:height].to_i - rheight)/2).round
          puts "shave off height: #{image[:height].to_i - rheight}"
          image.shave("0x#{shave_off}")
          puts "image crop size: #{image[:width].to_i}x#{image[:height].to_i}"
        elsif ratio_height > ratio_width || (ratio_width == ratio_height && image[:width].to_i > image[:height].to_i)
          # calc ratio width from height
          rwidth = (image[:height].to_i*(ratio_width.to_f / ratio_height.to_f)).round
          # shave off width
          shave_off = ((image[:width].to_i - rwidth).to_f / 2.to_f).round
          image.shave("#{shave_off}x0")
        end
      end
      return image
    end
    
    def run_system_command(command, error_message)
      output = `#{command}`
      raise "#{error_message}: error given #{$?}\n#{output}" if $? != 0
      return output
    end
    
  end
  
  # Configurations
  Document::PROCESS_FORMAT = 'jpg'
  
  Document::PSD_EXT = '.psd'
  Document::POSTSCRIPT_EXT = ['.pdf', '.eps', '.ai']
  Document::IMAGE_EXT = ['.bmp', '.gif', '.jpg', '.jpeg', '.png', '.tga']

end

