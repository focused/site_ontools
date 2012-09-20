# require 'i18n/backend/active_record'

# # set backend
# if !ENV['DISABLE_I18N_AR_BACKEND']
#   I18n.backend = I18n::Backend::ActiveRecord.new

#   # cache for I18n AR
#   I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Memoize)
#   I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Flatten)

#   # cache for Simple
#   I18n::Backend::Simple.send(:include, I18n::Backend::Memoize)
#   I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)

#   # set priority:
#   # 1 - from database
#   # 2 - from files
#   I18n.backend = I18n::Backend::Chain.new(I18n.backend, I18n::Backend::Simple.new)

#   # text for a missing translation
#   I18n.exception_handler = lambda { |exception, locale, key, options| "##{locale}.#{key}#" }
# end

