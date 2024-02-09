class ApplicationDecorator < Draper::Decorator
  # Define methods for all decorated objects.
  # Helpers are accessed through `helpers` (aka `h`). For example:
  #
  #   def percent_amount
  #     h.number_to_percentage object.amount, precision: 2
  #   end

  private

  def object_link_css
    "font-medium text-blue-600 dark:text-blue-500 hover:underline"
  end
end
