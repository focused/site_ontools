# encoding: utf-8

class Data < Thor
  include Thor::Actions

  MODELS = %w(Image Page PageMetaTag Product ProductGroup)

  desc 'export [MODELS]', 'exports data from db'
  method_options path: 'db/data'
  def export(models = MODELS)
    load_env

    models = models.split if models.is_a? String

    puts "======================================="
    models.each_with_index do |m, i|
      dst = File.join(Rails.root, options.path, "#{m.underscore.pluralize}.csv")
      m.constantize.pg_copy_to dst
      puts "* #{i + 1}. #{m} was exported to #{dst}"
    end
    puts "======================================="
  end

  desc 'import [MODELS]', 'imports data to db'
  method_options path: 'db/data'
  def import(models = MODELS)
    load_env

    models = models.split if models.is_a? String

    puts "======================================="
    models.each_with_index do |m, i|
      src = File.join(Rails.root, options.path, "#{m.underscore.pluralize}.csv")
      m.constantize.pg_copy_from src
      puts "* #{i + 1}. #{m} was imported from #{src}"
    end
    puts "======================================="
  end

  desc 'clear [MODELS]', 'clears csv data'
  method_options path: 'db/data'
  def clear(models = MODELS)
    load_env

    models = models.split if models.is_a? String

    puts "======================================="
    models.each_with_index do |m, i|
      src = File.join(Rails.root, options.path, "#{m.underscore.pluralize}.csv")
      remove_file src
      puts "* #{i + 1}. #{src} was removed"
    end
    puts "======================================="
  end

  private
  def load_env
    # Rails
    require File.expand_path('config/environment.rb')
  end

  def set_models(models)
    models.is_a?(String) ? models.split : models
  end
end
