module Pruview

  class Video
    # Configurations
    Video::FFYML = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'bin', 'ffyml'))
    Video::FFMPEG = 'ffmpeg'
    Video::FLVTOOL = 'flvtool2'
    Video::PAD_COLOR = "000000"
    Video::AUDIO_BITRATE = 128 # kbps
    Video::AUDIO_SAMPLING = 44100

    Video::EXT = ['.avi', '.flv', '.mov', '.mpg', '.mp4']

    # this class assumes you have 'ffmpeg' and 'flvtool2' installed and in your path

    def initialize(source, target_dir, bitrate_mult = 1)
      raise Pruview::Exceptions::InvalidError, "Invalid source file:: #{source.to_s}" if !File.file?(source)
      raise Pruview::Exceptions::InvalidError, "Invalid target directory: #{target_dir.to_s}" if !File.directory?(target_dir)
      raise Pruview::Exceptions::InvalidError, "Video not supported - file extension: " + file_extension(source) if !format_supported?(source)
      @source = source
      @target_dir = target_dir
      @bitrate_multiplier = bitrate_mult
    end

    def to_flv(name, width, height, scale_static = false)
      target = to_base(name, width, height, '.flv', scale_static)
      run("#{FLVTOOL} -U #{target}", "Unable to add meta-data for #{target}.")
      return target
    end

    def to_mov(name, width, height, scale_static = false)
      target = to_base(name, width, height, '.mov', scale_static)
      # TODO: run qt-faststart
      return target
    end

    def info
      yml_info_path = Tempfile.new("#{File.basename(@source)}.yml").path
      self.get_info(yml_info_path)
    end

    def to_jpg(name)
      VideoImage.to_jpg(@source, @target_dir, name)
    end

  protected

    def to_base(name, width, height, extension, scale_static)
      target = File.join(@target_dir, name.to_s + extension)
      info_yml = File.join(@target_dir, name.to_s + '_info.yml')
      run(build_command(@source, target, width, height, get_info(info_yml), scale_static), "Unable to convert #{@source} to #{target}.")
      return target
    end

    def format_supported?(source)
      file_ext = file_extension(source)
      EXT.each { |extension| return true if file_ext == extension }
      return false
    end

    def file_extension(source_file)
       File.extname(source_file).downcase.chomp
    end

    def get_info(yml_path)
      run(info_command(@source, yml_path), "Unable to get video info")
      YAML.load_file(yml_path)
    end

    def info_command(source, yml_path)
      %Q{#{FFYML} "#{source}" "#{yml_path}"}
    end

    def build_command(source, target, width, height, info, scale_static)
      command = "#{FFMPEG} -i #{source}"
      command += get_scale_command(info['width'], info['height'], width, height, scale_static)
      scale_factor = get_scale_factor(info['width'], info['height'], width, height)
      bitrate_factor = file_extension(target) != '.flv' ? 1000 : 1
      if file_extension(target) != '.flv' # use h264 codec with lower bitrate scaling factor
        command += " -vcodec libx264 -vpre slow -threads 0"
        scale_factor /= 2.0
      end
      puts "scale factor: #{scale_factor.to_s}"
      puts "info bitrate: #{info['bitrate']}"
      if !info['bitrate'].zero?
        calc_bitrate = info['bitrate']*@bitrate_multiplier*scale_factor*bitrate_factor
        puts "calc bitrate: #{calc_bitrate}"
        command += " -b #{calc_bitrate}"
      else
        command += " -sameq"
      end
      command += " -ab #{AUDIO_BITRATE*bitrate_factor}"
      command += " -ar #{AUDIO_SAMPLING}"
      command += " -y #{target}"
    end

    def get_scale_factor(source_width, source_height, scale_width, scale_height)
      if source_width > source_height
        return (scale_width.to_f / source_width.to_f)
      else
        return (scale_height.to_f / source_height.to_f)
      end
    end

    def get_scale_command(source_width, source_height, scale_width, scale_height, static)
      # this type of scaling assumes a static overall resolution with black padding added appropriately
      # to keep the meaningful video area at the source aspect ratio
      scale_params = get_scaling_params(source_width, source_height, scale_width, scale_height)
      scale_command = " -s #{scale_params[:width].to_s}x#{scale_params[:height].to_s}"
      if static == true
        scale_command += " -padcolor #{PAD_COLOR}"
        scale_command += " -padleft #{scale_params[:left]}" if scale_params[:left] > 0
        scale_command += " -padtop #{scale_params[:top]}" if scale_params[:top] > 0
        scale_command += " -padright #{scale_params[:right]}" if scale_params[:right] > 0
        scale_command += " -padbottom #{scale_params[:bottom]}" if scale_params[:bottom] > 0
      end
      scale_command
    end

    def get_scaling_params(source_width, source_height, scale_width, scale_height)
      params = {}
      params[:left],params[:top],params[:right],params[:bottom] = 0,0,0,0
      params[:width],params[:height] = scale_width, scale_height
      scale_aspect = scale_width.to_f / scale_height.to_f
      source_aspect = source_width.to_f / source_height.to_f
      if(source_aspect > scale_aspect)
        params[:height] = (scale_width.to_f / source_aspect).to_i
        params[:height] += 1 if params[:height] % 2 != 0
        params[:top] = params[:bottom] = ((scale_height - params[:height]).to_f / 2).to_i
        params[:top] = params[:bottom] += 1 if params[:top] % 2 != 0
      elsif(source_aspect < scale_aspect)
        params[:width] = (scale_height.to_f * source_aspect).to_i
        params[:width] += 1 if params[:width] % 2 != 0
        params[:left] = params[:right] = ((scale_width - params[:width]).to_f / 2).to_i
        params[:left] = params[:right] += 1 if params[:left] % 2 != 0
      end
      return params
    end

    def run(command, error_message = "Unknown error.")
      raise "Ffmpeg error: " + error_message + " - command: '#{command}'" if !system(command)
    end

  end
end
