require 'open-uri'

class UrlProcessingJob < ApplicationJob
  queue_as :default

  def perform(url)
    preview = Preview.find_or_initialize_by(url: url)
    doc = Nokogiri::HTML(open(url))
    image_tag = doc.at('meta[property="og:image"]')
    image_url = image_tag['content'] if image_tag
    preview.image_url = image_url
    preview.status = :processed
    preview.save
    ActionCable.server.broadcast("preview_channel", preview)
  rescue StandardError
    nil
  end
end
