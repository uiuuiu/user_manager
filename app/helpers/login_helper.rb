module LoginHelper

  def login_page_label(**options)
    tag_options = {class: default_classes_label}
    tag_options.merge!(options)
    content_tag(:label, **tag_options) do
      yield if block_given?
    end
  end

  def login_page_input(f, field_name, html_id: nil, html_class: nil, **other_options)
    tag_options = {class: default_classes_input}
    tag_options[:id] = html_id if html_id
    tag_options[:class] += " #{html_class}" if html_class

    f.text_field(field_name, **tag_options, **other_options) do
      yield if block_given?
    end
  end

  def login_page_checkbox(html_id: nil, html_class: nil, **other_options)
  end

  def login_page_submit(f, html_id: nil, html_class: nil, **other_options)
    tag_options = {class: default_classes_submit, type: "submit"}
    tag_options[:id] = html_id if html_id
    tag_options[:class] += " #{html_class}" if html_class
    puts tag_options
    f.button(**tag_options, **other_options) do
      yield if block_given?
    end
  end

  private

  def default_classes_label
    %w(
      block 
      mb-2 
      text-sm 
      font-medium 
      text-gray-900 
      dark:text-white
      required
    ).join(" ")
  end

  def default_classes_input
    %w(
      bg-gray-50
      border 
      border-gray-300 
      text-gray-900 
      sm:text-sm rounded-lg 
      focus:ring-primary-600 
      focus:border-primary-600 
      block w-full 
      dark:bg-gray-700
      dark:border-gray-600 
      dark:placeholder-gray-400
      dark:text-white
      dark:focus:ring-blue-500
      dark:focus:border-blue-500
    ).join(" ")
  end

  def default_classes_submit
    %w(
      w-full
      text-white
      bg-primary-600
      hover:bg-primary-700
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
    ).join(" ")
  end
end
