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
      image_tag "http://graph.facebook.com/#{user.uid}/picture", :class => "user-avatar"
    else
      image_tag user.avatar.url(:small), :class => "user-avatar"
    end
  end

  def profile_picture(user)
    if user.uid
      image_tag "http://graph.facebook.com/#{user.uid}/picture?width=200&height=200", :class => "user-profile-picture"
    else
      image_tag user.avatar.url(:large), :class => "user-avatar"
    end
  end
end
