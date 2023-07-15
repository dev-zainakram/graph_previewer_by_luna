class PreviewerController < ApplicationController
  def index; end

  def process_url # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    url = params[:url]

    ActiveRecord::Base.transaction do
      preview = Preview.find_or_create_by(url: url) do |p|
        p.status = :processing
      end

      if valid_url?(preview.url)
        ActionCable.server.broadcast("preview_channel", preview)
        UrlProcessingJob.perform_later(preview.url) unless preview.processed?
      else
        flash[:error] = "Invalid URL format"
        redirect_to root_path
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end
end
