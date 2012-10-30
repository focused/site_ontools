# encoding: utf-8

class Data < Thor
  MODELS = %w(PageMetaTag Page ProductGroup Product Image)

  desc 'export', 'exports data from db'
  method_options path: 'db/data'
  def export
    load_env

    puts "======================================="
    MODELS.each_with_index do |m, i|
      dst = File.join(Rails.root, options.path, "#{m.underscore.pluralize}.csv")
      m.constantize.pg_copy_to dst
      puts "* #{i + 1}. #{m} was exported to #{dst}"
    end
    puts "======================================="
  end

  desc 'import', 'imports data to db'
  method_options path: 'db/data'
  def import
    load_env

    puts "======================================="
    MODELS.each_with_index do |m, i|
      src = File.join(Rails.root, options.path, "#{m.underscore.pluralize}.csv")
      m.constantize.pg_copy_from src
      puts "* #{i + 1}. #{m} was imported from #{src}"
    end
    puts "======================================="
  end

  private
  def load_env
    # Rails
    require File.expand_path('config/environment.rb')
  end
end
