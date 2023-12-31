# frozen_string_literal: true

module LanguageHelper
  include ApplicationHelper

  def available_language_options
    options = []
    AVAILABLE_LANGUAGES.each do |locale, language|
      options << [language, locale]
    end
    options.sort_by { |o| o[0] }
  end

  def get_javascript_strings_for(language, section)
    translations = I18n.t(section, locale: DEFAULT_LANGUAGE).dup
    translations.deep_merge!(I18n.t(section, locale: language)) if language != DEFAULT_LANGUAGE

    translations["pluralization_rule"] = I18n.t("i18n.plural.js_rule", locale: language)
    translations["pod_name"] = pod_name
    translations
  end

  def direction_for(string)
    return '' unless string.respond_to?(:cleaned_is_rtl?)
    string.cleaned_is_rtl? ? 'rtl' : 'ltr'
  end

  def rtl?
    @rtl ||= RTL_LANGUAGES.include?(I18n.locale.to_s)
  end
end
