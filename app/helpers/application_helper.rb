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
      image_tag "https://graph.facebook.com/#{user.uid}/picture", :class => "user-avatar"
    else
      image_tag user.avatar.url(:small), :class => "user-avatar"
    end
  end

  def profile_picture(user)
    if user.uid
      image_tag "https://graph.facebook.com/#{user.uid}/picture?width=200&height=200", :class => "user-profile-picture"
    else
      image_tag user.avatar.url(:large), :class => "user-profile-picture"
    end
  end

  def last_month_in_words
    (Time.now - 1.month).strftime('%B')
  end

  def format_je_dates(dates)
    split_dates = dates.split(" 00:00:00 ")
    if split_dates.size > 1
      finely_split_dates = split_dates[0].split(" ")
      return "#{finely_split_dates[1]} #{finely_split_dates[2]}, #{finely_split_dates[3]} (#{finely_split_dates[0]})"
    else
      return dates
    end
  end
end
