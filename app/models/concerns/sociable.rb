module Sociable
  extend ActiveSupport::Concern

  included do
    validates :facebook_url, :instagram_url, :tiktok_url, :twitter_url, url: {allow_blank: true}
    before_validation :set_urls
  end

  private

  def set_urls
    set_facebook_url
    set_instagram_url
    set_tiktok_url
    set_twitter_url
  end

  def set_facebook_url
    return if facebook_url.blank?
    return if facebook_url.match?(/\Ahttps?:\/\//)
    return if instagram_url.match?(/facebook\.com/)
    username = facebook_url.sub("@", "")
    self.facebook_url = "https://www.facebook.com/#{username}"
  end

  def set_instagram_url
    return if instagram_url.blank?
    return if instagram_url.match?(/\Ahttps?:\/\//)
    return if instagram_url.match?(/instagram\.com/)
    username = instagram_url.sub("@", "")
    self.instagram_url = "https://www.instagram.com/#{username}"
  end

  def set_tiktok_url
    return if tiktok_url.blank?
    return if tiktok_url.match?(/\Ahttps?:\/\//)
    return if tiktok_url.match?(/tiktok\.com/)
    username = tiktok_url&.first == "@" ? tiktok_url : "@#{tiktok_url}"
    self.tiktok_url = "https://www.tiktok.com/#{username}"
  end

  def set_twitter_url
    return if twitter_url.blank?
    return if twitter_url.match?(/\Ahttps?:\/\//)
    return if twitter_url.match?(/twitter\.com/)
    username = twitter_url.sub("@", "")
    self.twitter_url = "https://twitter.com/#{username}"
  end
end