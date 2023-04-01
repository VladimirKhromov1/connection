# frozen_string_literal: true

module Svelte
  class Renderer
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper

    attr_accessor :output_buffer

    def render(name, props = {}, options = {}, &block)
      html_options = options.reverse_merge(:data => {})

      html_options[:data].tap do |data|
        data[:svelte_class] = name
        data[:svelte_props] = props.is_a?(String) ? props : props.to_json
      end

      html_options.except!(:tag, :prerender, :camelize_props)

      # rubocop:disable Rails/ContentTag
      content_tag(options[:tag] || :div, '', html_options, &block)
      # rubocop:enable Rails/ContentTag
    end
  end
end
