class TailwindFormBuilder < ActionView::Helpers::FormBuilder
  include Pundit::Authorization
  include ActionView::Helpers::TagHelper
  # include ActionView::Context
  delegate :current_user, :pundit_user, to: :@template

  def text_field(attribute, options = {})
    options[:class] += " #{text_field_css}"
    super(attribute, options)
  end

  def text_area(attribute, options = {})
    super(attribute, options)
  end

  def select(object_name, method_name, template_object, options = {})
    options[:class] += " #{select_css}"
    super(object_name, method_name, template_object, options)
  end

  def div_radio_button(method, tag_value, options = {})
    @template.content_tag(:div,
      @template.radio_button(
        @object_name, method, tag_value, objectify_options(options)
      ))
  end

  def submit(value = nil, options = {})
    options[:class] += " #{submit_css}"
    super(value, options)
  end

  def authorize_submit(resource, permission, value = nil, options = {})
    return unless policy(:team).send(permission)
    options[:class] += " #{submit_css}"
    submit(value, options) do
      yield if block_given?
    end
  end

  def authorize_button_to(action_name, resource, permission, options, &block)
    return unless policy(:team).send(permission)
    options[:class] += " #{button_to_css}"
    @template.button_to(action_name, **options) do
      block&.call
    end
  end

  private

  def current_user
    @template.current_user
  end

  def pundit_user
    @template.pundit_user
  end

  def text_field_css
    %w[
      bg-gray-50
      border
      border-gray-300
      text-gray-900
      text-sm
      rounded-lg
      focus:ring-primary-600
      focus:border-primary-600
      block
      w-full
      dark:bg-gray-700
      dark:border-gray-600
      dark:placeholder-gray-400
      dark:text-white
      dark:focus:ring-primary-500
      dark:focus:border-primary-500
    ].join(" ")
  end

  def select_css
    %w[
      bg-gray-50
      border
      border-gray-300
      text-gray-900
      text-sm
      rounded-lg
      focus:ring-primary-500
      focus:border-primary-500
      block
      w-full
      dark:bg-gray-700
      dark:border-gray-600
      dark:placeholder-gray-400
      dark:text-white
      dark:focus:ring-primary-500
      dark:focus:border-primary-500
    ].join(" ")
  end

  def submit_css
    %w[
      text-blue
      hover:text-white
      bg-white
      border
      border-gray-300
      hover:bg-primary-800
      focus:ring-4
      focus:outline-none
      focus:ring-primary-300
      font-medium
      rounded-lg
      text-sm
      px-5
      text-center
      dark:bg-primary-600
      dark:hover:bg-primary-700
      dark:focus:ring-primary-800
    ].join(" ")
  end

  def button_to_css
    %w[
      text-red-600
      inline-flex
      items-center
      hover:text-white
      border
      border-red-600
      hover:bg-red-600
      focus:ring-4
      focus:outline-none
      focus:ring-red-300
      font-medium
      rounded-lg
      text-sm
      px-5
      text-center
      dark:border-red-500
      dark:text-red-500
      dark:hover:text-white
      dark:hover:bg-red-600
      dark:focus:ring-red-900
    ].join(" ")
  end
end
