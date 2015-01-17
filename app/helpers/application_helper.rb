module ApplicationHelper
  def errors_for(model, attribute)
    if model.errors[attribute].present?
      content_tag :span, :class => 'error_explanation' do
        model.errors[attribute].join(", ").capitalize
      end
    end
  end
end
