class RefreshYoutubeTokenJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts 'Refreshing Youtube Token'
  end
end
