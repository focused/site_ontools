# encoding: utf-8
#
# changelog:
#
# v0.4
# add destroy task
#
# v0.3
# refactor
#


class Data < Thor
  include Thor::Actions

  MODELS = %w(Image Page PageMetaTag Product ProductGroup)

  desc 'export [MODELS]', 'exports data from db'
  method_options path: 'db/data'
  def export(arg_models = MODELS)
    load_env

    set_models(arg_models)

    puts "======================================="
    @models.each_with_index do |m, i|
      dst = File.join(Rails.root, options.path, "#{m.underscore.pluralize}.csv")
      m.constantize.pg_copy_to dst
      puts "* #{i + 1}. #{m} was exported to #{dst}"
    end
    puts "======================================="
  end

  desc 'import [MODELS]', 'imports data to db'
  method_options path: 'db/data'
  def import(arg_models = MODELS)
    load_env

    set_models(arg_models)

    puts "======================================="
    @models.each_with_index do |m, i|
      src = File.join(Rails.root, options.path, "#{m.underscore.pluralize}.csv")
      m.constantize.pg_copy_from src
      puts "* #{i + 1}. #{m} was imported from #{src}"
    end
    puts "======================================="
  end

  desc 'destroy [MODELS]', 'DANGEROUS! destroy models data'
  def destroy(arg_models = MODELS)
    load_env

    set_models(arg_models)

    puts "======================================="
    @models.each_with_index do |m, i|
      m.constantize.destroy_all
      puts "* #{i + 1}. #{m.underscore.pluralize} was truncated"
    end
    puts "======================================="
  end

  desc 'clear [MODELS]', 'clears csv data'
  method_options path: 'db/data'
  def clear(arg_models = MODELS)
    load_env

    set_models(arg_models)

    puts "======================================="
    @models.each_with_index do |m, i|
      src = File.join(Rails.root, options.path, "#{m.underscore.pluralize}.csv")
      remove_file src
      puts "* #{i + 1}. #{src} was removed"
    end
    puts "======================================="
  end

  protected
  def set_models(arg_models)
    arg_models = MODELS if arg_models =~ /^RAILS_ENV=\S+/
    @models = arg_models.is_a?(String) ? arg_models.split : arg_models
  end

  private
  def load_env
    # Rails
    require File.expand_path('config/environment.rb')
  end
end
