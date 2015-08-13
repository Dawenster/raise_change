module SocialHelper
  def facebook_link(url, campaign)
    facebook_app_id = Rails.env.development? ? 952931041384040 : 952917808052030
    facebook = "https://www.facebook.com/dialog/feed"
    facebook += "?app_id=#{facebook_app_id}"
    facebook += "&display=popup"
    facebook += "&caption=Raise%20Change"
    facebook += "&link=#{url}"
    facebook += "&redirect_uri=#{url}"
    facebook += "&picture=#{campaign.image.url(:display)}"
    return facebook
  end

  def twitter_link(url, campaign)
    twitter = "https://twitter.com/intent/tweet"
    twitter += "?text=#{campaign.title}"
    twitter += "&url=#{url}"
    twitter += "&hashtags=raisechange"
    return twitter
  end

  def linkedin_link(url, campaign)
    linkedin = "https://www.linkedin.com/shareArticle"
    linkedin += "?mini=true"
    linkedin += "&url=#{url}"
    linkedin += "&title=#{campaign.title}"
    return linkedin
  end

  def email_link(url, campaign)
    return "mailto:?subject=#{campaign.title}&body=#{url}"
  end
end