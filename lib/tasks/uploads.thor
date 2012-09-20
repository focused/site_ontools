# encoding: utf-8

class Uploads < Thor
  desc 'clear_temp', 'clears uploaded files in tmp folder'
  method_options path: 'tmp/uploads'
  def clear_temp
    FileUtils.rm_rf(options.path) unless options.path.nil?
  end
end
