module ApplicationHelper
  def errors_for(model, attribute)
    if model.errors[attribute].present?
      content_tag :span, :class => 'error_explanation' do
        model.errors[attribute].join(", ").capitalize
      end
    end
  end

  def avatar(user)
    if user.uid
      image_tag "http://graph.facebook.com/#{current_user.uid}/picture", :class => "user-avatar"
    else
      image_tag user.avatar.url(:small), :class => "user-avatar"
    end
  end
end
